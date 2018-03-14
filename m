Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeCNIBU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:01:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:28548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753110AbeCNIBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:01:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,469,1515484800";
   d="scan'208";a="211400579"
Message-ID: <1521014472.2087.32.camel@intel.com>
Subject: Re: [PATCH V4] thermal: Add cooling device's statistics in sysfs
From: Zhang Rui <rui.zhang@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date: Wed, 14 Mar 2018 16:01:12 +0800
In-Reply-To: <1520924571.3766.8.camel@intel.com>
References: <6e557b90950723065d49c9a545146ce31d7dc6e1.1516096153.git.viresh.kumar@linaro.org>
         <1520924571.3766.8.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 二, 2018-03-13 at 15:02 +0800, Zhang Rui wrote:
> Hi, Viresh,
> 
> I will queue it for 4.17, with just one minor fix below.
> 
I got the following warning from checkpatch.pl
---------------

WARNING: please write a paragraph that describes the config symbol
fully
#147: FILE: drivers/thermal/Kconfig:18:
+config THERMAL_STATISTICS

WARNING: Consider renaming function(s)
'thermal_cooling_device_total_trans_show' to 'total_trans_show'
#391: FILE: drivers/thermal/thermal_sysfs.c:901:
+}

WARNING: Consider renaming function(s)
'thermal_cooling_device_time_in_state_show' to 'time_in_state_show'
#395: FILE: drivers/thermal/thermal_sysfs.c:905:
+static DEVICE_ATTR(time_in_state, 0444,

WARNING: Consider renaming function(s)
'thermal_cooling_device_reset_store' to 'reset_store'
#397: FILE: drivers/thermal/thermal_sysfs.c:907:
+static DEVICE_ATTR(reset, 0200, NULL,
thermal_cooling_device_reset_store);

WARNING: Consider renaming function(s)
'thermal_cooling_device_trans_table_show' to 'trans_table_show'
#398: FILE: drivers/thermal/thermal_sysfs.c:908:
+static DEVICE_ATTR(trans_table, 0444,

total: 0 errors, 5 warnings, 366 lines checked


I'm okay with the first one because the description does not have to be
larger than 3 lines.
the last 4 warnings makes sense to me. I think we should rename the
function and use DEVICE_ATTR_RO() and DEVICE_ATTR_WO() instead.

what do you think?

thanks,
rui

> On 二, 2018-01-16 at 15:22 +0530, Viresh Kumar wrote:
> > 
> > This extends the sysfs interface for thermal cooling devices and
> > exposes
> > some pretty useful statistics. These statistics have proven to be
> > quite
> > useful specially while doing benchmarks related to the task
> > scheduler,
> > where we want to make sure that nothing has disrupted the test,
> > specially the cooling device which may have put constraints on the
> > CPUs.
> > The information exposed here tells us to what extent the CPUs were
> > constrained by the thermal framework.
> > 
> > The write-only "reset" file is used to reset the statistics.
> > 
> > The read-only "time_in_state" file shows the clock_t time spent by
> > the
> > device in the respective cooling states, and it prints one line per
> > cooling state.
> > 
> > The read-only "total_trans" file shows single positive integer
> > value
> > showing the total number of cooling state transitions the device
> > has
> > gone through since the time the cooling device is registered or the
> > time
> > when statistics were reset last.
> > 
> > The read-only "trans_table" file shows a two dimensional matrix,
> > where
> > an entry <i,j> (row i, column j) represents the number of
> > transitions
> > from State_i to State_j.
> > 
> > This is how the directory structure looks like for a single cooling
> > device:
> > 
> > $ ls -R /sys/class/thermal/cooling_device0/
> > /sys/class/thermal/cooling_device0/:
> > cur_state  max_state  power  stats  subsystem  type  uevent
> > 
> > /sys/class/thermal/cooling_device0/power:
> > autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> > control               runtime_status
> > 
> > /sys/class/thermal/cooling_device0/stats:
> > reset  time_in_state  total_trans  trans_table
> > 
> > This is tested on ARM 64-bit Hisilicon hikey620 board running
> > Ubuntu
> > and
> > ARM 64-bit Hisilicon hikey960 board running Android.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> [snip]
> 
> > 
> > +static void cooling_device_stats_setup(struct
> > thermal_cooling_device
> > *cdev)
> > +{
> > +	struct cooling_dev_stats *stats;
> > +	unsigned long states;
> > +	int var;
> > +
> > +	if (cdev->ops->get_max_state(cdev, &states))
> > +		return;
> > +
> > +	states++; /* Total number of states is highest state + 1
> > */
> > +
> > +	var = sizeof(*stats);
> > +	var += sizeof(*stats->time_in_state) * states;
> > +	var += sizeof(*stats->trans_table) * states * states;
> > +
> > +	stats = kzalloc(var, GFP_KERNEL);
> > +	if (!stats)
> > +		return;
> > +
> > +	stats->time_in_state = (ktime_t *)(stats + 1);
> > +	stats->trans_table = (unsigned int *)(stats->time_in_state 
> > +
> > states);
> > +	cdev->stats = stats;
> > +	stats->last_time = ktime_get();
> > +	stats->max_states = states;
> > +	cdev->stats = stats;
> > +
> cdev->stats is set twice here, I will remove the first one.
> 
> thanks,
> rui
