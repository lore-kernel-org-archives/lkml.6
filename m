Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4B7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94932156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kOy+R7SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94932156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeI0PPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:15:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33340 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeI0PPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+BRfyV9aNXSYEyDJJvoECUI4q4Uo7wUNNPWAYXh314I=; b=kOy+R7SEchBQ7hz7m4ti2B+/y
        V2oCWtAhJCzGstPVOMvHGLa+u4w+dhZiXPiYTSCFt888l5eAVMO1C3OnHdAEmAYIW3Kk0eqIfT8Wb
        FRTPr6YBdqBc37aMc5Zr3AVMWRPw2HS5QZreiTUKYWt3sBubsvqCjNBQl9wirsXcCZSp3LTSF66zt
        AcnBAm9tF5fDwKZJVVCr/Di9+7ZglEucOFbcFAkn2U7ED/kx810bcRObSIa1CrzEwsoi7vlV1DwuP
        WqLx1NLZtBfWYpo088CTTfxTOEVzVwK9QMGTiVAW1Kolc33rUF93psLLvNeq2h8GPJzJty8+4v9NE
        M0Z1OFlEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5S72-0005n8-9d; Thu, 27 Sep 2018 08:57:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F64B202C1A0F; Thu, 27 Sep 2018 10:57:28 +0200 (CEST)
Date:   Thu, 27 Sep 2018 10:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180927085728.GF5254@hirez.programming.kicks-ass.net>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20180926205208.GA4864@andrea>
 <20180927071747.GD5254@hirez.programming.kicks-ass.net>
 <20180927074748.GA7939@andrea>
 <20180927075935.GA4889@hirez.programming.kicks-ass.net>
 <20180927081314.GA8285@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927081314.GA8285@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:13:15AM +0200, Andrea Parri wrote:
> On Thu, Sep 27, 2018 at 09:59:35AM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 27, 2018 at 09:47:48AM +0200, Andrea Parri wrote:
> > > > LKMM in particular does _NOT_ deal with mixed sized atomics _at_all_.
> > > 
> > > True, but it is nothing conceptually new to deal with: there're Cat
> > > models that handle mixed-size accesses, just give it time.
> > 
> > Sure, but until that time I must not rely on (and thus not use) LKMM for
> > qspinlock things.
> 
> This is way too generic to be agreed ;D

Only if you know that thing well enough to know why it gives a certain
answer, and thus don't already need it.

If you need it to help you with something; it can't because it doesn't
do the mixed size thing.

> > So while your argument about coherence might be true -- I'll have to
> > think about it; litmus tests are out the window.
> 
> You trimmed the litmus test I gave you.

Because of not wanting to reverse engineer the argument from the litmus
test. But yes, I think I see your point, the earlier trylock will load
the new value and our later load cannot be earlier than that.
