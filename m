Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D7CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3197120C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JKFcFsRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfBTN10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:27:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTN10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4U1igPLjHCCxpklUARe0aNSziVmOKa+VLvdGbtr3la8=; b=JKFcFsRvbcKtaLFkGNIdaX7HH
        gkYaxoQOSMgXlYbYsfKEyuokQ4iblw3xCZ4Sf7bqnYFU2a+h1iga6fDhojf4wjwrEM7ceoBSEFXJe
        9OBv7PWfUufc16qjiT6L1P5yIwuBMWX+A3ltOsdH8seWKSLunTfRki07OU7lKwoks8WqrLPxKQ2Y9
        /ZslphZz5e+VXpzBbRlAfi30LYX2zkfnoZELLOJunUfSGeZV4O3Mf9MQtRrxSmw6Hbmyf9LOd9wyc
        fnQ5j0UcZIRptZuzTcs0yGAP4TSH6wN2S4ZlOFjtUIaybPgE+3DPqMT2LPEZWN+8TvUpP13VP5GFN
        NiMr15B5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwRu7-0005fN-OI; Wed, 20 Feb 2019 13:27:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 490DD20094FD6; Wed, 20 Feb 2019 14:27:14 +0100 (CET)
Date:   Wed, 20 Feb 2019 14:27:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220131456.GA3215@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:14:56PM +0100, Andrea Parri wrote:
> On Wed, Feb 20, 2019 at 10:26:04AM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 19, 2019 at 06:01:17PM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> > > > Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> > > > if necessary, but let us not encourage people to rely on this thing.
> > > > 
> > > > For example, the following "exists" clause can be satisfied with this
> > > > change:
> > > > 
> > > > C dep-rfi
> > > > 
> > > > { }
> > > > 
> > > > P0(int *x, int *y)
> > > > {
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	smp_store_release(y, 1);
> > > > }
> > > > 
> > > > P1(int *x, int *y, int *z)
> > > > {
> > > > 	int r0;
> > > > 	int r1;
> > > > 	int r2;
> > > > 
> > > > 	r0 = READ_ONCE(*y);
> > > > 	WRITE_ONCE(*z, r0);
> > > > 	r1 = smp_load_acquire(z);
> > > > 	r2 = READ_ONCE(*x);
> > > > }
> > > > 
> > > > exists (1:r0=1 /\ 1:r2=0)
> > > 
> > > Any objections?  If I don't hear any in a couple days, I will apply this.
> > 
> > IIUC you cannot build hardware that allows the above, so why would we
> > allow it?
> 
> The change/simplification was mainly intended as precautionary measure
> (hence the "we can add it back, ..."): I do agree that it shouldn't be
> possible to realize the above state; OTOH, you really don't need to be
> too "creative" to imagine possible mis-uses/mis-interpretations of the
> (dep ; rfi) term ("forget" ONCEs, trick herd7 with "false dependencies"
> or simply wrongly assume that control dependencies are part this "dep",
> what else? ...).  So, no, I'm not that fond to this term; why should I
> be?  or you are simply suggesting to expand the changelog?
> 
> I should probably also remark that "such a simplification" wouldn't be
> a first time for the LKMM and, in fact, for the ppo term itself:
> 
>   https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/WeakModel.html#Preserved%20Program%20Order

I'm completely failing to understand any of that.

What I do object to is a model that's weaker than any possible sane
hardware.
