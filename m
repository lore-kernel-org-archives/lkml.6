Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCXLZT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 07:25:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62929 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeCXLZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 07:25:17 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rik van Riel'" <riel@surriel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sat, 24 Mar 2018 12:25:40 +0100
Message-ID: <2389946.11pl7mXBNR@aspire.rjw.lan>
In-Reply-To: <000001d3c2ee$1e45c410$5ad14c30$@net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan> <CAJZ5v0iZVVkevY2oJnySoa6uQesMXcj_ZshV97utdXsW2w-aAA@mail.gmail.com> <000001d3c2ee$1e45c410$5ad14c30$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 23, 2018 10:30:03 PM CET Doug Smythies wrote:
> On 2018.03.23 02:08 Rafael J. Wysocki wrote:
> > On Fri, Mar 23, 2018 at 9:57 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> On Fri, Mar 23, 2018 at 4:19 AM, Doug Smythies <dsmythies@telus.net> wrote:
> >>> On 2018.03.22 12:12 Doug Smythies wrote:
> 
> ...[snip]...
> 
> >>
> >>> I'm not sure how good it is but I made a test. I didn't believe
> >>> the results, so I did it 3 times.
> >>>
> >>> V7.3 is as from the git branch.
> >>> V7.3p is plus the patch adding the counter loop to poll_state.c
> >>>
> >>> The test is a tight loop (about 19600 loops per second) running
> >>> on all 8 CPUs. I can not seem to get my system to use Idle State
> >>> 0, so I disabled Idle States 1 and 2 to force use of Idle State 0.
> >>>
> >>> V7.3 uses a processor package power of 62.5 Watts
> >>> V7.3p uses a processor package power of 53.4 Watts, or 14.6% less power.
> >>>
> >>> The loop times do not change.
> >>> The Idle state 0 residency per unit time does not change.
> >>
> >> OK, so this means that the results should improve for Rik with this
> >> patch too. :-)
> 
> I hope so.
> 
> > BTW, can you possibly check how much of a difference it makes to
> > reduce POLL_IDLE_COUNT in the patch to, say, 500 or even more?
> > 
> > The lower it is, the less noise it will introduce AFAICS.
> 
> Well, we would expect the curve to be something like a typical 1/x curve:
> 
> Power = 53.4 + k1/(k2* POLL_IDLE_COUNT + k3)
> 
> I did some runs and did a crude fit:
> 
> Power ~= 53.4 + 35/(POLL_IDLE_COUNT + 3)
> 
> And then calculate an allowed error from that. A count of 100 gives
> back only 0.64% of the power, and so I suggest would be a reasonable
> number.

I agree.

> That being said, my test is quite crude and we should first see what
> others, including Rik, get.
> 
> These two graphs might help explain what I did:
> 
> http://fast.smythies.com/v73p_vary_count.png
> http://fast.smythies.com/v73p_extra_power.png
> 
> It is just my opinion, but I think users with very stringent
> idle state 0 exit latency requirements should test with
> POLL_IDLE_COUNT set to 1. Then they know the worst case works,
> whereas they might not hit it at 1/POLL_IDLE_COUNT probability.
> Once happy that the worst case works, use nominal (T.B.D.)
> POLL_IDLE_COUNT, for the power savings.

Well, the exit latency is a sort of different story. :-)

Obviously, cpuidle_poll_state_init() lies about the exit latency of the
polling state (which is supposed to be worst-case), but that's for the
polling state to fit the "state 0" slot.  Ideally, the latency should be
really 0, meaning that the polling loop should terminate as soon as an
interrupt occurs (regardless of the need_resched() status).

I have a prototype (appended below) to make that happen which seems to be
working here.

---
 drivers/cpuidle/poll_state.c |    4 +++-
 include/linux/sched.h        |    1 +
 include/linux/sched/idle.h   |   15 +++++++++++++++
 kernel/softirq.c             |   10 ++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

Index: linux-pm/include/linux/sched.h
===================================================================
--- linux-pm.orig/include/linux/sched.h
+++ linux-pm/include/linux/sched.h
@@ -1319,6 +1319,7 @@ extern struct pid *cad_pid;
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
+#define PF_IDLE_POLL		0x10000000	/* I am an idle task in a polling loop */
 #define PF_MUTEX_TESTER		0x20000000	/* Thread belongs to the rt mutex tester */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
Index: linux-pm/include/linux/sched/idle.h
===================================================================
--- linux-pm.orig/include/linux/sched/idle.h
+++ linux-pm/include/linux/sched/idle.h
@@ -84,4 +84,19 @@ static inline void current_clr_polling(v
 	preempt_fold_need_resched();
 }
 
+static inline bool current_may_poll(void)
+{
+	return !!(current->flags & PF_IDLE_POLL);
+}
+
+static inline void current_enable_polling(void)
+{
+	current->flags |= PF_IDLE_POLL;
+}
+
+static inline void current_disable_polling(void)
+{
+	current->flags &= ~PF_IDLE_POLL;
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -17,11 +17,12 @@ static int __cpuidle poll_idle(struct cp
 {
 	u64 time_start = local_clock();
 
+	current_enable_polling();
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count = 0;
 
-		while (!need_resched()) {
+		while (!need_resched() && current_may_poll()) {
 			cpu_relax();
 			if (loop_count++ < POLL_IDLE_COUNT)
 				continue;
@@ -32,6 +33,7 @@ static int __cpuidle poll_idle(struct cp
 		}
 	}
 	current_clr_polling();
+	current_disable_polling();
 
 	return index;
 }
Index: linux-pm/kernel/softirq.c
===================================================================
--- linux-pm.orig/kernel/softirq.c
+++ linux-pm/kernel/softirq.c
@@ -22,6 +22,7 @@
 #include <linux/kthread.h>
 #include <linux/rcupdate.h>
 #include <linux/ftrace.h>
+#include <linux/sched/idle.h>
 #include <linux/smp.h>
 #include <linux/smpboot.h>
 #include <linux/tick.h>
@@ -389,6 +390,14 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
+static inline void idle_irq_exit(void)
+{
+#ifdef CONFIG_CPU_IDLE
+	if (is_idle_task(current))
+		current_disable_polling();
+#endif
+}
+
 /*
  * Exit an interrupt context. Process softirqs if needed and possible:
  */
@@ -405,6 +414,7 @@ void irq_exit(void)
 		invoke_softirq();
 
 	tick_irq_exit();
+	idle_irq_exit();
 	rcu_irq_exit();
 	trace_hardirq_exit(); /* must be last! */
 }
