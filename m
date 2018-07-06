Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3895FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC90223FC1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GWE4tLEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC90223FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbeGFMDw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:03:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932343AbeGFMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kb666mxKH0l5bKQzR87zVDr/XVF5EUlLiJcDEk2F938=; b=GWE4tLEL+0kKGesWheDf2egXQ
        QjQEkC0UoCER7egdk/WAktrVbyebEutZ960PiHiDRJeI6yWKBHV6fsEehVOf73XcGlsd1HrpK7EyW
        Mz3fzYazemhLXCSCk5kyWbK1vFrT/DnHQUVJ0V+uac0iCRWgPVtWGHRj/U6hawZZ6CwkjZCMPfXfX
        BHklUFkSAU6N4+us2ApufTkr/vGNIbkYPgSS5gxl6AC40wVMC1KGqhcBNSDnthMYagaF08+DSaLlB
        07iW/E2OrRWa5/2ea7fhZ7yRxsPHw8Xt6H2p1b39sAYVkXkMn1qLbsfbPkYFsTLKARyySmrLWVxAq
        5FUNOZPCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbPSP-0004Or-Bp; Fri, 06 Jul 2018 12:03:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C39A020289CE4; Fri,  6 Jul 2018 14:03:23 +0200 (CEST)
Date:   Fri, 6 Jul 2018 14:03:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706120323.GW2476@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
 <20180706114402.GB27148@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114402.GB27148@guoren>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:44:03PM +0800, Guo Ren wrote:
> On Thu, Jul 05, 2018 at 07:59:02PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> > 
> > > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > > +{
> > > +	unsigned int *p = &lock->lock;
> > > +	unsigned int tmp;
> > > +
> > > +	asm volatile (
> > > +		"1:	ldex.w		%0, (%1) \n"
> > > +		"	bnez		%0, 1b   \n"
> > > +		"	movi		%0, 1    \n"
> > > +		"	stex.w		%0, (%1) \n"
> > > +		"	bez		%0, 1b   \n"
> > > +		: "=&r" (tmp)
> > > +		: "r"(p)
> > > +		: "memory");
> > > +	smp_mb();
> > > +}
> > 
> > Test-and-set with MB acting as ACQUIRE, ok.
> Em ... Ok, I'll try to use test-and-set function instead of it.

"test-and-set" is just the name of this type of spinlock implementation.

You _could_ use the linux test_and_set bitop, but those are defined on
unsigned long and spinlock_t is generally assumed to be of unsigned int
size.

Go with the ticket locks as per below.

> > Also, the fact that you need MB for release implies your LDEX does not
> > in fact imply anything and your xchg/cmpxchg implementation is broken.
> xchg/cmxchg broken without 1th smp_mb()? Why we need protect the
> instructions flow before the ldex.w?

See the email I send earlier in that thread.

> Ok, I'll try to implement ticket lock in next version patch.

If you need inspiration, look at:

  git show 81bb5c6420635dfd058c210bd342c29c95ccd145^1:arch/arm64/include/asm/spinlock.h

Or look at the current version of that file and ignore the LSE version.

Note that unlock is a store half-word (u16), not having seen your arch
manual yet I don't know if you even have that.
