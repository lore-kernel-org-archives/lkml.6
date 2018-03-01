Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030800AbeCANgw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:36:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030646AbeCANgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:36:51 -0500
Date: Thu, 1 Mar 2018 15:36:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH net-next 1/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
Message-ID: <20180301153441-mutt-send-email-mst@kernel.org>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
 <1519874345-10235-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519874345-10235-2-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:19:04AM +0800, Jason Wang wrote:
> XDP_REDIRECT support for mergeable buffer was removed since commit
> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
> case"). This is because we don't reserve enough tailroom for struct
> skb_shared_info which breaks XDP assumption. Other complaints are, the
> complex linearize logic and EWMA estimation may increase the
> possibility of linearizing.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

How about reposting just this patch for net? It's pretty small
and this way we don't have broken redirect there.
Probably keeping the linearize in here to reduce the
amount of changes.

> ---
>  drivers/net/virtio_net.c | 107 +++++++++++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9bb9e56..81190ba 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -537,6 +537,26 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  	return NULL;
>  }
>  
> +static struct sk_buff *virtnet_skb_xdp(struct receive_queue *rq,
> +				       struct sk_buff *skb)
> +{
> +	struct bpf_prog *xdp_prog;
> +	int ret;
> +
> +	rcu_read_lock();
> +	xdp_prog = rcu_dereference(rq->xdp_prog);
> +	if (xdp_prog) {
> +		ret = do_xdp_generic(xdp_prog, skb);
> +		if (ret != XDP_PASS) {
> +			rcu_read_unlock();
> +			return NULL;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return skb;
> +}
> +
>  static struct sk_buff *receive_small(struct net_device *dev,
>  				     struct virtnet_info *vi,
>  				     struct receive_queue *rq,
> @@ -689,31 +709,30 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	struct bpf_prog *xdp_prog;
>  	unsigned int truesize;
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> -	bool sent;
> +	bool sent, skb_xdp = false;
> +	int err;
>  
>  	head_skb = NULL;
>  
>  	rcu_read_lock();
>  	xdp_prog = rcu_dereference(rq->xdp_prog);
>  	if (xdp_prog) {
> -		struct page *xdp_page;
>  		struct xdp_buff xdp;
>  		void *data;
>  		u32 act;
>  
> -		/* This happens when rx buffer size is underestimated */
> +		/* This happens when rx buffer size is underestimated
> +		 * or headroom is not enough because of the buffer
> +		 * was refilled before XDP is set. In both cases,
> +		 * for simplicity, we will offload them to generic
> +		 * XDP routine. This should only happen for the first
> +		 * several packets, so we don't care much about its
> +		 * performance.
> +		 */
>  		if (unlikely(num_buf > 1 ||
>  			     headroom < virtnet_get_headroom(vi))) {
> -			/* linearize data for XDP */
> -			xdp_page = xdp_linearize_page(rq, &num_buf,
> -						      page, offset,
> -						      VIRTIO_XDP_HEADROOM,
> -						      &len);
> -			if (!xdp_page)
> -				goto err_xdp;
> -			offset = VIRTIO_XDP_HEADROOM;
> -		} else {
> -			xdp_page = page;
> +			skb_xdp = true;
> +			goto skb_xdp;
>  		}
>  
>  		/* Transient failure which in theory could occur if
> @@ -727,7 +746,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		/* Allow consuming headroom but reserve enough space to push
>  		 * the descriptor on if we get an XDP_TX return code.
>  		 */
> -		data = page_address(xdp_page) + offset;
> +		data = page_address(page) + offset;
>  		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
>  		xdp.data = data + vi->hdr_len;
>  		xdp_set_data_meta_invalid(&xdp);
> @@ -736,9 +755,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>  
> -		if (act != XDP_PASS)
> -			ewma_pkt_len_add(&rq->mrg_avg_pkt_len, len);
> -
>  		switch (act) {
>  		case XDP_PASS:
>  			/* recalculate offset to account for any header
> @@ -746,28 +762,22 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			 * skb and avoid using offset
>  			 */
>  			offset = xdp.data -
> -					page_address(xdp_page) - vi->hdr_len;
> -
> -			/* We can only create skb based on xdp_page. */
> -			if (unlikely(xdp_page != page)) {
> -				rcu_read_unlock();
> -				put_page(page);
> -				head_skb = page_to_skb(vi, rq, xdp_page,
> -						       offset, len, PAGE_SIZE);
> -				return head_skb;
> -			}
> +					page_address(page) - vi->hdr_len;
>  			break;
>  		case XDP_TX:
>  			sent = __virtnet_xdp_xmit(vi, &xdp);
>  			if (unlikely(!sent)) {
>  				trace_xdp_exception(vi->dev, xdp_prog, act);
> -				if (unlikely(xdp_page != page))
> -					put_page(xdp_page);
>  				goto err_xdp;
>  			}
>  			*xdp_xmit = true;
> -			if (unlikely(xdp_page != page))
> +			rcu_read_unlock();
> +			goto xdp_xmit;
> +		case XDP_REDIRECT:
> +			err = xdp_do_redirect(dev, &xdp, xdp_prog);
> +			if (err)
>  				goto err_xdp;
> +			*xdp_xmit = true;
>  			rcu_read_unlock();
>  			goto xdp_xmit;
>  		default:
> @@ -775,13 +785,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		case XDP_ABORTED:
>  			trace_xdp_exception(vi->dev, xdp_prog, act);
>  		case XDP_DROP:
> -			if (unlikely(xdp_page != page))
> -				__free_pages(xdp_page, 0);
>  			goto err_xdp;
>  		}
>  	}
>  	rcu_read_unlock();
>  
> +skb_xdp:
>  	truesize = mergeable_ctx_to_truesize(ctx);
>  	if (unlikely(len > truesize)) {
>  		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
> @@ -848,7 +857,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		}
>  	}
>  
> -	ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);
> +	if (skb_xdp)
> +		head_skb = virtnet_skb_xdp(rq, head_skb);
> +	else
> +		ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);
> +
>  	return head_skb;
>  
>  err_xdp:
> @@ -1013,13 +1026,18 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
>  }
>  
>  static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
> -					  struct ewma_pkt_len *avg_pkt_len)
> +					  struct ewma_pkt_len *avg_pkt_len,
> +					  unsigned int room)
>  {
>  	const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>  	unsigned int len;
>  
> -	len = hdr_len + clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_len),
> +	if (room)
> +		return PAGE_SIZE - room;
> +
> +	len = hdr_len +	clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_len),
>  				rq->min_buf_len, PAGE_SIZE - hdr_len);
> +
>  	return ALIGN(len, L1_CACHE_BYTES);
>  }
>  
> @@ -1028,21 +1046,27 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  {
>  	struct page_frag *alloc_frag = &rq->alloc_frag;
>  	unsigned int headroom = virtnet_get_headroom(vi);
> +	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
> +	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>  	char *buf;
>  	void *ctx;
>  	int err;
>  	unsigned int len, hole;
>  
> -	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len);
> -	if (unlikely(!skb_page_frag_refill(len + headroom, alloc_frag, gfp)))
> +	/* Extra tailroom is needed to satisfy XDP's assumption. This
> +	 * means rx frags coalescing won't work, but consider we've
> +	 * disabled GSO for XDP, it won't be a big issue.
> +	 */
> +	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>  		return -ENOMEM;
>  
>  	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
>  	buf += headroom; /* advance address leaving hole at front of pkt */
>  	get_page(alloc_frag->page);
> -	alloc_frag->offset += len + headroom;
> +	alloc_frag->offset += len + room;
>  	hole = alloc_frag->size - alloc_frag->offset;
> -	if (hole < len + headroom) {
> +	if (hole < len + room) {
>  		/* To avoid internal fragmentation, if there is very likely not
>  		 * enough space for another buffer, add the remaining space to
>  		 * the current buffer.
> @@ -2576,12 +2600,15 @@ static ssize_t mergeable_rx_buffer_size_show(struct netdev_rx_queue *queue,
>  {
>  	struct virtnet_info *vi = netdev_priv(queue->dev);
>  	unsigned int queue_index = get_netdev_rx_queue_index(queue);
> +	unsigned int headroom = virtnet_get_headroom(vi);
> +	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>  	struct ewma_pkt_len *avg;
>  
>  	BUG_ON(queue_index >= vi->max_queue_pairs);
>  	avg = &vi->rq[queue_index].mrg_avg_pkt_len;
>  	return sprintf(buf, "%u\n",
> -		       get_mergeable_buf_len(&vi->rq[queue_index], avg));
> +		       get_mergeable_buf_len(&vi->rq[queue_index], avg,
> +				       SKB_DATA_ALIGN(headroom + tailroom)));
>  }
>  
>  static struct rx_queue_attribute mergeable_rx_buffer_size_attribute =
> -- 
> 2.7.4
