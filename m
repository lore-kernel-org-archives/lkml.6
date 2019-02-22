Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A7FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E8720823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfBVGAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:00:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:7937 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfBVGAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:00:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 22:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="322458806"
Received: from shbuild999.sh.intel.com ([10.239.147.118])
  by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2019 21:59:59 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v5] panic: Avoid the extra noise dmesg
Date:   Fri, 22 Feb 2019 14:00:26 +0800
Message-Id: <1550815226-34194-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel panic happens, it will first print the panic call stack,
then the ending msg like:

[   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
[   35.749975] ------------[ cut here ]------------

The above message are very useful for debugging.

But if system is configured to not reboot on panic, say the "panic_timeout"
parameter equals 0, it will likely print out many noisy message like
WARN() call stack for each and every CPU except the panic one, messages
like below:

	WARNING: CPU: 1 PID: 280 at kernel/sched/core.c:1198 set_task_cpu+0x183/0x190
	Call Trace:
	<IRQ>
	try_to_wake_up
	default_wake_function
	autoremove_wake_function
	__wake_up_common
	__wake_up_common_lock
	__wake_up
	wake_up_klogd_work_func
	irq_work_run_list
	irq_work_tick
	update_process_times
	tick_sched_timer
	__hrtimer_run_queues
	hrtimer_interrupt
	smp_apic_timer_interrupt
	apic_timer_interrupt

For people working in console mode, the screen will first show the panic
call stack, but immediately overridden by these noisy extra messages, which
makes debugging much more difficult, as the original context gets lost on
screen.

Also these noisy messages will confuse some users, as I have seen many bug
reporters posted the noisy message into bugzilla, instead of the real panic
call stack and context.

Adding a flag panic_suppress_printk to avoid those noisy message, without
changing the current kernel behavior that both panic blinking and sysrq
magic key can work as is, suggested by Petr Mladek.

To verify this, make sure kernel is not configured to reboot on panic and
in console
 # echo c > /proc/sysrq-trigger
to see if console only prints out the panic call stack.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Sasha Levin <sashal@kernel.org>
---
Change log:

  v5:
    - use a flag to notify printk not to print unimportant
      messages, while keep panic blinking and sysrq working,
      as suggested by Petr Mladek

  v4:
    - make the local_irq_enable conditional and default off
    to cover possible use of interrupt/scheduling, as
    mentioned by Sergey and Petr

  v3:
    - Make the change log clearer as suggested by Andrew Morton

  v2:
    - Move the solution from hacking arch/scheduler code back
    to panic.c

 drivers/tty/sysrq.c    | 6 ++++++
 include/linux/kernel.h | 1 +
 kernel/panic.c         | 5 +++++
 kernel/printk/printk.c | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f03078..763e24c 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -527,8 +527,12 @@ void __handle_sysrq(int key, bool check_mask)
 {
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
+	int orig_panic_suppress_printk;
 	int i;
 
+	orig_panic_suppress_printk = panic_suppress_printk;
+	panic_suppress_printk = 0;
+
 	rcu_sysrq_start();
 	rcu_read_lock();
 	/*
@@ -574,6 +578,8 @@ void __handle_sysrq(int key, bool check_mask)
 	}
 	rcu_read_unlock();
 	rcu_sysrq_end();
+
+	panic_suppress_printk = orig_panic_suppress_printk;
 }
 
 void handle_sysrq(int key)
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e..4120f3a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -534,6 +534,7 @@ extern int panic_on_io_nmi;
 extern int panic_on_warn;
 extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_panic_on_stackoverflow;
+extern int panic_suppress_printk;
 
 extern bool crash_kexec_post_notifiers;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index f121e6b..b9f004e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -46,6 +46,8 @@ int panic_on_warn __read_mostly;
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
+int panic_suppress_printk;
+
 #define PANIC_PRINT_TASK_INFO		0x00000001
 #define PANIC_PRINT_MEM_INFO		0x00000002
 #define PANIC_PRINT_TIMER_INFO		0x00000004
@@ -326,6 +328,9 @@ void panic(const char *fmt, ...)
 	}
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
+
+	/* Do not scroll important messages printed above */
+	panic_suppress_printk = 1;
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d1703..4f44d64 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1899,6 +1899,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 	unsigned long flags;
 	u64 curr_log_seq;
 
+	/* Suppress unimportant messages after panic happens */
+	if (unlikely(panic_suppress_printk))
+		return 0;
+
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		in_sched = true;
@@ -1987,6 +1991,7 @@ asmlinkage __visible int printk(const char *fmt, ...)
 	va_list args;
 	int r;
 
+
 	va_start(args, fmt);
 	r = vprintk_func(fmt, args);
 	va_end(args);
-- 
2.7.4

