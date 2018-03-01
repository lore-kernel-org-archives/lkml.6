Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966527AbeCAIle (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:41:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964939AbeCAIld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:41:33 -0500
Date: Thu, 1 Mar 2018 09:41:29 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, brouer@redhat.com
Subject: Re: [PATCH net-next 1/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
Message-ID: <20180301094129.29fb6ce6@redhat.com>
In-Reply-To: <1519874345-10235-2-git-send-email-jasowang@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
        <1519874345-10235-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu,  1 Mar 2018 11:19:04 +0800 Jason Wang <jasowang@redhat.com> wrote:

> XDP_REDIRECT support for mergeable buffer was removed since commit
> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
> case"). This is because we don't reserve enough tailroom for struct
> skb_shared_info which breaks XDP assumption. Other complaints are, the
> complex linearize logic and EWMA estimation may increase the
> possibility of linearizing.

This patch also have the intermixing issues, I mentioned for patch 2/2.

On Thu, 1 Mar 2018 09:02:06 +0100
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> 1. XDP generic is not feature complete, e.g. cpumap will drop these
>    packets. It might not be possible to implement some features, think
>    of (AF_XDP) zero-copy.
> 
> 2. This can easily cause out-of-order packets.
> 
> 3. It makes it harder to troubleshoot, when diagnosing issues
>    around #1, we have a hard time determining what path an XDP packet
>    took (the xdp tracepoints doesn't know).


It is slightly better, as it is consistent in calling XDP-generic in
the XDP_REDIRECT action, which an action under heavy development, here
we want the freedom to develop in different code tempi.  And some
features might never be available in XDP-generic. Thus, when a feature
is missing/broken it will be consistent for the user.

The remaining question is how will a user know that XDP "mode" she is
using?  The user clearly loaded an XDP-native program, and expect the
associated performance, but XDP_REDIRECT will be using the slow
XDP-generic code path...



> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 107 +++++++++++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9bb9e56..81190ba 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
[...]
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

I think you also need to check the tailroom here? (AFAIK this is hidden
in the len_to_ctx as the "truesize").

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


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
