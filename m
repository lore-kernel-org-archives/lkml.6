Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211052083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u+q3bcWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfBTROP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:14:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ybVo9mGI4HcbmJmi4sYFGwNG8PnToYqv+B//dtrnd0k=; b=u+q3bcWZqoFyyEBH7Jt+zUx2a
        qvLvjHnUyLm2xx15gFX468kAVrCmBS33zmulu5b4X9MITJCBg2Xq3S4lg1ZUCNMky4sy/Vx+SsjA5
        HkEdfl91iPqXAUwqgIZP15MKQ69JoGXoACJJdZtt4gmkk163Qd//AbblJZ1iiplZ54NSAxBic7d1t
        3c7mSVxRc3NrVjDtOao6R9bWhVP/Z3OIBiuLs5HPOBb8f97HZU5PJ5mH6myjadWhTbULEP1eTJMmu
        uK2trkvhe5r8E73fyu9WxJk6AizWSwvUWNmT+2FmYFVlf0DzaF77nbZomimL2Vtmln7Or4Jb9IX0l
        jZkAFIv6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwVRm-0005Og-90; Wed, 20 Feb 2019 17:14:14 +0000
Date:   Wed, 20 Feb 2019 09:14:14 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: xarray reserve/release?
Message-ID: <20190220171414.GI12668@bombadil.infradead.org>
References: <20190219235349.GA17351@ziepe.ca>
 <20190220012609.GC12668@bombadil.infradead.org>
 <20190220034627.GA564@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220034627.GA564@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:46:27PM -0700, Jason Gunthorpe wrote:
> On Tue, Feb 19, 2019 at 05:26:09PM -0800, Matthew Wilcox wrote:
> > On Tue, Feb 19, 2019 at 04:53:49PM -0700, Jason Gunthorpe wrote:
> > > Hey Matt,
> > > 
> > > Did you intend that xa_release doesn't work on allocating arrays:
> > 
> > That surprises me.  I'll take a look in the morning.
> 
> I think the issue is that this:
> 
> static inline void xa_release(struct xarray *xa, unsigned long index)
> {
> 	xa_cmpxchg(xa, index, NULL, NULL, 0);
> 
> relies on the NULL actually being xas_store(NULL), but cmpxchg
> transforms it into xas_store(XA_ZERO_ENTRY) when allocating..

Yes, you're right.

> So xa_reserve(), xa_release() and xa_cmpxchg() all do the same thing
> for allocating arrays.
> 
> Perhaps this:
> 
> void __xa_release(struct xarray *xa, unsigned long index)
> {
> 	XA_STATE(xas, xa, index);
> 	void *curr;
> 
> 	curr = xas_load(&xas);
> 	if (curr == XA_ZERO_ENTRY)
> 		xas_store(&xas, NULL);
> }
> 
> ?

I decided to instead remove the magic from xa_cmpxchg().  I used
to prohibit any internal entry being passed to the regular API, but
I recently changed that with 76b4e5299565 ("XArray: Permit storing
2-byte-aligned pointers").  Now that we can pass XA_ZERO_ENTRY, I
think this all makes much more sense.

> Also, I wonder if xa_reserve() is better written as as
> 
>        xa_cmpxchg(xa, index, NULL, XA_ZERO_ENTRY)
> 
> Bit clearer what is going on..

Yes, I agree.  I've pushed a couple of new commits to
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray

which should fix your problem, and implement this optimisation.
Thanks for the report!
