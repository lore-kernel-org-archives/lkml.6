Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED76C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79FC20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79FC20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbeHARJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:09:18 -0400
Received: from nautica.notk.org ([91.121.71.147]:47528 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389627AbeHARJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:09:18 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id DDBE3C009; Wed,  1 Aug 2018 17:23:03 +0200 (CEST)
Date:   Wed, 1 Aug 2018 17:22:48 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH 2/2] net/9p: add a per-client fcall
 kmem_cache
Message-ID: <20180801152248.GB21463@nautica>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
 <20180801162824.31fb6a30@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801162824.31fb6a30@bahia.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kurz wrote on Wed, Aug 01, 2018:
> > diff --git a/net/9p/client.c b/net/9p/client.c
> > index ba99a94a12c9..215e3b1ed7b4 100644
> > --- a/net/9p/client.c
> > +++ b/net/9p/client.c
> > @@ -231,15 +231,34 @@ static int parse_opts(char *opts, struct p9_client *clnt)
> >  	return ret;
> >  }
> >  
> > -static int p9_fcall_alloc(struct p9_fcall *fc, int alloc_msize)
> > +static int p9_fcall_alloc(struct p9_client *c, struct p9_fcall *fc,
> > +			  int alloc_msize)
> >  {
> > -	fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> > +	if (c->fcall_cache && alloc_msize == c->msize)
> 
> This is a presumably hot path for any request but the initial TVERSION,
> you probably want likely() here...

c->fcall_cache is indeed very likely, but alloc_size == c->msize not so
much, as zc requests will be quite common for virtio and will be 4k in
size.
Although with that cache I'm starting to wonder if we should always use
it... Speed-wise if there is no memory pressure the cache is likely
going to be faster.
If there is pressure and the items are reclaimed though that'll bring
some heavier slow-down as it'll need to find bigger memory regions.

I'm not sure which path we should favor, tbh. I'll keep these separate
for now.


For the first part of the check, Matthew suggested trying to trick msize
into a different value to fail this check for the initial TVERSION call,
but even after thinking it a bit I don't really see how to do that
cleanly. I can at least make -that- likely()...

> 
> > +		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
> > +	else
> > +		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> >  	if (!fc->sdata)
> >  		return -ENOMEM;
> >  	fc->capacity = alloc_msize;
> >  	return 0;
> >  }
> >  
> > +void p9_fcall_free(struct p9_client *c, struct p9_fcall *fc)
> > +{
> > +	/* sdata can be NULL for interrupted requests in trans_rdma,
> > +	 * and kmem_cache_free does not do NULL-check for us
> > +	 */
> > +	if (unlikely(!fc->sdata))
> > +		return;
> > +
> > +	if (c->fcall_cache && fc->capacity == c->msize)
> 
> ... and here as well.

For this one I'll unfortunately need to store in the fc how it has been
allocated as slob doesn't allow to kmem_cache_free() a buffer allocated
by kmalloc and in prevision of refs being refcounted in a hostile world
the initial TVERSION req could be freed after fcall_cache is created :/

That's a bit of a burden but at least will reduce the checks to one here

> > +		kmem_cache_free(c->fcall_cache, fc->sdata);
> > +	else
> > +		kfree(fc->sdata);
> > +}
> > +EXPORT_SYMBOL(p9_fcall_free);
> > +
> >  static struct kmem_cache *p9_req_cache;
> >  
> >  /**


Anyway I've had as many comments as I could hope for, thanks everyone
for the quick review.
I'll send a v2 of both patches tomorrow

-- 
Dominique
