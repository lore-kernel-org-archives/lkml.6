Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeBZVya (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:54:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751853AbeBZVwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:53 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Mike Galbraith <efault@gmx.de>, Rik van Riel <riel@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>, John Stultz <john.stultz@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH tip/core/rcu 02/20] sched/isolation: Eliminate NO_HZ_FULL_ALL
Date: Mon, 26 Feb 2018 13:52:52 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-0040-0000-0000-000003FD5BDC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-0041-0000-0000-000007FE65E8
Message-Id: <1519681990-31349-2-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6f1982fedd59 ("sched/isolation: Handle the nohz_full= parameter")
broke CONFIG_NO_HZ_FULL_ALL=y kernels.  This breakage is due to the code
under CONFIG_NO_HZ_FULL_ALL failing to invoke the shiny new housekeeping
functions.  This means that rcutorture scenario TREE04 now emits RCU CPU
stall warnings due to the RCU grace-period kthreads not being awakened
at a time of their choosing, or perhaps even not at all:

[   27.731422] rcu_bh kthread starved for 21001 jiffies! g18446744073709551369 c18446744073709551368 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=3
[   27.731423] rcu_bh          I14936     9      2 0x80080000
[   27.731435] Call Trace:
[   27.731440]  __schedule+0x31a/0x6d0
[   27.731442]  schedule+0x31/0x80
[   27.731446]  schedule_timeout+0x15a/0x320
[   27.731453]  ? call_timer_fn+0x130/0x130
[   27.731457]  rcu_gp_kthread+0x66c/0xea0
[   27.731458]  ? rcu_gp_kthread+0x66c/0xea0

Because no one has complained about CONFIG_NO_HZ_FULL_ALL=y being broken,
I hypothesize that no one is in fact using it, other than rcutorture.
This commit therefore eliminates CONFIG_NO_HZ_FULL_ALL and updates
rcutorture's config files to instead use the nohz_full= kernel parameter
to put the desired CPUs into nohz_full mode.

Fixes: 6f1982fedd59 ("sched/isolation: Handle the nohz_full= parameter")

Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/timers/NO_HZ.txt                     |  7 -------
 kernel/time/Kconfig                                | 10 ----------
 kernel/time/tick-sched.c                           | 22 ++--------------------
 .../selftests/rcutorture/configs/rcu/TASKS03       |  1 -
 .../selftests/rcutorture/configs/rcu/TASKS03.boot  |  2 +-
 .../selftests/rcutorture/configs/rcu/TREE04        |  1 -
 .../selftests/rcutorture/configs/rcu/TREE04.boot   |  2 +-
 .../selftests/rcutorture/configs/rcu/TREE07        |  1 -
 8 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/Documentation/timers/NO_HZ.txt b/Documentation/timers/NO_HZ.txt
index 2dcaf9adb7a7..9591092da5e0 100644
--- a/Documentation/timers/NO_HZ.txt
+++ b/Documentation/timers/NO_HZ.txt
@@ -131,13 +131,6 @@ error message, and the boot CPU will be removed from the mask.  Note that
 this means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
-Alternatively, the CONFIG_NO_HZ_FULL_ALL=y Kconfig parameter specifies
-that all CPUs other than the boot CPU are adaptive-ticks CPUs.  This
-Kconfig parameter will be overridden by the "nohz_full=" boot parameter,
-so that if both the CONFIG_NO_HZ_FULL_ALL=y Kconfig parameter and
-the "nohz_full=1" boot parameter is specified, the boot parameter will
-prevail so that only CPU 1 will be an adaptive-ticks CPU.
-
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.
 This is covered in the "RCU IMPLICATIONS" section below.
 
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index f6b5f19223d6..78eabc41eaa6 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -113,16 +113,6 @@ config NO_HZ_FULL
 
 endchoice
 
-config NO_HZ_FULL_ALL
-       bool "Full dynticks system on all CPUs by default (except CPU 0)"
-       depends on NO_HZ_FULL
-       help
-         If the user doesn't pass the nohz_full boot option to
-	 define the range of full dynticks CPUs, consider that all
-	 CPUs in the system are full dynticks by default.
-	 Note the boot CPU will still be kept outside the range to
-	 handle the timekeeping duty.
-
 config NO_HZ
 	bool "Old Idle dynticks config"
 	depends on !ARCH_USES_GETTIMEOFFSET && GENERIC_CLOCKEVENTS
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 29a5733eff83..ccd3782da0bf 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -405,30 +405,12 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	return 0;
 }
 
-static int tick_nohz_init_all(void)
-{
-	int err = -1;
-
-#ifdef CONFIG_NO_HZ_FULL_ALL
-	if (!alloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL)) {
-		WARN(1, "NO_HZ: Can't allocate full dynticks cpumask\n");
-		return err;
-	}
-	err = 0;
-	cpumask_setall(tick_nohz_full_mask);
-	tick_nohz_full_running = true;
-#endif
-	return err;
-}
-
 void __init tick_nohz_init(void)
 {
 	int cpu, ret;
 
-	if (!tick_nohz_full_running) {
-		if (tick_nohz_init_all() < 0)
-			return;
-	}
+	if (!tick_nohz_full_running)
+		return;
 
 	/*
 	 * Full dynticks uses irq work to drive the tick rescheduling on safe
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03 b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
index c70c51d5ded1..28568b72a31b 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03
@@ -9,5 +9,4 @@ CONFIG_PREEMPT=y
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
-CONFIG_NO_HZ_FULL_ALL=y
 #CHECK#CONFIG_RCU_EXPERT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03.boot
index cd2a188eeb6d..838297c58318 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TASKS03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKS03.boot
@@ -1 +1 @@
-rcutorture.torture_type=tasks
+rcutorture.torture_type=tasks nohz_full=1
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index 27d22695d64c..24c9f6012e35 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
-CONFIG_NO_HZ_FULL_ALL=y
 CONFIG_RCU_FAST_NO_HZ=y
 CONFIG_RCU_TRACE=y
 CONFIG_HOTPLUG_CPU=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
index e34c33430447..e6071bb96c7d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
@@ -1 +1 @@
-rcutorture.torture_type=rcu_bh rcutree.rcu_fanout_leaf=4
+rcutorture.torture_type=rcu_bh rcutree.rcu_fanout_leaf=4 nohz_full=1-7
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index 0f4759f4232e..d7afb271a586 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -7,7 +7,6 @@ CONFIG_PREEMPT=n
 CONFIG_HZ_PERIODIC=n
 CONFIG_NO_HZ_IDLE=n
 CONFIG_NO_HZ_FULL=y
-CONFIG_NO_HZ_FULL_ALL=n
 CONFIG_RCU_FAST_NO_HZ=n
 CONFIG_RCU_TRACE=y
 CONFIG_HOTPLUG_CPU=y
-- 
2.5.2
