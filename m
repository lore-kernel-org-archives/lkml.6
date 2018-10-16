Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81CEC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688F92098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwiY2m5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688F92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeJQBDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbeJQBDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE7220866;
        Tue, 16 Oct 2018 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709914;
        bh=ZinZamEaTbSjpRi7+dRq9JizfbinPQKBUy+j6wDR5ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwiY2m5gQJomwDe27btuSrVzcoTEPqfGJSUL1tIu6rDddCuiW2jS4pcFiv2c64c+D
         +CuLhfvECy7t50ZjfM2DbBmLVUetEL8Je9/si+lVOkRHv+4ODXLxNM8wrUoNKaWAI8
         FVqD5GY1U1XOSnbTutGI0ZGIis3Z7hnxqE51WbaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3fde91d4d394747d6db4@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 004/135] ip6_tunnel: be careful when accessing the inner header
Date:   Tue, 16 Oct 2018 19:03:54 +0200
Message-Id: <20181016170515.840573799@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 76c0ddd8c3a683f6e2c6e60e11dc1a1558caf4bc ]

the ip6 tunnel xmit ndo assumes that the processed skb always
contains an ip[v6] header, but syzbot has found a way to send
frames that fall short of this assumption, leading to the following splat:

BUG: KMSAN: uninit-value in ip6ip6_tnl_xmit net/ipv6/ip6_tunnel.c:1307
[inline]
BUG: KMSAN: uninit-value in ip6_tnl_start_xmit+0x7d2/0x1ef0
net/ipv6/ip6_tunnel.c:1390
CPU: 0 PID: 4504 Comm: syz-executor558 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  ip6ip6_tnl_xmit net/ipv6/ip6_tunnel.c:1307 [inline]
  ip6_tnl_start_xmit+0x7d2/0x1ef0 net/ipv6/ip6_tunnel.c:1390
  __netdev_start_xmit include/linux/netdevice.h:4066 [inline]
  netdev_start_xmit include/linux/netdevice.h:4075 [inline]
  xmit_one net/core/dev.c:3026 [inline]
  dev_hard_start_xmit+0x5f1/0xc70 net/core/dev.c:3042
  __dev_queue_xmit+0x27ee/0x3520 net/core/dev.c:3557
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3590
  packet_snd net/packet/af_packet.c:2944 [inline]
  packet_sendmsg+0x7c70/0x8a30 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmmsg+0x42d/0x800 net/socket.c:2136
  SYSC_sendmmsg+0xc4/0x110 net/socket.c:2167
  SyS_sendmmsg+0x63/0x90 net/socket.c:2162
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x441819
RSP: 002b:00007ffe58ee8268 EFLAGS: 00000213 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441819
RDX: 0000000000000002 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00000000006cd018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000402510
R13: 00000000004025a0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2737 [inline]
  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:984 [inline]
  alloc_skb_with_frags+0x1d4/0xb20 net/core/skbuff.c:5234
  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2085
  packet_alloc_skb net/packet/af_packet.c:2803 [inline]
  packet_snd net/packet/af_packet.c:2894 [inline]
  packet_sendmsg+0x6454/0x8a30 net/packet/af_packet.c:2969
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmmsg+0x42d/0x800 net/socket.c:2136
  SYSC_sendmmsg+0xc4/0x110 net/socket.c:2167
  SyS_sendmmsg+0x63/0x90 net/socket.c:2162
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

This change addresses the issue adding the needed check before
accessing the inner header.

The ipv4 side of the issue is apparently there since the ipv4 over ipv6
initial support, and the ipv6 side predates git history.

Fixes: c4d3efafcc93 ("[IPV6] IP6TUNNEL: Add support to IPv4 over IPv6 tunnel.")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+3fde91d4d394747d6db4@syzkaller.appspotmail.com
Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1226,7 +1226,7 @@ static inline int
 ip4ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	const struct iphdr  *iph = ip_hdr(skb);
+	const struct iphdr  *iph;
 	int encap_limit = -1;
 	struct flowi6 fl6;
 	__u8 dsfield;
@@ -1234,6 +1234,11 @@ ip4ip6_tnl_xmit(struct sk_buff *skb, str
 	u8 tproto;
 	int err;
 
+	/* ensure we can access the full inner ip header */
+	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		return -1;
+
+	iph = ip_hdr(skb);
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
 	tproto = READ_ONCE(t->parms.proto);
@@ -1297,7 +1302,7 @@ static inline int
 ip6ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	struct ipv6hdr *ipv6h;
 	int encap_limit = -1;
 	__u16 offset;
 	struct flowi6 fl6;
@@ -1306,6 +1311,10 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, str
 	u8 tproto;
 	int err;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
+		return -1;
+
+	ipv6h = ipv6_hdr(skb);
 	tproto = READ_ONCE(t->parms.proto);
 	if ((tproto != IPPROTO_IPV6 && tproto != 0) ||
 	    ip6_tnl_addr_conflict(t, ipv6h))


