Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B3DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFC72145D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788887;
	bh=b6NzSA+ENEmIz6ZA4e1Z2cpBhnnzTEl7CFkKXVuhm8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kTqPGZAxv90RgDIJovMhE1MHHqH/qqgYj0autTFbWKjLLy5R4m96FavKGvHAts9rO
	 zQkqIhyOrIs0DwEy6sy0jvsm8Z0q7qVqK8VC6q0wVQAJxTePB3ortQSkwJ82Z/Jv2Y
	 JWPZyrTvXwCokfSeXU4da/hzrt/LxjPG8QbSXEqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFC72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeLNMB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNMBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:01:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E3A21104;
        Fri, 14 Dec 2018 12:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788883;
        bh=b6NzSA+ENEmIz6ZA4e1Z2cpBhnnzTEl7CFkKXVuhm8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVulOnA4GPniz16mva1ChuvSYuRioqft5GXkoQgNwAeMX1lixTEFcBuUCd2Qug573
         IKrxiGgfaXVaAQTR2kELEnZqKGba0j9mAYGY6lygZnzf12AuzSUrMrzjk4IGCtcSae
         yUa6hgnmPtGAgikCOJfpODqLrd44FIdA3LQmFQmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 010/142] net: use skb_list_del_init() to remove from RX sublists
Date:   Fri, 14 Dec 2018 12:58:15 +0100
Message-Id: <20181214115747.460472293@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Cree <ecree@solarflare.com>

[ Upstream commit 22f6bbb7bcfcef0b373b0502a7ff390275c575dd ]

list_del() leaves the skb->next pointer poisoned, which can then lead to
 a crash in e.g. OVS forwarding.  For example, setting up an OVS VXLAN
 forwarding bridge on sfc as per:

========
$ ovs-vsctl show
5dfd9c47-f04b-4aaa-aa96-4fbb0a522a30
    Bridge "br0"
        Port "br0"
            Interface "br0"
                type: internal
        Port "enp6s0f0"
            Interface "enp6s0f0"
        Port "vxlan0"
            Interface "vxlan0"
                type: vxlan
                options: {key="1", local_ip="10.0.0.5", remote_ip="10.0.0.4"}
    ovs_version: "2.5.0"
========
(where 10.0.0.5 is an address on enp6s0f1)
and sending traffic across it will lead to the following panic:
========
general protection fault: 0000 [#1] SMP PTI
CPU: 5 PID: 0 Comm: swapper/5 Not tainted 4.20.0-rc3-ehc+ #701
Hardware name: Dell Inc. PowerEdge R710/0M233H, BIOS 6.4.0 07/23/2013
RIP: 0010:dev_hard_start_xmit+0x38/0x200
Code: 53 48 89 fb 48 83 ec 20 48 85 ff 48 89 54 24 08 48 89 4c 24 18 0f 84 ab 01 00 00 48 8d 86 90 00 00 00 48 89 f5 48 89 44 24 10 <4c> 8b 33 48 c7 03 00 00 00 00 48 8b 05 c7 d1 b3 00 4d 85 f6 0f 95
RSP: 0018:ffff888627b437e0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: dead000000000100 RCX: ffff88862279c000
RDX: ffff888614a342c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888618a88000 R08: 0000000000000001 R09: 00000000000003e8
R10: 0000000000000000 R11: ffff888614a34140 R12: 0000000000000000
R13: 0000000000000062 R14: dead000000000100 R15: ffff888616430000
FS:  0000000000000000(0000) GS:ffff888627b40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6d2bc6d000 CR3: 000000000200a000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 __dev_queue_xmit+0x623/0x870
 ? masked_flow_lookup+0xf7/0x220 [openvswitch]
 ? ep_poll_callback+0x101/0x310
 do_execute_actions+0xaba/0xaf0 [openvswitch]
 ? __wake_up_common+0x8a/0x150
 ? __wake_up_common_lock+0x87/0xc0
 ? queue_userspace_packet+0x31c/0x5b0 [openvswitch]
 ovs_execute_actions+0x47/0x120 [openvswitch]
 ovs_dp_process_packet+0x7d/0x110 [openvswitch]
 ovs_vport_receive+0x6e/0xd0 [openvswitch]
 ? dst_alloc+0x64/0x90
 ? rt_dst_alloc+0x50/0xd0
 ? ip_route_input_slow+0x19a/0x9a0
 ? __udp_enqueue_schedule_skb+0x198/0x1b0
 ? __udp4_lib_rcv+0x856/0xa30
 ? __udp4_lib_rcv+0x856/0xa30
 ? cpumask_next_and+0x19/0x20
 ? find_busiest_group+0x12d/0xcd0
 netdev_frame_hook+0xce/0x150 [openvswitch]
 __netif_receive_skb_core+0x205/0xae0
 __netif_receive_skb_list_core+0x11e/0x220
 netif_receive_skb_list+0x203/0x460
 ? __efx_rx_packet+0x335/0x5e0 [sfc]
 efx_poll+0x182/0x320 [sfc]
 net_rx_action+0x294/0x3c0
 __do_softirq+0xca/0x297
 irq_exit+0xa6/0xb0
 do_IRQ+0x54/0xd0
 common_interrupt+0xf/0xf
 </IRQ>
========
So, in all listified-receive handling, instead pull skbs off the lists with
 skb_list_del_init().

Fixes: 9af86f933894 ("net: core: fix use-after-free in __netif_receive_skb_list_core")
Fixes: 7da517a3bc52 ("net: core: Another step of skb receive list processing")
Fixes: a4ca8b7df73c ("net: ipv4: fix drop handling in ip_list_rcv() and ip_list_rcv_finish()")
Fixes: d8269e2cbf90 ("net: ipv6: listify ipv6_rcv() and ip6_rcv_finish()")
Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |   11 +++++++++++
 net/core/dev.c         |    8 ++++----
 net/ipv4/ip_input.c    |    4 ++--
 net/ipv6/ip6_input.c   |    4 ++--
 4 files changed, 19 insertions(+), 8 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1355,6 +1355,17 @@ static inline void skb_zcopy_abort(struc
 	}
 }
 
