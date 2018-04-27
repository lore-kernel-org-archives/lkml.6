Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZphUuU1KAk5nKMPEujvktXWk1kNQWbeCk8ZhT+DbDHJcLXv1YHF6uaZMgG7jw5LfCA1zV0s
ARC-Seal: i=1; a=rsa-sha256; t=1524837597; cv=none;
        d=google.com; s=arc-20160816;
        b=N3wltEtkChLESeQhJcUHUPUpTDhP7pV60mjNxMn1EbSgLzOPR3bRoXxSi2N8oFxirX
         RlZMGzfixjGvtFoH64RJF7A0Hvb9tB9sU1mgEydsMHCHFrUfSLsCjI013Sr8n+/C//Ln
         Eh2V7VZ6zW7T465KDeu+XEJXKRRA2xhv4VIX6DGNLjuWhV17WbrVQO5NanPCzyYCRq8o
         DaDQmREkRTXyntszhloDkvItmh2MttbHKdU59hwdhkxVrAOOXDgXH8YnttkarfD9mjSh
         6pbLLuCsMG3zVX2iOjbd6p+ZZgrZK5YzFYZMP7L7RLPyoNHyHU3sLll0rdVkCJty9vbB
         0iPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ztOznQVT2oEwK1eszv9sDImdbKlQDkVJq0ZSxnViTWA=;
        b=l3dzebpzl0xziBQXMyf/K4pliu7YVqSdUsMFBmirpzAEomeY3APK3oZe3dYGRtWNra
         FF7zT4ei5oQpCg908vaDXBZuNnRqzw1++JTUuuSFe7IlLC4pdqaF/N/6BlX/u8xeFet7
         H0aRE1peolNufSS5vqkoZCphSdiw5y1udx5USVoZbCfLD8qV4P5GI0/0JlI+CezCGIhH
         d7vGw1flULlfrg0VrXAFPlh8Sa0AELqGiCSIUoxr24/mQcT8+k0jZ++k7YJlv9L345Jr
         c2LpMYGG5cwD/lUF1dywx02xN9Rm92nN0DnckKijfPIHit+IcOqLKTA7nPij5IS0Gmwb
         iznA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4103321890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Byoungyoung Lee <byoungyoung@purdue.edu>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 18/24] packet: fix bitfield update race
Date: Fri, 27 Apr 2018 15:57:53 +0200
Message-Id: <20180427135632.336601010@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908108463523673?=
X-GMAIL-MSGID: =?utf-8?q?1598908108463523673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>


[ Upstream commit a6361f0ca4b25460f2cdf3235ebe8115f622901e ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   60 +++++++++++++++++++++++++++++++++++--------------
 net/packet/internal.h  |   10 ++++----
 2 files changed, 49 insertions(+), 21 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -323,11 +323,11 @@ static void packet_pick_tx_queue(struct
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
 
@@ -342,8 +342,13 @@ static void register_prot_hook(struct so
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
@@ -353,6 +358,8 @@ static void __unregister_prot_hook(struc
 {
 	struct packet_sock *po = pkt_sk(sk);
 
+	lockdep_assert_held_once(&po->bind_lock);
+
 	po->running = 0;
 
 	if (po->fanout)
@@ -2861,7 +2868,7 @@ static int packet_create(struct net *net
 
 	if (proto) {
 		po->prot_hook.type = proto;
-		register_prot_hook(sk);
+		__register_prot_hook(sk);
 	}
 
 	mutex_lock(&net->packet.sklist_lock);
@@ -3352,12 +3359,18 @@ packet_setsockopt(struct socket *sock, i
 
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
@@ -3368,7 +3381,9 @@ packet_setsockopt(struct socket *sock, i
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
+		lock_sock(sk);
 		po->auxdata = !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3380,7 +3395,9 @@ packet_setsockopt(struct socket *sock, i
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
+		lock_sock(sk);
 		po->origdev = !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3389,15 +3406,20 @@ packet_setsockopt(struct socket *sock, i
 
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
@@ -3428,11 +3450,17 @@ packet_setsockopt(struct socket *sock, i
 
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
