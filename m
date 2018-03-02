Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtNCr8gHpZDeepeaFs7I4idMYfNDjpVFiaJjN3cPjm7BWkW8FHGKNtS3hmJOnmgAIqvQ57Z
ARC-Seal: i=1; a=rsa-sha256; t=1519981261; cv=none;
        d=google.com; s=arc-20160816;
        b=0SbQCFRseUwJrO7JOQb1BNU6x+KX7iPB/ARXbPqz6LR4R4Q8thISJQPj018kmqwRAa
         acobPZLmDjzpCxjfvPLVGgcOeJZYP2eiXeaVAtc8UNzNOp/L8iCq2cGmVtfs11shP82X
         xEYb4/ZuZCPCNX5592JklqfOfAGNgajN8mctNibQ4pcOD+Q2HwF9SpIY7SEKcW5TlYop
         Jwquh+jn2ZQG0UsRLLyj+/iMzCGOdEUHHhpqwMNEjJj+yM4Hrh8qVxpE0ZTGXI1vJk4b
         JSyj88Q7S0FfTbrNvHVbTGdcZYKlPJXMDvz27t3typepzj8KMS0QTbWxBcTsDcLdX+MS
         GWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yi4ANdlCgBBz6aX+Exwq6nuzoF+OjL025u/LKK3SDy8=;
        b=HILGkdXiSaQxOZGHZZnFVgfrwcBWgBtVBskIIMoC5QJANFL0VM2+fmFlXUyjtWObJG
         1sgNB11HmAOMHbeLjs3i3ZgNpbh1qk4T2RKkUo4ZndLeF7N5VQC9E6KYVd2Cd3Y9XASY
         dmtngNs654y2E1/fmD9CPuIXHOOiyHwFu4dabsZYBTIlAQExuYKuBpvk9BqorFo5H3wG
         yO/VveMGkLnUv5mJ2BHHn1ycR5jBUtYzx1oFQhkVjb7pOHuUOVWrWHK4mBx+rALVhnXW
         cVmskcZMm/hZ57FZmwQD33WwRTDvzEnJysENJD/YEAFd16qs/RbdDW+58TE6jKP5LTds
         wZ6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 022/115] xfrm: Reinject transport-mode packets through tasklet
Date: Fri,  2 Mar 2018 09:50:25 +0100
Message-Id: <20180302084504.769769488@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815871823916822?=
X-GMAIL-MSGID: =?utf-8?q?1593815871823916822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>


[ Upstream commit acf568ee859f098279eadf551612f103afdacb4e ]

This is an old bugbear of mine:

https://www.mail-archive.com/netdev@vger.kernel.org/msg03894.html

By crafting special packets, it is possible to cause recursion
in our kernel when processing transport-mode packets at levels
that are only limited by packet size.

The easiest one is with DNAT, but an even worse one is where
UDP encapsulation is used in which case you just have to insert
an UDP encapsulation header in between each level of recursion.

This patch avoids this problem by reinjecting tranport-mode packets
through a tasklet.

Fixes: b05e106698d9 ("[IPV4/6]: Netfilter IPsec input hooks")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/xfrm.h     |    3 ++
 net/ipv4/xfrm4_input.c |   12 +++++++++-
 net/ipv6/xfrm6_input.c |   10 +++++++-
 net/xfrm/xfrm_input.c  |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 2 deletions(-)

--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1570,6 +1570,9 @@ int xfrm_init_state(struct xfrm_state *x
 int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb);
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
 int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
+int xfrm_trans_queue(struct sk_buff *skb,
+		     int (*finish)(struct net *, struct sock *,
+				   struct sk_buff *));
 int xfrm_output_resume(struct sk_buff *skb, int err);
 int xfrm_output(struct sock *sk, struct sk_buff *skb);
 int xfrm_inner_extract_output(struct xfrm_state *x, struct sk_buff *skb);
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -23,6 +23,12 @@ int xfrm4_extract_input(struct xfrm_stat
 	return xfrm4_extract_header(skb);
 }
 
