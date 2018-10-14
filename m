Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8516BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5542089D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5542089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeJNXMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36439 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728279AbeJNXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:08 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cA-8n; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000RG-6a; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "DaeRyong Jeong" <threeearcat@gmail.com>,
        "Byoungyoung Lee" <byoungyoung@purdue.edu>,
        "Willem de Bruijn" <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.635708873@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 211/366] packet: fix bitfield update race
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit a6361f0ca4b25460f2cdf3235ebe8115f622901e upstream.

Updates to the bitfields in struct packet_sock are not atomic.
Serialize these read-modify-write cycles.

Move po->running into a separate variable. Its writes are protected by
po->bind_lock (except for one startup case at packet_create). Also
replace a textual precondition warning with lockdep annotation.

All others are set only in packet_setsockopt. Serialize these
updates by holding the socket lock. Analogous to other field updates,
also hold the lock when testing whether a ring is active (pg_vec).

Fixes: 8dc419447415 ("[PACKET]: Add optional checksum computation for recvmsg")
Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Reported-by: Byoungyoung Lee <byoungyoung@purdue.edu>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/packet/af_packet.c | 60 +++++++++++++++++++++++++++++++-----------
 net/packet/internal.h  | 10 +++----
 2 files changed, 49 insertions(+), 21 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -343,11 +343,11 @@ static void packet_pick_tx_queue(struct
 	skb_set_queue_mapping(skb, queue_index);
 }
 
-/* register_prot_hook must be invoked with the po->bind_lock held,
+/* __register_prot_hook must be invoked through register_prot_hook
  * or from a context in which asynchronous accesses to the packet
  * socket is not possible (packet_create()).
  */
-static void register_prot_hook(struct sock *sk)
+static void __register_prot_hook(struct sock *sk)
 {
 	struct packet_sock *po = pkt_sk(sk);
 
@@ -362,8 +362,13 @@ static void register_prot_hook(struct so
 	}
 }
 
-/* {,__}unregister_prot_hook() must be invoked with the po->bind_lock
- * held.   If the sync parameter is true, we will temporarily drop
+static void register_prot_hook(struct sock *sk)
+{
+	lockdep_assert_held_once(&pkt_sk(sk)->bind_lock);
+	__register_prot_hook(sk);
+}
+
+/* If the sync parameter is true, we will temporarily drop
  * the po->bind_lock and do a synchronize_net to make sure no
  * asynchronous packet processing paths still refer to the elements
  * of po->prot_hook.  If the sync parameter is false, it is the
@@ -373,6 +378,8 @@ static void __unregister_prot_hook(struc
 {
 	struct packet_sock *po = pkt_sk(sk);
 
+	lockdep_assert_held_once(&po->bind_lock);
+
 	po->running = 0;
 
 	if (po->fanout)
@@ -2887,7 +2894,7 @@ static int packet_create(struct net *net
 
 	if (proto) {
 		po->prot_hook.type = proto;
-		register_prot_hook(sk);
+		__register_prot_hook(sk);
 	}
 
 	mutex_lock(&net->packet.sklist_lock);
@@ -3386,12 +3393,18 @@ packet_setsockopt(struct socket *sock, i
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
-		po->tp_loss = !!val;
-		return 0;
+
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret = -EBUSY;
+		} else {
+			po->tp_loss = !!val;
+			ret = 0;
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_AUXDATA:
 	{
@@ -3402,7 +3415,9 @@ packet_setsockopt(struct socket *sock, i
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
+		lock_sock(sk);
 		po->auxdata = !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3414,7 +3429,9 @@ packet_setsockopt(struct socket *sock, i
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
+		lock_sock(sk);
 		po->origdev = !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3423,15 +3440,20 @@ packet_setsockopt(struct socket *sock, i
 
 		if (sock->type != SOCK_RAW)
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (optlen < sizeof(val))
 			return -EINVAL;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		po->has_vnet_hdr = !!val;
-		return 0;
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret = -EBUSY;
+		} else {
+			po->has_vnet_hdr = !!val;
+			ret = 0;
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_TIMESTAMP:
 	{
@@ -3462,11 +3484,17 @@ packet_setsockopt(struct socket *sock, i
 
 		if (optlen != sizeof(val))
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
-		po->tp_tx_has_off = !!val;
+
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret = -EBUSY;
+		} else {
+			po->tp_tx_has_off = !!val;
+			ret = 0;
+		}
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_QDISC_BYPASS:
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -100,10 +100,12 @@ struct packet_sock {
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
-	unsigned int		running:1,	/* prot_hook is attached*/
-				auxdata:1,
+	unsigned int		running;	/* bind_lock must be held */
+	unsigned int		auxdata:1,	/* writer must hold sock lock */
 				origdev:1,
-				has_vnet_hdr:1;
+				has_vnet_hdr:1,
+				tp_loss:1,
+				tp_tx_has_off:1;
 	int			ifindex;	/* bound device		*/
 	__be16			num;
 	struct packet_mclist	*mclist;
@@ -111,8 +113,6 @@ struct packet_sock {
 	enum tpacket_versions	tp_version;
 	unsigned int		tp_hdrlen;
 	unsigned int		tp_reserve;
-	unsigned int		tp_loss:1;
-	unsigned int		tp_tx_has_off:1;
 	unsigned int		tp_tstamp;
 	struct net_device __rcu	*cached_dev;
 	int			(*xmit)(struct sk_buff *skb);

