Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeDQONZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:13:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:14815 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDQONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:13:23 -0400
To: dvyukov@google.com
Cc: sowmini.varadhan@oracle.com, ebiggers3@gmail.com,
        syzkaller-bugs@googlegroups.com, peterz@infradead.org,
        syzkaller@googlegroups.com, peterz@infradead.org, mingo@kernel.org,
        akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        msb@chromium.org, tglx@linutronix.de, vegard.nossum@oracle.com
Subject: [PATCH] sysrq: Allow obtaining SysRq upon kernel panic event.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <CACT4Y+Zhv4TgRcaZB7EVg0oK=DwLZF9X5zHJW9zadWQVJWxpSg@mail.gmail.com>
        <201804122220.BCB00091.HMtSQFLOFOFOVJ@I-love.SAKURA.ne.jp>
        <CACT4Y+ZDPXVU3uQLrXX1okkDaswJDDdNupCWVN+GeSaXPi4m4g@mail.gmail.com>
        <201804150140.ECH90673.VOFMJLHOOFFtSQ@I-love.SAKURA.ne.jp>
        <CACT4Y+YhHefKVH5Emw8sBMvq9et7JxN2WGnuRN-c-930p3fLxA@mail.gmail.com>
In-Reply-To: <CACT4Y+YhHefKVH5Emw8sBMvq9et7JxN2WGnuRN-c-930p3fLxA@mail.gmail.com>
Message-Id: <201804172313.GGB86422.LFOtOJFMOSHFVQ@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Tue, 17 Apr 2018 23:13:18 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Sat, Apr 14, 2018 at 6:40 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Dmitry Vyukov wrote:
> >> On Thu, Apr 12, 2018 at 3:20 PM, Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> > Dmitry Vyukov wrote:
> >> >> > I browsed demo_setup.sh and thought that we could use a simple wrapper approach
> >> >> > provided that questions below are solved.
> >> >> >
> >> >> > Question 1: When does the syzbot kill the qemu process?
> >> >>
> >> >> First thing is that syzbot uses GCE VMs as test machines rather than
> >> >> qemu (it can also test on android phones, some arm boards, etc, but
> >> >> we, of course, don't need to support all of them).
> >> >>
> >> >> GCE VMs don't have dump-guest-memory thing.
> >> >
> >> > Ouch! I thought syzbot runs tests inside qemu. ;-)
> >> >
> >> > Then, exporting only tests which found bugs under GCE VMs in order to
> >> > try to capture vmcore by reproducing under qemu might be useful...
> >>
> >> Yes, but then it's a whole new subsystem, some queueing mechanism,
> >> deployment and maintenance. There is also a question of how images
> >> will be shared, or otherwise the qemu subsystem will need to
> >> constantly rebuild images on specified git tree/commit/config/compiler
> >> for each test. And also dumps will probably be most useful exactly for
> >> bugs that can't be reliably reproduced (otherwise one just reproduce
> >> it locally and then obtain any required info).
> >> I think it's better long term to invest into kdump-based dump
> >> collection from GCE VMs. Since it does not depend on VMM features it
> >> can also be transparently extended to qemu, android phones, etc.
> >>
> >
> > But kdump on GCE VMs is not available right now. Until kdump becomes available,
> > I want to use SysRq-t just before the system halts. There are many hung up or
> > stall reports but it is difficult to understand what is happening.
> >
> > I updated wrapper.c to use notification from pvpanic module (CONFIG_PVPANIC=y).
> > Then, I noticed that we might be able to utilize panic notifier as a trigger
> > for obtaining SysRq-t. The code is shown below.
> >
> > ----------------------------------------
> > #include <linux/sched/debug.h>
> > #include <linux/notifier.h>
> > #include <linux/init.h>
> >
> > static int sysrq_on_panic_notify(struct notifier_block *nb, unsigned long code,
> >                                  void *unused)
> > {
> >         show_state();
> >         show_workqueue_state();
> >         return NOTIFY_DONE;
> > }
> >
> > static struct notifier_block sysrq_on_panic_nb = {
> >         .notifier_call = sysrq_on_panic_notify,
> > };
> >
> > static int __init sysrq_on_panic_init(void)
> > {
> >         atomic_notifier_chain_register(&panic_notifier_list,
> >                                        &sysrq_on_panic_nb);
> >         return 0;
> > }
> > late_initcall(sysrq_on_panic_init);
> > ----------------------------------------
> >
> > Maybe this code (with enable/disable switch added) is suitable for
> > drivers/tty/sysrq.c for environments where kdump is not available.
> 
> Interesting.
> If we have something like this, this may be the simplest way to obtain
> additional info. syzkaller already captures console output and we have
> panic_on_warn=1 and we definitely can enable CONFIG_PVPANIC, or any
> other config.
> We probably also want cpu backtraces. This probably should be
> configurable to some degree as to what types of info are dumped.
> 
Something like this?

