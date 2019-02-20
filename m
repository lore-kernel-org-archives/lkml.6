Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51975C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240862089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQ44dzuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBTUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:47:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBTUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cIG5KLPVKE5jZOeM678FWlWM4/Z9BTI2LUdDWJD6OAg=; b=mQ44dzuwcLGCyrvFwU4ICQDVE
        QHRnd8QPV6D5I8kTYi+keX3tpdrdD79ITSG4f+Yd7m3xqqS66SqtQyFrTh7jQ1YNtKzzEhVcbl9WN
        BfCPFgZ05vu3/hGCxWkQ/8d+wph9KP38G+zKAkrMXAKX4jsplfAQ2IcYBFKmrJ6v/F74IuY3bSXwK
        iPAEWMaakOIuHUagNRDi51pzno0iyCnQnLLtvAirFo7KCZ7BGLv8uf80gynTT9XAbQidmjEkIxTS/
        qrYwHZkUcn4Cm9wbaZIJ1mweC0MjZAjgwBOwPCvmlZ4HYOVbTnmx8Sww2IZhAk5epLBugQdfj87vN
        71hhBjh6Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwYm6-0004Oz-6Y; Wed, 20 Feb 2019 20:47:26 +0000
Date:   Wed, 20 Feb 2019 12:47:26 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: xarray reserve/release?
Message-ID: <20190220204726.GK12668@bombadil.infradead.org>
References: <20190219235349.GA17351@ziepe.ca>
 <20190220012609.GC12668@bombadil.infradead.org>
 <20190220034627.GA564@ziepe.ca>
 <20190220171414.GI12668@bombadil.infradead.org>
 <20190220174333.GI8429@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220174333.GI8429@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:43:33AM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 20, 2019 at 09:14:14AM -0800, Matthew Wilcox wrote:
> > > void __xa_release(struct xarray *xa, unsigned long index)
> > > {
> > > 	XA_STATE(xas, xa, index);
> > > 	void *curr;
> > > 
> > > 	curr = xas_load(&xas);
> > > 	if (curr == XA_ZERO_ENTRY)
> > > 		xas_store(&xas, NULL);
> > > }
> > > 
> > > ?
> > 
> > I decided to instead remove the magic from xa_cmpxchg().  I used
> > to prohibit any internal entry being passed to the regular API, but
> > I recently changed that with 76b4e5299565 ("XArray: Permit storing
> > 2-byte-aligned pointers").  Now that we can pass XA_ZERO_ENTRY, I
> > think this all makes much more sense.
> 
> Except that for allocating arrays xa_cmpxchg and xa_store now do
> different things with NULL. Not necessarily bad, but if you have this
> ABI variation it should be mentioned in the kdoc comment.

I'm worrying about the whole xa_store(... NULL, gfp) situation.  Before
I realised I needed to unify the XArray and the IDR (I'd originally
intended to have the IDR be a client of the XArray the same way that
it was a client of the radix tree), everything was nice and simple.
xa_erase() was a synonym for xa_store(... NULL, gfp).  Then the IDR
users showed up with their understanding of what storing NULL meant,
and now xa_store(NULL) means something different depending what kind of
array you have.  This sucks.  I'm tempted to have xa_store(NULL) always
transform the NULL into XA_ZERO_ENTRY, but I worry I might break some
users without noticing.

> This is a bit worrysome though:
> 
>                 curr = xas_load(&xas);
> -               if (curr == XA_ZERO_ENTRY)
> -                       curr = NULL;
>                 if (curr == old) {
> 
> It means any cmpxchg user has to care explicitly about the possibility
> for true-NULL vs reserved. Seems like a difficult API.

I think the users know, though.  I went through the current users of
xa_cmpxchg() and they're not the same users which are using xa_reserve()
or xa_alloc().

> What about writing it like this:
> 
>    if ((curr == XA_ZERO_ENTRY && old == NULL) || curr == old)
> 
> ? I can't think of a use case to cmpxchg against real-null only.
> 
> And here:
>                         xas_store(&xas, entry);
> -                       if (xa_track_free(xa))
> +                       if (xa_track_free(xa) && !old)
>                                 xas_clear_mark(&xas, XA_FREE_MARK);
> 
> Should this be
> 
>     if (xa_track_free(xa) && entry && !old)
> 
> ? Ie we don't want to clear the XA_FREE_MARK if we just wrote NULL

There are four cases to consider: old is NULL/present, entry is NULL/present.
xas_store() will set XA_FREE_MARK (by calling xas_init_marks()) if entry
is NULL.  Otherwise it leaves the marks alone.

old	entry	FREE before	FREE after xas_store	should be FREE
NULL	NULL	true		true			true
NULL	present	true		true			false
present	NULL	false		true			true
present	present	false		false			false

So the only case we need to clear the bit is if old is NULL and entry is
present.  I didn't consider the NULL->NULL transition, so you're right.

> Also I would think !curr is clearer? I assume the point is to not pay
> the price of xas_clear_mark if we already know the index stored is
> marked?

If you find it clearer, I'll use 'curr'.  They're equal at this point anyway.

> That looks really readable now that reserve and release are tidy
> paired operations.

Great!
