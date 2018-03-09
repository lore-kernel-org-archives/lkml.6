Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeCIDyi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 22:54:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbeCIDyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 22:54:37 -0500
Date: Fri, 9 Mar 2018 05:54:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        glider@google.com, dvyukov@google.com
Subject: Re: [PATCH net] vhost_net: examine pointer types during un-producing
Message-ID: <20180309055424-mutt-send-email-mst@kernel.org>
References: <1520565382-4915-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520565382-4915-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 11:16:22AM +0800, Jason Wang wrote:
> After commit 761876c857cb ("tap: XDP support"), we can actually
> queueing XDP pointers in the pointer ring, so we should examine the
> pointer type before freeing the pointer.
> 
> Fixes: 761876c857cb ("tap: XDP support")
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c      | 3 ++-
>  drivers/vhost/net.c    | 2 +-
>  include/linux/if_tun.h | 4 ++++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 7433bb2..28cfa64 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -655,7 +655,7 @@ static struct tun_struct *tun_enable_queue(struct tun_file *tfile)
>  	return tun;
>  }
>  
> -static void tun_ptr_free(void *ptr)
> +void tun_ptr_free(void *ptr)
>  {
>  	if (!ptr)
>  		return;
> @@ -667,6 +667,7 @@ static void tun_ptr_free(void *ptr)
>  		__skb_array_destroy_skb(ptr);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(tun_ptr_free);
>  
>  static void tun_queue_purge(struct tun_file *tfile)
>  {
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 610cba2..54a138f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -170,7 +170,7 @@ static void vhost_net_buf_unproduce(struct vhost_net_virtqueue *nvq)
>  	if (nvq->rx_ring && !vhost_net_buf_is_empty(rxq)) {
>  		ptr_ring_unconsume(nvq->rx_ring, rxq->queue + rxq->head,
>  				   vhost_net_buf_get_size(rxq),
> -				   __skb_array_destroy_skb);
> +				   tun_ptr_free);
>  		rxq->head = rxq->tail = 0;
>  	}
>  }
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index c5b0a75..fd00170 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -25,6 +25,7 @@ struct ptr_ring *tun_get_tx_ring(struct file *file);
>  bool tun_is_xdp_buff(void *ptr);
>  void *tun_xdp_to_ptr(void *ptr);
>  void *tun_ptr_to_xdp(void *ptr);
> +void tun_ptr_free(void *ptr);
>  #else
>  #include <linux/err.h>
>  #include <linux/errno.h>
> @@ -50,5 +51,8 @@ static inline void *tun_ptr_to_xdp(void *ptr)
>  {
>  	return NULL;
>  }
> +static inline void tun_ptr_free(void *ptr)
> +{
> +}
>  #endif /* CONFIG_TUN */
>  #endif /* __IF_TUN_H */
> -- 
> 2.7.4
