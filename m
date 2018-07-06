Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA32C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D8D23FBA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fz4qx9J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D8D23FBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeGFL5A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:57:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeGFL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jOtUjGb3nTprK2PnnEF1hrwKidzNUeglH1tiHaswtzA=; b=fz4qx9J8i+/tdPcNOB9ZcjNPP
        vuOIWr2SuLXvpiZpWi/wxUZjmCBtk+0/foorDhFExWZdI7Rv+OaE7t37NObJgiH/kx+AeZjwr1Ubl
        5x484ankuuLw0NxDXtxD9PA9X4Ib3IF2oTPMbDF8GOlqhW2wJfFQW7CEqp08WcbT4OMPW0bubpelP
        EtY0xg44X5PG9Epf1jDSLN85T0Lrr1VQOlrsZHcj6PWF3Q6rKPP7KAn7sNyamzw4bjRNSACoYT2qW
        sK3MPHNdZWCXJXYpdcqr9Jot8NA0dGq7Vi5khv3SkZhxlNCRkl7iEQF64GrekPYZDTqFv3puovhwq
        uJDyNRChA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbPLT-0000hc-MI; Fri, 06 Jul 2018 11:56:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7171B20289CF4; Fri,  6 Jul 2018 13:56:14 +0200 (CEST)
Date:   Fri, 6 Jul 2018 13:56:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706115614.GV2476@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706110129.GC8707@guoren>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:01:31PM +0800, Guo Ren wrote:
> On Thu, Jul 05, 2018 at 07:50:59PM +0200, Peter Zijlstra wrote:

> > What's the memory ordering rules for your LDEX/STEX ?
> Every CPU has a local exclusive monitor.
> 
> "Ldex rz, (rx, #off)" will add an entry into the local monitor, and the 
> entry is composed of a address tag and a exclusive flag (inited with 1). 
> Any stores (include other cores') will break the exclusive flag to 0 in
> the entry which could be indexed by the address tag.
> 
> "Stex rz, (rx, #off)" has two condition:
> 1. Store Success: When the entry's exclusive flag is 1, it will store rz
> to the [rx + off] address and the rz will be set to 1.
> 2. Store Failure: When the entry's exclusive flag is 0, just rz will be
> set to 0.

That's how LL/SC works. What I was asking is if they have any effect on
memory ordering. Some architectures have LL/SC imply memory ordering,
most do not.

Going by your spinlock implementation they don't imply any memory
ordering.

> > The mandated semantics for xchg() / cmpxchg() is an effective smp_mb()
> > before _and_ after.
> 
> 	switch (size) {						\
> 	case 4:							\
> 		smp_mb();					\
> 		asm volatile (					\
> 		"1:	ldex.w		%0, (%3) \n"		\
> 		"	mov		%1, %2   \n"		\
> 		"	stex.w		%1, (%3) \n"		\
> 		"	bez		%1, 1b   \n"		\
> 			: "=&r" (__ret), "=&r" (tmp)		\
> 			: "r" (__new), "r"(__ptr)		\
> 			: "memory");				\
> 		smp_mb();					\
> 		break;						\
> Hmm?
> But I couldn't undertand what's wrong without the 1th smp_mb()?
> 1th smp_mb will make all ld/st finish before ldex.w. Is it necessary?

Yes.

	CPU0			CPU1

	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
	r2 = xchg(&y, 2);	smp_store_release(&x, 1);

must not allow: r1==1 && r2==0

> > The above implementation suggests LDEX implies a SYNC.IS, is this
> > correct?
> No, ldex doesn't imply a sync.is.

Right, as per the spinlock emails, then your proposed primitives are
incorrect.
