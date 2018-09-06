Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56325C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186E42077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186E42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeIFNjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:39:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728066AbeIFNjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:39:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38ADFAF6D;
        Thu,  6 Sep 2018 09:04:55 +0000 (UTC)
Date:   Thu, 6 Sep 2018 11:04:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180906090454.5r4w7ylz4gkaudxy@pathway.suse.cz>
References: <20180905213334.03375777@vmware.local.home>
 <20180906023151.GA749@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906023151.GA749@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-09-06 11:31:51, Sergey Senozhatsky wrote:
> Hello,
> 
> On (09/05/18 21:33), Steven Rostedt wrote:
> >   do_idle {
> > 
> >     [interrupts enabled]
> > 
> >     <interrupt> [interrupts disabled]
> > 	TRACE_IRQS_OFF [lockdep says irqs off]
> > 	[...]
> > 	TRACE_IRQS_IRET
> > 	    test if pt_regs say return to interrupts enabled [yes]
> > 	    TRACE_IRQS_ON [lockdep says irqs are on]
> > 
> > 	    <nmi>
> > 		nmi_enter() {
> > 		    printk_nmi_enter() [traced by ftrace]
> > 		    [ hit ftrace breakpoint ]
> > 		    <breakpoint exception>
> > 			TRACE_IRQS_OFF [lockdep says irqs off]
> > 			[...]
> > 			TRACE_IRQS_IRET [return from breakpoint]
> > 			   test if pt_regs say interrupts enabled [no]
> > 			   [iret back to interrupt]
> > 	   [iret back to code]
> > 
> >     tick_nohz_idle_enter() {
> > 
> > 	lockdep_assert_irqs_enabled() [lockdep say no!]
> > 
> > Although interrupts are indeed enabled, lockdep thinks it is not, and since
> > we now do asserts via lockdep, it gives a false warning. The issue here is
> > that printk_nmi_enter() is called before lockdep_off(), which disables
> > lockdep (for this reason) in NMIs. By simply not allowing ftrace to see
> > printk_nmi_enter() (via notrace annotation) we keep lockdep from getting
> > confused.
> 
> Great catch and I like the patch!
> 
> Indeed, with printk_nmi we changed the "everything that nmi_enter does
> should happen after lockdep_off" to "everything that nmi_enter does should
> happen after printk_nmi_enter" // +similar change to nmi_exit.
> 
> An alternative option, thus, could be re-instating back the rule that
> lockdep_off/on should be the first and the last thing we do in
> nmi_enter/nmi_exit. E.g.
> 
> nmi_enter()
> 	lockdep_off();
> 	printk_nmi_enter();
> 
> nmi_exit()
> 	printk_nmi_exit();
> 	lockdep_on();

Yup, this would help here as well.

> I guess that we can keep printk_nmi_enter/printk_nmi_exit at the top
> and at the bottom of nmi_enter/nmi_exit correspondingly just in case
> if lockdep_off/lockdep_on sometime in the future starts invoking printk(),
> which would deadlock us. Hence

Yes.

In general, it does not looks safe to allow tracing functions
that are called before ftrace_nmi_enter().

> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Therefore I am all for Steven's patch.

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
