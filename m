Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C74D2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5mEmXym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfA2Jvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:51:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfA2Jvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6XIjcDQwIP+WQY5IcwlIazckl7rG6gnBTyMGW7XwXgQ=; b=T5mEmXymdKzGkOEdBkSqsPyDE
        8GYPzUzKbVvXliqAgHLN9mFfDjUq+UgzKxXcZb40czx2ppLxizGPw6yL4vZlRPofRIA8la1cnsUnv
        1aA0KwL7hLWULZRvgJgfONslon5Tvx/Bghh6tcgeTpzFsvzwsL8TcD2Eb88PCS1oHiw8PpOpLp+U8
        /f2E0lGBzxFjwkCxGvPiGqM34RzdG2pKvBZ1y9OBHDYZ1zgq9IPsRq//im3c3umgUtvOBPIYPmm7r
        S/9qdW88Nrl3mqKLOXFE+DoqECJswuRKRpFHLms5O3TmX5YjpdBSm2aWfUH6ss8FiBzp6zzy4QxgK
        l+Dr8spgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goQ3W-0003Lm-8Z; Tue, 29 Jan 2019 09:51:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE9F92018338A; Tue, 29 Jan 2019 10:51:44 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:51:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Message-ID: <20190129095144.GH28467@hirez.programming.kicks-ass.net>
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
 <20190128142910.GA7232@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128142910.GA7232@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 03:29:10PM +0100, Andrea Parri wrote:

> > diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> > index dbaed55..ab8f584 100644
> > --- a/arch/x86/include/asm/refcount.h
> > +++ b/arch/x86/include/asm/refcount.h
> > @@ -67,16 +67,29 @@ static __always_inline void refcount_dec(refcount_t *r)
> >  static __always_inline __must_check
> >  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
> >  {
> > -	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> > +	bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> >  					 REFCOUNT_CHECK_LT_ZERO,
> >  					 r->refs.counter, e, "er", i, "cx");
> > +
> > +    if (ret) {
> > +               smp_acquire__after_ctrl_dep();
> > +               return true;
> > +    }
> > +
> > +    return false;
> 
> There appears to be some white-space damage (here and in other places);
> checkpatch.pl should point these and other style problems out.

It's worse...

patch: **** malformed patch at line 81: diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h

And yes, there's a lot of whitespace damage all around. Lots of trailing
spaces too.

