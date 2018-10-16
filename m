Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68656C5ACC8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D0B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAmlxPPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D0B2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeJQBDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeJQBDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8748A20866;
        Tue, 16 Oct 2018 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709934;
        bh=3ORUG0ozdIxf3cK5JBYwXuGwocc+dxDHawtIpCeFt5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAmlxPPop+X/xQTpHeqUFIf9coJe4+F20Hyp9ChEUO0QY1CKgx6tMQiJg5itpM6T8
         rbGJEQSfnVDhLs4TZV/BK0Yn/vyLQOe3kD5FJY67m6HMxWXxfALUivB7PdXfQz1xXr
         zW5kv40YQlZPrH7dnWKHBMYMNJoK0fEQUjWCcHx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Soltys <soltys@ziu.info>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 039/135] bonding: pass link-local packets to bonding master also.
Date:   Tue, 16 Oct 2018 19:04:29 +0200
Message-Id: <20181016170517.590028583@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1178,9 +1178,26 @@ static rx_handler_result_t bond_handle_f
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
 


