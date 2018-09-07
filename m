Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B286C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B0E2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v005ubu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B0E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeIGMOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:14:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGMOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6AQiD9D2levhriXbeDepjyHN/nm3dK7vD8VzK4LogX0=; b=v005ubu5lP//KQK5nMFrrIxfx
        dc9Nd+FKLyFROyz8sjHtQV+nYHwt9MygVpoINVkrVcKDS1Ug0JAAY0PeJMLADbApUN3TTqW+pln2J
        Gwak9/LlTSgqTiyjUHAmxAEtsIXtDN7GrR+TqwH1eC6mwPIFeP1tkFIuLqCHWvbADAg3gJGDHT/lP
        jhDZySEy2DXHRuKtoaKYm3lGONotABXksU3LCsFvq9HepVuh2Ufx+SmK2IdxZEdZ7x4TtMt7TQAuP
        FnLkBmqwrYM8jKnhGRQyqdiJyi+V26WokuHD/D2CEyl0lTPay6HQPSly29MnigwGZ1wQrAptIoInr
        W1YMueKdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyBI3-0007h0-93; Fri, 07 Sep 2018 07:34:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04F39201F9C52; Fri,  7 Sep 2018 09:34:49 +0200 (CEST)
Date:   Fri, 7 Sep 2018 09:34:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907073448.GL24106@hirez.programming.kicks-ass.net>
References: <20180905213334.03375777@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905213334.03375777@vmware.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:33:34PM -0400, Steven Rostedt wrote:
>   do_idle {
> 
>     [interrupts enabled]
> 
>     <interrupt> [interrupts disabled]
> 	TRACE_IRQS_OFF [lockdep says irqs off]
> 	[...]
> 	TRACE_IRQS_IRET
> 	    test if pt_regs say return to interrupts enabled [yes]
> 	    TRACE_IRQS_ON [lockdep says irqs are on]
> 
> 	    <nmi>
> 		nmi_enter() {
> 		    printk_nmi_enter() [traced by ftrace]
> 		    [ hit ftrace breakpoint ]
> 		    <breakpoint exception>
> 			TRACE_IRQS_OFF [lockdep says irqs off]
> 			[...]
> 			TRACE_IRQS_IRET [return from breakpoint]
> 			   test if pt_regs say interrupts enabled [no]
> 			   [iret back to interrupt]
> 	   [iret back to code]
> 
>     tick_nohz_idle_enter() {
> 
> 	lockdep_assert_irqs_enabled() [lockdep say no!]

Isn't the problem that we muck with the IRQ state from NMI context? We
shouldn't be doing that.

The thing is, since we trace the IRQ state from within IRQ-disable,
since that's the only IRQ-safe option, it is very much not NMI-safe.

Your patch might avoid the symptom, but I don't think it cures the
fundamental problem.
