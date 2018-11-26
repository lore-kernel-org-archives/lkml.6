Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A2F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A2F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeK0Kzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:55:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0Kzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:55:47 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 036744A5;
        Mon, 26 Nov 2018 23:59:53 +0000 (UTC)
Date:   Mon, 26 Nov 2018 15:59:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] panic: Avoid the extra noise dmesg
Message-Id: <20181126155952.46d0c641a69746d33f4212e6@linux-foundation.org>
In-Reply-To: <20181108130503.a35cf6yfbkd232go@shbuild888>
References: <1539242268-63036-1-git-send-email-feng.tang@intel.com>
        <20181011093500.GB9848@hirez.programming.kicks-ass.net>
        <20181011095941.mlh675ag5v4fpgos@shbuild888>
        <20181022095515.wxq6dhvix4ujkskv@shbuild888>
        <20181108130503.a35cf6yfbkd232go@shbuild888>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 21:05:03 +0800 Feng Tang <feng.tang@intel.com> wrote:

> Sometimes when debugging kernel panic, we saw many extra noisy error
> messages after the expected end:
> 
> [   35.743249] ---[ end Kernel panic - not syncing: Fatal exception
> [   35.749975] ------------[ cut here ]------------

What are these "noisy messages"?  The above looks OK?

> When panic happens under console mode, the screen will first show the panic
> call stack, but will immediately be overrided by noisy extra messages, like
> this for every CPU except the panic one:
> 
> 	WARNING: CPU: 1 PID: 280 at kernel/sched/core.c:1198 set_task_cpu+0x183/0x190
> 	Call Trace:
> 	<IRQ>
> 	try_to_wake_up
> 	default_wake_function
> 	autoremove_wake_function
> 	__wake_up_common
> 	__wake_up_common_lock
> 	__wake_up
> 	wake_up_klogd_work_func
> 	irq_work_run_list
> 	irq_work_tick
> 	update_process_times
> 	tick_sched_timer
> 	__hrtimer_run_queues
> 	hrtimer_interrupt
> 	smp_apic_timer_interrupt
> 	apic_timer_interrupt

And this output looks OK as well.

> Which make debugging more difficult, as the original context is
> lost on screen.
> 
> Keeping the CPU IRQ disabled will void these messages, as we code
> run to this point, the user has chosed not to reboot, nor do
> some extra handling with panic notifier, not much point in
> re-enabling the interrupt.

And please have another attempt at the above paragraph?

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -295,7 +295,6 @@ void panic(const char *fmt, ...)
>  	}
>  #endif
>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> -	local_irq_enable();
>  	for (i = 0; ; i += PANIC_TIMER_STEP) {
>  		touch_softlockup_watchdog();
>  		if (i >= i_next) {

The patch looks reasonable, but the description is just too hard for me
to follow, sorry.  Please spend a bit more time over that and resend?

