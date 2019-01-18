Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F7020896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfARMvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:51:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfARMvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:51:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F5011F8C1;
        Fri, 18 Jan 2019 12:51:44 +0000 (UTC)
Received: from [10.72.12.162] (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C4635D964;
        Fri, 18 Jan 2019 12:51:39 +0000 (UTC)
Subject: Re: [PATCH v2] virtio_net: bulk free tx skbs
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20190118041842.24067-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e0610506-ef97-21e4-bad4-e22bd077234c@redhat.com>
Date:   Fri, 18 Jan 2019 20:51:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118041842.24067-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 18 Jan 2019 12:51:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/18 下午12:20, Michael S. Tsirkin wrote:
> Use napi_consume_skb() to get bulk free.  Note that napi_consume_skb is
> safe to call in a non-napi context as long as the napi_budget flag is
> correct.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Changes from v1:
> 	rebase on master.
>
> lightly tested on developer's box.
>
>   drivers/net/virtio_net.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 023725086046..8fadd8eaf601 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1330,7 +1330,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>   	return stats.packets;
>   }
>   
> -static void free_old_xmit_skbs(struct send_queue *sq)
> +static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
>   {
>   	struct sk_buff *skb;
>   	unsigned int len;
> @@ -1343,7 +1343,7 @@ static void free_old_xmit_skbs(struct send_queue *sq)
>   		bytes += skb->len;
>   		packets++;
>   
> -		dev_consume_skb_any(skb);
> +		napi_consume_skb(skb, in_napi);
>   	}
>   
>   	/* Avoid overhead when no packets have been processed
> @@ -1369,7 +1369,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>   		return;
>   
>   	if (__netif_tx_trylock(txq)) {
> -		free_old_xmit_skbs(sq);
> +		free_old_xmit_skbs(sq, true);
>   		__netif_tx_unlock(txq);
>   	}
>   
> @@ -1445,7 +1445,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>   	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
>   
>   	__netif_tx_lock(txq, raw_smp_processor_id());
> -	free_old_xmit_skbs(sq);
> +	free_old_xmit_skbs(sq, true);
>   	__netif_tx_unlock(txq);
>   
>   	virtqueue_napi_complete(napi, sq->vq, 0);
> @@ -1514,7 +1514,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>   	bool use_napi = sq->napi.weight;
>   
>   	/* Free up any pending old buffers before queueing new ones. */
> -	free_old_xmit_skbs(sq);
> +	free_old_xmit_skbs(sq, false);
>   
>   	if (use_napi && kick)
>   		virtqueue_enable_cb_delayed(sq->vq);
> @@ -1557,7 +1557,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>   		if (!use_napi &&
>   		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>   			/* More just got used, free them then recheck. */
> -			free_old_xmit_skbs(sq);
> +			free_old_xmit_skbs(sq, false);
>   			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>   				netif_start_subqueue(dev, qnum);
>   				virtqueue_disable_cb(sq->vq);
