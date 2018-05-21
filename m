Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeEUPDm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:03:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751021AbeEUPDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:03:39 -0400
Date: Mon, 21 May 2018 18:03:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] virtio-net: correctly redirect linearized packet
Message-ID: <20180521180321-mutt-send-email-mst@kernel.org>
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
 <1526891706-18516-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526891706-18516-2-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 04:35:03PM +0800, Jason Wang wrote:
> After a linearized packet was redirected by XDP, we should not go for
> the err path which will try to pop buffers for the next packet and
> increase the drop counter. Fixing this by just drop the page refcnt
> for the original page.
> 
> Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
> Reported-by: David Ahern <dsahern@gmail.com>
> Tested-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 770422e..c15d240 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -787,7 +787,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			}
>  			*xdp_xmit = true;
>  			if (unlikely(xdp_page != page))
> -				goto err_xdp;
> +				put_page(page);
>  			rcu_read_unlock();
>  			goto xdp_xmit;
>  		default:
> -- 
> 2.7.4
