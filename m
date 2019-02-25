Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2829EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FD621841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129827;
	bh=+KCY/EKhA3/TN4w/bBDm3+2hH15K3+o3qQf38++L0cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DlopBD2bkPHLX+72C4AtjyZkEgX3D/k/US4YnEa63JarmICqF5h/FfL176bxz6Gdp
	 L8a4Y4kXUNfWwIog4HhX6eEyB3cqo2G2YIoq4HpQggUVfLTLWDrjnegSFoDGPtk1Jk
	 N4h0vrSoJerWvhAwHvS2PaNH8bzzj1fodQBPD508=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfBYVXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbfBYVXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2618C21850;
        Mon, 25 Feb 2019 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129822;
        bh=+KCY/EKhA3/TN4w/bBDm3+2hH15K3+o3qQf38++L0cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUwLNxZPo1TxbeSTy5cJTjZHrryWbkRrZAfLXiIdTa7LV6RAmGBSE+ER0SQKlzJKt
         lcUJ2oC42oxak7GRObeDsnnOn+Iesm3a2lhWHx2OAu1MmCdwiAVKm+j35vcWrphPWv
         +Q5KejokSOJdDHQqcV+TeBf/wnzZBcxub6PZ2/Gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Pinto <jpinto@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/152] net: stmmac: dwxgmac2: Only clear interrupts that are active
Date:   Mon, 25 Feb 2019 22:10:53 +0100
Message-Id: <20190225195047.667016894@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 20909036e0028..1c39305274440 100644
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



