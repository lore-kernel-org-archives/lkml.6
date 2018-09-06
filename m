Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA962086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA962086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeIFWhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:37:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbeIFWhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:37:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A8314012985;
        Thu,  6 Sep 2018 18:00:57 +0000 (UTC)
Received: from redhat.com (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id 274DA10073D0;
        Thu,  6 Sep 2018 18:00:57 +0000 (UTC)
Date:   Thu, 6 Sep 2018 14:00:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 10/11] tap: accept an array of XDP buffs through
 sendmsg()
Message-ID: <20180906135450-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-11-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-11-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 18:00:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 18:00:57 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:05:25PM +0800, Jason Wang wrote:
> This patch implement TUN_MSG_PTR msg_control type. This type allows
> the caller to pass an array of XDP buffs to tuntap through ptr field
> of the tun_msg_control. Tap will build skb through those XDP buffers.
> 
> This will avoid lots of indirect calls thus improves the icache
> utilization and allows to do XDP batched flushing when doing XDP
> redirection.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/tap.c | 73 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 7996ed7cbf18..50eb7bf22225 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1146,14 +1146,83 @@ static const struct file_operations tap_fops = {
>  #endif
>  };
>  
> +static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> +{
> +	struct virtio_net_hdr *gso = xdp->data_hard_start + sizeof(int);
> +	int buflen = *(int *)xdp->data_hard_start;
> +	int vnet_hdr_len = 0;
> +	struct tap_dev *tap;
> +	struct sk_buff *skb;
> +	int err, depth;
> +
> +	if (q->flags & IFF_VNET_HDR)
> +		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> +
> +	skb = build_skb(xdp->data_hard_start, buflen);
> +	if (!skb) {
> +		err = -ENOMEM;
> +		goto err;
> +	}

So fundamentally why is it called XDP?
We just build and skb, don't we?

> +
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	skb_put(skb, xdp->data_end - xdp->data);
> +
> +	skb_set_network_header(skb, ETH_HLEN);
> +	skb_reset_mac_header(skb);
> +	skb->protocol = eth_hdr(skb)->h_proto;
> +
> +	if (vnet_hdr_len) {
> +		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
> +		if (err)
> +			goto err_kfree;
> +	}
> +
> +	skb_probe_transport_header(skb, ETH_HLEN);
> +
> +	/* Move network header to the right position for VLAN tagged packets */
> +	if ((skb->protocol == htons(ETH_P_8021Q) ||
> +	     skb->protocol == htons(ETH_P_8021AD)) &&
> +	    __vlan_get_protocol(skb, skb->protocol, &depth) != 0)
> +		skb_set_network_header(skb, depth);
> +
> +	rcu_read_lock();
> +	tap = rcu_dereference(q->tap);
> +	if (tap) {
> +		skb->dev = tap->dev;
> +		dev_queue_xmit(skb);
> +	} else {
> +		kfree_skb(skb);
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +
> +err_kfree:
> +	kfree_skb(skb);
> +err:
> +	rcu_read_lock();
> +		tap = rcu_dereference(q->tap);
> +	if (tap && tap->count_tx_dropped)
> +		tap->count_tx_dropped(tap);
> +	rcu_read_unlock();
> +	return err;
> +}
> +
>  static int tap_sendmsg(struct socket *sock, struct msghdr *m,
>  		       size_t total_len)
>  {
>  	struct tap_queue *q = container_of(sock, struct tap_queue, sock);
>  	struct tun_msg_ctl *ctl = m->msg_control;
> +	struct xdp_buff *xdp;
> +	int i;
>  
> -	if (ctl && ctl->type != TUN_MSG_UBUF)
> -		return -EINVAL;
> +	if (ctl && ((ctl->type & 0xF) == TUN_MSG_PTR)) {
> +		for (i = 0; i < ctl->type >> 16; i++) {
> +			xdp = &((struct xdp_buff *)ctl->ptr)[i];
> +			tap_get_user_xdp(q, xdp);
> +		}
> +		return 0;
> +	}
>  
>  	return tap_get_user(q, ctl ? ctl->ptr : NULL, &m->msg_iter,
>  			    m->msg_flags & MSG_DONTWAIT);
> -- 
> 2.17.1
