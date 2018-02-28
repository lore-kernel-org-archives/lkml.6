Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932701AbeB1P14 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:27:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933021AbeB1P1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:27:51 -0500
Date: Wed, 28 Feb 2018 17:27:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: disable NAPI only when enabled during
 XDP set
Message-ID: <20180228172739-mutt-send-email-mst@kernel.org>
References: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 06:20:04PM +0800, Jason Wang wrote:
> We try to disable NAPI to prevent a single XDP TX queue being used by
> multiple cpus. But we don't check if device is up (NAPI is enabled),
> this could result stall because of infinite wait in
> napi_disable(). Fixing this by checking device state through
> netif_running() before.
> 
> Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9bb9e56..2d54123 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2185,8 +2185,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	}
>  
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		napi_disable(&vi->rq[i].napi);
> +	if (netif_running(dev))
> +		for (i = 0; i < vi->max_queue_pairs; i++)
> +			napi_disable(&vi->rq[i].napi);
>  
>  	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
>  	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
> @@ -2205,7 +2206,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		}
>  		if (old_prog)
>  			bpf_prog_put(old_prog);
> -		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
> +		if (netif_running(dev))
> +			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
