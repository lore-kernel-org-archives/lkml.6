Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330CBC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B4120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B4120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeKHWds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:33:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:30816 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbeKHWdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:33:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 04:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="84930924"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2018 04:58:23 -0800
Date:   Thu, 8 Nov 2018 21:05:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] panic: Avoid the extra noise dmesg
Message-ID: <20181108130503.a35cf6yfbkd232go@shbuild888>
References: <1539242268-63036-1-git-send-email-feng.tang@intel.com>
 <20181011093500.GB9848@hirez.programming.kicks-ass.net>
 <20181011095941.mlh675ag5v4fpgos@shbuild888>
 <20181022095515.wxq6dhvix4ujkskv@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022095515.wxq6dhvix4ujkskv@shbuild888>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when debugging kernel panic, we saw many extra noisy error
messages after the expected end:

[   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
[   35.749975] ------------[ cut here ]------------

When panic happens under console mode, the screen will first show the panic
call stack, but will immediately be overrided by noisy extra messages, like
this for every CPU except the panic one:

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

Which make debugging more difficult, as the original context is
lost on screen.

Keeping the CPU IRQ disabled will void these messages, as we code
run to this point, the user has chosed not to reboot, nor do
some extra handling with panic notifier, not much point in
re-enabling the interrupt.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
---
 kernel/panic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index f6d549a29a5c..a616e55ab57e 100644
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
2.14.1

