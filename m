Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeEOSJ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:09:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751859AbeEOSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:09:57 -0400
Date: Tue, 15 May 2018 11:11:20 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, boqun.feng@gmail.com, byungchul.park@lge.com,
        nitzanc@mellanox.com, paul.gortmaker@windriver.com,
        ynorov@caviumnetworks.com, sfr@canb.auug.org.au, npiggin@gmail.com
Subject: [GIT PULL rcu/next] RCU commits for 4.18
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051518-0040-0000-0000-0000042BBEDF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009030; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032756; UDB=6.00528008; IPR=6.00811887;
 MB=3.00021129; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 18:09:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051518-0041-0000-0000-00000831D386
Message-Id: <20180515181120.GA29614@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo!

This pull request contains the following changes:

1.	Updates to the handling of expedited grace periods, perhaps most
	notably parallelizing their initialization.  Other changes
	include fixes from Boqun Feng.

	http://lkml.kernel.org/r/20180423022047.GA20189@linux.vnet.ibm.com

2.	Miscellaneous fixes.  These include an nvme fix from Nitzan Carmi
	that I am carrying because it depends on a new SRCU function
	cleanup_srcu_struct_quiesced().  This branch also includes fixes
	from Byungchul Park and Yury Norov.  Note that several patches
	were deferred to the v4.19 merge window due to late location
	of bugs and late determination of a need for restructuring.

	http://lkml.kernel.org/r/20180423023150.GA21533@linux.vnet.ibm.com

3.	Updates to reduce lock contention in the rcu_node combining tree.
	These are in preparation for the consolidation of RCU-bh,
	RCU-preempt, and RCU-sched into a single flavor, which was
	requested by Linus Torvalds in response to a security flaw
	whose root cause included confusion between the multiple flavors
	of RCU.  There will be another series of contention-reduction
	patches in the next merge window, hopefully accompanied by the
	consolidation itself.

	http://lkml.kernel.org/r/20180423030258.GA23370@linux.vnet.ibm.com

4.	Torture-test updates that save their users some time and effort.

	http://lkml.kernel.org/r/20180423031346.GA28371@linux.vnet.ibm.com

The nvme patch called out in #2 above has a conflict with a commit in
Linus's tree, which was reported by Stephen Rothwell in the course of
his -next testing.  He is carrying a resolution to this conflict as
reported on LKML here:

http://lkml.kernel.org/r/20180514134636.61831bcc@canb.auug.org.au

This resolution looks good to me.

All of these changes have been subjected to 0day Test Robot and -next
testing, and are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo

for you to fetch changes up to 22df7316ac71dc1ac57415349938737d2a229c59:

  Merge branches 'exp.2018.05.15a', 'fixes.2018.05.15a', 'lock.2018.05.15a' and 'torture.2018.05.15a' into HEAD (2018-05-15 10:33:05 -0700)

This merge commit is quite recent, however, the changes are exactly
the same as the previous merge commit (434533a52e8d) dated April 30th.
The only difference is the addition of Nick Piggin's Tested-by to all
of the commit logs (thank you, Nick!).

----------------------------------------------------------------
Boqun Feng (2):
      rcu: exp: Fix "must hold exp_mutex" comments for QS reporting functions
      rcu: exp: Protect all sync_rcu_preempt_exp_done() with rcu_node lock

Byungchul Park (3):
      rcu: Inline rcu_preempt_do_callback() into its sole caller
      rcu: Call wake_nocb_leader_defer() with 'FORCE' when nocb_q_count is high
      rcu: Remove deprecated RCU debugfs tracing code

Nitzan Carmi (1):
      nvme: Avoid flush dependency in delete controller flow

Paul E. McKenney (36):
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
      Merge branches 'exp.2018.05.15a', 'fixes.2018.05.15a', 'lock.2018.05.15a' and 'torture.2018.05.15a' into HEAD

Paul Gortmaker (1):
      doc: Ensure whatisRCU.txt actually says what RCU is

Yury Norov (1):
      rcu: Declare rcu_eqs_special_set() in public header

 Documentation/RCU/whatisRCU.txt                    |   2 +
 drivers/nvme/host/core.c                           |   2 +-
 include/linux/rcupdate.h                           |   4 +-
 include/linux/rcutree.h                            |   1 +
 include/linux/sched.h                              |   8 -
 include/linux/srcu.h                               |  36 ++-
 include/trace/events/rcu.h                         |  13 +-
 kernel/rcu/rcu.h                                   |  12 +-
 kernel/rcu/rcu_segcblist.c                         |  18 --
 kernel/rcu/rcu_segcblist.h                         |   2 -
 kernel/rcu/rcuperf.c                               |   2 +-
 kernel/rcu/rcutorture.c                            |  15 +-
 kernel/rcu/srcutiny.c                              |   9 +-
 kernel/rcu/srcutree.c                              |  30 +-
 kernel/rcu/tree.c                                  | 355 ++++++++-------------
 kernel/rcu/tree.h                                  |  36 ++-
 kernel/rcu/tree_exp.h                              | 235 ++++++++------
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
 29 files changed, 616 insertions(+), 628 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
 delete mode 100755 tools/testing/selftests/rcutorture/bin/parse-torture.sh
