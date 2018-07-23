Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D18ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE51220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbeGWNaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:30:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbeGWNap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:30:45 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17C98C19;
        Mon, 23 Jul 2018 12:29:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 31/44] net/ipv4: Set oif in fib_compute_spec_dst
Date:   Mon, 23 Jul 2018 14:25:07 +0200
Message-Id: <20180723122438.968786262@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit e7372197e15856ec4ee66b668020a662994db103 ]

Xin reported that icmp replies may not use the address on the device the
echo request is received if the destination address is broadcast. Instead
a route lookup is done without considering VRF context. Fix by setting
oif in flow struct to the master device if it is enslaved. That directs
the lookup to the VRF table. If the device is not enslaved, oif is still
0 so no affect.

Fixes: cd2fbe1b6b51 ("net: Use VRF device index for lookups on RX")
Reported-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_frontend.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -290,6 +290,7 @@ __be32 fib_compute_spec_dst(struct sk_bu
 	if (!ipv4_is_zeronet(ip_hdr(skb)->saddr)) {
 		struct flowi4 fl4 = {
 			.flowi4_iif = LOOPBACK_IFINDEX,
+			.flowi4_oif = l3mdev_master_ifindex_rcu(dev),
 			.daddr = ip_hdr(skb)->saddr,
 			.flowi4_tos = RT_TOS(ip_hdr(skb)->tos),
 			.flowi4_scope = scope,


