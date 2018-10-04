Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD6C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF1021470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF1021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJDPXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeJDPXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:23:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3B9BDF2C;
        Thu,  4 Oct 2018 08:31:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 761425D6A6;
        Thu,  4 Oct 2018 08:31:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next] r8169: Add some tracepoints for watching rx/tx
 events
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com
Date:   Thu, 04 Oct 2018 09:31:06 +0100
Message-ID: <153864186671.20395.13235648600774486012.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 04 Oct 2018 08:31:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some tracepoints into the Realtek r8169 driver to watch events involved
in the reception and transmission of packets, including:

 (1) Interrupts occurring.  The device status is logged.

 (2) NAPI polling.  The device status is logged.

 (3) Packet received and about to be handed off.  The sk_buff address is
     logged.

 (4) Packet queued for transmission and device poked.  The sk_buff address
     is logged along with the revised Tx ring indices.

 (5) Packet removed from Tx ring after transmission.  The sk_buff address
     is logged along with the Tx ring slot number.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/net/ethernet/realtek/r8169.c |    9 ++
 include/trace/events/net_rtl8169.h   |  125 ++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 include/trace/events/net_rtl8169.h

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 9a5e2969df61..1d4d3d953628 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -31,6 +31,9 @@
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/net_rtl8169.h>
+
 #define MODULENAME "r8169"
 
 #define FIRMWARE_8168D_1	"rtl_nic/rtl8168d-1.fw"
@@ -6192,6 +6195,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	RTL_W8(tp, TxPoll, NPQ);
 
 	mmiowb();
+	trace_net_rtl8169_tx(tp->dev, tp->dirty_tx, tp->cur_tx, skb);
 
 	if (!TX_FRAGS_READY_FOR(tp, MAX_SKB_FRAGS)) {
 		/* Avoid wrongly optimistic queue wake-up: rtl_tx thread must
@@ -6297,6 +6301,7 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp)
 		rtl8169_unmap_tx_skb(tp_to_dev(tp), tx_skb,
 				     tp->TxDescArray + entry);
 		if (status & LastFrag) {
+			trace_net_rtl8169_tx_done(dev, dirty_tx, tx_skb->skb);
 			u64_stats_update_begin(&tp->tx_stats.syncp);
 			tp->tx_stats.packets++;
 			tp->tx_stats.bytes += tx_skb->skb->len;
@@ -6447,6 +6452,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, u32 budget
 			if (skb->pkt_type == PACKET_MULTICAST)
 				dev->stats.multicast++;
 
+			trace_net_rtl8169_rx(dev, skb);
 			napi_gro_receive(&tp->napi, skb);
 
 			u64_stats_update_begin(&tp->rx_stats.syncp);
@@ -6473,6 +6479,8 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if (status == 0xffff || !(status & (RTL_EVENT_NAPI | tp->event_slow)))
 		return IRQ_NONE;
 
+	trace_net_rtl8169_interrupt(tp->napi.dev, status);
+
 	rtl_irq_disable(tp);
 	napi_schedule_irqoff(&tp->napi);
 
@@ -6554,6 +6562,7 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	status = rtl_get_events(tp);
 	rtl_ack_events(tp, status & ~tp->event_slow);
+	trace_net_rtl8169_poll(dev, status);
 
 	if (status & RTL_EVENT_NAPI_RX)
 		work_done = rtl_rx(dev, tp, (u32) budget);
diff --git a/include/trace/events/net_rtl8169.h b/include/trace/events/net_rtl8169.h
new file mode 100644
index 000000000000..15b3984c3939
--- /dev/null
+++ b/include/trace/events/net_rtl8169.h
@@ -0,0 +1,125 @@
+/* Realtek RTL8169 tracepoints
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM net_rtl8169
+
+#if !defined(_TRACE_NET_RTL8169_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NET_RTL8169_H
+
+#include <linux/tracepoint.h>
+#include <linux/errqueue.h>
+
+
+TRACE_EVENT(net_rtl8169_interrupt,
+	    TP_PROTO(struct net_device *netdev, u16 status),
+
+	    TP_ARGS(netdev, status),
+
+	    TP_STRUCT__entry(
+		    __field(u16,			status		)
+		    __array(char,			name, IFNAMSIZ	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->status = status;
+		    memcpy(__entry->name, netdev->name, IFNAMSIZ);
+			   ),
+
+	    TP_printk("%s st=%x", __entry->name, __entry->status)
+	    );
+
+TRACE_EVENT(net_rtl8169_poll,
+	    TP_PROTO(struct net_device *netdev, u16 status),
+
+	    TP_ARGS(netdev, status),
+
+	    TP_STRUCT__entry(
+		    __field(u16,			status		)
+		    __array(char,			name, IFNAMSIZ	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->status = status;
+		    memcpy(__entry->name, netdev->name, IFNAMSIZ);
+			   ),
+
+	    TP_printk("%s st=%x", __entry->name, __entry->status)
+	    );
+
+TRACE_EVENT(net_rtl8169_rx,
+	    TP_PROTO(struct net_device *netdev, struct sk_buff *skb),
+
+	    TP_ARGS(netdev, skb),
+
+	    TP_STRUCT__entry(
+		    __field(struct sk_buff *,		skb		)
+		    __array(char,			name, IFNAMSIZ	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->skb = skb;
+		    memcpy(__entry->name, netdev->name, IFNAMSIZ);
+			   ),
+
+	    TP_printk("%s skb=%p", __entry->name, __entry->skb)
+	    );
+
+TRACE_EVENT(net_rtl8169_tx_done,
+	    TP_PROTO(struct net_device *netdev, unsigned int dirty_tx,
+		     struct sk_buff *skb),
+
+	    TP_ARGS(netdev, dirty_tx, skb),
+
+	    TP_STRUCT__entry(
+		    __field(struct sk_buff *,		skb)
+		    __field(unsigned int,		dirty_tx)
+		    __array(char,			name, IFNAMSIZ	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->skb = skb;
+		    __entry->dirty_tx = dirty_tx;
+		    memcpy(__entry->name, netdev->name, IFNAMSIZ);
+			   ),
+
+	    TP_printk("%s p=%u skb=%p",
+		      __entry->name, __entry->dirty_tx, __entry->skb)
+	    );
+
+TRACE_EVENT(net_rtl8169_tx,
+	    TP_PROTO(struct net_device *netdev, unsigned int dirty_tx,
+		     unsigned int cur_tx, struct sk_buff *skb),
+
+	    TP_ARGS(netdev, dirty_tx, cur_tx, skb),
+
+	    TP_STRUCT__entry(
+		    __field(struct sk_buff *,		skb		)
+		    __field(unsigned int,		dirty_tx	)
+		    __field(unsigned int,		cur_tx		)
+		    __array(char,			name, IFNAMSIZ	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->skb = skb;
+		    __entry->dirty_tx = dirty_tx;
+		    __entry->cur_tx = cur_tx;
+		    memcpy(__entry->name, netdev->name, IFNAMSIZ);
+			   ),
+
+	    TP_printk("%s p=%u-%u skb=%p",
+		      __entry->name, __entry->dirty_tx, __entry->cur_tx,
+		      __entry->skb)
+	    );
+
+#endif /* _TRACE_NET_RTL8169_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

