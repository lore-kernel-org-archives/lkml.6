Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A73EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BC621934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026402;
	bh=EDXyxqQCAaFM61DsAbgJutfrzYfxK+zK5/r8bnlIq3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zvb0icF+wCmU8qb71ZnaRNkdnus1TgEYgaxH+MkTAw30oKJ4ufFK/CW7X2mgB4uyA
	 naf3qAtsWRYv7rc/AjbbjrtEq4Y3v4dAgE6alcw1zRf79uIm7FRraKikOi/ej+g076
	 iCURDpiSoDM1jEbhL3JVytSi4njPdVfo+7WZ9I7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbfBMCxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfBMCiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83FA206B6;
        Wed, 13 Feb 2019 02:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025499;
        bh=EDXyxqQCAaFM61DsAbgJutfrzYfxK+zK5/r8bnlIq3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Neo8hoqqihP46NsZ9zuhDn0+O/HAX1NrJjm1GW0q/0jCQCX0PoIRYwHy5AHbYUXPS
         r+7Aq0t1C2pwc9RJ6uk41a8snw7MPDpMIcalHWMLCog0lQqIO1rjHxsA1afRXVaA3P
         7kYxBt3JtOMcj6xrm6Fe3d/Yy0xn6jw3GYuIZU0s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 46/83] net: stmmac: dwxgmac2: Only clear interrupts that are active
Date:   Tue, 12 Feb 2019 21:36:24 -0500
Message-Id: <20190213023701.20286-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <jose.abreu@synopsys.com>

[ Upstream commit fcc509eb10ff4794641e6ad3082118287a750d0a ]

In DMA interrupt handler we were clearing all interrupts status, even
the ones that were not active. Fix this and only clear the active
interrupts.

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 20909036e002..1c3930527444 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -260,6 +260,7 @@ static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
 				  struct stmmac_extra_stats *x, u32 chan)
 {
 	u32 intr_status = readl(ioaddr + XGMAC_DMA_CH_STATUS(chan));
+	u32 intr_en = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 	int ret = 0;
 
 	/* ABNORMAL interrupts */
@@ -279,8 +280,7 @@ static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
 		x->normal_irq_n++;
 
 		if (likely(intr_status & XGMAC_RI)) {
-			u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
-			if (likely(value & XGMAC_RIE)) {
+			if (likely(intr_en & XGMAC_RIE)) {
 				x->rx_normal_irq_n++;
 				ret |= handle_rx;
 			}
@@ -292,7 +292,7 @@ static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
 	}
 
 	/* Clear interrupts */
-	writel(~0x0, ioaddr + XGMAC_DMA_CH_STATUS(chan));
+	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
 
 	return ret;
 }
-- 
2.19.1

