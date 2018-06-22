Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D58C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7FA23D53
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7FA23D53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeFVE7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:59:21 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:39138 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbeFVE7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:59:19 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 22 Jun 2018 13:59:17 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: hoeun.ryu@lge.com
Received: from unknown (HELO WMRRD11NA1021G) (10.159.138.109)
        by 156.147.1.151 with ESMTP; 22 Jun 2018 13:59:17 +0900
X-Original-SENDERIP: 10.159.138.109
X-Original-MAILFROM: hoeun.ryu@lge.com
From:   "Hoeun Ryu" <hoeun.ryu@lge.com>
To:     "'Hoeun Ryu'" <hoeun.ryu@lge.com.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Kees Cook'" <keescook@chromium.org>,
        "'Andi Kleen'" <ak@linux.intel.com>,
        "'Borislav Petkov'" <bp@suse.de>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Steven Rostedt \(VMware\)'" <rostedt@goodmis.org>
Cc:     <sergey.senozhatsky.work@gmail.com>, <pmladek@suse.com>,
        "'Josh Poimboeuf'" <jpoimboe@redhat.com>,
        "'Tejun Heo'" <tj@kernel.org>,
        "'Vitaly Kuznetsov'" <vkuznets@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <1528165248-17914-1-git-send-email-hoeun.ryu@lge.com.com>
In-Reply-To: <1528165248-17914-1-git-send-email-hoeun.ryu@lge.com.com>
Subject: RE: [PATCH v2] panic: move bust_spinlocks(0) after console_flush_on_panic() to avoid deadlocks
Date:   Fri, 22 Jun 2018 13:59:17 +0900
Message-ID: <01e801d409e5$c615b860$52412920$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFE/u0yIeeUKl1bBv8s7vNEgQ0k16WJzGmA
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC
sergey.senozhatsky.work@gmail.com
pmladek@suse.com

Please review this patch.

> -----Original Message-----
> From: Hoeun Ryu [mailto:hoeun.ryu@lge.com.com]
> Sent: Tuesday, June 05, 2018 11:19 AM
> To: Andrew Morton <akpm@linux-foundation.org>; Kees Cook
> <keescook@chromium.org>; Andi Kleen <ak@linux.intel.com>; Borislav Petkov
> <bp@suse.de>; Thomas Gleixner <tglx@linutronix.de>; Steven Rostedt
(VMware)
> <rostedt@goodmis.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>; Tejun Heo <tj@kernel.org>;
> Vitaly Kuznetsov <vkuznets@redhat.com>; Hoeun Ryu <hoeun.ryu@lge.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v2] panic: move bust_spinlocks(0) after
> console_flush_on_panic() to avoid deadlocks
> 
> From: Hoeun Ryu <hoeun.ryu@lge.com>
> 
>  Many console device drivers hold the uart_port->lock spinlock with irq
> disabled
> (using spin_lock_irqsave()) while the device drivers are writing
> characters to their
> devices, but the device drivers just try to hold the spin lock (using
> spin_trylock_irqsave()) instead if "oops_in_progress" is equal or greater
> than 1 to
> avoid deadlocks.
> 
>  There is a case ocurring a deadlock related to the lock and
> oops_in_progress. If the
> kernel lockup detector calls panic() while the device driver is holding
> the lock,
> it can cause a deadlock because panic() eventually calls console_unlock()
> and tries
> to hold the lock. Here is an example.
> 
>  CPU0
> 
>  local_irq_save()
>  .
>  foo()
>  bar()
>  .						// foo() + bar() takes long
time
>  printk()
>    console_unlock()
>      call_console_drivers()			// close to watchdog
threshold
>        some_slow_console_device_write()		// device driver
code
>          spin_lock_irqsave(uart->lock)		// acquire uart spin
lock
>            slow-write()
>              watchdog_overflow_callback()	// watchdog expired and call
> panic()
>                panic()
>                  bust_spinlocks(0)		// now, oops_in_progress = 0
>                    console_flush_on_panic()
>                      console_unlock()
>                        call_console_drivers()
>                          some_slow_console_device_write()
>                            spin_lock_irqsave(uart->lock)
>                            ^^^^ deadlock	// we can use
> spin_trylock_irqsave()
> 
>  console_flush_on_panic() is called in panic() and it eventually holds the
> uart
> lock but the lock is held by the preempted CPU (the same CPU in NMI
> context) and it is
> a deadlock.
>  By moving bust_spinlocks(0) after console_flush_on_panic(), let the
> console device
> drivers think the Oops is still in progress to call spin_trylock_irqsave()
> instead of
> spin_lock_irqsave() to avoid the deadlock.
> 
>  CPU0
> 
>  watchdog_overflow_callback()			// watchdog expired and
> call panic()
>    panic()
>      console_flush_on_panic()
>        console_unlock()
>          call_console_drivers()
>            some_slow_console_device_write()
>              spin_trylock_irqsave(uart->lock)	// oops_in_progress = 1
>              ^^^^ use trylock, no deadlock
>      bust_spinlocks(0)				// now,
oops_in_progress =
> 0
> 
> Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
> ---
>  v2: fix commit message on the reason of a deadlock, no code change.
> 
>  kernel/panic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 42e4874..b4063b6 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -233,8 +233,6 @@ void panic(const char *fmt, ...)
>  	if (_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
> 
> -	bust_spinlocks(0);
> -
>  	/*
>  	 * We may have ended up stopping the CPU holding the lock (in
>  	 * smp_send_stop()) while still having some valuable data in the
> console
> @@ -246,6 +244,8 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic();
> 
> +	bust_spinlocks(0);
> +
>  	if (!panic_blink)
>  		panic_blink = no_blink;
> 
> --
> 2.1.4

