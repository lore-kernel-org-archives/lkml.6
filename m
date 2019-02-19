Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D79DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B04121904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FlHFQPR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfBSJjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:39:07 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:52104 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:39:05 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7DD6810C1A3B;
        Tue, 19 Feb 2019 01:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550569145; bh=Ov8YlC2lWgVVrMBMhFClxVkRw59bMNUxJGwN+PVozqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=FlHFQPR2swuRZfeVVcDEgOFHKxB7y88nMlHkrCjki/pNGvh6U6tbSrlHtVsofqgTn
         PXgd1XAqi2pihe6UCDxKstFeDLC5O5+ohOfWJnM5MMI6Kao1QwF8Uzc29TpUEGGNEV
         KBjmm47KBGBIYlggoYjbcTid7twcKT3AqYjG+Iu9XmFVN2EenlkvIhBgVbibzoUWM9
         mdQUfyXGvSbOHvDFFcjX3Apef4boHkDGwpe2i/DYe1t+JDw3tb6wld4fpsWnkNVXfA
         tCuVSK+ec8angqP0yncmSh+oVjWDGddzHUucJcCchwwXV8QX+zT8/G4U0paz6wbYDB
         FQt5oXCGIb7xg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id BA9D65A5F;
        Tue, 19 Feb 2019 01:39:03 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next v3 3/3] net: stmmac: dwxgmac2: Also use TBU interrupt to clean TX path
Date:   Tue, 19 Feb 2019 10:38:49 +0100
Message-Id: <f340b2995f920e671e838ab47db3c4d2193984bc.1550569066.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1550569066.git.joabreu@synopsys.com>
References: <cover.1550569066.git.joabreu@synopsys.com>
In-Reply-To: <cover.1550569066.git.joabreu@synopsys.com>
References: <cover.1550569066.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TBU interrupt is a normal interrupt and can be used to trigger the
cleaning of TX path. Lets check if it's active in DMA interrupt handler.

While at it, refactor a little bit the function:
	- Don't check if RI is enabled because at function exit we will
	  only clear the interrupts that are enabled so, no event will
	  be missed.

In my tests withe XGMAC2 this increased performance.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 4 +++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 8 +++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index d6bb953685fa..37d5e6fe7473 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -193,9 +193,10 @@
 #define XGMAC_AIE			BIT(14)
 #define XGMAC_RBUE			BIT(7)
 #define XGMAC_RIE			BIT(6)
+#define XGMAC_TBUE			BIT(2)
 #define XGMAC_TIE			BIT(0)
 #define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
-					XGMAC_RIE | XGMAC_TIE)
+					XGMAC_RIE | XGMAC_TBUE | XGMAC_TIE)
 #define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
 #define XGMAC_RWT			GENMASK(7, 0)
 #define XGMAC_DMA_CH_STATUS(x)		(0x00003160 + (0x80 * (x)))
@@ -204,6 +205,7 @@
 #define XGMAC_FBE			BIT(12)
 #define XGMAC_RBU			BIT(7)
 #define XGMAC_RI			BIT(6)
+#define XGMAC_TBU			BIT(2)
 #define XGMAC_TPS			BIT(1)
 #define XGMAC_TI			BIT(0)
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index c5e25580a43f..2ba712b48a89 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -283,12 +283,10 @@ static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
 		x->normal_irq_n++;
 
 		if (likely(intr_status & XGMAC_RI)) {
-			if (likely(intr_en & XGMAC_RIE)) {
-				x->rx_normal_irq_n++;
-				ret |= handle_rx;
-			}
+			x->rx_normal_irq_n++;
+			ret |= handle_rx;
 		}
-		if (likely(intr_status & XGMAC_TI)) {
+		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
 			x->tx_normal_irq_n++;
 			ret |= handle_tx;
 		}
-- 
2.7.4

