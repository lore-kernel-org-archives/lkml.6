Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C46DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AB7208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AB7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbeHAQwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:52:42 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:51873 "EHLO
        17.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbeHAQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:52:42 -0400
Received: from player772.ha.ovh.net (unknown [10.109.146.19])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 181FF1D42BC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 16:28:31 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id 93F03740098;
        Wed,  1 Aug 2018 16:28:25 +0200 (CEST)
Date:   Wed, 1 Aug 2018 16:28:24 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH 2/2] net/9p: add a per-client fcall
 kmem_cache
Message-ID: <20180801162824.31fb6a30@bahia.lan>
In-Reply-To: <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
References: <20180730093101.GA7894@nautica>
        <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
        <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14091200286319024384
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrledvgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 11:34:23 +0200
Dominique Martinet <asmadeus@codewreck.org> wrote:

> From: Dominique Martinet <dominique.martinet@cea.fr>
> 
> Having a specific cache for the fcall allocations helps speed up
> allocations a bit, especially in case of non-"round" msizes.
> 
> The caches will automatically be merged if there are multiple caches
> of items with the same size so we do not need to try to share a cache
> between different clients of the same size.
> 
> Since the msize is negotiated with the server, only allocate the cache
> after that negotiation has happened - previous allocations or
> allocations of different sizes (e.g. zero-copy fcall) are made with
> kmalloc directly.
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> ---

The patch looks good to me. It would need to be rebased when you have fixed
the potential kfree() of stale data in patch 1. Either with an extra goto
label in p9_tag_alloc or by turning p9_fcall_alloc into p9_fcall_alloc_sdata,
both solutions are equivalent.

Just one suggestion, see below.

>  include/net/9p/client.h |  2 ++
>  net/9p/client.c         | 40 ++++++++++++++++++++++++++++++++--------
>  net/9p/trans_rdma.c     |  2 +-
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 4b4ac1362ad5..8d9bc7402a42 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -123,6 +123,7 @@ struct p9_client {
>  	struct p9_trans_module *trans_mod;
>  	enum p9_trans_status status;
>  	void *trans;
> +	struct kmem_cache *fcall_cache;
>  
>  	union {
>  		struct {
> @@ -230,6 +231,7 @@ int p9_client_mkdir_dotl(struct p9_fid *fid, const char *name, int mode,
>  				kgid_t gid, struct p9_qid *);
>  int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
>  int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
> +void p9_fcall_free(struct p9_client *c, struct p9_fcall *fc);
>  struct p9_req_t *p9_tag_lookup(struct p9_client *, u16);
>  void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status);
>  
> diff --git a/net/9p/client.c b/net/9p/client.c
> index ba99a94a12c9..215e3b1ed7b4 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -231,15 +231,34 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>  	return ret;
>  }
>  
> -static int p9_fcall_alloc(struct p9_fcall *fc, int alloc_msize)
> +static int p9_fcall_alloc(struct p9_client *c, struct p9_fcall *fc,
> +			  int alloc_msize)
>  {
> -	fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> +	if (c->fcall_cache && alloc_msize == c->msize)

This is a presumably hot path for any request but the initial TVERSION,
you probably want likely() here...

> +		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
> +	else
> +		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
>  	if (!fc->sdata)
>  		return -ENOMEM;
>  	fc->capacity = alloc_msize;
>  	return 0;
>  }
>  
> +void p9_fcall_free(struct p9_client *c, struct p9_fcall *fc)
> +{
> +	/* sdata can be NULL for interrupted requests in trans_rdma,
> +	 * and kmem_cache_free does not do NULL-check for us
> +	 */
> +	if (unlikely(!fc->sdata))
> +		return;
> +
> +	if (c->fcall_cache && fc->capacity == c->msize)

... and here as well.

> +		kmem_cache_free(c->fcall_cache, fc->sdata);
> +	else
> +		kfree(fc->sdata);
> +}
> +EXPORT_SYMBOL(p9_fcall_free);
> +
>  static struct kmem_cache *p9_req_cache;
>  
>  /**
> @@ -261,9 +280,9 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	if (!req)
>  		return NULL;
>  
> -	if (p9_fcall_alloc(&req->tc, alloc_msize))
> +	if (p9_fcall_alloc(c, &req->tc, alloc_msize))
>  		goto free;
> -	if (p9_fcall_alloc(&req->rc, alloc_msize))
> +	if (p9_fcall_alloc(c, &req->rc, alloc_msize))
>  		goto free;
>  
>  	p9pdu_reset(&req->tc);
> @@ -288,8 +307,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	return req;
>  
>  free:
> -	kfree(req->tc.sdata);
> -	kfree(req->rc.sdata);
> +	p9_fcall_free(c, &req->tc);
> +	p9_fcall_free(c, &req->rc);
>  	kmem_cache_free(p9_req_cache, req);
>  	return ERR_PTR(-ENOMEM);
>  }
> @@ -333,8 +352,8 @@ static void p9_free_req(struct p9_client *c, struct p9_req_t *r)
>  	spin_lock_irqsave(&c->lock, flags);
>  	idr_remove(&c->reqs, tag);
>  	spin_unlock_irqrestore(&c->lock, flags);
> -	kfree(r->tc.sdata);
> -	kfree(r->rc.sdata);
> +	p9_fcall_free(c, &r->tc);
> +	p9_fcall_free(c, &r->rc);
>  	kmem_cache_free(p9_req_cache, r);
>  }
>  
> @@ -944,6 +963,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  
>  	clnt->trans_mod = NULL;
>  	clnt->trans = NULL;
> +	clnt->fcall_cache = NULL;
>  
>  	client_id = utsname()->nodename;
>  	memcpy(clnt->name, client_id, strlen(client_id) + 1);
> @@ -980,6 +1000,9 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	if (err)
>  		goto close_trans;
>  
> +	clnt->fcall_cache = kmem_cache_create("9p-fcall-cache", clnt->msize,
> +					      0, 0, NULL);
> +
>  	return clnt;
>  
>  close_trans:
> @@ -1011,6 +1034,7 @@ void p9_client_destroy(struct p9_client *clnt)
>  
>  	p9_tag_cleanup(clnt);
>  
> +	kmem_cache_destroy(clnt->fcall_cache);
>  	kfree(clnt);
>  }
>  EXPORT_SYMBOL(p9_client_destroy);
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index c5cac97df7f7..5e43f0a00b3a 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -445,7 +445,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
>  	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
>  		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
>  			/* Got one! */
> -			kfree(req->rc.sdata);
> +			p9_fcall_free(client, &req->rc);
>  			req->rc.sdata = NULL;
>  			goto dont_need_post_recv;
>  		} else {

