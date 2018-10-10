Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B89A21526
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep0MrhwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B89A21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeJKGhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeJKGhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:31 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E6F2151C;
        Wed, 10 Oct 2018 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213188;
        bh=4hd9FBCSWy+rWeBBhdiWR0YvuhRHQ6FTVUB2qhblzLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ep0MrhwZuEexU51E4nBvN+MOTFq/HCCiAs4ZrYngk5DzTNqnEBwQYNwlkKDROO2ao
         32h/XVFj4++O6R13pd3TyRjaG6L4U0gvg44aPkpJ5Ovx6nW/vZqRUSeW6auTVXW2sV
         JOjUJx7hlL8ZY2Pnp9FVJ0LcyFVfat5c+DlunjKw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 12/30] rcu: Prepare rcu_read_[un]lock_bh() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:11:59 +0200
Message-Id: <1539213137-13953-13-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of local_bh_disable() that
is going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		bh2 = rcu_read_lock_bh() {
			bh2 = local_bh_disable(...)
            return bh2;
		}
		...
		rcu_read_unlock_bh(bh2) {
			local_bh_enable(bh2);
		}
	local_bh_enable(bh);

To prepare for that, make rcu_read_lock_bh() able to return a saved vector
enabled mask and pass it back to rcu_read_unlock_bh(). We'll plug it
to local_bh_disable() in a subsequent patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 crypto/pcrypt.c                           |  5 ++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c |  5 ++--
 drivers/net/hyperv/rndis_filter.c         |  5 ++--
 drivers/net/macsec.c                      | 12 +++++----
 drivers/net/vrf.c                         | 19 ++++++++------
 drivers/vhost/net.c                       |  5 ++--
 include/linux/rcupdate.h                  |  5 ++--
 include/net/arp.h                         | 10 ++++---
 include/net/ip6_fib.h                     |  1 +
 include/net/ndisc.h                       | 10 ++++---
 include/net/neighbour.h                   |  1 +
 kernel/padata.c                           |  5 ++--
 kernel/rcu/rcuperf.c                      |  2 +-
 kernel/rcu/rcutorture.c                   |  2 +-
 net/caif/caif_dev.c                       |  5 ++--
 net/core/dev.c                            |  7 ++---
 net/core/neighbour.c                      | 37 +++++++++++++++-----------
 net/core/pktgen.c                         |  5 ++--
 net/decnet/dn_route.c                     | 27 +++++++++++--------
 net/ipv4/fib_semantics.c                  |  5 ++--
 net/ipv4/ip_output.c                      |  7 ++---
 net/ipv4/netfilter/ipt_CLUSTERIP.c        |  5 ++--
 net/ipv6/addrconf.c                       | 21 ++++++++-------
 net/ipv6/ip6_fib.c                        |  4 +--
 net/ipv6/ip6_flowlabel.c                  | 43 ++++++++++++++++++-------------
 net/ipv6/ip6_output.c                     | 12 +++++----
 net/ipv6/route.c                          | 15 ++++++-----
 net/ipv6/xfrm6_tunnel.c                   |  5 ++--
 net/l2tp/l2tp_core.c                      | 33 ++++++++++++++----------
 net/llc/llc_core.c                        |  5 ++--
 net/llc/llc_proc.c                        | 13 +++++++---
 net/llc/llc_sap.c                         |  5 ++--
 net/netfilter/ipset/ip_set_core.c         | 10 ++++---
 net/netfilter/ipset/ip_set_hash_gen.h     | 15 ++++++-----
 net/netfilter/nfnetlink_log.c             | 17 ++++++++----
 35 files changed, 229 insertions(+), 154 deletions(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index f8ec3d4..490358c 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -73,12 +73,13 @@ struct pcrypt_aead_ctx {
 static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
 			      struct padata_pcrypt *pcrypt)
 {
+	unsigned int bh;
 	unsigned int cpu_index, cpu, i;
 	struct pcrypt_cpumask *cpumask;
 
 	cpu = *cb_cpu;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	cpumask = rcu_dereference_bh(pcrypt->cb_cpumask);
 	if (cpumask_test_cpu(cpu, cpumask->mask))
 			goto out;
@@ -95,7 +96,7 @@ static int pcrypt_do_parallel(struct padata_priv *padata, unsigned int *cb_cpu,
 	*cb_cpu = cpu;
 
 out:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return padata_do_parallel(pcrypt->pinst, padata, cpu);
 }
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index eaefa43..709a3e1 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1260,13 +1260,14 @@ static u32 ipoib_addr_hash(struct ipoib_neigh_hash *htbl, u8 *daddr)
 
 struct ipoib_neigh *ipoib_neigh_get(struct net_device *dev, u8 *daddr)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct ipoib_neigh_table *ntbl = &priv->ntbl;
 	struct ipoib_neigh_hash *htbl;
 	struct ipoib_neigh *neigh = NULL;
 	u32 hash_val;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	htbl = rcu_dereference_bh(ntbl->htbl);
 
@@ -1292,7 +1293,7 @@ struct ipoib_neigh *ipoib_neigh_get(struct net_device *dev, u8 *daddr)
 	}
 
 out_unlock:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return neigh;
 }
 
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 2a5209f..8c95eac 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -214,6 +214,7 @@ static void dump_rndis_message(struct net_device *netdev,
 static int rndis_filter_send_request(struct rndis_device *dev,
 				  struct rndis_request *req)
 {
+	unsigned int bh;
 	struct hv_netvsc_packet *packet;
 	struct hv_page_buffer page_buf[2];
 	struct hv_page_buffer *pb = page_buf;
@@ -245,9 +246,9 @@ static int rndis_filter_send_request(struct rndis_device *dev,
 
 	trace_rndis_send(dev->ndev, 0, &req->request_msg);
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	ret = netvsc_send(dev->ndev, packet, NULL, pb, NULL);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return ret;
 }
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7de88b3..eb7b6b7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -597,6 +597,7 @@ static void count_tx(struct net_device *dev, int ret, int len)
 
 static void macsec_encrypt_done(struct crypto_async_request *base, int err)
 {
+	unsigned int bh;
 	struct sk_buff *skb = base->data;
 	struct net_device *dev = skb->dev;
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -605,13 +606,13 @@ static void macsec_encrypt_done(struct crypto_async_request *base, int err)
 
 	aead_request_free(macsec_skb_cb(skb)->req);
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	macsec_encrypt_finish(skb, dev);
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
 	len = skb->len;
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	macsec_txsa_put(sa);
 	dev_put(dev);
@@ -886,6 +887,7 @@ static void count_rx(struct net_device *dev, int len)
 
 static void macsec_decrypt_done(struct crypto_async_request *base, int err)
 {
+	unsigned int bh;
 	struct sk_buff *skb = base->data;
 	struct net_device *dev = skb->dev;
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -899,10 +901,10 @@ static void macsec_decrypt_done(struct crypto_async_request *base, int err)
 	if (!err)
 		macsec_skb_cb(skb)->valid = true;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	pn = ntohl(macsec_ethhdr(skb)->packet_number);
 	if (!macsec_post_decrypt(skb, &macsec->secy, pn)) {
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 		kfree_skb(skb);
 		goto out;
 	}
@@ -915,7 +917,7 @@ static void macsec_decrypt_done(struct crypto_async_request *base, int err)
 	if (gro_cells_receive(&macsec->gro_cells, skb) == NET_RX_SUCCESS)
 		count_rx(dev, len);
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 out:
 	macsec_rxsa_put(rx_sa);
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index f93547f..4f7c6cb 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -327,6 +327,7 @@ static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 static int vrf_finish_direct(struct net *net, struct sock *sk,
 			     struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct net_device *vrf_dev = skb->dev;
 
 	if (!list_empty(&vrf_dev->ptype_all) &&
@@ -337,9 +338,9 @@ static int vrf_finish_direct(struct net *net, struct sock *sk,
 		eth_zero_addr(eth->h_dest);
 		eth->h_proto = skb->protocol;
 
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 		dev_queue_xmit_nit(skb, vrf_dev);
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 
 		skb_pull(skb, ETH_HLEN);
 	}
@@ -352,6 +353,7 @@ static int vrf_finish_direct(struct net *net, struct sock *sk,
 static int vrf_finish_output6(struct net *net, struct sock *sk,
 			      struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *dev = dst->dev;
 	struct neighbour *neigh;
@@ -363,7 +365,7 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	nexthop = rt6_nexthop((struct rt6_info *)dst, &ipv6_hdr(skb)->daddr);
 	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
 	if (unlikely(!neigh))
@@ -371,10 +373,10 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb);
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 		return ret;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	IP6_INC_STATS(dev_net(dst->dev),
 		      ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
@@ -544,6 +546,7 @@ static int vrf_rt6_create(struct net_device *dev)
 /* modelled after ip_finish_output2 */
 static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct dst_entry *dst = skb_dst(skb);
 	struct rtable *rt = (struct rtable *)dst;
 	struct net_device *dev = dst->dev;
@@ -570,7 +573,7 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 		skb = skb2;
 	}
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	nexthop = (__force u32)rt_nexthop(rt, ip_hdr(skb)->daddr);
 	neigh = __ipv4_neigh_lookup_noref(dev, nexthop);
@@ -579,11 +582,11 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb);
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 		return ret;
 	}
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 err:
 	vrf_tx_error(skb->dev, skb);
 	return ret;
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4e656f8..a467932 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -371,11 +371,12 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 
 static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 {
+	unsigned int bh;
 	struct vhost_net_ubuf_ref *ubufs = ubuf->ctx;
 	struct vhost_virtqueue *vq = ubufs->vq;
 	int cnt;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	/* set len to mark this desc buffers done DMA */
 	vq->heads[ubuf->desc].len = success ?
@@ -392,7 +393,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 	if (cnt <= 1 || !(cnt % 16))
 		vhost_poll_queue(&vq->poll);
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 
 static inline unsigned long busy_clock(void)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 75e5b39..60fbd15 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -700,13 +700,14 @@ static inline void rcu_read_unlock(void)
  * rcu_read_unlock_bh() from one task if the matching rcu_read_lock_bh()
  * was invoked from some other task.
  */
-static inline void rcu_read_lock_bh(void)
+static inline unsigned int rcu_read_lock_bh(void)
 {
 	local_bh_disable();
 	__acquire(RCU_BH);
 	rcu_lock_acquire(&rcu_bh_lock_map);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_lock_bh() used illegally while idle");
+	return 0;
 }
 
 /*
@@ -714,7 +715,7 @@ static inline void rcu_read_lock_bh(void)
  *
  * See rcu_read_lock_bh() for more information.
  */
-static inline void rcu_read_unlock_bh(void)
+static inline void rcu_read_unlock_bh(unsigned int bh)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_unlock_bh() used illegally while idle");
diff --git a/include/net/arp.h b/include/net/arp.h
index 977aabf..576a874 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -28,22 +28,24 @@ static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_device *dev
 
 static inline struct neighbour *__ipv4_neigh_lookup(struct net_device *dev, u32 key)
 {
+	unsigned int bh;
 	struct neighbour *n;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	n = __ipv4_neigh_lookup_noref(dev, key);
 	if (n && !refcount_inc_not_zero(&n->refcnt))
 		n = NULL;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return n;
 }
 
 static inline void __ipv4_confirm_neigh(struct net_device *dev, u32 key)
 {
+	unsigned int bh;
 	struct neighbour *n;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	n = __ipv4_neigh_lookup_noref(dev, key);
 	if (n) {
 		unsigned long now = jiffies;
@@ -52,7 +54,7 @@ static inline void __ipv4_confirm_neigh(struct net_device *dev, u32 key)
 		if (n->confirmed != now)
 			n->confirmed = now;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 
 void arp_init(void);
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 3d49305..d12fec0 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -439,6 +439,7 @@ struct ipv6_route_iter {
 	loff_t skip;
 	struct fib6_table *tbl;
 	int sernum;
+	unsigned int bh;
 };
 
 extern const struct seq_operations ipv6_route_seq_ops;
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index ddfbb59..d43423d 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -381,13 +381,14 @@ static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev
 
 static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, const void *pkey)
 {
+	unsigned int bh;
 	struct neighbour *n;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	n = __ipv6_neigh_lookup_noref(dev, pkey);
 	if (n && !refcount_inc_not_zero(&n->refcnt))
 		n = NULL;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return n;
 }
@@ -395,9 +396,10 @@ static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, cons
 static inline void __ipv6_confirm_neigh(struct net_device *dev,
 					const void *pkey)
 {
+	unsigned int bh;
 	struct neighbour *n;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	n = __ipv6_neigh_lookup_noref(dev, pkey);
 	if (n) {
 		unsigned long now = jiffies;
@@ -406,7 +408,7 @@ static inline void __ipv6_confirm_neigh(struct net_device *dev,
 		if (n->confirmed != now)
 			n->confirmed = now;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 
 int ndisc_init(void);
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 6c1eecd..b804121 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -374,6 +374,7 @@ struct neigh_seq_state {
 				struct neighbour *n, loff_t *pos);
 	unsigned int bucket;
 	unsigned int flags;
+	unsigned int bh;
 #define NEIGH_SEQ_NEIGH_ONLY	0x00000001
 #define NEIGH_SEQ_IS_PNEIGH	0x00000002
 #define NEIGH_SEQ_SKIP_NOARP	0x00000004
diff --git a/kernel/padata.c b/kernel/padata.c
index d568cc5..8a2fbd4 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -104,11 +104,12 @@ static void padata_parallel_worker(struct work_struct *parallel_work)
 int padata_do_parallel(struct padata_instance *pinst,
 		       struct padata_priv *padata, int cb_cpu)
 {
+	unsigned int bh;
 	int target_cpu, err;
 	struct padata_parallel_queue *queue;
 	struct parallel_data *pd;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	pd = rcu_dereference_bh(pinst->pd);
 
@@ -142,7 +143,7 @@ int padata_do_parallel(struct padata_instance *pinst,
 	queue_work_on(target_cpu, pinst->wq, &queue->work);
 
 out:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return err;
 }
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 3424452..fa25db2 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -201,7 +201,7 @@ static int rcu_bh_perf_read_lock(void) __acquires(RCU_BH)
 
 static void rcu_bh_perf_read_unlock(int idx) __releases(RCU_BH)
 {
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(0);
 }
 
 static struct rcu_perf_ops rcu_bh_ops = {
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c596c6f..cb3abdc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -446,7 +446,7 @@ static int rcu_bh_torture_read_lock(void) __acquires(RCU_BH)
 
 static void rcu_bh_torture_read_unlock(int idx) __releases(RCU_BH)
 {
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(0);
 }
 
 static void rcu_bh_torture_deferred_free(struct rcu_torture *p)
diff --git a/net/caif/caif_dev.c b/net/caif/caif_dev.c
index 711d715..264f715 100644
--- a/net/caif/caif_dev.c
+++ b/net/caif/caif_dev.c
@@ -165,13 +165,14 @@ static void caif_flow_cb(struct sk_buff *skb)
 
 static int transmit(struct cflayer *layer, struct cfpkt *pkt)
 {
+	unsigned int bh;
 	int err, high = 0, qlen = 0;
 	struct caif_device_entry *caifd =
 	    container_of(layer, struct caif_device_entry, layer);
 	struct sk_buff *skb;
 	struct netdev_queue *txq;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	skb = cfpkt_tonative(pkt);
 	skb->dev = caifd->netdev;
@@ -225,7 +226,7 @@ static int transmit(struct cflayer *layer, struct cfpkt *pkt)
 					_CAIF_CTRLCMD_PHYIF_FLOW_OFF_IND,
 					caifd->layer.id);
 noxoff:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	err = dev_queue_xmit(skb);
 	if (err > 0)
diff --git a/net/core/dev.c b/net/core/dev.c
index 82114e1..2898fb8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3725,6 +3725,7 @@ struct netdev_queue *netdev_pick_tx(struct net_device *dev,
  */
 static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 {
+	unsigned int bh;
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq;
 	struct Qdisc *q;
@@ -3739,7 +3740,7 @@ static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	/* Disable soft irqs for various locks below. Also
 	 * stops preemption for RCU.
 	 */
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	skb_update_prio(skb);
 
@@ -3820,13 +3821,13 @@ static int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	}
 
 	rc = -ENETDOWN;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	atomic_long_inc(&dev->tx_dropped);
 	kfree_skb_list(skb);
 	return rc;
 out:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return rc;
 }
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 91592fc..98cc21c 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -438,11 +438,12 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 			       struct net_device *dev)
 {
+	unsigned int bh;
 	struct neighbour *n;
 
 	NEIGH_CACHE_STAT_INC(tbl, lookups);
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	n = __neigh_lookup_noref(tbl, pkey, dev);
 	if (n) {
 		if (!refcount_inc_not_zero(&n->refcnt))
@@ -450,7 +451,7 @@ struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 		NEIGH_CACHE_STAT_INC(tbl, hits);
 	}
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return n;
 }
 EXPORT_SYMBOL(neigh_lookup);
@@ -458,6 +459,7 @@ EXPORT_SYMBOL(neigh_lookup);
 struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
 				     const void *pkey)
 {
+	unsigned int bh;
 	struct neighbour *n;
 	unsigned int key_len = tbl->key_len;
 	u32 hash_val;
@@ -465,7 +467,7 @@ struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
 
 	NEIGH_CACHE_STAT_INC(tbl, lookups);
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	nht = rcu_dereference_bh(tbl->nht);
 	hash_val = tbl->hash(pkey, NULL, nht->hash_rnd) >> (32 - nht->hash_shift);
 
@@ -481,7 +483,7 @@ struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
 		}
 	}
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return n;
 }
 EXPORT_SYMBOL(neigh_lookup_nodev);
@@ -1856,6 +1858,7 @@ static int neightbl_fill_parms(struct sk_buff *skb, struct neigh_parms *parms)
 static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			      u32 pid, u32 seq, int type, int flags)
 {
+	unsigned int bh;
 	struct nlmsghdr *nlh;
 	struct ndtmsg *ndtmsg;
 
@@ -1890,11 +1893,11 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			.ndtc_proxy_qlen	= tbl->proxy_queue.qlen,
 		};
 
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 		nht = rcu_dereference_bh(tbl->nht);
 		ndc.ndtc_hash_rnd = nht->hash_rnd[0];
 		ndc.ndtc_hash_mask = ((1 << nht->hash_shift) - 1);
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 
 		if (nla_put(skb, NDTA_CONFIG, sizeof(ndc), &ndc))
 			goto nla_put_failure;
@@ -2330,6 +2333,7 @@ static bool neigh_ifindex_filtered(struct net_device *dev, int filter_idx)
 static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			    struct netlink_callback *cb)
 {
+	unsigned int bh;
 	struct net *net = sock_net(skb->sk);
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct nlattr *tb[NDA_MAX + 1];
@@ -2357,7 +2361,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 			flags |= NLM_F_DUMP_FILTERED;
 	}
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	nht = rcu_dereference_bh(tbl->nht);
 
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
@@ -2384,7 +2388,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	}
 	rc = skb->len;
 out:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	cb->args[1] = h;
 	cb->args[2] = idx;
 	return rc;
@@ -2470,10 +2474,11 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 
 void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void *), void *cookie)
 {
+	unsigned int bh;
 	int chain;
 	struct neigh_hash_table *nht;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	nht = rcu_dereference_bh(tbl->nht);
 
 	read_lock(&tbl->lock); /* avoid resizes */
@@ -2486,7 +2491,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 			cb(n, cookie);
 	}
 	read_unlock(&tbl->lock);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 EXPORT_SYMBOL(neigh_for_each);
 
@@ -2528,6 +2533,7 @@ EXPORT_SYMBOL(__neigh_for_each_release);
 int neigh_xmit(int index, struct net_device *dev,
 	       const void *addr, struct sk_buff *skb)
 {
+	unsigned int bh;
 	int err = -EAFNOSUPPORT;
 	if (likely(index < NEIGH_NR_TABLES)) {
 		struct neigh_table *tbl;
@@ -2536,17 +2542,17 @@ int neigh_xmit(int index, struct net_device *dev,
 		tbl = neigh_tables[index];
 		if (!tbl)
 			goto out;
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 		neigh = __neigh_lookup_noref(tbl, addr, dev);
 		if (!neigh)
 			neigh = __neigh_create(tbl, addr, dev, false);
 		err = PTR_ERR(neigh);
 		if (IS_ERR(neigh)) {
-			rcu_read_unlock_bh();
+			rcu_read_unlock_bh(bh);
 			goto out_kfree_skb;
 		}
 		err = neigh->output(neigh, skb);
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 	}
 	else if (index == NEIGH_LINK_TABLE) {
 		err = dev_hard_header(skb, dev, ntohs(skb->protocol),
@@ -2753,7 +2759,7 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 	state->bucket = 0;
 	state->flags = (neigh_seq_flags & ~NEIGH_SEQ_IS_PNEIGH);
 
-	rcu_read_lock_bh();
+	state->bh = rcu_read_lock_bh();
 	state->nht = rcu_dereference_bh(tbl->nht);
 
 	return *pos ? neigh_get_idx_any(seq, pos) : SEQ_START_TOKEN;
@@ -2790,7 +2796,8 @@ EXPORT_SYMBOL(neigh_seq_next);
 void neigh_seq_stop(struct seq_file *seq, void *v)
 	__releases(rcu_bh)
 {
-	rcu_read_unlock_bh();
+	struct neigh_seq_state *state = seq->private;
+	rcu_read_unlock_bh(state->bh);
 }
 EXPORT_SYMBOL(neigh_seq_stop);
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7f69384..6e2bea0 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2502,6 +2502,7 @@ static u32 pktgen_dst_metrics[RTAX_MAX + 1] = {
 
 static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 {
+	unsigned int bh;
 	struct xfrm_state *x = pkt_dev->flows[pkt_dev->curfl].x;
 	int err = 0;
 	struct net *net = dev_net(pkt_dev->odev);
@@ -2519,9 +2520,9 @@ static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 	if ((x->props.mode == XFRM_MODE_TUNNEL) && (pkt_dev->spi != 0))
 		skb->_skb_refdst = (unsigned long)&pkt_dev->xdst.u.dst | SKB_DST_NOREF;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	err = x->outer_mode->output(x, skb);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	if (err) {
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTSTATEMODEERROR);
 		goto error;
diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
index 1c002c0..e1180f9 100644
--- a/net/decnet/dn_route.c
+++ b/net/decnet/dn_route.c
@@ -1247,11 +1247,12 @@ static int dn_route_output_slow(struct dst_entry **pprt, const struct flowidn *o
  */
 static int __dn_route_output_key(struct dst_entry **pprt, const struct flowidn *flp, int flags)
 {
+	unsigned int bh;
 	unsigned int hash = dn_hash(flp->saddr, flp->daddr);
 	struct dn_route *rt = NULL;
 
 	if (!(flags & MSG_TRYHARD)) {
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 		for (rt = rcu_dereference_bh(dn_rt_hash_table[hash].chain); rt;
 			rt = rcu_dereference_bh(rt->dn_next)) {
 			if ((flp->daddr == rt->fld.daddr) &&
@@ -1260,12 +1261,12 @@ static int __dn_route_output_key(struct dst_entry **pprt, const struct flowidn *
 			    dn_is_output_route(rt) &&
 			    (rt->fld.flowidn_oif == flp->flowidn_oif)) {
 				dst_hold_and_use(&rt->dst, jiffies);
-				rcu_read_unlock_bh();
+				rcu_read_unlock_bh(bh);
 				*pprt = &rt->dst;
 				return 0;
 			}
 		}
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 	}
 
 	return dn_route_output_slow(pprt, flp, flags);
@@ -1725,6 +1726,7 @@ static int dn_cache_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
  */
 int dn_cache_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	unsigned int bh;
 	struct net *net = sock_net(skb->sk);
 	struct dn_route *rt;
 	int h, s_h;
@@ -1748,7 +1750,7 @@ int dn_cache_dump(struct sk_buff *skb, struct netlink_callback *cb)
 			continue;
 		if (h > s_h)
 			s_idx = 0;
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 		for(rt = rcu_dereference_bh(dn_rt_hash_table[h].chain), idx = 0;
 			rt;
 			rt = rcu_dereference_bh(rt->dn_next), idx++) {
@@ -1759,12 +1761,12 @@ int dn_cache_dump(struct sk_buff *skb, struct netlink_callback *cb)
 					cb->nlh->nlmsg_seq, RTM_NEWROUTE,
 					1, NLM_F_MULTI) < 0) {
 				skb_dst_drop(skb);
-				rcu_read_unlock_bh();
+				rcu_read_unlock_bh(bh);
 				goto done;
 			}
 			skb_dst_drop(skb);
 		}
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 	}
 
 done:
@@ -1775,6 +1777,7 @@ int dn_cache_dump(struct sk_buff *skb, struct netlink_callback *cb)
 
 #ifdef CONFIG_PROC_FS
 struct dn_rt_cache_iter_state {
+	unsigned int bh;
 	int bucket;
 };
 
@@ -1784,25 +1787,26 @@ static struct dn_route *dn_rt_cache_get_first(struct seq_file *seq)
 	struct dn_rt_cache_iter_state *s = seq->private;
 
 	for(s->bucket = dn_rt_hash_mask; s->bucket >= 0; --s->bucket) {
-		rcu_read_lock_bh();
+		s->bh = rcu_read_lock_bh();
 		rt = rcu_dereference_bh(dn_rt_hash_table[s->bucket].chain);
 		if (rt)
 			break;
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(s->bh);
 	}
 	return rt;
 }
 
 static struct dn_route *dn_rt_cache_get_next(struct seq_file *seq, struct dn_route *rt)
 {
+	unsigned int bh;
 	struct dn_rt_cache_iter_state *s = seq->private;
 
 	rt = rcu_dereference_bh(rt->dn_next);
 	while (!rt) {
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(s->bh);
 		if (--s->bucket < 0)
 			break;
-		rcu_read_lock_bh();
+		s->bh = rcu_read_lock_bh();
 		rt = rcu_dereference_bh(dn_rt_hash_table[s->bucket].chain);
 	}
 	return rt;
@@ -1828,8 +1832,9 @@ static void *dn_rt_cache_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 static void dn_rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
+	struct dn_rt_cache_iter_state *s = seq->private;
 	if (v)
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(s->bh);
 }
 
 static int dn_rt_cache_seq_show(struct seq_file *seq, void *v)
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f3c89cc..e87de42 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1684,19 +1684,20 @@ int fib_sync_up(struct net_device *dev, unsigned int nh_flags)
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 static bool fib_good_nh(const struct fib_nh *nh)
 {
+	unsigned int bh;
 	int state = NUD_REACHABLE;
 
 	if (nh->nh_scope == RT_SCOPE_LINK) {
 		struct neighbour *n;
 
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 
 		n = __ipv4_neigh_lookup_noref(nh->nh_dev,
 					      (__force u32)nh->nh_gw);
 		if (n)
 			state = n->nud_state;
 
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 	}
 
 	return !!(state & NUD_VALID);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 9c4e72e..ffa7747 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -183,6 +183,7 @@ EXPORT_SYMBOL_GPL(ip_build_and_send_pkt);
 
 static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct dst_entry *dst = skb_dst(skb);
 	struct rtable *rt = (struct rtable *)dst;
 	struct net_device *dev = dst->dev;
@@ -217,7 +218,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 			return res;
 	}
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	nexthop = (__force u32) rt_nexthop(rt, ip_hdr(skb)->daddr);
 	neigh = __ipv4_neigh_lookup_noref(dev, nexthop);
 	if (unlikely(!neigh))
@@ -228,10 +229,10 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 		sock_confirm_neigh(skb, neigh);
 		res = neigh_output(neigh, skb);
 
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 		return res;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index 2c8d313..b65449d 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -142,9 +142,10 @@ __clusterip_config_find(struct net *net, __be32 clusterip)
 static inline struct clusterip_config *
 clusterip_config_find_get(struct net *net, __be32 clusterip, int entry)
 {
+	unsigned int bh;
 	struct clusterip_config *c;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	c = __clusterip_config_find(net, clusterip);
 	if (c) {
 #ifdef CONFIG_PROC_FS
@@ -161,7 +162,7 @@ clusterip_config_find_get(struct net *net, __be32 clusterip, int entry)
 			}
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return c;
 }
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d51a8c0..9f1d3d0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -987,6 +987,7 @@ static struct inet6_ifaddr *
 ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	      bool can_block, struct netlink_ext_ack *extack)
 {
+	unsigned int bh;
 	gfp_t gfp_flags = can_block ? GFP_KERNEL : GFP_ATOMIC;
 	int addr_type = ipv6_addr_type(cfg->pfx);
 	struct net *net = dev_net(idev->dev);
@@ -1072,11 +1073,11 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	/* For caller */
 	refcount_set(&ifa->refcnt, 1);
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	err = ipv6_add_addr_hash(idev->dev, ifa);
 	if (err < 0) {
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 		goto out;
 	}
 
@@ -1093,7 +1094,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	in6_ifa_hold(ifa);
 	write_unlock(&idev->lock);
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	inet6addr_notifier_call_chain(NETDEV_UP, ifa);
 out:
@@ -4339,13 +4340,14 @@ int ipv6_chk_home_addr(struct net *net, const struct in6_addr *addr)
 
 static void addrconf_verify_rtnl(void)
 {
+	unsigned int bh;
 	unsigned long now, next, next_sec, next_sched;
 	struct inet6_ifaddr *ifp;
 	int i;
 
 	ASSERT_RTNL();
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	now = jiffies;
 	next = round_jiffies_up(now + ADDR_CHECK_FREQUENCY);
 
@@ -4418,11 +4420,11 @@ static void addrconf_verify_rtnl(void)
 						spin_lock(&ifpub->lock);
 						ifpub->regen_count = 0;
 						spin_unlock(&ifpub->lock);
-						rcu_read_unlock_bh();
+						rcu_read_unlock_bh(bh);
 						ipv6_create_tempaddr(ifpub, ifp, true);
 						in6_ifa_put(ifpub);
 						in6_ifa_put(ifp);
-						rcu_read_lock_bh();
+						bh = rcu_read_lock_bh();
 						goto restart;
 					}
 				} else if (time_before(ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ, next))
@@ -4451,7 +4453,7 @@ static void addrconf_verify_rtnl(void)
 	pr_debug("now = %lu, schedule = %lu, rounded schedule = %lu => %lu\n",
 		 now, next, next_sec, next_sched);
 	mod_delayed_work(addrconf_wq, &addr_chk_work, next_sched - now);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 
 static void addrconf_verify_work(struct work_struct *w)
@@ -5714,10 +5716,11 @@ static void __ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 
 static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 {
-	rcu_read_lock_bh();
+	unsigned int bh;
+	bh = rcu_read_lock_bh();
 	if (likely(ifp->idev->dead == 0))
 		__ipv6_ifa_notify(event, ifp);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 
 #ifdef CONFIG_SYSCTL
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 5516f55..89e4083 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2386,7 +2386,7 @@ static void *ipv6_route_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct ipv6_route_iter *iter = seq->private;
 
-	rcu_read_lock_bh();
+	iter->bh = rcu_read_lock_bh();
 	iter->tbl = ipv6_route_seq_next_table(NULL, net);
 	iter->skip = *pos;
 
@@ -2413,7 +2413,7 @@ static void ipv6_route_seq_stop(struct seq_file *seq, void *v)
 	if (ipv6_route_iter_active(iter))
 		fib6_walker_unlink(net, &iter->w);
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(iter->bh);
 }
 
 const struct seq_operations ipv6_route_seq_ops = {
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index cb54a8a..61cb39c 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -84,13 +84,14 @@ static inline struct ip6_flowlabel *__fl_lookup(struct net *net, __be32 label)
 
 static struct ip6_flowlabel *fl_lookup(struct net *net, __be32 label)
 {
+	unsigned int bh;
 	struct ip6_flowlabel *fl;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	fl = __fl_lookup(net, label);
 	if (fl && !atomic_inc_not_zero(&fl->users))
 		fl = NULL;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return fl;
 }
 
@@ -240,22 +241,23 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 
 struct ip6_flowlabel *fl6_sock_lookup(struct sock *sk, __be32 label)
 {
+	unsigned int bh;
 	struct ipv6_fl_socklist *sfl;
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
 	label &= IPV6_FLOWLABEL_MASK;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	for_each_sk_fl_rcu(np, sfl) {
 		struct ip6_flowlabel *fl = sfl->fl;
 		if (fl->label == label) {
 			fl->lastuse = jiffies;
 			atomic_inc(&fl->users);
-			rcu_read_unlock_bh();
+			rcu_read_unlock_bh(bh);
 			return fl;
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(fl6_sock_lookup);
@@ -441,6 +443,7 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
+	unsigned int bh;
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct ipv6_fl_socklist *sfl;
 	int room = FL_MAX_SIZE - atomic_read(&fl_size);
@@ -449,10 +452,10 @@ static int mem_check(struct sock *sk)
 	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
 		return 0;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	for_each_sk_fl_rcu(np, sfl)
 		count++;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	if (room <= 0 ||
 	    ((count >= FL_MAX_PER_SOCK ||
@@ -476,6 +479,7 @@ static inline void fl_link(struct ipv6_pinfo *np, struct ipv6_fl_socklist *sfl,
 int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			   int flags)
 {
+	unsigned int bh;
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct ipv6_fl_socklist *sfl;
 
@@ -489,7 +493,7 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 		return 0;
 	}
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 
 	for_each_sk_fl_rcu(np, sfl) {
 		if (sfl->fl->label == (np->flow_label & IPV6_FLOWLABEL_MASK)) {
@@ -501,17 +505,18 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			freq->flr_linger = sfl->fl->linger / HZ;
 
 			spin_unlock_bh(&ip6_fl_lock);
-			rcu_read_unlock_bh();
+			rcu_read_unlock_bh(bh);
 			return 0;
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return -ENOENT;
 }
 
 int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 {
+	unsigned int bh;
 	int uninitialized_var(err);
 	struct net *net = sock_net(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -558,15 +563,15 @@ int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 		return -ESRCH;
 
 	case IPV6_FL_A_RENEW:
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 		for_each_sk_fl_rcu(np, sfl) {
 			if (sfl->fl->label == freq.flr_label) {
 				err = fl6_renew(sfl->fl, freq.flr_linger, freq.flr_expires);
-				rcu_read_unlock_bh();
+				rcu_read_unlock_bh(bh);
 				return err;
 			}
 		}
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 
 		if (freq.flr_share == IPV6_FL_S_NONE &&
 		    ns_capable(net->user_ns, CAP_NET_ADMIN)) {
@@ -608,11 +613,11 @@ int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 
 		if (freq.flr_label) {
 			err = -EEXIST;
-			rcu_read_lock_bh();
+			bh = rcu_read_lock_bh();
 			for_each_sk_fl_rcu(np, sfl) {
 				if (sfl->fl->label == freq.flr_label) {
 					if (freq.flr_flags&IPV6_FL_F_EXCL) {
-						rcu_read_unlock_bh();
+						rcu_read_unlock_bh(bh);
 						goto done;
 					}
 					fl1 = sfl->fl;
@@ -620,7 +625,7 @@ int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 					break;
 				}
 			}
-			rcu_read_unlock_bh();
+			rcu_read_unlock_bh(bh);
 
 			if (!fl1)
 				fl1 = fl_lookup(net, freq.flr_label);
@@ -695,6 +700,7 @@ int ipv6_flowlabel_opt(struct sock *sk, char __user *optval, int optlen)
 struct ip6fl_iter_state {
 	struct seq_net_private p;
 	struct pid_namespace *pid_ns;
+	unsigned int bh;
 	int bucket;
 };
 
@@ -757,7 +763,7 @@ static void *ip6fl_seq_start(struct seq_file *seq, loff_t *pos)
 
 	state->pid_ns = proc_pid_ns(file_inode(seq->file));
 
-	rcu_read_lock_bh();
+	state->bh = rcu_read_lock_bh();
 	return *pos ? ip6fl_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
@@ -776,7 +782,8 @@ static void *ip6fl_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void ip6fl_seq_stop(struct seq_file *seq, void *v)
 	__releases(RCU)
 {
-	rcu_read_unlock_bh();
+	struct ip6fl_iter_state *state = ip6fl_seq_private(seq);
+	rcu_read_unlock_bh(state->bh);
 }
 
 static int ip6fl_seq_show(struct seq_file *seq, void *v)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f9f8f554..93d49a9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -61,6 +61,7 @@
 
 static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *dev = dst->dev;
 	struct neighbour *neigh;
@@ -110,7 +111,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 			return res;
 	}
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	nexthop = rt6_nexthop((struct rt6_info *)dst, &ipv6_hdr(skb)->daddr);
 	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
 	if (unlikely(!neigh))
@@ -118,10 +119,10 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	if (!IS_ERR(neigh)) {
 		sock_confirm_neigh(skb, neigh);
 		ret = neigh_output(neigh, skb);
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 		return ret;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
 	kfree_skb(skb);
@@ -924,6 +925,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 			       struct dst_entry **dst, struct flowi6 *fl6)
 {
+	unsigned int bh;
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	struct neighbour *n;
 	struct rt6_info *rt;
@@ -989,11 +991,11 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 	 * dst entry of the nexthop router
 	 */
 	rt = (struct rt6_info *) *dst;
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	n = __ipv6_neigh_lookup_noref(rt->dst.dev,
 				      rt6_nexthop(rt, &fl6->daddr));
 	err = n && !(n->nud_state & NUD_VALID) ? -EINVAL : 0;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	if (err) {
 		struct inet6_ifaddr *ifp;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 480a79f..ce653f9 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -517,6 +517,7 @@ static void rt6_probe_deferred(struct work_struct *w)
 
 static void rt6_probe(struct fib6_info *rt)
 {
+	unsigned int bh;
 	struct __rt6_probe_work *work;
 	const struct in6_addr *nh_gw;
 	struct neighbour *neigh;
@@ -535,7 +536,7 @@ static void rt6_probe(struct fib6_info *rt)
 
 	nh_gw = &rt->fib6_nh.nh_gw;
 	dev = rt->fib6_nh.nh_dev;
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	neigh = __ipv6_neigh_lookup_noref(dev, nh_gw);
 	if (neigh) {
 		struct inet6_dev *idev;
@@ -567,7 +568,7 @@ static void rt6_probe(struct fib6_info *rt)
 	}
 
 out:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 #else
 static inline void rt6_probe(struct fib6_info *rt)
@@ -589,6 +590,7 @@ static inline int rt6_check_dev(struct fib6_info *rt, int oif)
 
 static inline enum rt6_nud_state rt6_check_neigh(struct fib6_info *rt)
 {
+	unsigned int bh;
 	enum rt6_nud_state ret = RT6_NUD_FAIL_HARD;
 	struct neighbour *neigh;
 
@@ -596,7 +598,7 @@ static inline enum rt6_nud_state rt6_check_neigh(struct fib6_info *rt)
 	    !(rt->fib6_flags & RTF_GATEWAY))
 		return RT6_NUD_SUCCEED;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	neigh = __ipv6_neigh_lookup_noref(rt->fib6_nh.nh_dev,
 					  &rt->fib6_nh.nh_gw);
 	if (neigh) {
@@ -614,7 +616,7 @@ static inline enum rt6_nud_state rt6_check_neigh(struct fib6_info *rt)
 		ret = IS_ENABLED(CONFIG_IPV6_ROUTER_PREF) ?
 		      RT6_NUD_SUCCEED : RT6_NUD_FAIL_DO_RR;
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return ret;
 }
@@ -1788,6 +1790,7 @@ void rt6_age_exceptions(struct fib6_info *rt,
 			struct fib6_gc_args *gc_args,
 			unsigned long now)
 {
+	unsigned int bh;
 	struct rt6_exception_bucket *bucket;
 	struct rt6_exception *rt6_ex;
 	struct hlist_node *tmp;
@@ -1796,7 +1799,7 @@ void rt6_age_exceptions(struct fib6_info *rt,
 	if (!rcu_access_pointer(rt->rt6i_exception_bucket))
 		return;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	spin_lock(&rt6_exception_lock);
 	bucket = rcu_dereference_protected(rt->rt6i_exception_bucket,
 				    lockdep_is_held(&rt6_exception_lock));
@@ -1812,7 +1815,7 @@ void rt6_age_exceptions(struct fib6_info *rt,
 		}
 	}
 	spin_unlock(&rt6_exception_lock);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 }
 
 /* must be called with rcu lock held */
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 4a46df8..1989703 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -101,13 +101,14 @@ static struct xfrm6_tunnel_spi *__xfrm6_tunnel_spi_lookup(struct net *net, const
 
 __be32 xfrm6_tunnel_spi_lookup(struct net *net, const xfrm_address_t *saddr)
 {
+	unsigned int bh;
 	struct xfrm6_tunnel_spi *x6spi;
 	u32 spi;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	x6spi = __xfrm6_tunnel_spi_lookup(net, saddr);
 	spi = x6spi ? x6spi->spi : 0;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return htonl(spi);
 }
 EXPORT_SYMBOL(xfrm6_tunnel_spi_lookup);
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 82cdf90..f8515be 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -165,19 +165,20 @@ EXPORT_SYMBOL(l2tp_tunnel_free);
 /* Lookup a tunnel. A new reference is held on the returned tunnel. */
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id)
 {
+	unsigned int bh;
 	const struct l2tp_net *pn = l2tp_pernet(net);
 	struct l2tp_tunnel *tunnel;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
 		if (tunnel->tunnel_id == tunnel_id) {
 			l2tp_tunnel_inc_refcount(tunnel);
-			rcu_read_unlock_bh();
+			rcu_read_unlock_bh(bh);
 
 			return tunnel;
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return NULL;
 }
@@ -185,19 +186,20 @@ EXPORT_SYMBOL_GPL(l2tp_tunnel_get);
 
 struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
 {
+	unsigned int bh;
 	const struct l2tp_net *pn = l2tp_pernet(net);
 	struct l2tp_tunnel *tunnel;
 	int count = 0;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
 		if (++count > nth) {
 			l2tp_tunnel_inc_refcount(tunnel);
-			rcu_read_unlock_bh();
+			rcu_read_unlock_bh(bh);
 			return tunnel;
 		}
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return NULL;
 }
@@ -227,20 +229,21 @@ EXPORT_SYMBOL_GPL(l2tp_tunnel_get_session);
 
 struct l2tp_session *l2tp_session_get(const struct net *net, u32 session_id)
 {
+	unsigned int bh;
 	struct hlist_head *session_list;
 	struct l2tp_session *session;
 
 	session_list = l2tp_session_id_hash_2(l2tp_pernet(net), session_id);
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	hlist_for_each_entry_rcu(session, session_list, global_hlist)
 		if (session->session_id == session_id) {
 			l2tp_session_inc_refcount(session);
-			rcu_read_unlock_bh();
+			rcu_read_unlock_bh(bh);
 
 			return session;
 		}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return NULL;
 }
@@ -275,23 +278,24 @@ EXPORT_SYMBOL_GPL(l2tp_session_get_nth);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname)
 {
+	unsigned int bh;
 	struct l2tp_net *pn = l2tp_pernet(net);
 	int hash;
 	struct l2tp_session *session;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	for (hash = 0; hash < L2TP_HASH_SIZE_2; hash++) {
 		hlist_for_each_entry_rcu(session, &pn->l2tp_session_hlist[hash], global_hlist) {
 			if (!strcmp(session->ifname, ifname)) {
 				l2tp_session_inc_refcount(session);
-				rcu_read_unlock_bh();
+				rcu_read_unlock_bh(bh);
 
 				return session;
 			}
 		}
 	}
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return NULL;
 }
@@ -1723,15 +1727,16 @@ static __net_init int l2tp_init_net(struct net *net)
 
 static __net_exit void l2tp_exit_net(struct net *net)
 {
+	unsigned int bh;
 	struct l2tp_net *pn = l2tp_pernet(net);
 	struct l2tp_tunnel *tunnel = NULL;
 	int hash;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
 		l2tp_tunnel_delete(tunnel);
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	flush_workqueue(l2tp_wq);
 	rcu_barrier();
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 260b3dc..9270e93 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -69,13 +69,14 @@ static struct llc_sap *__llc_sap_find(unsigned char sap_value)
  */
 struct llc_sap *llc_sap_find(unsigned char sap_value)
 {
+	unsigned int bh;
 	struct llc_sap *sap;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	sap = __llc_sap_find(sap_value);
 	if (!sap || !llc_sap_hold_safe(sap))
 		sap = NULL;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return sap;
 }
 
diff --git a/net/llc/llc_proc.c b/net/llc/llc_proc.c
index f3a36c1..6f068c8 100644
--- a/net/llc/llc_proc.c
+++ b/net/llc/llc_proc.c
@@ -59,8 +59,9 @@ static struct sock *llc_get_sk_idx(loff_t pos)
 static void *llc_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	loff_t l = *pos;
+	unsigned int *bh = seq->private
 
-	rcu_read_lock_bh();
+	*bh = rcu_read_lock_bh();
 	return l ? llc_get_sk_idx(--l) : SEQ_START_TOKEN;
 }
 
@@ -113,6 +114,8 @@ static void *llc_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 
 static void llc_seq_stop(struct seq_file *seq, void *v)
 {
+	unsigned int *bh = seq->private;
+
 	if (v && v != SEQ_START_TOKEN) {
 		struct sock *sk = v;
 		struct llc_sock *llc = llc_sk(sk);
@@ -120,7 +123,7 @@ static void llc_seq_stop(struct seq_file *seq, void *v)
 
 		spin_unlock_bh(&sap->sk_lock);
 	}
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(*bh);
 }
 
 static int llc_seq_socket_show(struct seq_file *seq, void *v)
@@ -225,11 +228,13 @@ int __init llc_proc_init(void)
 	if (!llc_proc_dir)
 		goto out;
 
-	p = proc_create_seq("socket", 0444, llc_proc_dir, &llc_seq_socket_ops);
+	p = proc_create_seq_private("socket", 0444, llc_proc_dir,
+				    &llc_seq_socket_ops, sizeof(unsigned int), NULL);
 	if (!p)
 		goto out_socket;
 
-	p = proc_create_seq("core", 0444, llc_proc_dir, &llc_seq_core_ops);
+	p = proc_create_seq_private("core", 0444, llc_proc_dir,
+				    &llc_seq_core_ops, sizeof(unsigned int), NULL);
 	if (!p)
 		goto out_core;
 
diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index a7f7b8f..d8dfcca 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -319,12 +319,13 @@ static inline bool llc_dgram_match(const struct llc_sap *sap,
 static struct sock *llc_lookup_dgram(struct llc_sap *sap,
 				     const struct llc_addr *laddr)
 {
+	unsigned int bh;
 	struct sock *rc;
 	struct hlist_nulls_node *node;
 	int slot = llc_sk_laddr_hashfn(sap, laddr);
 	struct hlist_nulls_head *laddr_hb = &sap->sk_laddr_hash[slot];
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 again:
 	sk_nulls_for_each_rcu(rc, node, laddr_hb) {
 		if (llc_dgram_match(sap, laddr, rc)) {
@@ -348,7 +349,7 @@ static struct sock *llc_lookup_dgram(struct llc_sap *sap,
 	if (unlikely(get_nulls_value(node) != slot))
 		goto again;
 found:
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	return rc;
 }
 
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index bc4bd247..bc93d4d 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -560,6 +560,7 @@ int
 ip_set_test(ip_set_id_t index, const struct sk_buff *skb,
 	    const struct xt_action_param *par, struct ip_set_adt_opt *opt)
 {
+	unsigned int bh;
 	struct ip_set *set = ip_set_rcu_get(xt_net(par), index);
 	int ret = 0;
 
@@ -570,9 +571,9 @@ ip_set_test(ip_set_id_t index, const struct sk_buff *skb,
 	    !(opt->family == set->family || set->family == NFPROTO_UNSPEC))
 		return 0;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	ret = set->variant->kadt(set, skb, par, IPSET_TEST, opt);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	if (ret == -EAGAIN) {
 		/* Type requests element to be completed */
@@ -1659,6 +1660,7 @@ static int ip_set_utest(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 			const struct nlattr * const attr[],
 			struct netlink_ext_ack *extack)
 {
+	unsigned int bh;
 	struct ip_set_net *inst = ip_set_pernet(net);
 	struct ip_set *set;
 	struct nlattr *tb[IPSET_ATTR_ADT_MAX + 1] = {};
@@ -1678,9 +1680,9 @@ static int ip_set_utest(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 			     set->type->adt_policy, NULL))
 		return -IPSET_ERR_PROTOCOL;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	ret = set->variant->uadt(set, tb, IPSET_TEST, NULL, 0, 0);
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 	/* Userspace can't trigger element to be re-added */
 	if (ret == -EAGAIN)
 		ret = 1;
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 8a33dac..7c31c5e 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -548,6 +548,7 @@ mtype_gc(struct timer_list *t)
 static int
 mtype_resize(struct ip_set *set, bool retried)
 {
+	unsigned int bh;
 	struct htype *h = set->data;
 	struct htable *t, *orig;
 	u8 htable_bits;
@@ -567,10 +568,10 @@ mtype_resize(struct ip_set *set, bool retried)
 	if (!tmp)
 		return -ENOMEM;
 #endif
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	orig = rcu_dereference_bh_nfnl(h->table);
 	htable_bits = orig->htable_bits;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 retry:
 	ret = 0;
@@ -1033,6 +1034,7 @@ mtype_test(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 static int
 mtype_head(struct ip_set *set, struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct htype *h = set->data;
 	const struct htable *t;
 	struct nlattr *nested;
@@ -1051,11 +1053,11 @@ mtype_head(struct ip_set *set, struct sk_buff *skb)
 		spin_unlock_bh(&set->lock);
 	}
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	t = rcu_dereference_bh_nfnl(h->table);
 	memsize = mtype_ahash_memsize(h, t) + set->ext_size;
 	htable_bits = t->htable_bits;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	nested = ipset_nest_start(skb, IPSET_ATTR_DATA);
 	if (!nested)
@@ -1090,15 +1092,16 @@ mtype_head(struct ip_set *set, struct sk_buff *skb)
 static void
 mtype_uref(struct ip_set *set, struct netlink_callback *cb, bool start)
 {
+	unsigned int bh;
 	struct htype *h = set->data;
 	struct htable *t;
 
 	if (start) {
-		rcu_read_lock_bh();
+		bh = rcu_read_lock_bh();
 		t = rcu_dereference_bh_nfnl(h->table);
 		atomic_inc(&t->uref);
 		cb->args[IPSET_CB_PRIVATE] = (unsigned long)t;
-		rcu_read_unlock_bh();
+		rcu_read_unlock_bh(bh);
 	} else if (cb->args[IPSET_CB_PRIVATE]) {
 		t = (struct htable *)cb->args[IPSET_CB_PRIVATE];
 		if (atomic_dec_and_test(&t->uref) && atomic_read(&t->ref)) {
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 332c69d..05f6c44 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -123,13 +123,14 @@ instance_get(struct nfulnl_instance *inst)
 static struct nfulnl_instance *
 instance_lookup_get(struct nfnl_log_net *log, u_int16_t group_num)
 {
+	unsigned int bh;
 	struct nfulnl_instance *inst;
 
-	rcu_read_lock_bh();
+	bh = rcu_read_lock_bh();
 	inst = __instance_lookup(log, group_num);
 	if (inst && !refcount_inc_not_zero(&inst->use))
 		inst = NULL;
-	rcu_read_unlock_bh();
+	rcu_read_unlock_bh(bh);
 
 	return inst;
 }
@@ -955,6 +956,7 @@ static const struct nfnetlink_subsystem nfulnl_subsys = {
 
 #ifdef CONFIG_PROC_FS
 struct iter_state {
+	unsigned int bh;
 	struct seq_net_private p;
 	unsigned int bucket;
 };
@@ -1009,8 +1011,11 @@ static struct hlist_node *get_idx(struct net *net, struct iter_state *st,
 static void *seq_start(struct seq_file *s, loff_t *pos)
 	__acquires(rcu_bh)
 {
-	rcu_read_lock_bh();
-	return get_idx(seq_file_net(s), s->private, *pos);
+	struct iter_state *st = s->private;
+
+	st->bh = rcu_read_lock_bh();
+
+	return get_idx(seq_file_net(s), st, *pos);
 }
 
 static void *seq_next(struct seq_file *s, void *v, loff_t *pos)
@@ -1022,7 +1027,9 @@ static void *seq_next(struct seq_file *s, void *v, loff_t *pos)
 static void seq_stop(struct seq_file *s, void *v)
 	__releases(rcu_bh)
 {
-	rcu_read_unlock_bh();
+	struct iter_state *st = s->private;
+
+	rcu_read_unlock_bh(st->bh);
 }
 
 static int seq_show(struct seq_file *s, void *v)
-- 
2.7.4

