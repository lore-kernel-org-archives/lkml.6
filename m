Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C817C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419FB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419FB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeLFIbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:31:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbeLFIbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:31:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDAD23086249;
        Thu,  6 Dec 2018 08:31:48 +0000 (UTC)
Received: from [10.72.12.143] (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1AC519C7B;
        Thu,  6 Dec 2018 08:31:32 +0000 (UTC)
Subject: Re: [PATCH RFC 1/2] virtio-net: bql support
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        maxime.coquelin@redhat.com, wexu@redhat.com,
        "David S. Miller" <davem@davemloft.net>
References: <20181205225323.12555-1-mst@redhat.com>
 <20181205225323.12555-2-mst@redhat.com>
 <21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com>
Message-ID: <a7c57a15-825d-b7fa-8f6d-790cb285bdcc@redhat.com>
Date:   Thu, 6 Dec 2018 16:31:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------43F548859632C22C685A62DF"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 06 Dec 2018 08:31:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------43F548859632C22C685A62DF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2018/12/6 下午4:17, Jason Wang wrote:
>
> On 2018/12/6 上午6:54, Michael S. Tsirkin wrote:
>> When use_napi is set, let's enable BQLs. Note: some of the issues are
>> similar to wifi.  It's worth considering whether something similar to
>> commit 36148c2bbfbe ("mac80211: Adjust TSQ pacing shift") might be
>> benefitial.
>
>
> I've played a similar patch several days before. The tricky part is 
> the mode switching between napi and no napi. We should make sure when 
> the packet is sent and trakced by BQL,  it should be consumed by BQL 
> as well. I did it by tracking it through skb->cb.  And deal with the 
> freeze by reset the BQL status. Patch attached.


Add the patch.

Thanks


>
> But when testing with vhost-net, I don't very a stable performance, it 
> was probably because we batch the used ring updating so tx interrupt 
> may come randomly. We probably need to implement time bounded 
> coalescing mechanism which could be configured from userspace.
>
> Btw, maybe it's time just enable napi TX by default. I get ~10% TCP_RR 
> regression on machine without APICv, (haven't found time to test APICv 
> machine). But consider it was for correctness, I think it's 
> acceptable? Then we can do optimization on top?
>
>
> Thanks
>
>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index cecfd77c9f3c..b657bde6b94b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1325,7 +1325,8 @@ static int virtnet_receive(struct receive_queue 
>> *rq, int budget,
>>       return stats.packets;
>>   }
>>   -static void free_old_xmit_skbs(struct send_queue *sq)
>> +static void free_old_xmit_skbs(struct send_queue *sq, struct 
>> netdev_queue *txq,
>> +                   bool use_napi)
>>   {
>>       struct sk_buff *skb;
>>       unsigned int len;
>> @@ -1347,6 +1348,9 @@ static void free_old_xmit_skbs(struct 
>> send_queue *sq)
>>       if (!packets)
>>           return;
>>   +    if (use_napi)
>> +        netdev_tx_completed_queue(txq, packets, bytes);
>> +
>>       u64_stats_update_begin(&sq->stats.syncp);
>>       sq->stats.bytes += bytes;
>>       sq->stats.packets += packets;
>> @@ -1364,7 +1368,7 @@ static void virtnet_poll_cleantx(struct 
>> receive_queue *rq)
>>           return;
>>         if (__netif_tx_trylock(txq)) {
>> -        free_old_xmit_skbs(sq);
>> +        free_old_xmit_skbs(sq, txq, true);
>>           __netif_tx_unlock(txq);
>>       }
>>   @@ -1440,7 +1444,7 @@ static int virtnet_poll_tx(struct napi_struct 
>> *napi, int budget)
>>       struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, 
>> vq2txq(sq->vq));
>>         __netif_tx_lock(txq, raw_smp_processor_id());
>> -    free_old_xmit_skbs(sq);
>> +    free_old_xmit_skbs(sq, txq, true);
>>       __netif_tx_unlock(txq);
>>         virtqueue_napi_complete(napi, sq->vq, 0);
>> @@ -1505,13 +1509,15 @@ static netdev_tx_t start_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>       struct send_queue *sq = &vi->sq[qnum];
>>       int err;
>>       struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>> -    bool kick = !skb->xmit_more;
>> +    bool more = skb->xmit_more;
>>       bool use_napi = sq->napi.weight;
>> +    unsigned int bytes = skb->len;
>> +    bool kick;
>>         /* Free up any pending old buffers before queueing new ones. */
>> -    free_old_xmit_skbs(sq);
>> +    free_old_xmit_skbs(sq, txq, use_napi);
>>   -    if (use_napi && kick)
>> +    if (use_napi && !more)
>>           virtqueue_enable_cb_delayed(sq->vq);
>>         /* timestamp packet in software */
>> @@ -1552,7 +1558,7 @@ static netdev_tx_t start_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>           if (!use_napi &&
>>               unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>>               /* More just got used, free them then recheck. */
>> -            free_old_xmit_skbs(sq);
>> +            free_old_xmit_skbs(sq, txq, false);
>>               if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>>                   netif_start_subqueue(dev, qnum);
>>                   virtqueue_disable_cb(sq->vq);
>> @@ -1560,7 +1566,12 @@ static netdev_tx_t start_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>           }
>>       }
>>   -    if (kick || netif_xmit_stopped(txq)) {
>> +    if (use_napi)
>> +        kick = __netdev_tx_sent_queue(txq, bytes, more);
>> +    else
>> +        kick = !more || netif_xmit_stopped(txq);
>> +
>> +    if (kick) {
>>           if (virtqueue_kick_prepare(sq->vq) && 
>> virtqueue_notify(sq->vq)) {
>>               u64_stats_update_begin(&sq->stats.syncp);
>>               sq->stats.kicks++;
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

--------------43F548859632C22C685A62DF
Content-Type: text/x-patch;
 name="0001-virtio-net-byte-queue-limit-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-virtio-net-byte-queue-limit-support.patch"

From f1c27543dc412778e682b63addbb0a471afc5153 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Nov 2018 14:25:30 +0800
Subject: [PATCH] virtio-net: byte queue limit support

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 47979fc..8712c11 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -279,6 +279,14 @@ static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
 	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
 }
 
+
+static inline int *skb_cb_bql(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct virtio_net_hdr_mrg_rxbuf) +
+		     sizeof(int) > sizeof(skb->cb));
+	return (int *)(skb->cb + sizeof(struct virtio_net_hdr_mrg_rxbuf));
+}
+
 /*
  * private is used to chain pages for big packets, put the whole
  * most recent used list in the beginning for reuse
@@ -1325,12 +1333,14 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return stats.packets;
 }
 
-static void free_old_xmit_skbs(struct send_queue *sq)
+static void free_old_xmit_skbs(struct send_queue *sq,
+			       struct netdev_queue *txq)
 {
 	struct sk_buff *skb;
 	unsigned int len;
-	unsigned int packets = 0;
-	unsigned int bytes = 0;
+	unsigned int packets = 0, bql_packets = 0;
+	unsigned int bytes = 0, bql_bytes = 0;
+	int *bql;
 
 	while ((skb = virtqueue_get_buf(sq->vq, &len)) != NULL) {
 		pr_debug("Sent skb %p\n", skb);
@@ -1338,6 +1348,12 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 		bytes += skb->len;
 		packets++;
 
+		bql = skb_cb_bql(skb);
+		if (*bql) {
+			bql_packets ++;
+			bql_bytes += skb->len;
+		}
+
 		dev_consume_skb_any(skb);
 	}
 
@@ -1351,6 +1367,8 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 	sq->stats.bytes += bytes;
 	sq->stats.packets += packets;
 	u64_stats_update_end(&sq->stats.syncp);
+
+	netdev_tx_completed_queue(txq, bql_packets, bql_bytes);
 }
 
 static void virtnet_poll_cleantx(struct receive_queue *rq)
@@ -1364,7 +1382,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq);
+		free_old_xmit_skbs(sq, txq);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1440,7 +1458,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
 
 	__netif_tx_lock(txq, raw_smp_processor_id());
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, txq);
 	__netif_tx_unlock(txq);
 
 	virtqueue_napi_complete(napi, sq->vq, 0);
@@ -1459,6 +1477,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
 	bool can_push;
+	int *bql = skb_cb_bql(skb);
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
@@ -1495,6 +1514,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
+
+	*bql = sq->napi.weight ? 1 : 0;
 	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
 }
 
@@ -1509,7 +1530,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool use_napi = sq->napi.weight;
 
 	/* Free up any pending old buffers before queueing new ones. */
