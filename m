Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeBIQXU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:23:20 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:49982 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeBIQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:23:19 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: stmmac: remove redundant enable of PMT irq
Date: Fri,  9 Feb 2018 17:22:47 +0100
Message-Id: <20180209162247.3724-4-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180209162247.3724-1-niklas.cassel@axis.com>
References: <20180209162247.3724-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dwmac4, GMAC_INT_DEFAULT_ENABLE already includes
GMAC_INT_PMT_EN, so it is redundant to check if hw->pmt
is set, and if so, setting the bit again.

For dwmac1000, GMAC_INT_DEFAULT_MASK does not include
GMAC_INT_DISABLE_PMT, so it is redundant to check if
hw->pmt is set, and if so, clearing an already cleared bit.

Improve code readability by removing this redundant code.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 --
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 540d21786a43..ef10baf14186 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -74,8 +74,6 @@ static void dwmac1000_core_init(struct mac_device_info *hw,
 	/* Mask GMAC interrupts */
 	value = GMAC_INT_DEFAULT_MASK;
 
-	if (hw->pmt)
-		value &= ~GMAC_INT_DISABLE_PMT;
 	if (hw->pcs)
 		value &= ~GMAC_INT_DISABLE_PCS;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6badc63d8e6d..63795ecafc8d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -63,8 +63,7 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 
 	/* Enable GMAC interrupts */
 	value = GMAC_INT_DEFAULT_ENABLE;
-	if (hw->pmt)
-		value |= GMAC_INT_PMT_EN;
+
 	if (hw->pcs)
 		value |= GMAC_PCS_IRQ_DEFAULT;
 
-- 
2.14.2
