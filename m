Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DD7208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DD7208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLDFmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:42:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:58909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbeLDFmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:42:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 21:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,312,1539673200"; 
   d="scan'208";a="115748415"
Received: from shbuild999.sh.intel.com ([10.239.146.218])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2018 21:42:48 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, stable@kernel.org
Subject: [PATCH v3] panic: Avoid the extra noise dmesg
Date:   Tue,  4 Dec 2018 13:43:48 +0800
Message-Id: <1543902228-23834-1-git-send-email-feng.tang@intel.com>
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

Removing the "local_irq_enable" will avoid the noisy message.

The justification for the removing is: when code runs to this point, it
means user has chosed to not reboot, or do any special handling by using
the panic notifier method, no much point in re-enabling the interrupt.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: stable@kernel.org
---
 kernel/panic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index f6d549a..a616e55 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -295,7 +295,6 @@ void panic(const char *fmt, ...)
 	}
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
-	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
 		touch_softlockup_watchdog();
 		if (i >= i_next) {
-- 
2.7.4

