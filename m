Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeDPCdk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:33:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61803 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752552AbeDPCdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:33:39 -0400
X-UUID: 61a5ec34f1c548c3b2104c1059753a84-20180416
From: Ryder Lee <ryder.lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] soc: mediatek: use of_device_get_match_data()
Date: Mon, 16 Apr 2018 10:33:34 +0800
Message-ID: <b7fffebff04c6b717c568194ac7503144a3302a8.1523347340.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of of_device_get_match_data() reduce the code size a bit.

Also, the only way to call pwrap_probe() is to match an entry in
of_pwrap_match_tbl[], so of_id cannot be NULL.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 13 +++----------
 drivers/soc/mediatek/mtk-scpsys.c    |  4 +---
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index e9e054a..2afae64 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1458,19 +1458,12 @@ static int pwrap_probe(struct platform_device *pdev)
 	int ret, irq;
 	struct pmic_wrapper *wrp;
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id =
-		of_match_device(of_pwrap_match_tbl, &pdev->dev);
 	const struct of_device_id *of_slave_id = NULL;
 	struct resource *res;
 
-	if (!of_id) {
-		dev_err(&pdev->dev, "Error: No device match found\n");
-		return -ENODEV;
-	}
+	if (np->child)
+		of_slave_id = of_match_node(of_slave_match_tbl, np->child);
 
-	if (pdev->dev.of_node->child)
-		of_slave_id = of_match_node(of_slave_match_tbl,
-					    pdev->dev.of_node->child);
 	if (!of_slave_id) {
 		dev_dbg(&pdev->dev, "slave pmic should be defined in dts\n");
 		return -EINVAL;
@@ -1482,7 +1475,7 @@ static int pwrap_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wrp);
 
-	wrp->master = of_id->data;
+	wrp->master = of_device_get_match_data(&pdev->dev);
 	wrp->slave = of_slave_id->data;
 	wrp->dev = &pdev->dev;
 
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 435ce5e..a02a18e 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -973,15 +973,13 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 
 static int scpsys_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct scp_subdomain *sd;
 	const struct scp_soc_data *soc;
 	struct scp *scp;
 	struct genpd_onecell_data *pd_data;
 	int i, ret;
 
-	match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
-	soc = (const struct scp_soc_data *)match->data;
+	soc = of_device_get_match_data(&pdev->dev);
 
 	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs,
 			soc->bus_prot_reg_update);
-- 
1.9.1
