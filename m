Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2030C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E5521523
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2k1wNTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E5521523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJHWjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeJHWjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94ECB2150B;
        Mon,  8 Oct 2018 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012409;
        bh=S4/bMoIx4NOX+2XS9xjxwBWZsSyOZCgTtg2kSZs048k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2k1wNTTwLWK5gyJanhp1IStSNVxUhTyIECyb4i8wEnxc0KGxoHymAqqAqCeaNvPr
         20Nhu8xPOQD7rNLNdnCJEZSINjXsEI6UvFh7zVbqMgOxjG/yWPjk9Eto6W6Tr06QvO
         +kLfmsXF2US85J27nYKni8V2s0PPWE5fym63Sg+0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/32] ravb: do not write 1 to reserved bits
Date:   Mon,  8 Oct 2018 11:26:17 -0400
Message-Id: <20181008152629.70812-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

[ Upstream commit 2fe397a3959de8a472f165e6d152f64cb77fa2cc ]

EtherAVB hardware requires 0 to be written to status register bits in
order to clear them, however, care must be taken not to:

1. Clear other bits, by writing zero to them
2. Write one to reserved bits

This patch corrects the ravb driver with respect to the second point above.
This is done by defining reserved bit masks for the affected registers and,
after auditing the code, ensure all sites that may write a one to a
reserved bit use are suitably masked.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  5 +++++
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++++-----
 drivers/net/ethernet/renesas/ravb_ptp.c  |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 96a27b00c90e..897bd33c2c50 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -431,6 +431,7 @@ enum EIS_BIT {
 	EIS_CULF1	= 0x00000080,
 	EIS_TFFF	= 0x00000100,
 	EIS_QFS		= 0x00010000,
+	EIS_RESERVED	= (GENMASK(31, 17) | GENMASK(15, 11)),
 };
 
 /* RIC0 */
@@ -475,6 +476,7 @@ enum RIS0_BIT {
 	RIS0_FRF15	= 0x00008000,
 	RIS0_FRF16	= 0x00010000,
 	RIS0_FRF17	= 0x00020000,
+	RIS0_RESERVED	= GENMASK(31, 18),
 };
 
 /* RIC1 */
@@ -531,6 +533,7 @@ enum RIS2_BIT {
 	RIS2_QFF16	= 0x00010000,
 	RIS2_QFF17	= 0x00020000,
 	RIS2_RFFF	= 0x80000000,
+	RIS2_RESERVED	= GENMASK(30, 18),
 };
 
 /* TIC */
@@ -547,6 +550,7 @@ enum TIS_BIT {
 	TIS_FTF1	= 0x00000002,	/* Undocumented? */
 	TIS_TFUF	= 0x00000100,
 	TIS_TFWF	= 0x00000200,
+	TIS_RESERVED	= (GENMASK(31, 20) | GENMASK(15, 12) | GENMASK(7, 4))
 };
 
 /* ISS */
@@ -620,6 +624,7 @@ enum GIC_BIT {
 enum GIS_BIT {
 	GIS_PTCF	= 0x00000001,	/* Undocumented? */
 	GIS_PTMF	= 0x00000004,
+	GIS_RESERVED	= GENMASK(15, 10),
 };
 
 /* GIE (R-Car Gen3 only) */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e87a779bfcfe..ff3a293ffe36 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -721,10 +721,11 @@ static void ravb_error_interrupt(struct net_device *ndev)
 	u32 eis, ris2;
 
 	eis = ravb_read(ndev, EIS);
-	ravb_write(ndev, ~EIS_QFS, EIS);
+	ravb_write(ndev, ~(EIS_QFS | EIS_RESERVED), EIS);
 	if (eis & EIS_QFS) {
 		ris2 = ravb_read(ndev, RIS2);
-		ravb_write(ndev, ~(RIS2_QFF0 | RIS2_RFFF), RIS2);
+		ravb_write(ndev, ~(RIS2_QFF0 | RIS2_RFFF | RIS2_RESERVED),
+			   RIS2);
 
 		/* Receive Descriptor Empty int */
 		if (ris2 & RIS2_QFF0)
@@ -777,7 +778,7 @@ static bool ravb_timestamp_interrupt(struct net_device *ndev)
 	u32 tis = ravb_read(ndev, TIS);
 
 	if (tis & TIS_TFUF) {
-		ravb_write(ndev, ~TIS_TFUF, TIS);
+		ravb_write(ndev, ~(TIS_TFUF | TIS_RESERVED), TIS);
 		ravb_get_tx_tstamp(ndev);
 		return true;
 	}
@@ -912,7 +913,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 		/* Processing RX Descriptor Ring */
 		if (ris0 & mask) {
 			/* Clear RX interrupt */
-			ravb_write(ndev, ~mask, RIS0);
+			ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
 			if (ravb_rx(ndev, &quota, q))
 				goto out;
 		}
@@ -920,7 +921,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 		if (tis & mask) {
 			spin_lock_irqsave(&priv->lock, flags);
 			/* Clear TX interrupt */
-			ravb_write(ndev, ~mask, TIS);
+			ravb_write(ndev, ~(mask | TIS_RESERVED), TIS);
 			ravb_tx_free(ndev, q, true);
 			netif_wake_subqueue(ndev, q);
 			mmiowb();
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index eede70ec37f8..9e3222fd69f9 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -319,7 +319,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 		}
 	}
 
-	ravb_write(ndev, ~gis, GIS);
+	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
 void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
-- 
2.17.1

