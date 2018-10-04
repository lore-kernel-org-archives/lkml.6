Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BC721470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BC721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJDPWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeJDPWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:22:49 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 061563082125;
        Thu,  4 Oct 2018 08:30:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04517A52EE;
        Thu,  4 Oct 2018 08:30:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next] udp: Add tracepoints to monitor skbs going in and
 out of a UDP socket
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 09:30:41 +0100
Message-ID: <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 04 Oct 2018 08:30:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three tracepoints to the UDP/UDP6 code to trace three aspects of
sk_buff handling:

 (1) UDP packets that are about to be handed off to the IP layer to be
     transmitted.

 (2) UDP packets that have just arrived at the socket.

 (3) UDP packets that are about to be queued on the UDP socket's receive
     queue, and displaying the sk_rmem_alloc counter.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/trace/events/udp.h |   53 ++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/udp.c             |    3 ++
 net/ipv6/udp.c             |    3 ++
 3 files changed, 59 insertions(+)

diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
index 336fe272889f..ff6b3ab5a65e 100644
--- a/include/trace/events/udp.h
+++ b/include/trace/events/udp.h
@@ -27,6 +27,59 @@ TRACE_EVENT(udp_fail_queue_rcv_skb,
 	TP_printk("rc=%d port=%hu", __entry->rc, __entry->lport)
 );
 
+TRACE_EVENT(udp_tx,
+
+	TP_PROTO(struct sk_buff *skb),
+
+	TP_ARGS(skb),
+
+	TP_STRUCT__entry(
+		__field(struct sk_buff *, skb)
+	),
+
+	TP_fast_assign(
+		__entry->skb = skb;
+	),
+
+	TP_printk("skb=%p", __entry->skb)
+);
+
+TRACE_EVENT(udp_rcv,
+
+	TP_PROTO(struct sk_buff *skb),
+
+	TP_ARGS(skb),
+
+	TP_STRUCT__entry(
+		__field(struct sk_buff *, skb)
+	),
+
+	TP_fast_assign(
+		__entry->skb = skb;
+	),
+
+	TP_printk("skb=%p", __entry->skb)
+);
+
+TRACE_EVENT(udp_enqueue,
+
+	    TP_PROTO(struct sk_buff *skb, int rmem),
+
+	    TP_ARGS(skb, rmem),
+
+	    TP_STRUCT__entry(
+		    __field(struct sk_buff *, skb)
+		    __field(int, rmem)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->skb = skb;
+		    __entry->rmem = rmem;
+			   ),
+
+	    TP_printk("skb=%p rm=%d", __entry->skb, __entry->rmem)
+	    );
+
 #endif /* _TRACE_UDP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f93bc444f631..67afbd0ac0a7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -826,6 +826,7 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		uh->check = CSUM_MANGLED_0;
 
 send:
+	trace_udp_tx(skb);
 	err = ip_send_skb(sock_net(sk), skb);
 	if (err) {
 		if (err == -ENOBUFS && !inet->recverr) {
@@ -1363,6 +1364,7 @@ static int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	if (rmem > sk->sk_rcvbuf)
 		goto drop;
+	trace_udp_enqueue(skb, rmem);
 
 	/* Under mem pressure, it might be helpful to help udp_recvmsg()
 	 * having linear skbs :
@@ -2395,6 +2397,7 @@ int udp_v4_early_demux(struct sk_buff *skb)
 
 int udp_rcv(struct sk_buff *skb)
 {
+	trace_udp_rcv(skb);
 	return __udp4_lib_rcv(skb, &udp_table, IPPROTO_UDP);
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 4421fbf0a7a4..baec8abc1409 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -54,6 +54,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <trace/events/skb.h>
+#include <trace/events/udp.h>
 #include "udp_impl.h"
 
 static bool udp6_lib_exact_dif_match(struct net *net, struct sk_buff *skb)
@@ -950,6 +951,7 @@ static void udp_v6_early_demux(struct sk_buff *skb)
 
 static __inline__ int udpv6_rcv(struct sk_buff *skb)
 {
+	trace_udp_rcv(skb);
 	return __udp6_lib_rcv(skb, &udp_table, IPPROTO_UDP);
 }
 
@@ -1093,6 +1095,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		uh->check = CSUM_MANGLED_0;
 
 send:
+	trace_udp_tx(skb);
 	err = ip6_send_skb(skb);
 	if (err) {
 		if (err == -ENOBUFS && !inet6_sk(sk)->recverr) {

