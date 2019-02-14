Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947EC21B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XKg4pCQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406668AbfBNWdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:33:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405378AbfBNWdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MBAGkJdSgmXxu0mbI4mgnApyfv4udU7FAl/+UdC+geM=; b=XKg4pCQij/pZ5dposeFn1+2LQ
        XCerJte914YkZcYi1ruJzQFs7XsqnGs8HW2CblzhM/wWuhYfmDhOqJDVp1JryeRWxadmDtUC6u/9v
        ZPJxHIc3fl78RakGNEeAnjW2dI8jVy4Zn46BQ11LGIJitM2TekrSie0fENEyUH/qjp7SBdKKLLTQh
        rkPERpS3Yu9XWnJLKBawJk6s2bJ+6Yqm7b9liRH+1ZQSH448XAfrU3WRoGJfgd+EsLB3xQaMIb3HM
        K4EIQYhXTikAkvf3OdoLwskTikX536o36+z6tugf3Zt+dcJugnJZeCCK8Ghc8kriEM6I+6zb01JRy
        OxhktcWJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guPYy-0004UH-9C; Thu, 14 Feb 2019 22:33:00 +0000
Date:   Thu, 14 Feb 2019 14:33:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Document erasing entries during iteration
Message-ID: <20190214223300.GH12668@bombadil.infradead.org>
References: <20190212072958.17373-1-tobin@kernel.org>
 <20190212135129.GL12668@bombadil.infradead.org>
 <20190213144744.ifejzbxrbaltivwc@master>
 <20190213161258.GS12668@bombadil.infradead.org>
 <20190214221652.rwctk7wrocpojtfy@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214221652.rwctk7wrocpojtfy@master>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:16:52PM +0000, Wei Yang wrote:
> On Wed, Feb 13, 2019 at 08:12:58AM -0800, Matthew Wilcox wrote:
> >The only remaining user of the radix tree in that tree is the IDR.  So
> >now I'm converting the IDR users over to the XArray as well.
> 
> Wow, really a HUGE work.

Yes ... but necessary.  Have to pay down the technical debt.

> >But that isn't what I was talking about.  At the moment, the radix
> >tree and the XArray use the same data structure.  It has good best-case
> >performance, but shockingly bad worst-case performance.  So we're looking
> >at replacing the data structure, which won't require changing any of the
> >users (maybe the page cache ... that has some pretty intimate knowledge
> >of exactly how the radix tree works).
> 
> Two questions from my curiosity:
> 
> 1. Why you come up the idea to replace radix tree with XArray even they
>    use the same data structure?

The radix tree API was just awful to use.  I tried to convert some users
with their own resizing-array-of-pointers to use the radix tree, and I
gave up in disgust.  I believe the XArray is much simpler to use.

> 2. The worst-case performance is related to the data structure itself?

Yes.  Consider the case where you store a pointer at its own address in
the data structure.  It'll allocate 11 nodes occupying one-and-a-half pages
of RAM in order to store a single pointer.

> >> BTW, have we compared the performance difference?
> >
> >It's in the noise.  Sometimes the XArray does a little better because
> >the APIs encourage the user to do things in a more efficient way.
> >Some of the users are improved just because the original author didn't
> >know about a more efficient way of doing what they wanted to do.
> 
> So sometimes XArray does a little worse?
> 
> Why this happens whey XArray and radix tree has the same data structure?
> 
> Interesting.

I'm not sure there are any cases where the XArray does worse.
Feel free to run your own measurements ... the test cases in
tools/testing/radix-tree can always do with being improved ;-) (that
directory is a bit misnamed as it now features tests for the radix tree,
IDR, IDA and XArray).
