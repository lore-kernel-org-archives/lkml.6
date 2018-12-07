Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D96C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE122083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE122083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLGJuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:50:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:18029 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLGJuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:50:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 01:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="125892940"
Received: from shbuild999.sh.intel.com ([10.239.146.218])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2018 01:50:18 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Subject: [PATCH v4] panic: Avoid the extra noise dmesg
Date:   Fri,  7 Dec 2018 17:51:19 +0800
Message-Id: <1544176279-77828-1-git-send-email-feng.tang@intel.com>
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
call stack, but immediately overridded by these noisy extra messages, which
makes debugging much more difficult, as the original context gets lost on
screen.

Also these noisy messages will confuse some users, as I have seen many bug
reporters posted the noisy message into bugzilla, instead of the real panic
call stack and context.

Keeping the interrupt disabled will avoid the noisy message.

When code runs to this point, it means user has chosed to not reboot, or
do any special handling by using the panic notifier method, the only reason
to enable the interrupt may be sysrq migic key and panic_blink function
(though may not work even with irq enabled). 

So make the irq disabled by default and add a cmdline parameter
"panic_keep_irq_on" to turn it on when needed.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: stable@kernel.org
---
Changelog:

  v4:
     - make the local_irq_enable conditional and default off
       to cover possible use of interrupt/scheduling, as
       mentioned by Sergey and Petr
  v3:
     - Make the change log clearer as suggested by Andrew Morton
  v2:
     - Move the solution from hacking arch/scheduler code back
       to panic.c

 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 kernel/panic.c                                  | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ad8dc61..45621e9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3093,6 +3093,12 @@
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
+	panic_keep_irq_on
+			To keep the panic call stack info clean and suppress
+			noisy kernel message, the interrupt on panic cpu is
+			disabled by default. Add this to cmdline to enable
+			interrupt for panic cpu.
+
 	crash_kexec_post_notifiers
 			Run kdump after running panic-notifiers and dumping
 			kmsg. This only for the users who doubt kdump always
diff --git a/kernel/panic.c b/kernel/panic.c
index 85c4d14..04ace9b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -40,6 +40,7 @@ static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
+bool panic_keep_irq_on;
 int panic_on_warn __read_mostly;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
@@ -322,7 +323,12 @@ void panic(const char *fmt, ...)
 	}
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
-	local_irq_enable();
+
+	if (panic_keep_irq_on)
+		local_irq_enable();
+	else
+		pr_emerg("Please add panic_keep_irq_on to cmdline if you want blink/sysrq to work.");
+
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
 		if (i >= i_next) {
@@ -684,6 +690,7 @@ core_param(panic, panic_timeout, int, 0644);
 core_param(panic_print, panic_print, ulong, 0644);
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
+core_param(panic_keep_irq_on, panic_keep_irq_on, bool, 0644);
 core_param(crash_kexec_post_notifiers, crash_kexec_post_notifiers, bool, 0644);
 
 static int __init oops_setup(char *s)
-- 
2.7.4