>From 82f156636ab2ed4d1042d765a27aa23c109d5197 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 17 Apr 2018 22:50:30 +0900
Subject: [PATCH] sysrq: Allow obtaining SysRq upon kernel panic event.

While syzbot is finding many hungup bugs and stall bugs, currently we
can't capture vmcore on the platform which syzbot is running tests.
This situation makes us difficult to understand what is happening.

For now, allowing syzbot to obtain SysRq-t and SysRq-l just before
the kernel halts would be helpful. And this will remain true even after
it became possible to capture vmcore on the platform which syzbot uses.

Therefore, this patch utilizes panic notifier callback in order to allow
administrators to obtain SysRq under environments where it is difficult
to configure kdump.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/sysrq.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6364890..bc099f2 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1128,6 +1128,54 @@ static inline void sysrq_init_procfs(void)
 
 #endif /* CONFIG_PROC_FS */
 
+/*
+ * Allow administrators to obtain SysRq upon panic() for environments where
+ * kdump is not available. Types to obtain is configured as bitmask of the
+ * following values. Can be set at sysrq.dump_on_panic= kernel command line
+ * and get/set via /sys/module/sysrq/parameters/dump_on_panic .
+ *
+ *  1 == "Show State" (SysRq-t).
+ *  2 == "Show Blocked State" (SysRq-w). Implied by "Show State".
+ *  4 == "Show Locks Held" (SysRq-d). Implied by "Show State".
+ *  8 == "Show workqueue state". Implied by "Show State".
+ * 16 == "Show backtrace of all active CPUs" (SysRq-l).
+ */
+static unsigned int sysrq_on_panic;
+
+static int sysrq_on_panic_notify(struct notifier_block *nb, unsigned long code,
+				 void *unused)
+{
+	if (sysrq_on_panic & 1) {
+		sysrq_handle_showstate(0);
+	} else {
+		if (sysrq_on_panic & 2)
+			sysrq_handle_showstate_blocked(0);
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (sysrq_on_panic & 4))
+			debug_show_all_locks();
+		if (sysrq_on_panic & 8)
+			show_workqueue_state();
+	}
+	/* No fall back, for we can't wait when we are already in panic(). */
+	if (IS_ENABLED(CONFIG_SMP) && (sysrq_on_panic & 16))
+		trigger_all_cpu_backtrace();
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sysrq_panic_nb = {
+	.notifier_call = sysrq_on_panic_notify,
+	/*
+	 * Call me after panic notifiers for watchdogs are told that there is
+	 * no need to warn again because we are already in panic() state.
+	 */
+	.priority = -1,
+};
+
+static inline void sysrq_register_panic_handler(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list, &sysrq_panic_nb);
+}
+module_param_named(dump_on_panic, sysrq_on_panic, uint, 0644);
+
 static int __init sysrq_init(void)
 {
 	sysrq_init_procfs();
@@ -1135,6 +1183,7 @@ static int __init sysrq_init(void)
 	if (sysrq_on())
 		sysrq_register_handler();
 
+	sysrq_register_panic_handler();
 	return 0;
 }
 device_initcall(sysrq_init);
-- 
1.8.3.1
