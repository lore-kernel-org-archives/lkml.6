Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812F0C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 01:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02FC217C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 01:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02FC217C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeHMERe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 00:17:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbeHMERe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 00:17:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A57AEEA4B1FAA;
        Mon, 13 Aug 2018 09:37:31 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Mon, 13 Aug 2018
 09:37:29 +0800
Subject: Re: [V9fs-developer] [PATCH 2/2] 9p: Add refcount to p9_req_t
To:     Tomas Bortoli <tomasbortoli@gmail.com>, <asmadeus@codewreck.org>,
        <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>
References: <20180811144254.23665-1-tomasbortoli@gmail.com>
 <20180811144254.23665-2-tomasbortoli@gmail.com>
CC:     Dominique Martinet <dominique.martinet@cea.fr>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller@googlegroups.com>,
        <v9fs-developer@lists.sourceforge.net>, <davem@davemloft.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B70E0D1.2080300@huawei.com>
Date:   Mon, 13 Aug 2018 09:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180811144254.23665-2-tomasbortoli@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas & Dominique,

Could you help paste the reason of the crash bug to help others understand
more clearly? And I have another question below.

On 2018/8/11 22:42, Tomas Bortoli wrote:
> To avoid use-after-free(s), use a refcount to keep track of the
> usable references to any instantiated struct p9_req_t.
> 
> This commit adds p9_req_put(), p9_req_get() and p9_req_try_get() as
> wrappers to kref_put(), kref_get() and kref_get_unless_zero().
> These are used by the client and the transports to keep track of
> valid requests' references.
> 
> p9_free_req() is added back and used as callback by kref_put().
> 
> Add SLAB_TYPESAFE_BY_RCU as it ensures that the memory freed by
> kmem_cache_free() will not be reused for another type until the rcu
> synchronisation period is over, so an address gotten under rcu read
> lock is safe to inc_ref() without corrupting random memory while
> the lock is held.
> 
> Co-developed-by: Dominique Martinet <dominique.martinet@cea.fr>
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> ---
>  include/net/9p/client.h | 14 +++++++++++++
>  net/9p/client.c         | 54 +++++++++++++++++++++++++++++++++++++++++++------
>  net/9p/trans_fd.c       | 11 +++++++++-
>  net/9p/trans_rdma.c     |  1 +
>  4 files changed, 73 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index 735f3979d559..947a570307a6 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -94,6 +94,7 @@ enum p9_req_status_t {
>  struct p9_req_t {
>  	int status;
>  	int t_err;
> +	struct kref refcount;
>  	wait_queue_head_t wq;
>  	struct p9_fcall tc;
>  	struct p9_fcall rc;
> @@ -233,6 +234,19 @@ int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
>  int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
>  void p9_fcall_fini(struct p9_fcall *fc);
>  struct p9_req_t *p9_tag_lookup(struct p9_client *, u16);
> +
> +static inline void p9_req_get(struct p9_req_t *r)
> +{
> +	kref_get(&r->refcount);
> +}
> +
> +static inline int p9_req_try_get(struct p9_req_t *r)
> +{
> +	return kref_get_unless_zero(&r->refcount);
> +}
> +
> +int p9_req_put(struct p9_req_t *r);
> +
>  void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status);
>  
>  int p9_parse_header(struct p9_fcall *, int32_t *, int8_t *, int16_t *, int);
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 7942c0bfcc5b..83f2f0aadc14 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -310,6 +310,18 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	if (tag < 0)
>  		goto free;
>  
> +	/*	Init ref to two because in the general case there is one ref
> +	 *	that is put asynchronously by a writer thread, one ref
> +	 *	temporarily given by p9_tag_lookup and put by p9_client_cb
> +	 *	in the recv thread, and one ref put by p9_remove_tag in the
> +	 *	main thread. The only exception is virtio that does not use
> +	 *	p9_tag_lookup but does not have a writer thread either
> +	 *	(the write happens synchronously in the request/zc_request
> +	 *	callback), so p9_client_cb eats the second ref there
> +	 *	as the pointer is duplicated directly by virtqueue_add_sgs()
> +	 */
> +	refcount_set(&req->refcount.refcount, 2);
> +
>  	return req;
>  
>  free:
> @@ -333,10 +345,21 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
>  	struct p9_req_t *req;
>  
>  	rcu_read_lock();
> +again:
>  	req = idr_find(&c->reqs, tag);
> -	/* There's no refcount on the req; a malicious server could cause
> -	 * us to dereference a NULL pointer
> -	 */
> +	if (req) {
> +		/* We have to be careful with the req found under rcu_read_lock
> +		 * Thanks to SLAB_TYPESAFE_BY_RCU we can safely try to get the
> +		 * ref again without corrupting other data, then check again
> +		 * that the tag matches once we have the ref
> +		 */
> +		if (!p9_req_try_get(req))
> +			goto again;
> +		if (req->tc.tag != tag) {
> +			p9_req_put(req);
> +			goto again;
> +		}
> +	}
>  	rcu_read_unlock();
>  
>  	return req;
> @@ -350,7 +373,7 @@ EXPORT_SYMBOL(p9_tag_lookup);
>   *
>   * Context: Any context.
>   */
> -static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
> +static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>  {
>  	unsigned long flags;
>  	u16 tag = r->tc.tag;
> @@ -359,11 +382,23 @@ static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>  	spin_lock_irqsave(&c->lock, flags);
>  	idr_remove(&c->reqs, tag);
>  	spin_unlock_irqrestore(&c->lock, flags);
> +	return p9_req_put(r);
> +}
> +
> +static void p9_req_free(struct kref *ref)
> +{
> +	struct p9_req_t *r = container_of(ref, struct p9_req_t, refcount);
>  	p9_fcall_fini(&r->tc);
>  	p9_fcall_fini(&r->rc);
>  	kmem_cache_free(p9_req_cache, r);
>  }
>  
> +int p9_req_put(struct p9_req_t *r)
> +{
> +	return kref_put(&r->refcount, p9_req_free);
> +}
> +EXPORT_SYMBOL(p9_req_put);
> +
>  /**
>   * p9_tag_cleanup - cleans up tags structure and reclaims resources
>   * @c:  v9fs client struct
> @@ -379,7 +414,9 @@ static void p9_tag_cleanup(struct p9_client *c)
>  	rcu_read_lock();
>  	idr_for_each_entry(&c->reqs, req, id) {
>  		pr_info("Tag %d still in use\n", id);
> -		p9_tag_remove(c, req);
> +		if (p9_tag_remove(c, req) == 0)
> +			pr_warn("Packet with tag %d has still references",
> +				req->tc.tag);
>  	}
>  	rcu_read_unlock();
>  }
> @@ -403,6 +440,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>  
>  	wake_up(&req->wq);
>  	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
> +	p9_req_put(req);
>  }
>  EXPORT_SYMBOL(p9_client_cb);
>  
> @@ -682,6 +720,8 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
>  	return req;
>  reterr:
>  	p9_tag_remove(c, req);
> +	/* We have to put also the 2nd reference as it won't be used */
> +	p9_req_put(req);
>  	return ERR_PTR(err);
>  }
>  
> @@ -716,6 +756,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  
>  	err = c->trans_mod->request(c, req);
>  	if (err < 0) {
> +		/* write won't happen */
> +		p9_req_put(req);
>  		if (err != -ERESTARTSYS && err != -EFAULT)
>  			c->status = Disconnected;
>  		goto recalc_sigpending;
> @@ -2241,7 +2283,7 @@ EXPORT_SYMBOL(p9_client_readlink);
>  
>  int __init p9_client_init(void)
>  {
> -	p9_req_cache = KMEM_CACHE(p9_req_t, 0);
> +	p9_req_cache = KMEM_CACHE(p9_req_t, SLAB_TYPESAFE_BY_RCU);
>  	return p9_req_cache ? 0 : -ENOMEM;
>  }
>  
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 20f46f13fe83..686e24e355d0 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -132,6 +132,7 @@ struct p9_conn {
>  	struct list_head req_list;
>  	struct list_head unsent_req_list;
>  	struct p9_req_t *req;
> +	struct p9_req_t *wreq;

Why adding a wreq for write work? And I wonder we should rename req to
rreq?

>  	char tmp_buf[7];
>  	struct p9_fcall rc;
>  	int wpos;
> @@ -383,6 +384,7 @@ static void p9_read_work(struct work_struct *work)
>  		m->rc.sdata = NULL;
>  		m->rc.offset = 0;
>  		m->rc.capacity = 0;
> +		p9_req_put(m->req);
>  		m->req = NULL;
>  	}
>  
> @@ -472,6 +474,8 @@ static void p9_write_work(struct work_struct *work)
>  		m->wbuf = req->tc.sdata;
>  		m->wsize = req->tc.size;
>  		m->wpos = 0;
> +		p9_req_get(req);
> +		m->wreq = req;
>  		spin_unlock(&m->client->lock);
>  	}
>  
> @@ -492,8 +496,11 @@ static void p9_write_work(struct work_struct *work)
>  	}
>  
>  	m->wpos += err;
> -	if (m->wpos == m->wsize)
> +	if (m->wpos == m->wsize) {
>  		m->wpos = m->wsize = 0;
> +		p9_req_put(m->wreq);
> +		m->wreq = NULL;
> +	}
>  
>  end_clear:
>  	clear_bit(Wworksched, &m->wsched);
> @@ -694,6 +701,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
>  	if (req->status == REQ_STATUS_UNSENT) {
>  		list_del(&req->req_list);
>  		req->status = REQ_STATUS_FLSHD;
> +		p9_req_put(req);
>  		ret = 0;
>  	}
>  	spin_unlock(&client->lock);
> @@ -711,6 +719,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
>  	spin_lock(&client->lock);
>  	list_del(&req->req_list);
>  	spin_unlock(&client->lock);
> +	p9_req_put(req);
>  
>  	return 0;
>  }
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index c60655c90c9e..8cff368a11e3 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -365,6 +365,7 @@ send_done(struct ib_cq *cq, struct ib_wc *wc)
>  			    c->busa, c->req->tc.size,
>  			    DMA_TO_DEVICE);
>  	up(&rdma->sq_sem);
> +	p9_req_put(c->req);
>  	kfree(c);
>  }
>  
> 
