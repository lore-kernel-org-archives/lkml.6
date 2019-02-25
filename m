Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39981C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EB821848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130286;
	bh=2Bgbuc+tIi4yUTYYg4dxLkOl3rZq/EZ78QedHWtkXwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqvOprDGTxMBuep4BPz+AksHPVleAvHIrrztnxYKElBe6rS2jBWgYGfmCx+kmCZxm
	 2q0CYdHuD0vBdM/3Z0QbWRNLcyZVhMCfnKbijod7ct1MSEMX1BDk/W5pz96eoDzTIB
	 FZvqnhV0IuCihdCfvu5NjThDP+JGcDm/x40eJfjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfBYVbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbfBYVbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E440E217F5;
        Mon, 25 Feb 2019 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130281;
        bh=2Bgbuc+tIi4yUTYYg4dxLkOl3rZq/EZ78QedHWtkXwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjNPDEq1upPIxwXgUaFTdI4oe3Mewq2Bq+KVZRvsWwmB+0B/GKbcpdeyd1vCMy3k5
         wP4MQnQL1hW3PIOt08sTM8Szypli96bQ2KaqYlONrhGqp7sGvceAkzWDvVdYX1Q4RN
         dynhqmLiefElSJ3Z+YDcRkdKARtpNpO7Jo8tq2vg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 072/183] net: stmmac: dwxgmac2: Only clear interrupts that are active
Date:   Mon, 25 Feb 2019 22:10:45 +0100
Message-Id: <20190225195106.611833341@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6c5092e7771cd..c5e25580a43fa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -263,6 +263,7 @@ static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
 				  struct stmmac_extra_stats *x, u32 chan)
 {
 	u32 intr_status = readl(ioaddr + XGMAC_DMA_CH_STATUS(chan));
+	u32 intr_en = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 	int ret = 0;
 
 	/* ABNORMAL interrupts */
@@ -282,8 +283,7 @@ static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
 		x->normal_irq_n++;
 
 		if (likely(intr_status & XGMAC_RI)) {
-			u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
-			if (likely(value & XGMAC_RIE)) {
+			if (likely(intr_en & XGMAC_RIE)) {
 				x->rx_normal_irq_n++;
 				ret |= handle_rx;
 			}
@@ -295,7 +295,7 @@ static int dwxgmac2_dma_interrupt(void __iomem *ioaddr,
 	}
 
 	/* Clear interrupts */
-	writel(~0x0, ioaddr + XGMAC_DMA_CH_STATUS(chan));
+	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
 
 	return ret;
 }
-- 
2.19.1



