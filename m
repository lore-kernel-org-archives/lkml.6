Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeBIQXH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:23:07 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:49954 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbeBIQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:23:04 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: stmmac: discard disabled flags in interrupt status register
Date: Fri,  9 Feb 2018 17:22:45 +0100
Message-Id: <20180209162247.3724-2-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180209162247.3724-1-niklas.cassel@axis.com>
References: <20180209162247.3724-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt status register in both dwmac1000 and dwmac4 ignores
interrupt enable (for dwmac4) / interrupt mask (for dwmac1000).
Therefore, if we want to check only the bits that can actually trigger
an irq, we have to filter the interrupt status register manually.

Commit 0a764db10337 ("stmmac: Discard masked flags in interrupt status
register") fixed this for dwmac1000. Fix the same issue for dwmac4.

Just like commit 0a764db10337 ("stmmac: Discard masked flags in
interrupt status register"), this makes sure that we do not get
spurious link up/link down prints.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index ed222b20fcf1..1e0a7668b752 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -572,10 +572,12 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 			     struct stmmac_extra_stats *x)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 intr_status;
+	u32 intr_status = readl(ioaddr + GMAC_INT_STATUS);
+	u32 intr_enable = readl(ioaddr + GMAC_INT_EN);
 	int ret = 0;
 
-	intr_status = readl(ioaddr + GMAC_INT_STATUS);
+	/* Discard disabled bits */
+	intr_status &= intr_enable;
 
 	/* Not used events (e.g. MMC interrupts) are not handled. */
 	if ((intr_status & mmc_tx_irq))
-- 
2.14.2
