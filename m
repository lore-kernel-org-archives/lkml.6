Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C564208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C564208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbeGaC4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:56:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729441AbeGaC4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:56:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3F4ED82E0E6C;
        Tue, 31 Jul 2018 09:19:06 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Tue, 31 Jul 2018
 09:19:07 +0800
Subject: Re: [V9fs-developer] [PATCH 2/2] net/9p: add a per-client fcall
 kmem_cache
To:     Dominique Martinet <asmadeus@codewreck.org>,
        <v9fs-developer@lists.sourceforge.net>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
CC:     <linux-fsdevel@vger.kernel.org>, Greg Kurz <groug@kaod.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B5FB8F0.6020908@huawei.com>
Date:   Tue, 31 Jul 2018 09:18:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

Could you help paste some test result before-and-after the patch applied?
And I have a little suggestion in comments below.

On 2018/7/30 17:34, Dominique Martinet wrote:
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

We could set NULL for fcall_cache in case of use-after-free.

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
> 
