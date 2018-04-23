Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeDWIgl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:36:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11999 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754384AbeDWIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:36:30 -0400
X-UUID: 47a5a4d2fc824c12b2613c782e2c5710-20180423
From: <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>, <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/2] soc: mediatek: introduce a CAPS flag for scp_domain_data
Date: Mon, 23 Apr 2018 16:36:21 +0800
Message-ID: <2e16481e1477dfae0cfb24568d8111da81d92628.1524472331.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Instead of adding more and more fields to scp_domain_data which get
checked in the code flow, add a caps field used for an indication the
characteristics for each SCP domain.

At present, type u8 for the caps field is selected which can satisfy the
current situation and doesn't take up extra space against type bool
previously used.

Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 65 ++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index f140e71..b1b45e4 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -31,6 +31,9 @@
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
 
+#define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
+#define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
+
 #define SPM_VDE_PWR_CON			0x0210
 #define SPM_MFG_PWR_CON			0x0214
 #define SPM_VEN_PWR_CON			0x0230
@@ -120,7 +123,7 @@ struct scp_domain_data {
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id[MAX_CLKS];
-	bool active_wakeup;
+	u8 caps;
 };
 
 struct scp;
@@ -424,7 +427,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 		genpd->name = data->name;
 		genpd->power_off = scpsys_power_off;
 		genpd->power_on = scpsys_power_on;
-		if (scpd->data->active_wakeup)
+		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
 			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	}
 
@@ -477,7 +480,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
 				 MT2701_TOP_AXI_PROT_EN_CONN_S,
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_DISP] = {
 		.name = "disp",
@@ -486,7 +489,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.clk_id = {CLK_MM},
 		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_MFG] = {
 		.name = "mfg",
@@ -495,7 +498,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.clk_id = {CLK_MFG},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_VDEC] = {
 		.name = "vdec",
@@ -504,7 +507,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.clk_id = {CLK_MM},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_ISP] = {
 		.name = "isp",
@@ -513,7 +516,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.clk_id = {CLK_MM},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_BDP] = {
 		.name = "bdp",
@@ -521,7 +524,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.ctl_offs = SPM_BDP_PWR_CON,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_ETH] = {
 		.name = "eth",
@@ -530,7 +533,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_ETHIF},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_HIF] = {
 		.name = "hif",
@@ -539,14 +542,14 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_ETHIF},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2701_POWER_DOMAIN_IFR_MSC] = {
 		.name = "ifr_msc",
 		.sta_mask = PWR_STATUS_IFR_MSC,
 		.ctl_offs = SPM_IFR_MSC_PWR_CON,
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 };
 
@@ -561,7 +564,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.clk_id = {CLK_MM},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_VDEC] = {
 		.name = "vdec",
@@ -570,7 +573,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.clk_id = {CLK_MM, CLK_VDEC},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_VENC] = {
 		.name = "venc",
@@ -579,7 +582,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_MM, CLK_VENC, CLK_JPGDEC},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_ISP] = {
 		.name = "isp",
@@ -588,7 +591,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.clk_id = {CLK_MM},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_AUDIO] = {
 		.name = "audio",
@@ -597,7 +600,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_AUDIO},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_USB] = {
 		.name = "usb",
@@ -606,7 +609,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(10, 8),
 		.sram_pdn_ack_bits = GENMASK(14, 12),
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_USB2] = {
 		.name = "usb2",
@@ -615,7 +618,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(10, 8),
 		.sram_pdn_ack_bits = GENMASK(14, 12),
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_MFG] = {
 		.name = "mfg",
@@ -625,7 +628,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_ack_bits = GENMASK(16, 16),
 		.clk_id = {CLK_MFG},
 		.bus_prot_mask = BIT(14) | BIT(21) | BIT(23),
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_MFG_SC1] = {
 		.name = "mfg_sc1",
@@ -634,7 +637,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(16, 16),
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_MFG_SC2] = {
 		.name = "mfg_sc2",
@@ -643,7 +646,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(16, 16),
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT2712_POWER_DOMAIN_MFG_SC3] = {
 		.name = "mfg_sc3",
@@ -652,7 +655,7 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(16, 16),
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 };
 
@@ -752,7 +755,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_NONE},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_ETHSYS,
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT7622_POWER_DOMAIN_HIF0] = {
 		.name = "hif0",
@@ -762,7 +765,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_HIFSEL},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF0,
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT7622_POWER_DOMAIN_HIF1] = {
 		.name = "hif1",
@@ -772,7 +775,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_HIFSEL},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF1,
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT7622_POWER_DOMAIN_WB] = {
 		.name = "wb",
@@ -782,7 +785,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 		.sram_pdn_ack_bits = 0,
 		.clk_id = {CLK_NONE},
 		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 };
 
@@ -798,7 +801,7 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
 		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
 				 MT2701_TOP_AXI_PROT_EN_CONN_S,
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT7623A_POWER_DOMAIN_ETH] = {
 		.name = "eth",
@@ -807,7 +810,7 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_ETHIF},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT7623A_POWER_DOMAIN_HIF] = {
 		.name = "hif",
@@ -816,14 +819,14 @@ static const struct scp_domain_data scp_domain_data_mt7623a[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_ETHIF},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT7623A_POWER_DOMAIN_IFR_MSC] = {
 		.name = "ifr_msc",
 		.sta_mask = PWR_STATUS_IFR_MSC,
 		.ctl_offs = SPM_IFR_MSC_PWR_CON,
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 };
 
@@ -889,7 +892,7 @@ static const struct scp_domain_data scp_domain_data_mt8173[] = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = {CLK_NONE},
-		.active_wakeup = true,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
 	},
 	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
 		.name = "mfg_async",
-- 
2.7.4