-	free_old_xmit_skbs(sq);
+	free_old_xmit_skbs(sq, txq);
 
 	if (use_napi && kick)
 		virtqueue_enable_cb_delayed(sq->vq);
@@ -1537,6 +1558,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		nf_reset(skb);
 	}
 
+	if (use_napi)
+		netdev_tx_sent_queue(txq, skb->len);
+
 	/* If running out of space, stop queue to avoid getting packets that we
 	 * are then unable to transmit.
 	 * An alternative would be to force queuing layer to requeue the skb by
@@ -1552,7 +1576,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (!use_napi &&
 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
 			/* More just got used, free them then recheck. */
-			free_old_xmit_skbs(sq);
+			free_old_xmit_skbs(sq, txq);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
 				virtqueue_disable_cb(sq->vq);
@@ -2275,8 +2299,14 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 
 	if (netif_running(vi->dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
+			struct send_queue *sq = &vi->sq[i];
+			struct netdev_queue *txq =
+			       netdev_get_tx_queue(vi->dev, i);
+
 			napi_disable(&vi->rq[i].napi);
-			virtnet_napi_tx_disable(&vi->sq[i].napi);
+			virtnet_napi_tx_disable(&sq->napi);
+			if (sq->napi.weight)
+				netdev_tx_reset_queue(txq);
 		}
 	}
 }
-- 
1.8.3.1


--------------43F548859632C22C685A62DF--
