Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937078AbeE2Wnf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:43:35 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:34388 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935813AbeE2Wne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:43:34 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hoeun.ryu@lge.com
X-Original-SENDERIP: 10.159.138.109
X-Original-MAILFROM: hoeun.ryu@lge.com
From: "Hoeun Ryu" <hoeun.ryu@lge.com>
To: "'Sergey Senozhatsky'" <sergey.senozhatsky.work@gmail.com>,
        "'Hoeun Ryu'" <hoeun.ryu@lge.com.com>
Cc: "'Petr Mladek'" <pmladek@suse.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
References: <1527562331-25880-1-git-send-email-hoeun.ryu@lge.com.com> <20180529121315.GE438@jagdpanzerIV>
In-Reply-To: <20180529121315.GE438@jagdpanzerIV>
Subject: RE: [PATCH]  printk: make printk_safe_flush safe in NMI context by skipping flushing
Date: Wed, 30 May 2018 07:43:32 +0900
Message-ID: <03d301d3f79e$78ec4580$6ac4d080$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHGl8zEcapaZebFXoFDB4TGV4TnLwIHjkX5pFHQraA=
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Sergey Senozhatsky [mailto:sergey.senozhatsky.work@gmail.com]
> Sent: Tuesday, May 29, 2018 9:13 PM
> To: Hoeun Ryu <hoeun.ryu@lge.com.com>
> Cc: Petr Mladek <pmladek@suse.com>; Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com>; Steven Rostedt <rostedt@goodmis.org>;
> Hoeun Ryu <hoeun.ryu@lge.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] printk: make printk_safe_flush safe in NMI context by
> skipping flushing
> 
> On (05/29/18 11:51), Hoeun Ryu wrote:
> >  Make printk_safe_flush() safe in NMI context.
> > nmi_trigger_cpumask_backtrace() can be called in NMI context. For
> example the
> > function is called in watchdog_overflow_callback() if the flag of
> hardlockup
> > backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
> > watchdog_overflow_callback() function is called in NMI context on some
> > architectures.
> >  Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace()
> eventually tries
> > to lock logbuf_lock in vprintk_emit() but the logbuf_lock can be already
> locked in
> > preempted contexts (task or irq in this case) or by other CPUs and it
> may cause
> > deadlocks.
> >  By making printk_safe_flush() safe in NMI context, the backtrace
> triggering CPU
> > just skips flushing if the lock is not avaiable in NMI context. The
> messages in
> > per-cpu nmi buffer of the backtrace triggering CPU can be lost if the
> CPU is in
> > hard lockup (because irq is disabled here) but if panic() is not called.
> The
> > flushing can be delayed by the next irq work in normal cases.
> 
> Any chance we can add more info to the commit message? E.g. backtraces
> which would describe "how" is this possible (like the one I posted in
> another email). Just to make it more clear.
> 

OK, I will.

> > @@ -254,6 +254,16 @@ void printk_safe_flush(void)
> >  {
> >  	int cpu;
> >
> > +	/*
> > +	 * Just avoid deadlocks here, we could loose the messages in per-
> cpu nmi buffer
> > +	 * in the case that hardlockup happens but panic() is not called
> (irq_work won't
> > +	 * work).
> > +	 * The flushing can be delayed by the next irq_work if flushing is
> skippped here
>
^^ skipped
> 

Typo will be fixed.

> 	-ss
