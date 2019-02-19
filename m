Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52753208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBaqha41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfBSL6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:58:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=063b44LnIli6UeiU3wWvish88zFP5Ns8Dmd2qWXtsD4=; b=oBaqha41N6526htEcKVMXn6cz
        fWMi0W2rm6slY4Uhkd8XZdaMNmzRg0sQ+J7u0EMImV5MYD9SROimDtR1AweEuAPgIFwBurR1NVU7/
        ySPCTdG2/HfDfkO76hqmHpOqroqzslUkPk3pmZl0vpXuXmKuT0ZznZVCe7QWSaKK4Cecrzg6VCV4F
        wgwDj5y7V3ez5gySFyzPnvL0XZzMVBLejaGDYKLuG3X0RfKIsdp7U1REw2D8H37aYggNrhw0pzctR
        WL36Y3xO5d8p45IWRIDVrPjoQ1DroLy0Dxpug5SOgJLKqP0qTDcwJsASGswhh82mJGxdSTCAMi3tC
        /X8z1JoNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw42s-0001cF-C0; Tue, 19 Feb 2019 11:58:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10598201A577B; Tue, 19 Feb 2019 12:58:40 +0100 (CET)
Date:   Tue, 19 Feb 2019 12:58:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190219115840.GV32477@hirez.programming.kicks-ass.net>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219094438.GV32534@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902191238250.1644@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902191238250.1644@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:38:42PM +0100, Thomas Gleixner wrote:
> On Tue, 19 Feb 2019, Peter Zijlstra wrote:
> 
> > On Tue, Feb 19, 2019 at 10:04:09AM +0100, Peter Zijlstra wrote:
> > > > Does that make more sense?
> > > 
> > > It appears to me you're going about it backwards.
> > 
> > So how about you do a GCC plugin that verifies limits on code-gen
> > between user_access_begin/user_access_end() ?
> > 
> >  - No CALL/RET
> >    - implies user_access_end() happens
> >    - implies no fentry hooks
> >  - No __preempt_count frobbing
> >  - No tracepoints
> >  - ...
> > 
> > That way you put the burden on the special code, not on the rest of the
> > kernel.
> 
> And then you have kprobes ....

They prod the INT3 byte and then take an exception, and exceptions are
'fine'.

