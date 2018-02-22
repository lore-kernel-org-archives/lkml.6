Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeBVFtS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:49:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:28463 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751594AbeBVFtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:49:08 -0500
X-UUID: fd3143f42b0745c691267b93d51be434-20180222
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
CC: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v1 2/5] soc: mediatek: update power domain data of MT2712
Date: Thu, 22 Feb 2018 13:48:48 +0800
Message-ID: <20180222054851.26096-4-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180222054851.26096-1-weiyi.lu@mediatek.com>
References: <20180222054851.26096-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. split MFG power domain into MFG/MFG_SC1/MFG_SC2/MFG_SC3
according to MT2712 ECO design change
2. add subdomain support for MT2712

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 42 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 59bd749c2f25..edf8fd6c2c85 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -664,12 +664,48 @@ static const struct scp_domain_data scp_domain_data_mt2712[] = {
 		.name = "mfg",
 		.sta_mask = PWR_STATUS_MFG,
 		.ctl_offs = SPM_MFG_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(19, 16),
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(16, 16),
 		.clk_id = {CLK_MFG},
 		.bus_prot_mask = BIT(14) | BIT(21) | BIT(23),
 		.active_wakeup = true,
 	},
+	[MT2712_POWER_DOMAIN_MFG_SC1] = {
+		.name = "mfg_sc1",
+		.sta_mask = BIT(22),
+		.ctl_offs = 0x02c0,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(16, 16),
+		.clk_id = {CLK_NONE},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_MFG_SC2] = {
+		.name = "mfg_sc2",
+		.sta_mask = BIT(23),
+		.ctl_offs = 0x02c4,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(16, 16),
+		.clk_id = {CLK_NONE},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_MFG_SC3] = {
+		.name = "mfg_sc3",
+		.sta_mask = BIT(30),
+		.ctl_offs = 0x01f8,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(16, 16),
+		.clk_id = {CLK_NONE},
+		.active_wakeup = true,
+	},
+};
+
+static const struct scp_subdomain scp_subdomain_mt2712[] = {
+	{MT2712_POWER_DOMAIN_MM, MT2712_POWER_DOMAIN_VDEC},
+	{MT2712_POWER_DOMAIN_MM, MT2712_POWER_DOMAIN_VENC},
+	{MT2712_POWER_DOMAIN_MM, MT2712_POWER_DOMAIN_ISP},
+	{MT2712_POWER_DOMAIN_MFG, MT2712_POWER_DOMAIN_MFG_SC1},
+	{MT2712_POWER_DOMAIN_MFG_SC1, MT2712_POWER_DOMAIN_MFG_SC2},
+	{MT2712_POWER_DOMAIN_MFG_SC2, MT2712_POWER_DOMAIN_MFG_SC3},
 };
 
 /*
@@ -905,6 +941,8 @@ static const struct scp_soc_data mt2701_data = {
 static const struct scp_soc_data mt2712_data = {
 	.domains = scp_domain_data_mt2712,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt2712),
+	.subdomains = scp_subdomain_mt2712,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt2712),
 	.regs = {
 		.pwr_sta_offs = SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
-- 
2.12.5
