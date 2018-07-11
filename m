Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D185C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466120846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbeGKNhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:37:52 -0400
Received: from nautica.notk.org ([91.121.71.147]:52454 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732562AbeGKNhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:37:52 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 098F9C009; Wed, 11 Jul 2018 15:33:28 +0200 (CEST)
Date:   Wed, 11 Jul 2018 15:33:13 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 5/6] 9p: Use a slab for allocating
 requests
Message-ID: <20180711133313.GC835@nautica>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628132629.3148-6-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Thu, Jun 28, 2018:
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 0fa0fbab33b0..fd326811ebd4 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -92,24 +85,12 @@ enum p9_req_status_t {
>   * struct p9_req_t - request slots
>   * @status: status of this request slot
>   * @t_err: transport error
> - * @flush_tag: tag of request being flushed (for flush requests)
>   * @wq: wait_queue for the client to block on for this request
>   * @tc: the request fcall structure
>   * @rc: the response fcall structure
>   * @aux: transport specific data (provided for trans_fd migration)
>   * @req_list: link for higher level objects to chain requests
> - *
> - * Transport use an array to track outstanding requests
> - * instead of a list.  While this may incurr overhead during initial
> - * allocation or expansion, it makes request lookup much easier as the
> - * tag id is a index into an array.  (We use tag+1 so that we can accommodate
> - * the -1 tag for the T_VERSION request).
> - * This also has the nice effect of only having to allocate wait_queues
> - * once, instead of constantly allocating and freeing them.  Its possible
> - * other resources could benefit from this scheme as well.
> - *
>   */
> -
>  struct p9_req_t {
>  	int status;
>  	int t_err;
> @@ -117,40 +98,26 @@ struct p9_req_t {
>  	struct p9_fcall *tc;
>  	struct p9_fcall *rc;
>  	void *aux;
> -
>  	struct list_head req_list;
>  };
>  
>  /**
>   * struct p9_client - per client instance state
> - * @lock: protect @fidlist
> + * @lock: protect @fids and @reqs
>   * @msize: maximum data size negotiated by protocol
> - * @dotu: extension flags negotiated by protocol
>   * @proto_version: 9P protocol version to use
>   * @trans_mod: module API instantiated with this client
> + * @status: XXX

Let's give this a proper comment; something like 'connection state
machine' ? (this contains Connected/BeginDisconnect/Disconnected/Hung)


> diff --git a/net/9p/client.c b/net/9p/client.c
> index 2dce8d8307cc..fd5446377445 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -241,132 +241,104 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
>  	return fc;
>  }
>  
> +static struct kmem_cache *p9_req_cache;
> +
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
> + * Context: Process context.  What mutex might we be holding that
> + * requires GFP_NOFS?

Good question, but p9_tag_alloc happens on every single client request
so the fs/9p functions might be trying to do something and the alloc
request here comes in and could try to destroy the inode that is
currently used in the request -- I'm not sure how likely this is, but
I'd rather not tempt fate :p

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

Well this appears to work but P9_NOTAG being '(u16)(~0)' I'm not too
confident with P9_NOTAG + 1. . . it doesn't look like it's overflowing
before the cast on my laptop but is that guaranteed?


> [..]
> @@ -1012,14 +940,11 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  
>  	spin_lock_init(&clnt->lock);
>  	idr_init(&clnt->fids);
> -
> -	err = p9_tag_init(clnt);
> -	if (err < 0)
> -		goto free_client;
> +	idr_init(&clnt->reqs);

I do not see any call to idr_destroy, is that OK?


Looks like another good patch overall, thanks!
-- 
Dominique
