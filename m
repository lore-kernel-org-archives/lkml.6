Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03017C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905CE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqafYOtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905CE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeJPMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbeJPMCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FEB421486;
        Tue, 16 Oct 2018 04:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663269;
        bh=Fgfz/npDeDg8qZch0SvinRjOgYROE6XrFulxksFM3uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QqafYOtSxBBaUjHJNWlfEI8oiGxFAJdzFibZ5c8Iy5BGfbLJ9wCuMYd8NbKotItl+
         PLsS4w/XHnnFftBay8erDYeEQD+iUjMyDXgPzfvFu2TCoXlEJgurKWTeJBEQ9OwQqH
         WgQibuWaqNtRn6NIKieuQVZ9CWYrCAx+YXK9L26o=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 28/61] bonding: pass link-local packets to bonding master also.
Date:   Tue, 16 Oct 2018 00:13:30 -0400
Message-Id: <20181016041403.135678-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 6a9e461f6fe4434e6172304b69774daff9a3ac4c ]

Commit b89f04c61efe ("bonding: deliver link-local packets with
skb->dev set to link that packets arrived on") changed the behavior
of how link-local-multicast packets are processed. The change in
the behavior broke some legacy use cases where these packets are
expected to arrive on bonding master device also.

This patch passes the packet to the stack with the link it arrived
on as well as passes to the bonding-master device to preserve the
legacy use case.

Fixes: b89f04c61efe ("bonding: deliver link-local packets with skb->dev set to link that packets arrived on")
Reported-by: Michal Soltys <soltys@ziu.info>
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 15aedb64a02b..4cee9c5b2d5f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1176,9 +1176,26 @@ static rx_handler_result_t bond_handle_frame(struct sk_buff **pskb)
 		}
 	}
 
-	/* don't change skb->dev for link-local packets */
-	if (is_link_local_ether_addr(eth_hdr(skb)->h_dest))
+	/* Link-local multicast packets should be passed to the
+	 * stack on the link they arrive as well as pass them to the
+	 * bond-master device. These packets are mostly usable when
+	 * stack receives it with the link on which they arrive
+	 * (e.g. LLDP) they also must be available on master. Some of
+	 * the use cases include (but are not limited to): LLDP agents
+	 * that must be able to operate both on enslaved interfaces as
+	 * well as on bonds themselves; linux bridges that must be able
+	 * to process/pass BPDUs from attached bonds when any kind of
+	 * STP version is enabled on the network.
+	 */
+	if (is_link_local_ether_addr(eth_hdr(skb)->h_dest)) {
+		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+
+		if (nskb) {
+			nskb->dev = bond->dev;
+			netif_rx(nskb);
+		}
 		return RX_HANDLER_PASS;
+	}
 	if (bond_should_deliver_exact_match(skb, slave, bond))
 		return RX_HANDLER_EXACT;
 
-- 
2.17.1

