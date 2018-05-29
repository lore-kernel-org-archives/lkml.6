Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933983AbeE2MNW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:13:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43078 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeE2MNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:13:19 -0400
X-Google-Smtp-Source: AB8JxZpBipfSbQYw4wuGwNX8KPus3G3NvTeUiuNjn25UogSdNYnWKsafnNtwWJpNu9S56gmJminO4A==
Date: Tue, 29 May 2018 21:13:15 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Hoeun Ryu <hoeun.ryu@lge.com.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Hoeun Ryu <hoeun.ryu@lge.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  printk: make printk_safe_flush safe in NMI context by
 skipping flushing
Message-ID: <20180529121315.GE438@jagdpanzerIV>
References: <1527562331-25880-1-git-send-email-hoeun.ryu@lge.com.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527562331-25880-1-git-send-email-hoeun.ryu@lge.com.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/29/18 11:51), Hoeun Ryu wrote:
>  Make printk_safe_flush() safe in NMI context.
> nmi_trigger_cpumask_backtrace() can be called in NMI context. For example the
> function is called in watchdog_overflow_callback() if the flag of hardlockup
> backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
> watchdog_overflow_callback() function is called in NMI context on some
> architectures.
>  Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace() eventually tries
> to lock logbuf_lock in vprintk_emit() but the logbuf_lock can be already locked in
> preempted contexts (task or irq in this case) or by other CPUs and it may cause
> deadlocks.
>  By making printk_safe_flush() safe in NMI context, the backtrace triggering CPU
> just skips flushing if the lock is not avaiable in NMI context. The messages in
> per-cpu nmi buffer of the backtrace triggering CPU can be lost if the CPU is in
> hard lockup (because irq is disabled here) but if panic() is not called. The
> flushing can be delayed by the next irq work in normal cases.

Any chance we can add more info to the commit message? E.g. backtraces
which would describe "how" is this possible (like the one I posted in
another email). Just to make it more clear.

> @@ -254,6 +254,16 @@ void printk_safe_flush(void)
>  {
>  	int cpu;
>  
> +	/*
> +	 * Just avoid deadlocks here, we could loose the messages in per-cpu nmi buffer
> +	 * in the case that hardlockup happens but panic() is not called (irq_work won't
> +	 * work).
> +	 * The flushing can be delayed by the next irq_work if flushing is skippped here
									   ^^ skipped

	-ss
