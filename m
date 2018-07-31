Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD6AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27A220840
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27A220840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeGaFzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:55:41 -0400
Received: from nautica.notk.org ([91.121.71.147]:51623 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeGaFzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:55:41 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 668F7C009; Tue, 31 Jul 2018 06:17:22 +0200 (CEST)
Date:   Tue, 31 Jul 2018 06:17:07 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net, Greg Kurz <groug@kaod.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net/9p: add a per-client fcall kmem_cache
Message-ID: <20180731041707.GA20546@nautica>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
 <20180731024658.GC19692@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180731024658.GC19692@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Mon, Jul 30, 2018:
> On Mon, Jul 30, 2018 at 11:34:23AM +0200, Dominique Martinet wrote:
> > -static int p9_fcall_alloc(struct p9_fcall *fc, int alloc_msize)
> > +static int p9_fcall_alloc(struct p9_client *c, struct p9_fcall *fc,
> > +			  int alloc_msize)
> >  {
> > -	fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> > +	if (c->fcall_cache && alloc_msize == c->msize)
> > +		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
> > +	else
> > +		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> 
> Could you simplify this by initialising c->msize to 0 and then this
> can simply be:
> 
> > +	if (alloc_msize == c->msize)
> ...

Hmm, this is rather tricky with the current flow of things;
p9_client_version() has multiple uses for that msize field.

Basically what happens is:
 - init client struct, set clip msize to mount option/transport-specific
max
 - p9_client_version() uses current c->msize to send a suggested value
to the server
 - p9_client_rpc() uses current c->msize to allocate that first rpc,
this is pretty much hard-coded and will be quite intrusive to make an
exception for
 - p9_client_version() looks at the msize the server suggested and clips
c->msize if the reply's is smaller than c->msize


I kind of agree it'd be nice to remove that check being done all the
time for just startup, but I don't see how to do this easily with the
current code.

Making p9_client_version take an extra argument would be easy but we'd
need to actually hardcode in p9_client_rpc that "if the message type is
TVERSION then use [page size or whatever] for allocation" and that kinds
of kills the point... The alternative being having p9_client_rpc takes
the actual size as argument itself but this once again is pretty
intrusive even if it could be done mechanically...

I'll think about this some more

> > +void p9_fcall_free(struct p9_client *c, struct p9_fcall *fc)
> > +{
> > +	/* sdata can be NULL for interrupted requests in trans_rdma,
> > +	 * and kmem_cache_free does not do NULL-check for us
> > +	 */
> > +	if (unlikely(!fc->sdata))
> > +		return;
> > +
> > +	if (c->fcall_cache && fc->capacity == c->msize)
> > +		kmem_cache_free(c->fcall_cache, fc->sdata);
> > +	else
> > +		kfree(fc->sdata);
> > +}
> 
> Is it possible for fcall_cache to be allocated before fcall_free is
> called?  I'm concerned we might do this:
> 
> allocate message A
> allocate message B
> receive response A
> allocate fcall_cache
> receive response B
> 
> and then we'd call kmem_cache_free() for something allocated by kmalloc(),
> which works with slab and slub, but doesn't work with slob (alas).

Bleh, I checked this would work for slab and didn't really check
others..

This cannot happen right now because we only return the client struct
from p9_client_create after the first message is done (and, right now,
freed) but when we start adding refcounting to requests it'd be possible
to free the very first response after fcall_cache is allocated with a
"bad" server like syzcaller does sending the version reply before the
request came in.

I can't see any work-around around this other than storing how the fcall
was allocated in the struct itself though...
I guess I might as well do that now, unless you have a better idea.


> > @@ -980,6 +1000,9 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
> >  	if (err)
> >  		goto close_trans;
> >  
> > +	clnt->fcall_cache = kmem_cache_create("9p-fcall-cache", clnt->msize,
> > +					      0, 0, NULL);
> > +
> 
> If we have slab merging turned off, or we have two mounts from servers
> with different msizes, we'll end up with two slabs called 9p-fcall-cache.
> I'm OK with that, but are you?

Yeah, the reason I didn't make it global like p9_req_cache is precisely
to get two separate caches if the msizes are different.

I actually considered adding msize to the string with snprintf or
something but someone looking at it through slabinfo or similar will
have the sizes anyway so I don't think this would bring anything, do you
know if/think that tools will choke on multiple caches with the same
name?


I'm not sure about slab merging being disabled though, from the little I
understand I do not see why anyone would do that except for debugging,
and I'm fine with that.
Please let me know if I'm missing something though!


Thanks for the review,
-- 
Dominique Martinet
