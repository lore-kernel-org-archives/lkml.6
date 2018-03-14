Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbeCNDhm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:37:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750902AbeCNDhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:37:41 -0400
Date: Wed, 14 Mar 2018 05:37:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tuntap: XDP_TX can use native XDP
Message-ID: <20180314053424-mutt-send-email-mst@kernel.org>
References: <1520997820-8289-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520997820-8289-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 11:23:40AM +0800, Jason Wang wrote:
> Now we have ndo_xdp_xmit, switch to use it instead of the slow generic
> XDP TX routine. XDP_TX on TAP gets ~20% improvements from ~1.5Mpps to
> ~1.8Mpps on 2.60GHz Core(TM) i7-5600U.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 475088f..baeafa0 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1613,7 +1613,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	unsigned int delta = 0;
>  	char *buf;
>  	size_t copied;
> -	bool xdp_xmit = false;
>  	int err, pad = TUN_RX_PAD;
>  
>  	rcu_read_lock();
> @@ -1671,8 +1670,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  			preempt_enable();
>  			return NULL;
>  		case XDP_TX:
> -			xdp_xmit = true;
> -			/* fall through */
> +			get_page(alloc_frag->page);
> +			alloc_frag->offset += buflen;
> +			if (tun_xdp_xmit(tun->dev, &xdp))
> +				goto err_redirect;
> +			tun_xdp_flush(tun->dev);

Why do we have to flush here though?
It might be a good idea to document the reason in a code comment.

> +			rcu_read_unlock();
> +			preempt_enable();
> +			return NULL;
>  		case XDP_PASS:
>  			delta = orig_data - xdp.data;
>  			break;
> @@ -1699,14 +1704,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	get_page(alloc_frag->page);
>  	alloc_frag->offset += buflen;
>  
> -	if (xdp_xmit) {
> -		skb->dev = tun->dev;
> -		generic_xdp_tx(skb, xdp_prog);
> -		rcu_read_unlock();
> -		preempt_enable();
> -		return NULL;
> -	}
> -
>  	rcu_read_unlock();
>  	preempt_enable();
>  
> -- 
> 2.7.4
