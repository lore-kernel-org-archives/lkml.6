Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeFAJFj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:05:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeFAJFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:05:36 -0400
Date: Fri, 1 Jun 2018 11:05:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Hoeun Ryu <hoeun.ryu@lge.com>
Cc: "'Sergey Senozhatsky'" <sergey.senozhatsky.work@gmail.com>,
        "'Hoeun Ryu'" <hoeun.ryu@lge.com.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  printk: make printk_safe_flush safe in NMI context by
 skipping flushing
Message-ID: <20180601090533.kvklyu43ypkswrqb@pathway.suse.cz>
References: <1527562331-25880-1-git-send-email-hoeun.ryu@lge.com.com>
 <20180529121315.GE438@jagdpanzerIV>
 <20180530083204.m2yvmm7mc6owvpdk@pathway.suse.cz>
 <045f01d3f967$e5239b20$af6ad160$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <045f01d3f967$e5239b20$af6ad160$@lge.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-06-01 14:17:54, Hoeun Ryu wrote:
> 
> > -----Original Message-----
> > From: Petr Mladek [mailto:pmladek@suse.com]
> > Sent: Wednesday, May 30, 2018 5:32 PM
> > To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > Cc: Hoeun Ryu <hoeun.ryu@lge.com.com>; Sergey Senozhatsky
> > <sergey.senozhatsky@gmail.com>; Steven Rostedt <rostedt@goodmis.org>;
> > Hoeun Ryu <hoeun.ryu@lge.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] printk: make printk_safe_flush safe in NMI context by
> > skipping flushing
> > 
> > On Tue 2018-05-29 21:13:15, Sergey Senozhatsky wrote:
> > > On (05/29/18 11:51), Hoeun Ryu wrote:
> > > >  Make printk_safe_flush() safe in NMI context.
> > > > nmi_trigger_cpumask_backtrace() can be called in NMI context. For
> > example the
> > > > function is called in watchdog_overflow_callback() if the flag of
> > hardlockup
> > > > backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
> > > > watchdog_overflow_callback() function is called in NMI context on some
> > > > architectures.
> > > >  Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace()
> > eventually tries
> > > > to lock logbuf_lock in vprintk_emit() but the logbuf_lock can be
> > already locked in
> > > > preempted contexts (task or irq in this case) or by other CPUs and it
> > may cause
> > 
> > The sentence "logbuf_lock can be already locked in preempted contexts"
> > does not
> > make much sense. It is a spin lock. It means that both interrupts and
> > preemption are disabled.
> > 
> 
> I'd like to say that the preempting context is NMI,
> so the preempted contexts could be task/irq/bh contexts on the same CPU.

Good point!

> > I would change it to something like:
> > 
> > "Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace() eventually
> > tries
> > to lock logbuf_lock in vprintk_emit() that might be already be part
> > of a soft- or hard-lockup on another CPU."
> > 
> 
> It looks more clear.
> But I'd modify "be part of a soft- or hard-lockup on another CPU." to
> "be part of another non-nmi context on the same CPU or a soft- or
> hard-lockup on another CPU."
> 
> How about it?

Looks fine to me.

Best Regards,
Petr
