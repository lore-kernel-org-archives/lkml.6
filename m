Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbeBSRMC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:12:02 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38928 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbeBSRL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:59 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/7] net: stmmac: honor error code from stmmac_dt_phy()
Date: Mon, 19 Feb 2018 18:11:15 +0100
Message-Id: <20180219171116.15326-8-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Honor error code from stmmac_dt_phy() instead of always
returning -ENODEV.

No functional change intended.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index bcfac84cf6fb..ebd3e5ffa73c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -417,8 +417,9 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
 	/* To Configure PHY by using all device-tree supported properties */
-	if (stmmac_dt_phy(plat, np, &pdev->dev))
-		return ERR_PTR(-ENODEV);
+	rc = stmmac_dt_phy(plat, np, &pdev->dev);
+	if (rc)
+		return ERR_PTR(rc);
 
 	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
 
-- 
2.14.2
