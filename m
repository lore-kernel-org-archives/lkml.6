Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30267C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA00214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789500;
	bh=+qRyDE4ulNHVcbtfTsVV3Ecj1ZyBXoy0s4iDaxfG+4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uK6Ng9U0ET7Ks79pWdKFCQ67GAuC0MzLB/TLRJN0HtOX10oIePTaTO0peKkMQcy+S
	 6i+mCw2a8yIBtKalzSx8KaiFcDq1tQnN2qZ9tKLpKvoKggo/FJXkH6Dz4/kT9kKXt3
	 ia7qh0QfRFgNRfbJGQSzcnZnSln1KjQ3eBONz++c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA00214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeLNMLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731795AbeLNMLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CEA21104;
        Fri, 14 Dec 2018 12:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789492;
        bh=+qRyDE4ulNHVcbtfTsVV3Ecj1ZyBXoy0s4iDaxfG+4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glhcvnCmxm9l9Qzkm3UYKYwJbmAtLbSbU2ki67hkhSJ58lTSygpTr2dgjAYAYHOAL
         tsw5mk+08PNOXI3WfopT+A9nKoAp6yrqB0TOlBPDIWh3VSpewfIwJ+hUhcCuOKqwem
         GUnT2BCQtt/D6PhPpSRbnkGMyMG1b4zPFSLOqUVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 02/51] ipv6: Check available headroom in ip6_xmit() even without options
Date:   Fri, 14 Dec 2018 13:00:04 +0100
Message-Id: <20181214115713.647593482@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 66033f47ca60294a95fc85ec3a3cc909dab7b765 ]

Even if we send an IPv6 packet without options, MAX_HEADER might not be
enough to account for the additional headroom required by alignment of
hardware headers.

On a configuration without HYPERV_NET, WLAN, AX25, and with IPV6_TUNNEL,
sending short SCTP packets over IPv4 over L2TP over IPv6, we start with
100 bytes of allocated headroom in sctp_packet_transmit(), end up with 54
bytes after l2tp_xmit_skb(), and 14 bytes in ip6_finish_output2().

Those would be enough to append our 14 bytes header, but we're going to
align that to 16 bytes, and write 2 bytes out of the allocated slab in
neigh_hh_output().

KASan says:

[  264.967848] ==================================================================
[  264.967861] BUG: KASAN: slab-out-of-bounds in ip6_finish_output2+0x1aec/0x1c70
[  264.967866] Write of size 16 at addr 000000006af1c7fe by task netperf/6201
[  264.967870]
[  264.967876] CPU: 0 PID: 6201 Comm: netperf Not tainted 4.20.0-rc4+ #1
[  264.967881] Hardware name: IBM 2827 H43 400 (z/VM 6.4.0)
[  264.967887] Call Trace:
[  264.967896] ([<00000000001347d6>] show_stack+0x56/0xa0)
[  264.967903]  [<00000000017e379c>] dump_stack+0x23c/0x290
[  264.967912]  [<00000000007bc594>] print_address_description+0xf4/0x290
[  264.967919]  [<00000000007bc8fc>] kasan_report+0x13c/0x240
[  264.967927]  [<000000000162f5e4>] ip6_finish_output2+0x1aec/0x1c70
[  264.967935]  [<000000000163f890>] ip6_finish_output+0x430/0x7f0
[  264.967943]  [<000000000163fe44>] ip6_output+0x1f4/0x580
[  264.967953]  [<000000000163882a>] ip6_xmit+0xfea/0x1ce8
[  264.967963]  [<00000000017396e2>] inet6_csk_xmit+0x282/0x3f8
[  264.968033]  [<000003ff805fb0ba>] l2tp_xmit_skb+0xe02/0x13e0 [l2tp_core]
[  264.968037]  [<000003ff80631192>] l2tp_eth_dev_xmit+0xda/0x150 [l2tp_eth]
[  264.968041]  [<0000000001220020>] dev_hard_start_xmit+0x268/0x928
[  264.968069]  [<0000000001330e8e>] sch_direct_xmit+0x7ae/0x1350
[  264.968071]  [<000000000122359c>] __dev_queue_xmit+0x2b7c/0x3478
[  264.968075]  [<00000000013d2862>] ip_finish_output2+0xce2/0x11a0
[  264.968078]  [<00000000013d9b14>] ip_finish_output+0x56c/0x8c8
[  264.968081]  [<00000000013ddd1e>] ip_output+0x226/0x4c0
[  264.968083]  [<00000000013dbd6c>] __ip_queue_xmit+0x894/0x1938
[  264.968100]  [<000003ff80bc3a5c>] sctp_packet_transmit+0x29d4/0x3648 [sctp]
[  264.968116]  [<000003ff80b7bf68>] sctp_outq_flush_ctrl.constprop.5+0x8d0/0xe50 [sctp]
[  264.968131]  [<000003ff80b7c716>] sctp_outq_flush+0x22e/0x7d8 [sctp]
[  264.968146]  [<000003ff80b35c68>] sctp_cmd_interpreter.isra.16+0x530/0x6800 [sctp]
[  264.968161]  [<000003ff80b3410a>] sctp_do_sm+0x222/0x648 [sctp]
[  264.968177]  [<000003ff80bbddac>] sctp_primitive_ASSOCIATE+0xbc/0xf8 [sctp]
[  264.968192]  [<000003ff80b93328>] __sctp_connect+0x830/0xc20 [sctp]
[  264.968208]  [<000003ff80bb11ce>] sctp_inet_connect+0x2e6/0x378 [sctp]
[  264.968212]  [<0000000001197942>] __sys_connect+0x21a/0x450
[  264.968215]  [<000000000119aff8>] sys_socketcall+0x3d0/0xb08
[  264.968218]  [<000000000184ea7a>] system_call+0x2a2/0x2c0

