Return-Path: <jrosen@cisco.com>
X-Google-Smtp-Source: AB8JxZoH3Iyol0AoBTXgx4mkDI60VnYBQFeOD/KJ90L2VQU5fFhSfoiwvPsM8Yqk2W+Mvrl2UAae
ARC-Seal: i=1; a=rsa-sha256; t=1526731669; cv=none;
        d=google.com; s=arc-20160816;
        b=MxMvBZl6ZXok3gvW7tPuIx2FY8Yi2iT2E4d18lJ+bgA1HiSEpeaItKWwC0gGkexfE/
         M8ft7UUhnOwMsOFy04KeHZxBHZEhw5f72kaa+Lx1EQ9s9VnV3nmBpK2S/Xq0Ud/6g7rt
         13qU+1VAFE9PInFDarscJAemk9/B2wgPSrLR579+wDop9vq8PQtvFPzHoE1Cn7EuMxfk
         mDgcHqajx4IDLm2lF4pKjzHu6hwD12j0/otbAWj6FcpECInAU9bbs2QOn3hZoYY8CM4p
         KlmbM7uUYyTHUuyOgYCZ4EhQ64m7+WecCRZGhTMeX7aHS4QnHoLXBRAJmBpvRwVLo6bJ
         xaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Q4BocBUQjSZslG7JrJ/7UOan+C/6gD10m2O6CUHFIww=;
        b=XAgFVhO8Tn764u+3LGFH0oTkvc3fmlloCED6O9mp2DNxlpsxkoWhfM24U1fLKPo3Sc
         Kp+CorS5initi69f8Kx/Tco6kdFue+RbGXLxrs50Cfo29vWd7ps7qAo5EJZvw260Z0DL
         IU3UvJvdwmswuy6miz0f+2PCFDURkG6KtByV+67DCBFOqv0A0Ox7XAfUXvYB7s9lex46
         c4roFZ5fQbRyawVR1Wrq0mdr/VDD6Z2BhTNj5Axdc/mcFf/Y1ZkS0OiJ1IJ0Wm6ByGw0
         LpCzWKPRuTbe7QMvvjGqI+k/yL1VWYqI53QJ9Vp03dkqMQYY+5g083hbSXHB+utfDwL8
         SMbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=aFvxDIiL;
       spf=pass (google.com: domain of jrosen@cisco.com designates 173.37.142.93 as permitted sender) smtp.mailfrom=jrosen@cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=aFvxDIiL;
       spf=pass (google.com: domain of jrosen@cisco.com designates 173.37.142.93 as permitted sender) smtp.mailfrom=jrosen@cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.49,417,1520899200";
   d="scan'208";a="116355637"
From: Jon Rosen <jrosen@cisco.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jon Rosen <jrosen@cisco.com>, Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Mike Maloney <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] packet: track ring entry use using a shadow ring to prevent RX ring overrun
Date: Sat, 19 May 2018 12:07:33 +0000
Message-Id: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
X-Mailer: git-send-email 2.5.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600894186810885957?=
X-GMAIL-MSGID: =?utf-8?q?1600894186810885957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix PACKET_RX_RING bug for versions TPACKET_V1 and TPACKET_V2 which
casues the ring to get corrupted by allowing multiple kernel threads
to claim ownership of the same ring entry. Track ownership in a shadow
ring structure to prevent other kernel threads from reusing the same
entry before it's fully filled in, passed to user space, and then
eventually passed back to the kernel for use with a new packet.

Signed-off-by: Jon Rosen <jrosen@cisco.com>
---

There is a bug in net/packet/af_packet.c:tpacket_rcv in how it manages
the PACKET_RX_RING for versions TPACKET_V1 and TPACKET_V2.  This bug makes
it possible for multiple kernel threads to claim ownership of the same
ring entry, corrupting the ring and the corresponding packet(s).

