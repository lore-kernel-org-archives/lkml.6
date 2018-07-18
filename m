Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80638ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4512A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4512A20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeGRKnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:43:20 -0400
Received: from nautica.notk.org ([91.121.71.147]:49825 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeGRKnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:43:20 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A3C31C009; Wed, 18 Jul 2018 12:06:09 +0200 (CEST)
Date:   Wed, 18 Jul 2018 12:05:54 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kurz <groug@kaod.org>, v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] 9p: Use a slab for allocating requests
Message-ID: <20180718100554.GA21781@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711210225.19730-6-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Greg, I could use your opinion on this if you have a moment.

Matthew Wilcox wrote on Wed, Jul 11, 2018:
> Replace the custom batch allocation with a slab.  Use an IDR to store
> pointers to the active requests instead of an array.  We don't try to
> handle P9_NOTAG specially; the IDR will happily shrink all the way back
> once the TVERSION call has completed.

Sorry for coming back to this patch now, I just noticed something that's
actually probably a fairly big hit on performance...

While the slab is just as good as the array for the request itself, this
makes every single request allocate "fcalls" everytime instead of
reusing a cached allocation.
The default msize is 8k and these allocs probably are fairly efficient,
but some transports like RDMA allow to increase this to up to 1MB... And
doing this kind of allocation twice for every packet is going to be very
slow.
(not that hogging megabytes of memory was a great practice either!)


One thing is that the buffers are all going to be the same size for a
given client (.... except virtio zc buffers, I wonder what I'm missing
or why that didn't blow up before?)
Err, that aside I was going to ask if we couldn't find a way to keep a
pool of these somehow.
Ideally putting them in another slab so they could be reclaimed if
necessary, but the size could vary from one client to another, can we
create a kmem_cache object per client? the KMEM_CACHE macro is not very
flexible so I don't think that is encouraged... :)


It's a shame because I really like that patch, I'll try to find time to
run some light benchmark with varying msizes eventually but I'm not sure
when I'll find time for that... Hopefully before the 4.19 merge window!


>  /**
> - * p9_tag_alloc - lookup/allocate a request by tag
> - * @c: client session to lookup tag within
> - * @tag: numeric id for transaction
> - *
> - * this is a simple array lookup, but will grow the
> - * request_slots as necessary to accommodate transaction
> - * ids which did not previously have a slot.
> - *
> - * this code relies on the client spinlock to manage locks, its
> - * possible we should switch to something else, but I'd rather
> - * stick with something low-overhead for the common case.
> + * p9_req_alloc - Allocate a new request.
> + * @c: Client session.
> + * @type: Transaction type.
> + * @max_size: Maximum packet size for this request.
>   *
> + * Context: Process context.
> + * Return: Pointer to new request.
>   */
> -
>  static struct p9_req_t *
> -p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
> +p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  {
> -	unsigned long flags;
> -	int row, col;
> -	struct p9_req_t *req;
> +	struct p9_req_t *req = kmem_cache_alloc(p9_req_cache, GFP_NOFS);
>  	int alloc_msize = min(c->msize, max_size);
> +	int tag;
>  
> -	/* This looks up the original request by tag so we know which
> -	 * buffer to read the data into */
> -	tag++;
> -
> -	if (tag >= c->max_tag) {
> -		spin_lock_irqsave(&c->lock, flags);
> -		/* check again since original check was outside of lock */
> -		while (tag >= c->max_tag) {
> -			row = (tag / P9_ROW_MAXTAG);
> -			c->reqs[row] = kcalloc(P9_ROW_MAXTAG,
> -					sizeof(struct p9_req_t), GFP_ATOMIC);
> -
> -			if (!c->reqs[row]) {
> -				pr_err("Couldn't grow tag array\n");
> -				spin_unlock_irqrestore(&c->lock, flags);
> -				return ERR_PTR(-ENOMEM);
> -			}
> -			for (col = 0; col < P9_ROW_MAXTAG; col++) {
> -				req = &c->reqs[row][col];
> -				req->status = REQ_STATUS_IDLE;
> -				init_waitqueue_head(&req->wq);
> -			}
> -			c->max_tag += P9_ROW_MAXTAG;
> -		}
> -		spin_unlock_irqrestore(&c->lock, flags);
> -	}
> -	row = tag / P9_ROW_MAXTAG;
> -	col = tag % P9_ROW_MAXTAG;
> +	if (!req)
> +		return NULL;
>  
> -	req = &c->reqs[row][col];
> -	if (!req->tc)
> -		req->tc = p9_fcall_alloc(alloc_msize);
> -	if (!req->rc)
> -		req->rc = p9_fcall_alloc(alloc_msize);
> +	req->tc = p9_fcall_alloc(alloc_msize);
> +	req->rc = p9_fcall_alloc(alloc_msize);
>  	if (!req->tc || !req->rc)
> -		goto grow_failed;
> +		goto free;
>  
>  	p9pdu_reset(req->tc);
>  	p9pdu_reset(req->rc);
> -
> -	req->tc->tag = tag-1;
>  	req->status = REQ_STATUS_ALLOC;
> +	init_waitqueue_head(&req->wq);
> +	INIT_LIST_HEAD(&req->req_list);
> +
> +	idr_preload(GFP_NOFS);
> +	spin_lock_irq(&c->lock);
> +	if (type == P9_TVERSION)
> +		tag = idr_alloc(&c->reqs, req, P9_NOTAG, P9_NOTAG + 1,
> +				GFP_NOWAIT);
> +	else
> +		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
> +	req->tc->tag = tag;
> +	spin_unlock_irq(&c->lock);
> +	idr_preload_end();
> +	if (tag < 0)
> +		goto free;

-- 
Dominique