[...]

Just like ip_finish_output2() does for IPv4, check that we have enough
headroom in ip6_xmit(), and reallocate it if we don't.

This issue is older than git history.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -177,37 +177,37 @@ int ip6_xmit(const struct sock *sk, stru
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
+	unsigned int head_room;
 	struct ipv6hdr *hdr;
 	u8  proto = fl6->flowi6_proto;
 	int seg_len = skb->len;
 	int hlimit = -1;
 	u32 mtu;
 
-	if (opt) {
-		unsigned int head_room;
-
-		/* First: exthdrs may take lots of space (~8K for now)
-		   MAX_HEADER is not enough.
-		 */
-		head_room = opt->opt_nflen + opt->opt_flen;
-		seg_len += head_room;
-		head_room += sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dst->dev);
+	head_room = sizeof(struct ipv6hdr) + LL_RESERVED_SPACE(dst->dev);
+	if (opt)
+		head_room += opt->opt_nflen + opt->opt_flen;
 
-		if (skb_headroom(skb) < head_room) {
-			struct sk_buff *skb2 = skb_realloc_headroom(skb, head_room);
-			if (!skb2) {
-				IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-					      IPSTATS_MIB_OUTDISCARDS);
-				kfree_skb(skb);
-				return -ENOBUFS;
-			}
-			if (skb->sk)
-				skb_set_owner_w(skb2, skb->sk);
-			consume_skb(skb);
-			skb = skb2;
+	if (unlikely(skb_headroom(skb) < head_room)) {
+		struct sk_buff *skb2 = skb_realloc_headroom(skb, head_room);
+		if (!skb2) {
+			IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+				      IPSTATS_MIB_OUTDISCARDS);
+			kfree_skb(skb);
+			return -ENOBUFS;
 		}
+		if (skb->sk)
+			skb_set_owner_w(skb2, skb->sk);
+		consume_skb(skb);
+		skb = skb2;
+	}
+
+	if (opt) {
+		seg_len += opt->opt_nflen + opt->opt_flen;
+
 		if (opt->opt_flen)
 			ipv6_push_frag_opts(skb, opt, &proto);
+
 		if (opt->opt_nflen)
 			ipv6_push_nfrag_opts(skb, opt, &proto, &first_hop);
 	}


