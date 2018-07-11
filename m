Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3BF20871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uTXRxoxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3BF20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbeGKOTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:19:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGKOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y6u97+/sQjuzhzy5/ZkJdItnZDX3We5CPROIWF5G+dw=; b=uTXRxoxD2Fr5dx9hRUxBZBFOH
        hdWAAQhKN3ooTXkreIf09+up/49+FpA9cNO6SMh+7S80QfRNKzAte20UqllkqUWovTZEHykxpi4Z6
        gQXwX7/108LglGlBDn7ley0oSt4jhlfVSK4/B3kB9MXvJ+BciIwWxzeNpxGJOHA4XFZswfWg86zoC
        rBqAn9lCN7STVxQYn/drTCOHvr5YJpE9M+Gk4rnn38i01jBw9Ycwv4ogrsP/rDzHeEFXhfL/6OnUX
        Cy0WtVnNWWGJKmIm8A5Y6Yi/NzqIx+jXXgMtdi5r4ari78VLg6xHhbgUiGL6/SALwRBmA8tTZR2Ot
        GvRkpV8EQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdFs2-0006kV-BC; Wed, 11 Jul 2018 14:14:21 +0000
Date:   Wed, 11 Jul 2018 07:13:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 5/6] 9p: Use a slab for allocating
 requests
Message-ID: <20180711141256.GC23640@bombadil.infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-6-willy@infradead.org>
 <20180711133313.GC835@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711133313.GC835@nautica>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:33:13PM +0200, Dominique Martinet wrote:
> Matthew Wilcox wrote on Thu, Jun 28, 2018:
> >  /**
> >   * struct p9_client - per client instance state
> > - * @lock: protect @fidlist
> > + * @lock: protect @fids and @reqs
> >   * @msize: maximum data size negotiated by protocol
> > - * @dotu: extension flags negotiated by protocol
> >   * @proto_version: 9P protocol version to use
> >   * @trans_mod: module API instantiated with this client
> > + * @status: XXX
> 
> Let's give this a proper comment; something like 'connection state
> machine' ? (this contains Connected/BeginDisconnect/Disconnected/Hung)

Sure!  Will add.

> >  /**
> > - * p9_tag_alloc - lookup/allocate a request by tag
> > - * @c: client session to lookup tag within
> > - * @tag: numeric id for transaction
> > - *
> > - * this is a simple array lookup, but will grow the
> > - * request_slots as necessary to accommodate transaction
> > - * ids which did not previously have a slot.
> > - *
> > - * this code relies on the client spinlock to manage locks, its
> > - * possible we should switch to something else, but I'd rather
> > - * stick with something low-overhead for the common case.
> > + * p9_req_alloc - Allocate a new request.
> > + * @c: Client session.
> > + * @type: Transaction type.
> > + * @max_size: Maximum packet size for this request.
> >   *
> > + * Context: Process context.  What mutex might we be holding that
> > + * requires GFP_NOFS?
> 
> Good question, but p9_tag_alloc happens on every single client request
> so the fs/9p functions might be trying to do something and the alloc
> request here comes in and could try to destroy the inode that is
> currently used in the request -- I'm not sure how likely this is, but
> I'd rather not tempt fate :p

Fair.  I'll remove the question.

> > +	INIT_LIST_HEAD(&req->req_list);
> > +
> > +	idr_preload(GFP_NOFS);
> > +	spin_lock_irq(&c->lock);
> > +	if (type == P9_TVERSION)
> > +		tag = idr_alloc(&c->reqs, req, P9_NOTAG, P9_NOTAG + 1,
> > +				GFP_NOWAIT);
> 
> Well this appears to work but P9_NOTAG being '(u16)(~0)' I'm not too
> confident with P9_NOTAG + 1. . . it doesn't look like it's overflowing
> before the cast on my laptop but is that guaranteed?

By my understanding of n1256.pdf ... this falls under 6.3.1.8 ("Usual
arithmetic conversions").  We have a u16 and an int.  Therefore this
rule applies:

    Otherwise, if the type of the operand with signed integer type can
    represent all of the values of the type of the operand with unsigned
    integer type, then the operand with unsigned integer type is converted
    to the type of the operand with signed integer type.

> > [..]
> > @@ -1012,14 +940,11 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
> >  
> >  	spin_lock_init(&clnt->lock);
> >  	idr_init(&clnt->fids);
> > -
> > -	err = p9_tag_init(clnt);
> > -	if (err < 0)
> > -		goto free_client;
> > +	idr_init(&clnt->reqs);
> 
> I do not see any call to idr_destroy, is that OK?

Yes, that's fine.  It used to be (back in 2013) that one had to call
idr_destroy() in order to free the preallocated idr data structures.
Now it's a no-op if called on an empty IDR, and I would expect that both
IDRs are empty at the time that it comes to unloading the module (and if
they aren't, we probably have bigger problems than a small memory leak).
Some users like to assert that the IDR is empty; most do not go to that
extent of defensive programming.
