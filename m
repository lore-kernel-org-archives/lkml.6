Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF42C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD657208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZyMU/Yh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD657208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966115AbeFOTeq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:34:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5lafXdAvp4KqA5Y2JT8DicmPWcDyn2SJek/oM2IJJ6Q=; b=ZyMU/Yh9cBzRcCa530k0zRG8F
        q/qBj51k4VoMkXDc3jbpptnWaureiqFHk3993gzB8s5yn7dQy4fLQZyXqBWyku9Bfb59X0s6XnBpK
        iZ5C1Gns6JzgK1BgOTddHiRpIxFuxspm64RTOe2gLrWQxuTahHnYhMTa2s4lgVbTb8vHJR4k84XHo
        RO41r8dMhut/9I9EoykdjPVUoajMQudpyv+Xl/9UHQ6WohW8i+Pd5/2DzV3gwekdDIwdu/vQ1fLrq
        /aY/UftLqSJODzkaWtZ5ERGEj44UPDB40Dn5dJs2BnrACrEjq5euVcJbFxbc6+xwGP6PlvCzRkUwU
        t9XOI3gJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTuUb-0007Lp-89; Fri, 15 Jun 2018 19:34:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BFE92029FA0B; Fri, 15 Jun 2018 21:34:38 +0200 (CEST)
Date:   Fri, 15 Jun 2018 21:34:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
Message-ID: <20180615193438.GE2458@hirez.programming.kicks-ass.net>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 06:25:39PM +0200, Thomas Gleixner wrote:
> On Fri, 15 Jun 2018, Jason A. Donenfeld wrote:
> > In a loop this looks like:
> > 
> > for (thing) {
> >   kernel_fpu_begin();
> >   encrypt(thing);
> >   kernel_fpu_end();
> > }
> > 
> > This is obviously very bad, because begin() and end() are slow, so
> > WireGuard does the obvious:
> > 
> > kernel_fpu_begin();
> > for (thing)
> >   encrypt(thing);
> > kernel_fpu_end();
> > 
> > This is fine and well, and the crypto API I'm working on will enable
> 
> It might be fine crypto performance wise, but it's a total nightmare
> latency wise because kernel_fpu_begin() disables preemption. We've seen
> latencies in the larger millisecond range due to processing large data sets
> with kernel FPU.
> 
> If you want to go there then we really need a better approach which allows
> kernel FPU usage in preemptible context and in case of preemption a way to
> stash the preempted FPU context and restore it when the task gets scheduled
> in again. Just using the existing FPU stuff and moving the loops inside the
> begin/end section and keeping preemption disabled for arbitrary time spans
> is not going to fly.

Didn't we recently do a bunch of crypto patches to help with this?

I think they had the pattern:

	kernel_fpu_begin();
	for (units-of-work) {
		do_unit_of_work();
		if (need_resched()) {
			kernel_fpu_end();
			cond_resched();
			kernel_fpu_begin();
		}
	}
	kernel_fpu_end();

I'd have to go dig out the actual series, but I think they had a bunch
of helpers to deal with that.
