Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5859C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CABE20895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CABE20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404765AbeHGVQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:16:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404680AbeHGVQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:16:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 10D0774;
        Tue,  7 Aug 2018 19:00:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 73/85] ipv4: remove BUG_ON() from fib_compute_spec_dst
Date:   Tue,  7 Aug 2018 20:52:15 +0200
Message-Id: <20180807172400.073372311@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 9fc12023d6f51551d6ca9ed7e02ecc19d79caf17 ]

Remove BUG_ON() from fib_compute_spec_dst routine and check
in_dev pointer during flowi4 data structure initialization.
fib_compute_spec_dst routine can be run concurrently with device removal
where ip_ptr net_device pointer is set to NULL. This can happen
if userspace enables pkt info on UDP rx socket and the device
is removed while traffic is flowing

Fixes: 35ebf65e851c ("ipv4: Create and use fib_compute_spec_dst() helper")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_frontend.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -209,19 +209,19 @@ __be32 fib_compute_spec_dst(struct sk_bu
 		return ip_hdr(skb)->daddr;
 
 	in_dev = __in_dev_get_rcu(dev);
-	BUG_ON(!in_dev);
 
 	net = dev_net(dev);
 
 	scope = RT_SCOPE_UNIVERSE;
 	if (!ipv4_is_zeronet(ip_hdr(skb)->saddr)) {
+		bool vmark = in_dev && IN_DEV_SRC_VMARK(in_dev);
 		fl4.flowi4_oif = 0;
 		fl4.flowi4_iif = LOOPBACK_IFINDEX;
 		fl4.daddr = ip_hdr(skb)->saddr;
 		fl4.saddr = 0;
 		fl4.flowi4_tos = RT_TOS(ip_hdr(skb)->tos);
 		fl4.flowi4_scope = scope;
-		fl4.flowi4_mark = IN_DEV_SRC_VMARK(in_dev) ? skb->mark : 0;
+		fl4.flowi4_mark = vmark ? skb->mark : 0;
 		if (!fib_lookup(net, &fl4, &res))
 			return FIB_RES_PREFSRC(net, res);
 	} else {