+static int xfrm4_rcv_encap_finish2(struct net *net, struct sock *sk,
+				   struct sk_buff *skb)
+{
+	return dst_input(skb);
+}
+
 static inline int xfrm4_rcv_encap_finish(struct net *net, struct sock *sk,
 					 struct sk_buff *skb)
 {
@@ -33,7 +39,11 @@ static inline int xfrm4_rcv_encap_finish
 					 iph->tos, skb->dev))
 			goto drop;
 	}
-	return dst_input(skb);
+
+	if (xfrm_trans_queue(skb, xfrm4_rcv_encap_finish2))
+		goto drop;
+
+	return 0;
 drop:
 	kfree_skb(skb);
 	return NET_RX_DROP;
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -32,6 +32,14 @@ int xfrm6_rcv_spi(struct sk_buff *skb, i
 }
 EXPORT_SYMBOL(xfrm6_rcv_spi);
 
+static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
+				   struct sk_buff *skb)
+{
+	if (xfrm_trans_queue(skb, ip6_rcv_finish))
+		__kfree_skb(skb);
+	return -1;
+}
+
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	struct xfrm_offload *xo = xfrm_offload(skb);
@@ -56,7 +64,7 @@ int xfrm6_transport_finish(struct sk_buf
 
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
 		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-		ip6_rcv_finish);
+		xfrm6_transport_finish2);
 	return -1;
 }
 
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -8,15 +8,29 @@
  *
  */
 
+#include <linux/bottom_half.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/percpu.h>
 #include <net/dst.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
 #include <net/ip_tunnels.h>
 #include <net/ip6_tunnel.h>
 
+struct xfrm_trans_tasklet {
+	struct tasklet_struct tasklet;
+	struct sk_buff_head queue;
+};
+
+struct xfrm_trans_cb {
+	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
+};
+
+#define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]))
+
 static struct kmem_cache *secpath_cachep __read_mostly;
 
 static DEFINE_SPINLOCK(xfrm_input_afinfo_lock);
@@ -25,6 +39,8 @@ static struct xfrm_input_afinfo const __
 static struct gro_cells gro_cells;
 static struct net_device xfrm_napi_dev;
 
+static DEFINE_PER_CPU(struct xfrm_trans_tasklet, xfrm_trans_tasklet);
+
 int xfrm_input_register_afinfo(const struct xfrm_input_afinfo *afinfo)
 {
 	int err = 0;
@@ -477,9 +493,41 @@ int xfrm_input_resume(struct sk_buff *sk
 }
 EXPORT_SYMBOL(xfrm_input_resume);
 
+static void xfrm_trans_reinject(unsigned long data)
+{
+	struct xfrm_trans_tasklet *trans = (void *)data;
+	struct sk_buff_head queue;
+	struct sk_buff *skb;
+
+	__skb_queue_head_init(&queue);
+	skb_queue_splice_init(&trans->queue, &queue);
+
+	while ((skb = __skb_dequeue(&queue)))
+		XFRM_TRANS_SKB_CB(skb)->finish(dev_net(skb->dev), NULL, skb);
+}
+
+int xfrm_trans_queue(struct sk_buff *skb,
+		     int (*finish)(struct net *, struct sock *,
+				   struct sk_buff *))
+{
+	struct xfrm_trans_tasklet *trans;
+
+	trans = this_cpu_ptr(&xfrm_trans_tasklet);
+
+	if (skb_queue_len(&trans->queue) >= netdev_max_backlog)
+		return -ENOBUFS;
+
+	XFRM_TRANS_SKB_CB(skb)->finish = finish;
+	skb_queue_tail(&trans->queue, skb);
+	tasklet_schedule(&trans->tasklet);
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_trans_queue);
+
 void __init xfrm_input_init(void)
 {
 	int err;
+	int i;
 
 	init_dummy_netdev(&xfrm_napi_dev);
 	err = gro_cells_init(&gro_cells, &xfrm_napi_dev);
@@ -490,4 +538,13 @@ void __init xfrm_input_init(void)
 					   sizeof(struct sec_path),
 					   0, SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 					   NULL);
+
+	for_each_possible_cpu(i) {
+		struct xfrm_trans_tasklet *trans;
+
+		trans = &per_cpu(xfrm_trans_tasklet, i);
+		__skb_queue_head_init(&trans->queue);
+		tasklet_init(&trans->tasklet, xfrm_trans_reinject,
+			     (unsigned long)trans);
+	}
 }
