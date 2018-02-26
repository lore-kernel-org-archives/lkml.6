Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeBZV6s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:58:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751679AbeBZVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:52:51 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 06/20] rcu: Call touch_nmi_watchdog() while printing stall warnings
Date: Mon, 26 Feb 2018 13:52:56 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226215219.GA27379@linux.vnet.ibm.com>
References: <20180226215219.GA27379@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022621-2213-0000-0000-000002764558
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995530; UDB=6.00506033; IPR=6.00774858;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 21:52:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022621-2214-0000-0000-0000593F37D1
Message-Id: <1519681990-31349-6-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: Tejun Heo <tj@kernel.org>

When RCU stall warning triggers, it can print out a lot of messages
while holding spinlocks.  If the console device is slow (e.g. an
actual or IPMI serial console), it may end up triggering NMI hard
lockup watchdog like the following.

*** CPU printking while holding RCU spinlock

  PID: 4149739  TASK: ffff881a46baa880  CPU: 13  COMMAND: "CPUThreadPool8"
   #0 [ffff881fff945e48] crash_nmi_callback at ffffffff8103f7d0
   #1 [ffff881fff945e58] nmi_handle at ffffffff81020653
   #2 [ffff881fff945eb0] default_do_nmi at ffffffff81020c36
   #3 [ffff881fff945ed0] do_nmi at ffffffff81020d32
   #4 [ffff881fff945ef0] end_repeat_nmi at ffffffff81956a7e
      [exception RIP: io_serial_in+21]
      RIP: ffffffff81630e55  RSP: ffff881fff943b88  RFLAGS: 00000002
      RAX: 000000000000ca00  RBX: ffffffff8230e188  RCX: 0000000000000000
      RDX: 00000000000002fd  RSI: 0000000000000005  RDI: ffffffff8230e188
      RBP: ffff881fff943bb0   R8: 0000000000000000   R9: ffffffff820cb3c4
      R10: 0000000000000019  R11: 0000000000002000  R12: 00000000000026e1
      R13: 0000000000000020  R14: ffffffff820cd398  R15: 0000000000000035
      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
  --- <NMI exception stack> ---
   #5 [ffff881fff943b88] io_serial_in at ffffffff81630e55
   #6 [ffff881fff943b90] wait_for_xmitr at ffffffff8163175c
   #7 [ffff881fff943bb8] serial8250_console_putchar at ffffffff816317dc
   #8 [ffff881fff943bd8] uart_console_write at ffffffff8162ac00
   #9 [ffff881fff943c08] serial8250_console_write at ffffffff81634691
  #10 [ffff881fff943c80] univ8250_console_write at ffffffff8162f7c2
  #11 [ffff881fff943c90] console_unlock at ffffffff810dfc55
  #12 [ffff881fff943cf0] vprintk_emit at ffffffff810dffb5
  #13 [ffff881fff943d50] vprintk_default at ffffffff810e01bf
  #14 [ffff881fff943d60] vprintk_func at ffffffff810e1127
  #15 [ffff881fff943d70] printk at ffffffff8119a8a4
  #16 [ffff881fff943dd0] print_cpu_stall_info at ffffffff810eb78c
  #17 [ffff881fff943e88] rcu_check_callbacks at ffffffff810ef133
  #18 [ffff881fff943ee8] update_process_times at ffffffff810f3497
  #19 [ffff881fff943f10] tick_sched_timer at ffffffff81103037
  #20 [ffff881fff943f38] __hrtimer_run_queues at ffffffff810f3f38
  #21 [ffff881fff943f88] hrtimer_interrupt at ffffffff810f442b

*** CPU triggering the hardlockup watchdog

  PID: 4149709  TASK: ffff88010f88c380  CPU: 26  COMMAND: "CPUThreadPool35"
   #0 [ffff883fff1059d0] machine_kexec at ffffffff8104a874
   #1 [ffff883fff105a30] __crash_kexec at ffffffff811116cc
   #2 [ffff883fff105af0] __crash_kexec at ffffffff81111795
   #3 [ffff883fff105b08] panic at ffffffff8119a6ae
   #4 [ffff883fff105b98] watchdog_overflow_callback at ffffffff81135dbd
   #5 [ffff883fff105bb0] __perf_event_overflow at ffffffff81186866
   #6 [ffff883fff105be8] perf_event_overflow at ffffffff81192bc4
   #7 [ffff883fff105bf8] intel_pmu_handle_irq at ffffffff8100b265
   #8 [ffff883fff105df8] perf_event_nmi_handler at ffffffff8100489f
   #9 [ffff883fff105e58] nmi_handle at ffffffff81020653
  #10 [ffff883fff105eb0] default_do_nmi at ffffffff81020b94
  #11 [ffff883fff105ed0] do_nmi at ffffffff81020d32
  #12 [ffff883fff105ef0] end_repeat_nmi at ffffffff81956a7e
      [exception RIP: queued_spin_lock_slowpath+248]
      RIP: ffffffff810da958  RSP: ffff883fff103e68  RFLAGS: 00000046
      RAX: 0000000000000000  RBX: 0000000000000046  RCX: 00000000006d0000
      RDX: ffff883fff49a950  RSI: 0000000000d10101  RDI: ffffffff81e54300
      RBP: ffff883fff103e80   R8: ffff883fff11a950   R9: 0000000000000000
      R10: 000000000e5873ba  R11: 000000000000010f  R12: ffffffff81e54300
      R13: 0000000000000000  R14: ffff88010f88c380  R15: ffffffff81e54300
      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
  --- <NMI exception stack> ---
  #13 [ffff883fff103e68] queued_spin_lock_slowpath at ffffffff810da958
  #14 [ffff883fff103e70] _raw_spin_lock_irqsave at ffffffff8195550b
  #15 [ffff883fff103e88] rcu_check_callbacks at ffffffff810eed18
  #16 [ffff883fff103ee8] update_process_times at ffffffff810f3497
  #17 [ffff883fff103f10] tick_sched_timer at ffffffff81103037
  #18 [ffff883fff103f38] __hrtimer_run_queues at ffffffff810f3f38
  #19 [ffff883fff103f88] hrtimer_interrupt at ffffffff810f442b
  --- <IRQ stack> ---

Avoid spuriously triggering NMI hardlockup watchdog by touching it
from the print functions.  show_state_filter() shares the same problem
and solution.

v2: Relocate the comment to where it belongs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_plugin.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 93f5649ffd2b..7e31fb1e9fd8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -560,8 +560,14 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 	}
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
-	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry)
+	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		/*
+		 * We could be printing a lot while holding a spinlock.
+		 * Avoid triggering hard lockup.
+		 */
+		touch_nmi_watchdog();
 		sched_show_task(t);
+	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
@@ -1677,6 +1683,12 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 	char *ticks_title;
 	unsigned long ticks_value;
 
+	/*
+	 * We could be printing a lot while holding a spinlock.  Avoid
+	 * triggering hard lockup.
+	 */
+	touch_nmi_watchdog();
+
 	if (rsp->gpnum == rdp->gpnum) {
 		ticks_title = "ticks this GP";
 		ticks_value = rdp->ticks_this_gp;
-- 
2.5.2
