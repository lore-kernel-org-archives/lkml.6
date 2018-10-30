Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC58AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEF620827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEF620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJ3SYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:24:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJ3SYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:24:32 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1gHQNB-0003Lk-Dn; Tue, 30 Oct 2018 10:31:41 +0100
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 1/2] net: axienet: recheck condition after timeout in mdio_wait()
Date:   Tue, 30 Oct 2018 10:31:38 +0100
Message-Id: <20181030093139.10226-2-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181030093139.10226-1-kurt@linutronix.de>
References: <20181030093139.10226-1-kurt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function could report a false positive if it gets preempted between reading
the XAE_MDIO_MCR_OFFSET register and checking for the timeout.  In such a case,
the condition has to be rechecked to avoid false positives.

Therefore, check for expected condition even after the timeout occurred.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 757a3b37ae8a..4f13125e4942 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -21,15 +21,26 @@
 int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 {
 	unsigned long end = jiffies + 2;
-	while (!(axienet_ior(lp, XAE_MDIO_MCR_OFFSET) &
-		 XAE_MDIO_MCR_READY_MASK)) {
+	u32 val;
+
+	while (1) {
+		val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
+
+		if (val & XAE_MDIO_MCR_READY_MASK)
+			return 0;
+
 		if (time_before_eq(end, jiffies)) {
-			WARN_ON(1);
-			return -ETIMEDOUT;
+			val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
+			break;
 		}
+
 		udelay(1);
 	}
-	return 0;
+	if (val & XAE_MDIO_MCR_READY_MASK)
+		return 0;
+
+	WARN_ON(1);
+	return -ETIMEDOUT;
 }
 
 /**
-- 
2.11.0

