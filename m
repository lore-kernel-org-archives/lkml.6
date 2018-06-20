Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA802C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D392083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D392083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933583AbeFTVaI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:30:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933232AbeFTVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:30:06 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA213D1D;
        Wed, 20 Jun 2018 21:30:05 +0000 (UTC)
Date:   Wed, 20 Jun 2018 14:30:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hoeun Ryu <hoeun.ryu@lge.com.com>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Hoeun Ryu <hoeun.ryu@lge.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] panic: move bust_spinlocks(0) after
 console_flush_on_panic() to avoid deadlocks
Message-Id: <20180620143004.9dd0cf834acfcff5bd1bcb58@linux-foundation.org>
In-Reply-To: <1528091179-3015-1-git-send-email-hoeun.ryu@lge.com.com>
References: <1528091179-3015-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Jun 2018 14:45:57 +0900 Hoeun Ryu <hoeun.ryu@lge.com.com> wrote:

> From: Hoeun Ryu <hoeun.ryu@lge.com>
> 
>  Many console device drivers hold the uart_port->lock spinlock with irq enabled
> (using spin_lock()) while the device drivers are writing characters to their devices,
> but the device drivers just try to hold the spin lock (using spin_trylock()) if
> "oops_in_progress" is equal or greater than 1 to avoid deadlocks.
> 
>  There is a case ocurring a deadlock related to the lock and oops_in_progress. A CPU
> could be stopped by smp_send_stop() while it was holding the port lock because irq was
> enabled. Once a CPU stops, it doesn't respond interrupts anymore and the lock stays
> locked forever.
> 
>  console_flush_on_panic() is called during panic() and it eventually holds the uart
> lock but the lock is held by another stopped CPU and it is a deadlock. By moving
> bust_spinlocks(0) after console_flush_on_panic(), let the console device drivers
> think the Oops is still in progress to call spin_trylock() instead of spin_lock() to
> avoid the deadlock.

hm.  Sergey, is this at all related to the UART printk deadlock change
which you're presently discussing in
http://lkml.kernel.org/r/20180615093919.559-1-sergey.senozhatsky@gmail.com?

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
>  	 * smp_send_stop()) while still having some valuable data in the console
> @@ -246,6 +244,8 @@ void panic(const char *fmt, ...)
>  	debug_locks_off();
>  	console_flush_on_panic();
>  
> +	bust_spinlocks(0);
> +
>  	if (!panic_blink)
>  		panic_blink = no_blink;
>  

