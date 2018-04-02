Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeDBGaI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:30:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38357 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751928AbeDBGaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:30:06 -0400
X-Google-Smtp-Source: AIpwx4/Iaa5DcAtZ+3cg4ff3+diI7W0X8ju4WSvxaWJmquxO9JPX0kDdjMTpm7nLV1Cmi0okuQkZvw==
Date: Mon, 2 Apr 2018 08:30:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU changes for v4.17
Message-ID: <20180402063002.l2kaek47dxsaayfh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rcu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

   # HEAD: c4fb5f37001514c0004d17b79cf74a499b9bc320 Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The main RCU subsystem changes in this cycle were:

 - Miscellaneous fixes, perhaps most notably removing obsolete
   code whose only purpose in life was to gather information for
   the now-removed RCU debugfs facility.  Other notable changes
   include removing NO_HZ_FULL_ALL in favor of the nohz_full kernel
   boot parameter, minor optimizations for expedited grace periods,
   some added tracing, creating an RCU-specific workqueue using Tejun's
   new WQ_MEM_RECLAIM flag, and several cleanups to code and comments.

 - SRCU cleanups and optimizations.

 - Torture-test updates, perhaps most notably the adding of ARMv8
   support, but also including numerous cleanups and usability fixes.

 Thanks,

	Ingo

------------------>
Byungchul Park (1):
      srcu: Remove dead code in srcu_gp_end()

Ildar Ismagilov (3):
      rcu: Fix misprint in srcu_funnel_exp_start
      srcu: Prevent sdp->srcu_gp_seq_needed_exp counter wrap
      srcu: Reduce scans of srcu_data in counter wrap check

Lihao Liang (4):
      rcu: Remove unnecessary spinlock in rcu_boot_init_percpu_data()
      doc: Fix typo in rcutorture documentation
      doc: Fix typo in rcu_head comments
      rcutorture: Add basic ARM64 support to run scripts

Liu, Changcheng (1):
      rcu: Remove redundant nxttail index macro define

Matthew Wilcox (1):
      rcu: Use wrapper for lockdep asserts

Paul E. McKenney (26):
      sched/isolation: Eliminate NO_HZ_FULL_ALL
      rcu: Fix CPU offload boot message when no CPUs are offloaded
      rcu: Remove obsolete boost statistics for debugfs
      rcu: Remove obsolete callback-invocation statistics for debugfs
      rcu: Remove obsolete __rcu_pending() statistics for debugfs
      rcu: Remove obsolete force-quiescent-state statistics for debugfs
      rcu: More clearly identify grace-period kthread stack dump
      rcu: Consolidate rcu.h #ifdefs
      rcu: Fix init_rcu_head() comment.
      rcu: Add more tracing of expedited grace periods
      rcu: Trace expedited GP delays due to transitioning CPUs
      rcu: Make expedited RCU CPU selection avoid unnecessary stores
      srcu: Abstract function name
      rcu: Remove SRCU throttling
      rcutorture: Replace multi-instance kzalloc() with kcalloc()
      rcutorture: Abstract function and module names
      rcutorture: Avoid fake-writer use of undefined primitives
      rcutorture: Re-enable testing of dynamic expediting
      rcutorture: Record which grace-period primitives are tested
      rcutorture: Update kvm.sh header comment
      torture: Specify qemu memory size with --memory argument
      torture: Default jitter off when running rcuperf
      torture: Adjust rcuperf trace processing to allow for workqueues
      torture: Grace periods do not piggyback off of themselves
      torture: Provide more sensible nreader/nwriter defaults for rcuperf
      rcu: Create RCU-specific workqueues with rescuers

Tejun Heo (1):
      rcu: Call touch_nmi_watchdog() while printing stall warnings


 Documentation/timers/NO_HZ.txt                     |  7 ---
 include/linux/rcupdate.h                           | 10 +--
 include/linux/types.h                              |  2 +-
 include/trace/events/rcu.h                         |  4 ++
 kernel/rcu/rcu.h                                   | 38 ++++++++----
 kernel/rcu/rcuperf.c                               | 21 ++++++-
 kernel/rcu/rcutorture.c                            | 72 ++++++++++++----------
 kernel/rcu/srcutree.c                              | 29 +++++----
 kernel/rcu/tree.c                                  | 72 ++++++++--------------
 kernel/rcu/tree.h                                  | 36 +----------
 kernel/rcu/tree_exp.h                              | 36 ++++++++---
 kernel/rcu/tree_plugin.h                           | 34 ++++++----
 kernel/time/Kconfig                                | 10 ---
 kernel/time/tick-sched.c                           | 22 +------
 .../testing/selftests/rcutorture/bin/functions.sh  | 17 ++++-
 .../rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh   | 11 ++--
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  4 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      | 22 +++++--
 .../selftests/rcutorture/configs/rcu/TASKS03       |  1 -
 .../selftests/rcutorture/configs/rcu/TASKS03.boot  |  2 +-
 .../selftests/rcutorture/configs/rcu/TREE04        |  1 -
 .../selftests/rcutorture/configs/rcu/TREE04.boot   |  2 +-
 .../selftests/rcutorture/configs/rcu/TREE07        |  1 -
 .../rcutorture/configs/rcuperf/ver_functions.sh    | 24 +-------
 .../selftests/rcutorture/doc/rcu-test-image.txt    |  2 +-
 25 files changed, 238 insertions(+), 242 deletions(-)
