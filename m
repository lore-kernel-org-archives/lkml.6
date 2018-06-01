Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeFABzX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:55:23 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:58777 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeFABzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:55:22 -0400
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: hoeun.ryu@lge.com
X-Original-SENDERIP: 10.159.138.109
X-Original-MAILFROM: hoeun.ryu@lge.com
From: "Hoeun Ryu" <hoeun.ryu@lge.com>
To: "'Petr Mladek'" <pmladek@suse.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky.work@gmail.com>
Cc: "'Hoeun Ryu'" <hoeun.ryu@lge.com.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
References: <1527562331-25880-1-git-send-email-hoeun.ryu@lge.com.com> <20180529121315.GE438@jagdpanzerIV> <20180530083204.m2yvmm7mc6owvpdk@pathway.suse.cz>
In-Reply-To: <20180530083204.m2yvmm7mc6owvpdk@pathway.suse.cz>
Subject: RE: [PATCH]  printk: make printk_safe_flush safe in NMI context by skipping flushing
Date: Fri, 1 Jun 2018 10:55:20 +0900
Message-ID: <045e01d3f94b$98b330a0$ca1991e0$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHGl8zEcapaZebFXoFDB4TGV4TnLwIHjkX5AdFhGqOkRp7l4A==
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I appreciate the detailed correction.
I will reflect the corrections in the next patch.
plus, the explanation in the code will be fixed.

> -----Original Message-----
> From: Petr Mladek [mailto:pmladek@suse.com]
> Sent: Wednesday, May 30, 2018 5:32 PM
> To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Hoeun Ryu <hoeun.ryu@lge.com.com>; Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com>; Steven Rostedt <rostedt@goodmis.org>;
> Hoeun Ryu <hoeun.ryu@lge.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] printk: make printk_safe_flush safe in NMI context by
> skipping flushing
> 
> On Tue 2018-05-29 21:13:15, Sergey Senozhatsky wrote:
> > On (05/29/18 11:51), Hoeun Ryu wrote:
> > >  Make printk_safe_flush() safe in NMI context.
> > > nmi_trigger_cpumask_backtrace() can be called in NMI context. For
> example the
> > > function is called in watchdog_overflow_callback() if the flag of
> hardlockup
> > > backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
> > > watchdog_overflow_callback() function is called in NMI context on some
> > > architectures.
> > >  Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace()
> eventually tries
> > > to lock logbuf_lock in vprintk_emit() but the logbuf_lock can be
> already locked in
> > > preempted contexts (task or irq in this case) or by other CPUs and it
> may cause
> 
> The sentence "logbuf_lock can be already locked in preempted contexts"
> does not
> make much sense. It is a spin lock. It means that both interrupts and
> preemption are disabled.
> 
> I would change it to something like:
> 
> "Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace() eventually
> tries
> to lock logbuf_lock in vprintk_emit() that might be already be part
> of a soft- or hard-lockup on another CPU."
> 
> 
> > > deadlocks.
> > >  By making printk_safe_flush() safe in NMI context, the backtrace
> triggering CPU
> > > just skips flushing if the lock is not avaiable in NMI context. The
> messages in
> > > per-cpu nmi buffer of the backtrace triggering CPU can be lost if the
> CPU is in
> > > hard lockup (because irq is disabled here) but if panic() is not
> called. The
> > > flushing can be delayed by the next irq work in normal cases.
> 
> I somehow miss there a motivation why the current state is better than
> the previous. It looks like we exchange the risk of a deadlock with
> a risk of loosing the messages.
> 
> I see it the following way:
> 
> "This patch prevents a deadlock in printk_safe_flush() in NMI
> context. It makes sure that we continue and eventually call
> printk_safe_flush_on_panic() from panic() that has better
> chances to succeed.
> 
> There is a risk that logbuf_lock was not part of a soft- or
> dead-lockup and we might just loose the messages. But then there is a high
> chance that irq_work will get called and the messages will get flushed
> the normal way."
> 
> 
> > Any chance we can add more info to the commit message? E.g. backtraces
> > which would describe "how" is this possible (like the one I posted in
> > another email). Just to make it more clear.
> 
> I agree that a backtrace would be helpful. But it is not a must to
> have from my point of view.
> 
> The patch itself looks good to me.
> 
> Best Regards,
> Petr