+static inline void skb_mark_not_on_list(struct sk_buff *skb)
+{
+	skb->next = NULL;
+}
+
+static inline void skb_list_del_init(struct sk_buff *skb)
+{
+	__list_del_entry(&skb->list);
+	skb_mark_not_on_list(skb);
+}
+
 /**
  *	skb_queue_empty - check if a queue is empty
  *	@list: queue head
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4981,7 +4981,7 @@ static void __netif_receive_skb_list_cor
 		struct net_device *orig_dev = skb->dev;
 		struct packet_type *pt_prev = NULL;
 
-		list_del(&skb->list);
+		skb_list_del_init(skb);
 		__netif_receive_skb_core(skb, pfmemalloc, &pt_prev);
 		if (!pt_prev)
 			continue;
@@ -5137,7 +5137,7 @@ static void netif_receive_skb_list_inter
 	INIT_LIST_HEAD(&sublist);
 	list_for_each_entry_safe(skb, next, head, list) {
 		net_timestamp_check(netdev_tstamp_prequeue, skb);
-		list_del(&skb->list);
+		skb_list_del_init(skb);
 		if (!skb_defer_rx_timestamp(skb))
 			list_add_tail(&skb->list, &sublist);
 	}
@@ -5148,7 +5148,7 @@ static void netif_receive_skb_list_inter
 		rcu_read_lock();
 		list_for_each_entry_safe(skb, next, head, list) {
 			xdp_prog = rcu_dereference(skb->dev->xdp_prog);
-			list_del(&skb->list);
+			skb_list_del_init(skb);
 			if (do_xdp_generic(xdp_prog, skb) == XDP_PASS)
 				list_add_tail(&skb->list, &sublist);
 		}
@@ -5167,7 +5167,7 @@ static void netif_receive_skb_list_inter
 
 			if (cpu >= 0) {
 				/* Will be handled, remove from list */
-				list_del(&skb->list);
+				skb_list_del_init(skb);
 				enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
 			}
 		}
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -551,7 +551,7 @@ static void ip_list_rcv_finish(struct ne
 	list_for_each_entry_safe(skb, next, head, list) {
 		struct dst_entry *dst;
 
-		list_del(&skb->list);
+		skb_list_del_init(skb);
 		/* if ingress device is enslaved to an L3 master device pass the
 		 * skb to its handler for processing
 		 */
@@ -598,7 +598,7 @@ void ip_list_rcv(struct list_head *head,
 		struct net_device *dev = skb->dev;
 		struct net *net = dev_net(dev);
 
-		list_del(&skb->list);
+		skb_list_del_init(skb);
 		skb = ip_rcv_core(skb, net);
 		if (skb == NULL)
 			continue;
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -95,7 +95,7 @@ static void ip6_list_rcv_finish(struct n
 	list_for_each_entry_safe(skb, next, head, list) {
 		struct dst_entry *dst;
 
-		list_del(&skb->list);
+		skb_list_del_init(skb);
 		/* if ingress device is enslaved to an L3 master device pass the
 		 * skb to its handler for processing
 		 */
@@ -295,7 +295,7 @@ void ipv6_list_rcv(struct list_head *hea
 		struct net_device *dev = skb->dev;
 		struct net *net = dev_net(dev);
 
-		list_del(&skb->list);
+		skb_list_del_init(skb);
 		skb = ip6_rcv_core(skb, dev, net);
 		if (skb == NULL)
 			continue;


