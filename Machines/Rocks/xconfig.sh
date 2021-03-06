#!/bin/bash
## scenario definition section
NAME='erai-wc2'
# GHG emission scenario
GHG='RCP8.5' # CAMtr_volume_mixing_ratio.* file to be used
# time period and cycling interval
CYCLING="5days.2010-08" # stepfile to be used (leave empty if not cycling)
# I/O and archiving
IO='fineIO' # this is used for executables and archiving
ARSYS='' # not available
ARSCRIPT='' # no archiving available on Bugaboo yet
ARINTERVAL='' # default is yearly
AVGSYS='Rocks' # post-processign on Bugaboo
AVGSCRIPT='DEFAULT' # this is a dummy name...
AVGINTERVAL='MONTHLY' # default is yearly

## configure data sources
RUNDIR="${PWD}" # must not contain spaces!
# source data definition
DATATYPE='ERA-I'
DATADIR="/pub/home_local/wrf/${DATATYPE}/"
# other WPS configuration files
GEODATA="/pub/home_local/wrf/geog/"

## namelist definition section
# list of namelist groups and used snippets
MAXDOM=2 # number of domains in WRF and WPS
RES='7km'
DOM="wc2-${RES}"
# WRF
TIME_CONTROL="cycling,${IO}" # use fineIO and switch on snow diagnostics
TIME_CONTROL_MOD=' io_form_auxhist10 = 2 ! switch on hourly snow diagnostics'
DIAGS='hitop' # needs output stream #23
PHYSICS='clim-new-v36' # this namelist has to be compatible with the WRF build used!
PHYSICS_MOD=' cu_physics = 5, 0, 0, ! no convection scheme in inner domain : cu_rad_feedback = .true., .false., .false., : cu_diag = 0, : cugd_avedx = 2 ! increase subsidence spreading in outer domain ' # fractional_seaice = 0, ! does not work with ERA-I? 
NOAH_MP='new-v36'
DOMAINS="${DATATYPE,,}-${RES},${DOM}-grid" # lower-case dataset name
FDDA='spectral'
DYNAMICS='default'
DYNAMICS_MOD=' epssm = 0.5, 0.5,'
BDY_CONTROL='clim'
NAMELIST_QUILT=''
# WPS
# SHARE,GEOGRID, and METGRID usually don't have to be set manually
GEOGRID="${DOM},${DOM}-grid"
## namelist modifications by group
# you can make modifications to namelist groups in the {NMLGRP}_MOD variables
# the line in the *_MOD variable will replace the corresponding entry in the template
# you can separate multiple modifications by colons ':'
#PHYSICS_MOD=' cu_physics = 3, 3, 3,: shcu_physics = 0, 0, 0,: sf_surface_physics = 4, 4, 4,'
FLAKE=0 # don't use FLake

## system settings
WRFTOOLS="${HOME}/WRF Tools/"
WRFROOT="${HOME}/WRFV3.6/"
# WRF and WPS wallclock  time limits (no way to query from queue system)
#export WRFWCT='24:00:00' # WRF wallclock time
#export WPSWCT='01:00:00' # WPS wallclock time
#WRFNODES=4
# WPS executables
WPSSYS="Rocks" # also affects unccsm.exe
# set path for metgrid.exe and real.exe explicitly using METEXE and REALEXE
# WRF executable
WRFSYS="Rocks"
# set path for geogrid.exe and wrf.exe eplicitly using GEOEXE and WRFEXE