These diffs are the second proposed solution, previous proposal was described
in https://www.mail-archive.com/netdev@vger.kernel.org/msg227468.html
subject [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
to prevent RX ring overrun

Those diffs would have changed the binary interface and have broken certain
applications. Consensus was that such a change would be inappropriate.

These new diffs use a shadow ring in kernel space for tracking intermediate
state of an entry and prevent more than one kernel thread from simultaneously
allocating a ring entry. This avoids any impact to the binary interface
between kernel and userspace but comes at the additional cost of requiring a
second spin_lock when passing ownership of a ring entry to userspace.

Jon Rosen (1):
  packet: track ring entry use using a shadow ring to prevent RX ring
    overrun

 net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/packet/internal.h  | 14 +++++++++++
 2 files changed, 78 insertions(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e0f3f4a..4d08c8e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2165,6 +2165,26 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 }
 
+static inline void *packet_rx_shadow_aquire_head(struct packet_sock *po)
+{
+	struct packet_ring_shadow_entry *entry;
+
+	entry = &po->rx_shadow.ring[po->rx_ring.head];
+	if (unlikely(entry->inuse))
+		return NULL;
+
+	entry->inuse = 1;
+	return (void *)entry;
+}
+
+static inline void packet_rx_shadow_release(void *_entry)
+{
+	struct packet_ring_shadow_entry *entry;
+
+	entry = (struct packet_ring_shadow_entry *)_entry;
+	entry->inuse = 0;
+}
+
 static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		       struct packet_type *pt, struct net_device *orig_dev)
 {
@@ -2182,6 +2202,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	__u32 ts_status;
 	bool is_drop_n_account = false;
 	bool do_vnet = false;
+	void *rx_shadow_ring_entry = NULL;
 
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2277,7 +2298,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!h.raw)
 		goto drop_n_account;
 	if (po->tp_version <= TPACKET_V2) {
+		/* Attempt to allocate shadow ring entry.
+		 * If already inuse then the ring is full.
+		 */
+		rx_shadow_ring_entry = packet_rx_shadow_aquire_head(po);
+		if (unlikely(!rx_shadow_ring_entry))
+			goto ring_is_full;
+
 		packet_increment_rx_head(po, &po->rx_ring);
+
 	/*
 	 * LOSING will be reported till you read the stats,
 	 * because it's COR - Clear On Read.
@@ -2383,7 +2412,11 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 #endif
 
 	if (po->tp_version <= TPACKET_V2) {
+		spin_lock(&sk->sk_receive_queue.lock);
 		__packet_set_status(po, h.raw, status);
+		packet_rx_shadow_release(rx_shadow_ring_entry);
+		spin_unlock(&sk->sk_receive_queue.lock);
+
 		sk->sk_data_ready(sk);
 	} else {
 		prb_clear_blk_fill_status(&po->rx_ring);
@@ -4197,6 +4230,25 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
 	goto out;
 }
 
+static struct packet_ring_shadow_entry *
+		packet_rx_shadow_alloc(unsigned int tp_frame_nr)
+{
+	struct packet_ring_shadow_entry *rx_shadow_ring;
+	int ring_size;
+	int i;
+
+	ring_size = tp_frame_nr * sizeof(*rx_shadow_ring);
+	rx_shadow_ring = kmalloc(ring_size, GFP_KERNEL);
+
+	if (!rx_shadow_ring)
+		return NULL;
+
+	for (i = 0; i < tp_frame_nr; i++)
+		rx_shadow_ring[i].inuse = 0;
+
+	return rx_shadow_ring;
+}
+
 static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		int closing, int tx_ring)
 {
@@ -4209,6 +4261,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	int err = -EINVAL;
 	/* Added to avoid minimal code churn */
 	struct tpacket_req *req = &req_u->req;
+	struct packet_ring_shadow_entry *rx_shadow_ring = NULL;
 
 	lock_sock(sk);
 
@@ -4266,6 +4319,13 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 			goto out;
 
 		err = -ENOMEM;
+		if (!tx_ring && po->tp_version <= TPACKET_V2) {
+			rx_shadow_ring =
+				packet_rx_shadow_alloc(req->tp_frame_nr);
+			if (!rx_shadow_ring)
+				goto out;
+		}
+
 		order = get_order(req->tp_block_size);
 		pg_vec = alloc_pg_vec(req, order);
 		if (unlikely(!pg_vec))
@@ -4319,6 +4379,8 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frame_max = (req->tp_frame_nr - 1);
 		rb->head = 0;
 		rb->frame_size = req->tp_frame_size;
+		if (!tx_ring)
+			swap(po->rx_shadow.ring, rx_shadow_ring);
 		spin_unlock_bh(&rb_queue->lock);
 
 		swap(rb->pg_vec_order, order);
@@ -4349,6 +4411,8 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	if (pg_vec)
 		free_pg_vec(pg_vec, order, req->tp_block_nr);
 out:
+	kfree(rx_shadow_ring);
+
 	release_sock(sk);
 	return err;
 }
diff --git a/net/packet/internal.h b/net/packet/internal.h
index a1d2b23..d1a965e 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -73,6 +73,14 @@ struct packet_ring_buffer {
 	struct tpacket_kbdq_core	prb_bdqc;
 };
 
+struct packet_ring_shadow_entry {
+	unsigned int		inuse;
+};
+
+struct packet_ring_shadow {
+	struct packet_ring_shadow_entry	*ring;
+};
+
 extern struct mutex fanout_mutex;
 #define PACKET_FANOUT_MAX	256
 
@@ -107,8 +115,14 @@ struct packet_sock {
 	struct sock		sk;
 	struct packet_fanout	*fanout;
 	union  tpacket_stats_u	stats;
+	/* Do not separate rx/tx ring structures.
+	 * They are treated as an array in af_packet.c:packet_mmap()
+	 */
 	struct packet_ring_buffer	rx_ring;
 	struct packet_ring_buffer	tx_ring;
+	/* end of rings */
+
+	struct packet_ring_shadow	rx_shadow;
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
-- 
2.5.0
