Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35245C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F9023FCF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IGx7aCyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F9023FCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeGFMFp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:05:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43836 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbeGFMFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3g9h+VMg1o12oa5nA8Cpbglt+dSX1GSsGn7A6f2NYNs=; b=IGx7aCytwz3fbMMNU1GQL64sr
        Q1pYKHhnyRlJpya3lPqF3zQZV3HvOVqR2LwIBjN5PRT3QLX2sr1TaMn8PoxIzQ0eqAx2SVMihNcA7
        JnncZhjcH2IyBPt+XI4CDVvS68S+HpJxXv9701fKHJbGMZsRryCizoqb/QTwWGj7dX8CiKvlobSGP
        AQBmvB0DMBXCTorJHriTub0uhZMyoz6uLz4PZoGYmD6L5/tUTCcGsfM7UULjS6lmUssCORW9zY3DL
        t8BLMPJDQa7cLpz9rgG8p21kFbxxABtJMEKle/rubN3d0Sb53m7wUOtEo57B+Fm0/vu4eV4HkJBVi
        tTESHFbUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbPUU-0000l7-7f; Fri, 06 Jul 2018 12:05:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0029D20289CE4; Fri,  6 Jul 2018 14:05:32 +0200 (CEST)
Date:   Fri, 6 Jul 2018 14:05:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706120532.GX2476@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705180008.GG2530@hirez.programming.kicks-ass.net>
 <20180706114812.GC27148@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114812.GC27148@guoren>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:48:12PM +0800, Guo Ren wrote:
> On Thu, Jul 05, 2018 at 08:00:08PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> > > +#ifdef CONFIG_CPU_HAS_LDSTEX
> > > +ENTRY(csky_cmpxchg)
> > > +	USPTOKSP
> > > +	mfcr	a3, epc
> > > +	INCTRAP	a3
> > > +
> > > +	subi    sp, 8
> > > +	stw     a3, (sp, 0)
> > > +	mfcr    a3, epsr
> > > +	stw     a3, (sp, 4)
> > > +
> > > +	psrset	ee
> > > +1:
> > > +	ldex	a3, (a2)
> > > +	cmpne	a0, a3
> > > +	bt16	2f
> > > +	mov	a3, a1
> > > +	stex	a3, (a2)
> > > +	bez	a3, 1b
> > > +2:
> > > +	sync.is
> > > +	mvc	a0
> > > +	ldw	a3, (sp, 0)
> > > +	mtcr	a3, epc
> > > +	ldw     a3, (sp, 4)
> > > +	mtcr	a3, epsr
> > > +	addi	sp, 8
> > > +	KSPTOUSP
> > > +	rte
> > > +END(csky_cmpxchg)
> > > +#else
> > 
> > Please explain... if the CPU has LDEX/STEX, then _why_ do you need this?
> Our libc use csky_cmpxchg and we want it compatible. Of course, we'll
> also implement the ldex/stex atomic operations in libs in future.

I would strongly suggest not providing this syscall on SMP systems from
the get go. There is no point in starting with legacy problems without
an actual legacy.


