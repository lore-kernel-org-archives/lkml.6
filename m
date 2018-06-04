Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeFDIuC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:50:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55730 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:49:59 -0400
X-Google-Smtp-Source: ADUXVKLIojzdEL3YxnoljkUIZNyjMGVzv+SoScPDi/WtrcFOf9XrTFHOITy6itnWOoQJCGGp/zgKQQ==
Date: Mon, 4 Jun 2018 10:49:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU changes for v4.18
Message-ID: <20180604084955.GA12702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rcu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

   # HEAD: 52f2b34f46223ca2789320fa10c13f6664c1b628 Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The changes in this cycle were:

 - Updates to the handling of expedited grace periods.

 - Updates to reduce lock contention in the rcu_node combining tree.
   ( These are in preparation for the consolidation of RCU-bh,
     RCU-preempt, and RCU-sched into a single flavor, which was
     requested by Linus in response to a security flaw whose root cause
     included confusion between the multiple flavors of RCU. )

 - Torture-test updates that save their users some time and effort.

 - Miscellaneous fixes.

Thanks,

	Ingo

------------------>
Boqun Feng (2):
      rcu: exp: Fix "must hold exp_mutex" comments for QS reporting functions
      rcu: exp: Protect all sync_rcu_preempt_exp_done() with rcu_node lock

Byungchul Park (3):
      rcu: Inline rcu_preempt_do_callback() into its sole caller
      rcu: Call wake_nocb_leader_defer() with 'FORCE' when nocb_q_count is high
      rcu: Remove deprecated RCU debugfs tracing code

Nitzan Carmi (1):
      nvme: Avoid flush dependency in delete controller flow

Paul E. McKenney (35):
      rcu: Parallelize expedited grace-period initialization
      rcu: Don't allocate rcu_nocb_mask if no one needs it
      rcu: Rename cond_resched_rcu_qs() to cond_resched_tasks_rcu_qs()
      softirq: Eliminate unused cond_resched_softirq() macro
      rcu: Move __rcu_read_lock() and __rcu_read_unlock() to tree_plugin.h
      rcu: Update rcu_bind_gp_kthread() header comment
      srcu: Add cleanup_srcu_struct_quiesced()
      rcu: Add leaf-node macros
      rcu: Improve non-root rcu_cbs_completed() accuracy
      rcu: Make rcu_start_future_gp()'s grace-period check more precise
      rcu: Add accessor macros for the ->need_future_gp[] array
      rcu: Make rcu_gp_kthread() check for early-boot activity
      rcu: Make rcu_gp_cleanup() more accurately predict need for new GP
      rcu: Avoid losing ->need_future_gp[] values due to GP start/end races
      rcu: Make rcu_future_needs_gp() check all ->need_future_gps[] elements
      rcu: Convert ->need_future_gp[] array to boolean
      rcu: Make rcu_migrate_callbacks wake GP kthread when needed
      rcu: Avoid __call_rcu_core() root rcu_node ->lock acquisition
      rcu: Switch __rcu_process_callbacks() to rcu_accelerate_cbs()
      rcu: Cleanup, don't put ->completed into an int
      rcu: Clear request other than RCU_GP_FLAG_INIT at GP end
      rcu: Inline rcu_start_gp_advanced() into rcu_start_future_gp()
      rcu: Make rcu_start_future_gp() caller select grace period
      rcu: Add funnel locking to rcu_start_this_gp()
      rcu: Make rcu_start_this_gp() check for out-of-range requests
      rcu: The rcu_gp_cleanup() function does not need cpu_needs_another_gp()
      rcu: Simplify and inline cpu_needs_another_gp()
      rcu: Drop early GP request check from rcu_gp_kthread()
      rcu: Update list of rcu_future_grace_period() trace events
      torture: Add a script to edit output from failed runs
      torture: Fold parse-torture.sh into parse-console.sh
      rcutorture: Print end-of-test state
      rcutorture: Print end-of-test state in kvm.sh summary
      rcutorture: Abbreviate kvm.sh summary lines
      torture: Make kvm-find-errors.sh find build warnings

Paul Gortmaker (1):
      doc: Ensure whatisRCU.txt actually says what RCU is

Peter Zijlstra (1):
      rcu/x86: Provide early rcu_cpu_starting() callback

Yury Norov (1):
      rcu: Declare rcu_eqs_special_set() in public header


 Documentation/RCU/whatisRCU.txt                    |   2 +
 arch/x86/kernel/cpu/mtrr/main.c                    |   4 +
 drivers/nvme/host/core.c                           |   2 +-
 include/linux/rcupdate.h                           |   5 +-
 include/linux/rcutiny.h                            |   1 +
 include/linux/rcutree.h                            |   2 +
 include/linux/sched.h                              |   8 -
 include/linux/srcu.h                               |  36 +-
 include/trace/events/rcu.h                         |  13 +-
 kernel/rcu/rcu.h                                   |  12 +-
 kernel/rcu/rcu_segcblist.c                         |  18 -
 kernel/rcu/rcu_segcblist.h                         |   2 -
 kernel/rcu/rcuperf.c                               |   2 +-
 kernel/rcu/rcutorture.c                            |  15 +-
 kernel/rcu/srcutiny.c                              |   9 +-
 kernel/rcu/srcutree.c                              |  30 +-
 kernel/rcu/tree.c                                  | 364 ++++++++-------------
 kernel/rcu/tree.h                                  |  36 +-
 kernel/rcu/tree_exp.h                              | 235 +++++++------
 kernel/rcu/tree_plugin.h                           |  98 +++---
 kernel/rcu/update.c                                |  50 +--
 kernel/sched/core.c                                |  14 -
 kernel/softirq.c                                   |   3 +-
 kernel/torture.c                                   |   2 +-
 kernel/trace/trace_benchmark.c                     |   4 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |  56 ++++
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |  12 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   4 -
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |   1 -
 .../selftests/rcutorture/bin/parse-console.sh      | 115 ++++++-
 .../selftests/rcutorture/bin/parse-torture.sh      | 105 ------
 31 files changed, 631 insertions(+), 629 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
 delete mode 100755 tools/testing/selftests/rcutorture/bin/parse-torture.sh
