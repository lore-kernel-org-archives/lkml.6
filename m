Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97954C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D4C21929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tq8DXC9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395034AbfBONmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:42:53 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43898 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBONmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:42:52 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 65C6B10C107D;
        Fri, 15 Feb 2019 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550238172; bh=VpbMwFSjKIjoga2jnTw3hNoJo6MpSF4+usQFNCdJYtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Tq8DXC9vkEbc0V1ftRWSCnf84rfaYQzfwndBIj7hFZr+CZAWWDC40jT0be540BrGT
         qIhbAx66IMpDr8SWMO9Zkl3obdcmFViUHyAaazf4fcykXFQCN4k9GtzYGRICf60rec
         iaJgKSBUtDPHHYfl3/nSt7wlJ4FdQrpqgctqW9TbBvUXCa5xHyP96vGdsrkIbY1AFA
         Uvm+AA5NEA4W0hXcTfeqCLJS/jVXyJMLwMfGyJZb3WCQ7DkiEhFvN9nx3cA8lqvobk
         nYUNWHmc0XVPL479AOjYGNqmunb5fMwkADIkRcYjjVJNCPsoHX1tKvowirF1A7DXjo
         QeSYuSxRfa5WA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 06E0F5349;
        Fri, 15 Feb 2019 05:42:20 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 2/3] net: stmmac: dwmac4: Also use TBU interrupt to clean TX path
Date:   Fri, 15 Feb 2019 14:42:06 +0100
Message-Id: <7381bc27f8268376345f60d1996734805257354c.1550237884.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1550237884.git.joabreu@synopsys.com>
References: <cover.1550237884.git.joabreu@synopsys.com>
In-Reply-To: <cover.1550237884.git.joabreu@synopsys.com>
References: <cover.1550237884.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TBU interrupt is a normal interrupt and can be used to trigger the
cleaning of TX path. Lets check if it's active in DMA interrupt handler.

While at it, refactor a little bit the function:
	- Don't check if RI is enabled because at function exit we will
	  only clear the interrupts that are enabled so, no event will be
	  missed.

In my tests with GMAC5 this increased performance.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 49f5687879df..545cb9c47433 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -124,9 +124,9 @@ void dwmac4_disable_dma_irq(void __iomem *ioaddr, u32 chan)
 int dwmac4_dma_interrupt(void __iomem *ioaddr,
 			 struct stmmac_extra_stats *x, u32 chan)
 {
-	int ret = 0;
-
 	u32 intr_status = readl(ioaddr + DMA_CHAN_STATUS(chan));
+	u32 intr_en = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
+	int ret = 0;
 
 	/* ABNORMAL interrupts */
 	if (unlikely(intr_status & DMA_CHAN_STATUS_AIS)) {
@@ -151,16 +151,11 @@ int dwmac4_dma_interrupt(void __iomem *ioaddr,
 	if (likely(intr_status & DMA_CHAN_STATUS_NIS)) {
 		x->normal_irq_n++;
 		if (likely(intr_status & DMA_CHAN_STATUS_RI)) {
-			u32 value;
-
-			value = readl(ioaddr + DMA_CHAN_INTR_ENA(chan));
-			/* to schedule NAPI on real RIE event. */
-			if (likely(value & DMA_CHAN_INTR_ENA_RIE)) {
-				x->rx_normal_irq_n++;
-				ret |= handle_rx;
-			}
+			x->rx_normal_irq_n++;
+			ret |= handle_rx;
 		}
-		if (likely(intr_status & DMA_CHAN_STATUS_TI)) {
+		if (likely(intr_status & (DMA_CHAN_STATUS_TI |
+					  DMA_CHAN_STATUS_TBU))) {
 			x->tx_normal_irq_n++;
 			ret |= handle_tx;
 		}
@@ -168,12 +163,7 @@ int dwmac4_dma_interrupt(void __iomem *ioaddr,
 			x->rx_early_irq++;
 	}
 
-	/* Clear the interrupt by writing a logic 1 to the chanX interrupt
-	 * status [21-0] expect reserved bits [5-3]
-	 */
-	writel((intr_status & 0x3fffc7),
-	       ioaddr + DMA_CHAN_STATUS(chan));
-
+	writel(intr_status & intr_en, ioaddr + DMA_CHAN_STATUS(chan));
 	return ret;
 }
 
-- 
2.7.4

