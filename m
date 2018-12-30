Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A391420836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeL3SsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 13:48:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeL3SsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 13:48:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F9FF80E7B;
        Sun, 30 Dec 2018 18:48:20 +0000 (UTC)
Received: from redhat.com (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A167910018F9;
        Sun, 30 Dec 2018 18:48:12 +0000 (UTC)
Date:   Sun, 30 Dec 2018 13:48:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] virtio-net: bql support
Message-ID: <20181230134539-mutt-send-email-mst@kernel.org>
References: <20181205225323.12555-1-mst@redhat.com>
 <20181205225323.12555-2-mst@redhat.com>
 <21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com>
 <20181226102100-mutt-send-email-mst@kernel.org>
 <620cfd46-aa3e-7eb6-0757-f4afbafda44b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <620cfd46-aa3e-7eb6-0757-f4afbafda44b@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 30 Dec 2018 18:48:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 06:04:53PM +0800, Jason Wang wrote:
> 
> On 2018/12/26 下午11:22, Michael S. Tsirkin wrote:
> > On Thu, Dec 06, 2018 at 04:17:36PM +0800, Jason Wang wrote:
> > > On 2018/12/6 上午6:54, Michael S. Tsirkin wrote:
> > > > When use_napi is set, let's enable BQLs.  Note: some of the issues are
> > > > similar to wifi.  It's worth considering whether something similar to
> > > > commit 36148c2bbfbe ("mac80211: Adjust TSQ pacing shift") might be
> > > > benefitial.
> > > 
> > > I've played a similar patch several days before. The tricky part is the mode
> > > switching between napi and no napi. We should make sure when the packet is
> > > sent and trakced by BQL,  it should be consumed by BQL as well.
> > 
> > I just went over the patch again and I don't understand this comment.
> > This patch only enabled BQL with tx napi.
> > 
> > Thus there's no mode switching.
> > 
> > What did I miss?
> 
> 
> Consider the case:
> 
> 
> TX NAPI is disabled:
> 
> send N packets
> 
> turn TX NAPI on:
> 
> get tx interrupt
> 
> BQL try to consume those packets when lead WARN for dql.
> 
> 
> Thanks

Can one really switch tx napi on and off? How?
While root can change the napi_tx module parameter, I don't think
that has any effect outside device probe time. What did I miss?



> 
> 
> > 
> > 
> > > I did it by
> > > tracking it through skb->cb.  And deal with the freeze by reset the BQL
> > > status. Patch attached.
> > > 
> > > But when testing with vhost-net, I don't very a stable performance, it was
> > > probably because we batch the used ring updating so tx interrupt may come
> > > randomly. We probably need to implement time bounded coalescing mechanism
> > > which could be configured from userspace.
> > > 
> > > Btw, maybe it's time just enable napi TX by default. I get ~10% TCP_RR
> > > regression on machine without APICv, (haven't found time to test APICv
> > > machine). But consider it was for correctness, I think it's acceptable? Then
> > > we can do optimization on top?
> > > 
> > > 
> > > Thanks
> > > 
> > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >    drivers/net/virtio_net.c | 27 +++++++++++++++++++--------
> > > >    1 file changed, 19 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index cecfd77c9f3c..b657bde6b94b 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -1325,7 +1325,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > > >    	return stats.packets;
> > > >    }
> > > > -static void free_old_xmit_skbs(struct send_queue *sq)
> > > > +static void free_old_xmit_skbs(struct send_queue *sq, struct netdev_queue *txq,
> > > > +			       bool use_napi)
> > > >    {
> > > >    	struct sk_buff *skb;
> > > >    	unsigned int len;
> > > > @@ -1347,6 +1348,9 @@ static void free_old_xmit_skbs(struct send_queue *sq)
> > > >    	if (!packets)
> > > >    		return;
> > > > +	if (use_napi)
> > > > +		netdev_tx_completed_queue(txq, packets, bytes);
> > > > +
> > > >    	u64_stats_update_begin(&sq->stats.syncp);
> > > >    	sq->stats.bytes += bytes;
> > > >    	sq->stats.packets += packets;
> > > > @@ -1364,7 +1368,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
> > > >    		return;
> > > >    	if (__netif_tx_trylock(txq)) {
> > > > -		free_old_xmit_skbs(sq);
> > > > +		free_old_xmit_skbs(sq, txq, true);
> > > >    		__netif_tx_unlock(txq);
> > > >    	}
> > > > @@ -1440,7 +1444,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> > > >    	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, vq2txq(sq->vq));
> > > >    	__netif_tx_lock(txq, raw_smp_processor_id());
> > > > -	free_old_xmit_skbs(sq);
> > > > +	free_old_xmit_skbs(sq, txq, true);
> > > >    	__netif_tx_unlock(txq);
> > > >    	virtqueue_napi_complete(napi, sq->vq, 0);
> > > > @@ -1505,13 +1509,15 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >    	struct send_queue *sq = &vi->sq[qnum];
> > > >    	int err;
> > > >    	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> > > > -	bool kick = !skb->xmit_more;
> > > > +	bool more = skb->xmit_more;
> > > >    	bool use_napi = sq->napi.weight;
> > > > +	unsigned int bytes = skb->len;
> > > > +	bool kick;
> > > >    	/* Free up any pending old buffers before queueing new ones. */
> > > > -	free_old_xmit_skbs(sq);
> > > > +	free_old_xmit_skbs(sq, txq, use_napi);
> > > > -	if (use_napi && kick)
> > > > +	if (use_napi && !more)
> > > >    		virtqueue_enable_cb_delayed(sq->vq);
> > > >    	/* timestamp packet in software */
> > > > @@ -1552,7 +1558,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >    		if (!use_napi &&
> > > >    		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > > >    			/* More just got used, free them then recheck. */
> > > > -			free_old_xmit_skbs(sq);
> > > > +			free_old_xmit_skbs(sq, txq, false);
> > > >    			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > > >    				netif_start_subqueue(dev, qnum);
> > > >    				virtqueue_disable_cb(sq->vq);
> > > > @@ -1560,7 +1566,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >    		}
> > > >    	}
> > > > -	if (kick || netif_xmit_stopped(txq)) {
> > > > +	if (use_napi)
> > > > +		kick = __netdev_tx_sent_queue(txq, bytes, more);
> > > > +	else
> > > > +		kick = !more || netif_xmit_stopped(txq);
> > > > +
> > > > +	if (kick) {
> > > >    		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> > > >    			u64_stats_update_begin(&sq->stats.syncp);
> > > >    			sq->stats.kicks++;
