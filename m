Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730F9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2244E2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2244E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeIGSWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbeIGSWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:22:52 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D752075E;
        Fri,  7 Sep 2018 13:41:49 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:41:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907094148.2444acc6@gandalf.local.home>
In-Reply-To: <20180907073448.GL24106@hirez.programming.kicks-ass.net>
References: <20180905213334.03375777@vmware.local.home>
        <20180907073448.GL24106@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 09:34:48 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Sep 05, 2018 at 09:33:34PM -0400, Steven Rostedt wrote:
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
> 
> Isn't the problem that we muck with the IRQ state from NMI context? We
> shouldn't be doing that.

Not really. The problem is that the exception handling code jumps into
lockdep, and we allow exceptions to happen in NMIs. It's just that the
tracing of printk_nmi_enter() caused an exception before lockdep was
turned off.

> 
> The thing is, since we trace the IRQ state from within IRQ-disable,
> since that's the only IRQ-safe option, it is very much not NMI-safe.
> 
> Your patch might avoid the symptom, but I don't think it cures the
> fundamental problem.

No, the issue is that the nmi_enter() code was traced early which adds
breakpoints and breakpoints causes exceptions which jumps into lockdep,
and we did this before lockdep was turned off.

-- Steve
