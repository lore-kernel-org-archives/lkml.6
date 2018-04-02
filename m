Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeDBIvv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 04:51:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52370 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeDBIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 04:51:50 -0400
X-Google-Smtp-Source: AIpwx4+eqIGmKMXAGO3s+n3AcM7Ka3OsQdmWIbbvRMobp2K28i+swhGOt9yAnvrBi0F2stLWJ0x54w==
Date: Mon, 2 Apr 2018 10:51:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler changes for v4.17
Message-ID: <20180402085146.asht73murbfbhycz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

   # HEAD: b720342849fe685310fca01748a32730a6eca5aa sched/core: Update preempt_notifier_key to modern API

The main scheduler changes in this cycle were:

 - NUMA balancing improvements               (Mel Gorman)

 - Further load tracking improvements        (Patrick Bellasi)

 - Various NOHZ balancing cleanups and
   optimizations                             (Peter Zijlstra)

 - Improve blocked load handling, in particular we can now reduce
   and eventually stop periodic load updates on 'very idle' CPUs.

                                             (Vincent Guittot)

 - On isolated CPUs offload the final 1Hz scheduler tick as well,
   plus related cleanups and reorganization.
                                             (Frederic Weisbecker)

 - Core scheduler code cleanups              (Ingo Molnar)

 Thanks,

	Ingo

------------------>
Claudio Scordino (1):
      sched/cpufreq: Rate limits for SCHED_DEADLINE

Davidlohr Bueso (1):
      sched/core: Update preempt_notifier_key to modern API

Frederic Weisbecker (7):
      sched/core: Rename init_rq_hrtick() to hrtick_rq_init()
      nohz: Convert tick_nohz_tick_stopped() to bool
      nohz: Allow to check if remote CPU tick is stopped
      sched/isolation: Isolate workqueues when "nohz_full=" is set
      sched/isolation: Offload residual 1Hz scheduler tick
      sched/nohz: Remove the 1 Hz tick code
      sched/isolation: Update nohz documentation to explain tick offload

Ingo Molnar (5):
      sched: Clean up and harmonize the coding style of the scheduler code base
      sched/headers: Simplify and clean up header usage in the scheduler
      sched/idle: Merge kernel/sched/idle.c and kernel/sched/idle_task.c
      sched/deadline, rt: Rename queue_push_tasks/queue_pull_task to create separate namespace
      sched/core: Undefine tracepoint creation at the end of core.c

Mario Leinweber (1):
      sched/deadline: Clean up various coding style details

Mel Gorman (5):
      sched/fair: Avoid an unnecessary lookup of current CPU ID during wake_affine
      sched/fair: Defer calculation of 'prev_eff_load' in wake_affine_weight() until needed
      sched/fair: Do not migrate on wake_affine_weight() if weights are equal
      sched/fair: Consider SD_NUMA when selecting the most idle group to schedule on
      sched/numa: Delay retrying placement for automatic NUMA balance after wake_affine()

Norbert Manthey (1):
      sched/fair: Add ';' after label attributes

Patrick Bellasi (4):
      sched/fair: Add util_est on top of PELT
      sched/fair: Use util_est in LB and WU paths
      sched/cpufreq/schedutil: Use util_est for OPP selection
      sched/fair: Update util_est only on util_avg updates

Peter Zijlstra (15):
      sched/fair: Do not migrate due to a sync wakeup on exit
      cpufreq/schedutil: Remove unused CPUFREQ_DL
      cpufreq/schedutil: Rewrite CPUFREQ_RT support
      sched/core: Convert nohz_flags to atomic_t
      sched/fair: Add NOHZ_STATS_KICK
      sched/fair: Restructure nohz_balance_kick()
      sched/fair: Add NOHZ stats balancing
      sched/fair: Update blocked load from NEWIDLE
      sched/nohz: Clean up nohz enter/exit
      sched/cpufreq: Provide migration hint
      sched/nohz: Optimize nohz_idle_balance()
      sched/fair: Move rebalance_domains()
      sched/nohz: Merge CONFIG_NO_HZ_COMMON blocks
      sched/fair: Move idle_balance()
      sched/core: Remove TASK_ALL

Vincent Guittot (4):
      sched/fair: Remove stray space in #ifdef
      sched/nohz: Stop NOHZ stats when decayed
      sched/fair: Reduce the periodic update duration
      sched/fair: Update blocked load when newly idle

gaurav jindal (1):
      sched/completions: Use bool in try_wait_for_completion()


 Documentation/admin-guide/kernel-parameters.txt |   11 +
 include/linux/sched.h                           |   30 +-
 include/linux/sched/cpufreq.h                   |    5 +-
 include/linux/sched/deadline.h                  |    6 -
 include/linux/sched/isolation.h                 |    1 +
 include/linux/sched/nohz.h                      |    6 -
 include/linux/tick.h                            |    4 +-
 kernel/sched/Makefile                           |    5 +-
 kernel/sched/autogroup.c                        |   21 +-
 kernel/sched/autogroup.h                        |   12 +-
 kernel/sched/clock.c                            |   36 +-
 kernel/sched/completion.c                       |   11 +-
 kernel/sched/core.c                             |  186 ++-
 kernel/sched/cpuacct.c                          |   33 +-
 kernel/sched/cpudeadline.c                      |   23 +-
 kernel/sched/cpudeadline.h                      |   29 +-
 kernel/sched/cpufreq.c                          |    1 -
 kernel/sched/cpufreq_schedutil.c                |  221 ++--
 kernel/sched/cpupri.c                           |   15 +-
 kernel/sched/cpupri.h                           |   25 +-
 kernel/sched/cputime.c                          |   58 +-
 kernel/sched/deadline.c                         |   82 +-
 kernel/sched/debug.c                            |  103 +-
 kernel/sched/fair.c                             | 1479 +++++++++++++++--------
 kernel/sched/features.h                         |    5 +
 kernel/sched/idle.c                             |  142 ++-
 kernel/sched/idle_task.c                        |  110 --
 kernel/sched/isolation.c                        |   14 +-
 kernel/sched/loadavg.c                          |   34 +-
 kernel/sched/membarrier.c                       |   27 +-
 kernel/sched/rt.c                               |   60 +-
 kernel/sched/sched.h                            |  650 +++++-----
 kernel/sched/stats.c                            |   20 +-
 kernel/sched/stats.h                            |   86 +-
 kernel/sched/stop_task.c                        |   11 +-
 kernel/sched/swait.c                            |    6 +-
 kernel/sched/topology.c                         |   46 +-
 kernel/sched/wait.c                             |   13 +-
 kernel/sched/wait_bit.c                         |   23 +-
 kernel/time/tick-sched.c                        |   22 +-
 kernel/workqueue.c                              |    3 +-
 41 files changed, 2114 insertions(+), 1561 deletions(-)
 delete mode 100644 kernel/sched/idle_task.c
