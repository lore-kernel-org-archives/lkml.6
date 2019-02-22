Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D145C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FB420652
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfBVKhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:37:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:51158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfBVKhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:37:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 697DCAD29;
        Fri, 22 Feb 2019 10:37:33 +0000 (UTC)
Date:   Fri, 22 Feb 2019 11:37:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 11/25] printk_safe: remove printk safe code
Message-ID: <20190222103732.zkcvjijtdcfu4vbt@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-12-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:49, John Ogness wrote:
> vprintk variants are now NMI-safe so there is no longer a need for
> the "safe" calls.
> 
> NOTE: This also removes printk flushing functionality.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/hardirq.h     |   2 -
>  include/linux/printk.h      |  27 ---
>  init/main.c                 |   1 -
>  kernel/kexec_core.c         |   1 -
>  kernel/panic.c              |   3 -
>  kernel/printk/Makefile      |   1 -
>  kernel/printk/internal.h    |  30 +---
>  kernel/printk/printk.c      |  13 +-
>  kernel/printk/printk_safe.c | 427 --------------------------------------------
>  kernel/trace/trace.c        |   2 -
>  lib/nmi_backtrace.c         |   6 -
>  11 files changed, 7 insertions(+), 506 deletions(-)
>  delete mode 100644 kernel/printk/printk_safe.c

From my POV, this is the primary selling argument for the new
ring buffer.


> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b6a6f1002741..073ff9fd6872 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1752,6 +1745,11 @@ asmlinkage int vprintk_emit(int facility, int level,
>  }
>  EXPORT_SYMBOL(vprintk_emit);
>  
> +__printf(1, 0) int vprintk_func(const char *fmt, va_list args)
> +{
> +	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
> +}

All vprintk_func() calls should get replaced with vprintk_default().
It includes a crazy hack to reuse some kernel code (that calls
printk() in kdb code.


>  asmlinkage int vprintk(const char *fmt, va_list args)
>  {
>  	return vprintk_func(fmt, args);
> diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> index 15ca78e1c7d4..77bf84987cda 100644
> --- a/lib/nmi_backtrace.c
> +++ b/lib/nmi_backtrace.c
> @@ -75,12 +75,6 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>  		touch_softlockup_watchdog();
>  	}
>  
> -	/*
> -	 * Force flush any remote buffers that might be stuck in IRQ context
> -	 * and therefore could not run their irq_work.
> -	 */
> -	printk_safe_flush();
> -
>  	clear_bit_unlock(0, &backtrace_flag);
>  	put_cpu();
>  }

This reminds me that we need to add back the locking that was
removed in the commit 03fc7f9c99c1e7ae2925d45 ("printk/nmi:
Prevent deadlock when accessing the main log buffer in NMI").

Otherwise, backtraces from different CPUs would get mixed.

We need to add this before redirecting printk() to
the new ring buffer.

Best Regards,
Petr
