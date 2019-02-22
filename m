Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27909C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C642077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IG4FN1Ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBVWNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:13:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iJ3NrCm21RjbtC8DMhQQ2V5Motg7BymSiSwnZ/9zdOk=; b=IG4FN1EiT1Hhgus3VGH0aNUIY
        /ypsvByjAHCdWCIDkw44OUJy1VbCFQBwFGXwATpPQOlJ4I7thK/r4SF/iX+WWC6s0DapceCB/Zp4j
        6aeCA+IIa69ve7zy1NB8DSsFXNnv8jTdFJoDV/okb5NXPaYs1+g1D+iTmZXM7/w3edWJwI+bRckVW
        xDDQjpgxbQY3AUN8cY5ITihP0+z4VH96LHzk9LDeN5uNdXsfhMtNCB8QD8/uYL1ndtPO8W7w85X/V
        NirgXwv1xqnKnMbkw0/htMjge3U8YGWpJIxneTHC9wY76kcdvPZgxP8Dkh/Bn11f2QFCZm/QTYPxe
        4oY1uNoAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxJ4G-0001pX-3n; Fri, 22 Feb 2019 22:13:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12D0C984351; Fri, 22 Feb 2019 23:13:14 +0100 (CET)
Date:   Fri, 22 Feb 2019 23:13:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/23] locking/lockdep: Add support for dynamic keys
Message-ID: <20190222221314.GJ14054@worktop.programming.kicks-ass.net>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <1550786525.31902.140.camel@acm.org>
 <20190222162622.GB32494@hirez.programming.kicks-ass.net>
 <7216ba17-8e38-d8e9-6ba3-1bc0e6a9fc2d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7216ba17-8e38-d8e9-6ba3-1bc0e6a9fc2d@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:20:34AM -0800, Bart Van Assche wrote:
> On 2/22/19 8:26 AM, Peter Zijlstra wrote:
> > I've gone over all and I think it looks ok now; I'll give it another
> > round tomorrow^Wmonday and then queue bits.
> > 
> > So far the only changes I've made are the below. I'm not entirely sure
> > on the unconditional validity check on DEBUG_LOCKDEP, maybe I'll add a
> > boot param for that.
> 
> Hi Peter,
> 
> Please keep in mind that calling check_data_structures() slows down the
> kernel a lot and also that it makes systems much less responsive. This is
> because the consistency checks disable interrupts for a long time, up to
> several seconds. That is why I think it should be possible to enable and
> disable the consistency checks independent of other kernel config options.

Ah, yes. So I had expected expensive, but hadn't tried it yet.

I'll make it a boot option.
