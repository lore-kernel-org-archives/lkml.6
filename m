Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1C6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60642133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60642133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIMOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeIMOQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79EA230001E2;
        Thu, 13 Sep 2018 09:07:51 +0000 (UTC)
Received: from [10.72.12.62] (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C27E600C2;
        Thu, 13 Sep 2018 09:07:45 +0000 (UTC)
Subject: Re: [PATCH net-next V2] virtio_net: ethtool tx napi configuration
To:     mst@redhat.com
Cc:     davem@davemloft.net, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
References: <20180913053545.18585-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1ebbe892-1be0-18b1-3dee-d52bedc9a05d@redhat.com>
Date:   Thu, 13 Sep 2018 17:07:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913053545.18585-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Sep 2018 09:07:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月13日 13:35, Jason Wang wrote:
> Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
> Interrupt moderation is currently not supported, so these accept and
> display the default settings of 0 usec and 1 frame.
>
> Toggle tx napi through a bit in tx-frames. So as to not interfere
> with possible future interrupt moderation, value 1 means tx napi while
> value 0 means not.
>
> To properly synchronize with the data path, tx napi is disabled and
> tx lock is held when changing the value of napi weight. And two more
> places that can access tx napi weight:
>
> - speculative tx polling in rx napi, we can leave it as is since it
>    not a must for correctness.
> - skb_xmit_done(), one more check of napi weight is added before
>    trying to enable tx to avoid tx to be disabled forever if napi is
>    disabled after skb_xmit_done() but before the napi
>
> Link: https://patchwork.ozlabs.org/patch/948149/
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - try to synchronize with datapath to allow changing mode when
>    interface is up.
> - use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi
> ---
>   drivers/net/virtio_net.c | 64 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 765920905226..6e70864f5899 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -66,6 +66,8 @@ DECLARE_EWMA(pkt_len, 0, 64)
>   
>   #define VIRTNET_DRIVER_VERSION "1.0.0"
>   
> +static const u32 ethtool_coalesce_napi_mask = (1UL << 10);
> +
>   static const unsigned long guest_offloads[] = {
>   	VIRTIO_NET_F_GUEST_TSO4,
>   	VIRTIO_NET_F_GUEST_TSO6,
> @@ -1444,7 +1446,10 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>   
>   	virtqueue_napi_complete(napi, sq->vq, 0);
>   
> -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +	/* Check napi.weight to avoid tx stall since it could be set
> +	 * to zero by ethtool after skb_xmit_done().
> +	 */
> +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS || !sq->napi.weight)
>   		netif_tx_wake_queue(txq);
>   
>   	return 0;
> @@ -2181,6 +2186,61 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
>   	return 0;
>   }
>   
> +static int virtnet_set_coalesce(struct net_device *dev,
> +				struct ethtool_coalesce *ec)
> +{
> +	struct ethtool_coalesce ec_default = {
> +		.cmd = ETHTOOL_SCOALESCE,
> +		.rx_max_coalesced_frames = 1,
> +	};
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	int i, napi_weight;
> +
> +	if (ec->tx_max_coalesced_frames > 1)
> +		return -EINVAL;
> +
> +	ec_default.tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
> +	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> +
> +	/* disallow changes to fields not explicitly tested above */
> +	if (memcmp(ec, &ec_default, sizeof(ec_default)))
> +		return -EINVAL;
> +
> +	if (napi_weight ^ vi->sq[0].napi.weight) {
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			struct netdev_queue *txq =
> +			       netdev_get_tx_queue(vi->dev, i);
> +
> +			virtnet_napi_tx_disable(&vi->sq[i].napi);
> +			__netif_tx_lock_bh(txq);

Need to check netif_running() before disabling napi. Otherwise we may 
have a infinite loop here.

The discussion is still ongoing, if we decide to go set_coalesce, I will 
post a V3.

Thanks

> +			vi->sq[i].napi.weight = napi_weight;
> +			__netif_tx_unlock_bh(txq);
> +			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
> +					       &vi->sq[i].napi);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int virtnet_get_coalesce(struct net_device *dev,
> +				struct ethtool_coalesce *ec)
> +{
> +	struct ethtool_coalesce ec_default = {
> +		.cmd = ETHTOOL_GCOALESCE,
> +		.rx_max_coalesced_frames = 1,
> +		.tx_max_coalesced_frames = 0,
> +	};
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	memcpy(ec, &ec_default, sizeof(ec_default));
> +
> +	if (vi->sq[0].napi.weight)
> +		ec->tx_max_coalesced_frames = 1;
> +
> +	return 0;
> +}
> +
>   static void virtnet_init_settings(struct net_device *dev)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> @@ -2219,6 +2279,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>   	.get_ts_info = ethtool_op_get_ts_info,
>   	.get_link_ksettings = virtnet_get_link_ksettings,
>   	.set_link_ksettings = virtnet_set_link_ksettings,
> +	.set_coalesce = virtnet_set_coalesce,
> +	.get_coalesce = virtnet_get_coalesce,
>   };
>   
>   static void virtnet_freeze_down(struct virtio_device *vdev)

