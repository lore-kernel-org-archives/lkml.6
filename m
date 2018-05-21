Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeEUQ4P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:56:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:50469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752908AbeEUQ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:56:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="57756676"
Date: Mon, 21 May 2018 09:56:11 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: <mst@redhat.com>, <kvm@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, jesse.brandeburg@intel.com
Subject: Re: [RFC PATCH net-next 10/12] vhost_net: build xdp buff
Message-ID: <20180521095611.00005caa@intel.com>
In-Reply-To: <1526893473-20128-11-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
        <1526893473-20128-11-git-send-email-jasowang@redhat.com>
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 17:04:31 +0800 Jason wrote:
> This patch implement build XDP buffers in vhost_net. The idea is do
> userspace copy in vhost_net and build XDP buff based on the
> page. Vhost_net can then submit one or an array of XDP buffs to
> underlayer socket (e.g TUN). TUN can choose to do XDP or call
> build_skb() to build skb. To support build skb, vnet header were also
> stored into the header of the XDP buff.
> 
> This userspace copy and XDP buffs building is key to achieve XDP
> batching in TUN, since TUN does not need to care about userspace copy
> and then can disable premmption for several XDP buffs to achieve
> batching from XDP.
> 
> TODO: reserve headroom based on the TUN XDP.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f0639d7..1209e84 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -492,6 +492,80 @@ static bool vhost_has_more_pkts(struct vhost_net *net,
>  	       likely(!vhost_exceeds_maxpend(net));
>  }
>  
> +#define VHOST_NET_HEADROOM 256
> +#define VHOST_NET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
> +
> +static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
> +			       struct iov_iter *from,
> +			       struct xdp_buff *xdp)
> +{
> +	struct vhost_virtqueue *vq = &nvq->vq;
> +	struct page_frag *alloc_frag = &current->task_frag;
> +	struct virtio_net_hdr *gso;
> +	size_t len = iov_iter_count(from);
> +	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	int pad = SKB_DATA_ALIGN(VHOST_NET_RX_PAD + VHOST_NET_HEADROOM
> +				 + nvq->sock_hlen);
> +	int sock_hlen = nvq->sock_hlen;
> +	void *buf;
> +	int copied;
> +
> +	if (len < nvq->sock_hlen)
> +		return -EFAULT;
> +
> +	if (SKB_DATA_ALIGN(len + pad) +
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
> +		return -ENOSPC;
> +
> +	buflen += SKB_DATA_ALIGN(len + pad);

maybe store the result of SKB_DATA_ALIGN in a local instead of doing
the work twice?

> +	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
> +	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
> +		return -ENOMEM;
> +
> +	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
> +
> +	/* We store two kinds of metadata in the header which will be
> +	 * used for XDP_PASS to do build_skb():
> +	 * offset 0: buflen
> +	 * offset sizeof(int): vnet header
> +	 */
> +	copied = copy_page_from_iter(alloc_frag->page,
> +				     alloc_frag->offset + sizeof(int), sock_hlen, from);
> +	if (copied != sock_hlen)
> +		return -EFAULT;
> +
> +	gso = (struct virtio_net_hdr *)(buf + sizeof(int));
> +
> +	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> +	    vhost16_to_cpu(vq, gso->csum_start) +
> +	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> +	    vhost16_to_cpu(vq, gso->hdr_len)) {
> +		gso->hdr_len = cpu_to_vhost16(vq,
> +			       vhost16_to_cpu(vq, gso->csum_start) +
> +			       vhost16_to_cpu(vq, gso->csum_offset) + 2);
> +
> +		if (vhost16_to_cpu(vq, gso->hdr_len) > len)
> +			return -EINVAL;
> +	}
> +
> +	len -= sock_hlen;
> +	copied = copy_page_from_iter(alloc_frag->page,
> +				     alloc_frag->offset + pad,
> +				     len, from);
> +	if (copied != len)
> +		return -EFAULT;
> +
> +	xdp->data_hard_start = buf;
> +	xdp->data = buf + pad;
> +	xdp->data_end = xdp->data + len;
> +	*(int *)(xdp->data_hard_start)= buflen;

space before =

> +
> +	get_page(alloc_frag->page);
> +	alloc_frag->offset += buflen;
> +
> +	return 0;
> +}
> +
>  static void handle_tx_copy(struct vhost_net *net)
>  {
>  	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
