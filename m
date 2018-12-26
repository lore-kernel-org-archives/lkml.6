Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77DAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EBA218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864090;
	bh=lEuLbH9Yd4L96+Je7E+z6jJ99MfKux6Eowdf90mOoFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ilFNypvvotiKEcBxyJdWj5D4W21hmE/yveO1xCylSXjDy0f4j6inbi/8xs0ggJLHO
	 NrOGO74s3bh8kbxf+cKAMrFDZxoa9pUfYvREXyapwp2IUicqx5194kdG6FiZQsCq+v
	 4FU9+bawJB+6MRoQI1mt5GK9b0eDiAoLgsdQ5xGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeLZWl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbeLZWlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23EC218EA;
        Wed, 26 Dec 2018 22:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864083;
        bh=lEuLbH9Yd4L96+Je7E+z6jJ99MfKux6Eowdf90mOoFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDe8la1DrL2KxgYS3H+hhe9L4lI1tBGNYJqjTYVwYTkWemdGtlRPIf33+M/vURN8u
         CZWH2aX0tVc7cTVXrY0FUesTf4NeI5ZElUOPEc3mBvLrypAgZBk1gMn8IYf7q5w8/x
         xGjZCPo3lrN/hQ7tChlBx9aHThl8rWeLxaMnagck=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anssi Hannula <anssi.hannula@bitwise.fi>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 47/59] net: macb: fix dropped RX frames due to a race
Date:   Wed, 26 Dec 2018 17:38:27 -0500
Message-Id: <20181226223839.150262-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

[ Upstream commit 8159ecab0db9095902d4c73605fb8787f5c7d653 ]

Bit RX_USED set to 0 in the address field allows the controller to write
data to the receive buffer descriptor.

The driver does not ensure the ctrl field is ready (cleared) when the
controller sees the RX_USED=0 written by the driver. The ctrl field might
only be cleared after the controller has already updated it according to
a newly received frame, causing the frame to be discarded in gem_rx() due
to unexpected ctrl field contents.

A message is logged when the above scenario occurs:

  macb ff0b0000.ethernet eth0: not whole frame pointed by descriptor

Fix the issue by ensuring that when the controller sees RX_USED=0 the
ctrl field is already cleared.

This issue was observed on a ZynqMP based system.

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index db5be65b2553..50101ca1e35f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -922,14 +922,19 @@ static void gem_rx_refill(struct macb *bp)
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
-			macb_set_addr(bp, desc, paddr);
 			desc->ctrl = 0;
+			/* Setting addr clears RX_USED and allows reception,
+			 * make sure ctrl is cleared first to avoid a race.
+			 */
+			dma_wmb();
+			macb_set_addr(bp, desc, paddr);
 
 			/* properly align Ethernet header */
 			skb_reserve(skb, NET_IP_ALIGN);
 		} else {
-			desc->addr &= ~MACB_BIT(RX_USED);
 			desc->ctrl = 0;
+			dma_wmb();
+			desc->addr &= ~MACB_BIT(RX_USED);
 		}
 	}
 
-- 
2.19.1

