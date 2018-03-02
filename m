Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428239AbeCBRgS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:36:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424425AbeCBRgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:36:16 -0500
Date: Fri, 2 Mar 2018 19:36:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
 buffer
Message-ID: <20180302193104-mutt-send-email-mst@kernel.org>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 05:29:14PM +0800, Jason Wang wrote:
> XDP_REDIRECT support for mergeable buffer was removed since commit
> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
> case"). This is because we don't reserve enough tailroom for struct
> skb_shared_info which breaks XDP assumption. So this patch fixes this
> by reserving enough tailroom and using fixed size of rx buffer.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I think the next incremental step is to look at splitting
out fast path XDP processing to a separate set of functions.

> ---
> Changes from V1:
> - do not add duplicated tracepoint when redirection fails
> ---
>  drivers/net/virtio_net.c | 54 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9bb9e56..426dcf7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -504,6 +504,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  	page_off += *len;
>  
>  	while (--*num_buf) {
> +		int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		unsigned int buflen;
>  		void *buf;
>  		int off;
> @@ -518,7 +519,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  		/* guard against a misconfigured or uncooperative backend that
>  		 * is sending packet larger than the MTU.
>  		 */
> -		if ((page_off + buflen) > PAGE_SIZE) {
> +		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>  			put_page(p);
>  			goto err_buf;
>  		}
> @@ -690,6 +691,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	unsigned int truesize;
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>  	bool sent;
> +	int err;
>  
>  	head_skb = NULL;
>  
> @@ -701,7 +703,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		void *data;
>  		u32 act;
>  
> -		/* This happens when rx buffer size is underestimated */
> +		/* This happens when rx buffer size is underestimated
> +		 * or headroom is not enough because of the buffer
> +		 * was refilled before XDP is set. This should only
> +		 * happen for the first several packets, so we don't
> +		 * care much about its performance.
> +		 */
>  		if (unlikely(num_buf > 1 ||
>  			     headroom < virtnet_get_headroom(vi))) {
>  			/* linearize data for XDP */
> @@ -736,9 +743,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>  
> -		if (act != XDP_PASS)
> -			ewma_pkt_len_add(&rq->mrg_avg_pkt_len, len);
> -
>  		switch (act) {
>  		case XDP_PASS:
>  			/* recalculate offset to account for any header
> @@ -770,6 +774,18 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  				goto err_xdp;
>  			rcu_read_unlock();
>  			goto xdp_xmit;
> +		case XDP_REDIRECT:
> +			err = xdp_do_redirect(dev, &xdp, xdp_prog);
> +			if (err) {
> +				if (unlikely(xdp_page != page))
> +					put_page(xdp_page);
> +				goto err_xdp;
> +			}
> +			*xdp_xmit = true;
> +			if (unlikely(xdp_page != page))
> +				goto err_xdp;
> +			rcu_read_unlock();
> +			goto xdp_xmit;
>  		default:
>  			bpf_warn_invalid_xdp_action(act);
>  		case XDP_ABORTED:
> @@ -1013,13 +1029,18 @@ static int add_recvbuf_big(struct virtnet_info *vi, struct receive_queue *rq,
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
> @@ -1028,21 +1049,27 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
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
> @@ -2576,12 +2603,15 @@ static ssize_t mergeable_rx_buffer_size_show(struct netdev_rx_queue *queue,
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
