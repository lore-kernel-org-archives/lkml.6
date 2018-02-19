Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeBSRMe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:12:34 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38937 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeBSRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:12:00 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/7] net: stmmac: add error handling in stmmac_mtl_setup()
Date: Mon, 19 Feb 2018 18:11:14 +0100
Message-Id: <20180219171116.15326-7-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree binding for stmmac says:

- Multiple TX Queues parameters: below the list of all the parameters to
                                 configure the multiple TX queues:
        - snps,tx-queues-to-use: number of TX queues to be used in the driver
	[...]
        - For each TX queue
		[...]

However, if one specifies snps,tx-queues-to-use = 2,
but omits the queue subnodes, or defines just one queue subnode,
since the driver appears to initialize queues with sane default
values, we will get tx queue timeouts.

This is because the initialization code only initializes
as many queues as it finds subnodes. Potentially leaving
some queues uninitialized.

To avoid hard to debug issues, return an error if the number
of subnodes differ from snps,tx-queues-to-use/snps,rx-queues-to-use.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 05f122b8424a..bcfac84cf6fb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -135,13 +135,14 @@ static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
  * stmmac_mtl_setup - parse DT parameters for multiple queues configuration
  * @pdev: platform device
  */
-static void stmmac_mtl_setup(struct platform_device *pdev,
-			     struct plat_stmmacenet_data *plat)
+static int stmmac_mtl_setup(struct platform_device *pdev,
+			    struct plat_stmmacenet_data *plat)
 {
 	struct device_node *q_node;
 	struct device_node *rx_node;
 	struct device_node *tx_node;
 	u8 queue = 0;
+	int ret = 0;
 
 	/* For backwards-compatibility with device trees that don't have any
 	 * snps,mtl-rx-config or snps,mtl-tx-config properties, we fall back
@@ -159,12 +160,12 @@ static void stmmac_mtl_setup(struct platform_device *pdev,
 
 	rx_node = of_parse_phandle(pdev->dev.of_node, "snps,mtl-rx-config", 0);
 	if (!rx_node)
-		return;
+		return ret;
 
 	tx_node = of_parse_phandle(pdev->dev.of_node, "snps,mtl-tx-config", 0);
 	if (!tx_node) {
 		of_node_put(rx_node);
-		return;
+		return ret;
 	}
 
 	/* Processing RX queues common config */
@@ -220,6 +221,11 @@ static void stmmac_mtl_setup(struct platform_device *pdev,
 
 		queue++;
 	}
+	if (queue != plat->rx_queues_to_use) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "Not all RX queues were configured\n");
+		goto out;
+	}
 
 	/* Processing TX queues common config */
 	if (of_property_read_u32(tx_node, "snps,tx-queues-to-use",
@@ -281,10 +287,18 @@ static void stmmac_mtl_setup(struct platform_device *pdev,
 
 		queue++;
 	}
+	if (queue != plat->tx_queues_to_use) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "Not all TX queues were configured\n");
+		goto out;
+	}
 
+out:
 	of_node_put(rx_node);
 	of_node_put(tx_node);
 	of_node_put(q_node);
+
+	return ret;
 }
 
 /**
@@ -376,6 +390,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
+	int rc;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -499,7 +514,11 @@ stmmac_probe_config_dt(struct platform_device *pdev, const char **mac)
 
 	plat->axi = stmmac_axi_setup(pdev);
 
-	stmmac_mtl_setup(pdev, plat);
+	rc = stmmac_mtl_setup(pdev, plat);
+	if (rc) {
+		stmmac_remove_config_dt(pdev, plat);
+		return ERR_PTR(rc);
+	}
 
 	/* clock setup */
 	plat->stmmac_clk = devm_clk_get(&pdev->dev,
-- 
2.14.2
