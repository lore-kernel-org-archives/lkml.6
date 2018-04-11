Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeDKNPh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:15:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39121 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeDKNPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:15:35 -0400
X-Google-Smtp-Source: AIpwx4+6fXUGg+Qc87kJnZNcH7gXCdAtR57uliuDvsEr27gDp1LA/QKt6/FE7TrUad55jqM1ryaS2AhVOit65WbQxMg=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Apr 2018 15:15:33 +0200
X-Google-Sender-Auth: V6nf78jme8sUWNEhJhKM6y2OLdk
Message-ID: <CAJZ5v0ix6HLnQfvwTD7TAH9zrgo=1sUmCMJ3ecsLaPw+ddxm5g@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.17-rc1-2

with top-most commit 51798deaffb738ef3bdd4f544b11ce2adaff40f3

 Merge branches 'pm-cpuidle' and 'pm-qos'

on top of commit 38c23685b273cfb4ccf31a199feccce3bdcb5d83

 Merge tag 'armsoc-drivers' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc

to receive additional power management updates for 4.17-rc1.

These include one big-ticket item which is the rework of the idle
loop in order to prevent CPUs from spending too much time in shallow
idle states.  It reduces idle power on some systems by 10% or more
and may improve performance of workloads in which the idle loop
overhead matters.  This has been in the works for several weeks and
it has been tested and reviewed quite thoroughly.

Also included are changes that finalize the cpufreq cleanup moving
frequency table validation from drivers to the core, a few fixes and
cleanups of cpufreq drivers, a cpuidle documentation update and a
PM QoS core update to mark the expected switch fall-throughs in it.

Specifics:

 - Rework the idle loop in order to prevent CPUs from spending too
   much time in shallow idle states by making it stop the scheduler
   tick before putting the CPU into an idle state only if the idle
   duration predicted by the idle governor is long enough.  That
   required the code to be reordered to invoke the idle governor
   before stopping the tick, among other things (Rafael Wysocki,
   Frederic Weisbecker, Arnd Bergmann).

 - Add the missing description of the residency sysfs attribute to
   the cpuidle documentation (Prashanth Prakash).

 - Finalize the cpufreq cleanup moving frequency table validation
   from drivers to the core (Viresh Kumar).

 - Fix a clock leak regression in the armada-37xx cpufreq driver
   (Gregory Clement).

 - Fix the initialization of the CPU performance data structures
   for shared policies in the CPPC cpufreq driver (Shunyong Yang).

 - Clean up the ti-cpufreq, intel_pstate and CPPC cpufreq drivers
   a bit (Viresh Kumar, Rafael Wysocki).

 - Mark the expected switch fall-throughs in the PM QoS core (Gustavo
   Silva).

Thanks!


---------------

Arnd Bergmann (1):
      tick-sched: avoid a maybe-uninitialized warning

Frederic Weisbecker (1):
      nohz: Gather tick_sched booleans under a common flag field

Gregory CLEMENT (1):
      cpufreq: armada-37xx: Fix clock leak

Gustavo A. R. Silva (1):
      PM / QoS: mark expected switch fall-throughs

Prakash, Prashanth (1):
      cpuidle: Add definition of residency to sysfs documentation

Rafael J. Wysocki (13):
      time: tick-sched: Reorganize idle tick management code
      sched: idle: Do not stop the tick upfront in the idle loop
      sched: idle: Do not stop the tick before cpuidle_idle_call()
      jiffies: Introduce USER_TICK_USEC and redefine TICK_USEC
      cpuidle: Return nohz hint from cpuidle_select()
      time: tick-sched: Split tick_nohz_stop_sched_tick()
      time: hrtimer: Introduce hrtimer_next_event_without()
      sched: idle: Select idle state before stopping the tick
      cpuidle: menu: Refine idle state selection for running tick
      cpuidle: menu: Avoid selecting shallow states with stopped tick
      nohz: Avoid duplication of code related to got_idle_tick
      time: hrtimer: Use timerqueue_iterate_next() to get to the next timer
      cpufreq: intel_pstate: Do not include debugfs.h

Shunyong Yang (1):
      cpufreq: CPPC: Initialize shared perf capabilities of CPUs

Viresh Kumar (4):
      cpufreq: ti-cpufreq: Use builtin_platform_driver()
      cpufreq: CPPC: Don't set transition_latency
      cpufreq: SCMI: Don't validate the frequency table twice
      cpufreq: Drop cpufreq_table_validate_and_show()

---------------

 Documentation/cpu-freq/core.txt        |  12 +-
 Documentation/cpu-freq/cpu-drivers.txt |   6 +-
 Documentation/cpuidle/sysfs.txt        |   6 +
 arch/x86/xen/smp_pv.c                  |   1 +
 drivers/cpufreq/armada-37xx-cpufreq.c  |   2 +
 drivers/cpufreq/cppc_cpufreq.c         |  15 +-
 drivers/cpufreq/freq_table.c           |  14 --
 drivers/cpufreq/intel_pstate.c         |   1 -
 drivers/cpufreq/scmi-cpufreq.c         |  10 +-
 drivers/cpufreq/ti-cpufreq.c           |   2 +-
 drivers/cpuidle/cpuidle.c              |  10 +-
 drivers/cpuidle/governors/ladder.c     |   3 +-
 drivers/cpuidle/governors/menu.c       | 113 ++++++++++++---
 drivers/net/ethernet/sfc/mcdi.c        |   2 +-
 include/linux/cpufreq.h                |   2 -
 include/linux/cpuidle.h                |   8 +-
 include/linux/hrtimer.h                |   1 +
 include/linux/jiffies.h                |   7 +-
 include/linux/tick.h                   |  25 +++-
 kernel/power/qos.c                     |   2 +
 kernel/sched/idle.c                    |  34 ++++-
 kernel/time/hrtimer.c                  |  53 ++++++-
 kernel/time/ntp.c                      |   2 +-
 kernel/time/tick-sched.c               | 250 +++++++++++++++++++++++----------
 kernel/time/tick-sched.h               |  18 ++-
 25 files changed, 438 insertions(+), 161 deletions(-)
