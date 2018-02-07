Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeBGKXE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:23:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42233 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753834AbeBGKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:23:00 -0500
X-UUID: f47336e5a34f45d58a6b6acdc4261eb9-20180207
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>,
        <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 4/4] soc: mediatek: add SCPSYS power domain driver for MediaTek MT7623A SoC
Date: Wed, 7 Feb 2018 18:22:50 +0800
Message-ID: <7a90721d7327c90c2716394dc1fd88233fb07256.1517998367.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add SCPSYS power domain driver for MT7623A SoC. The MT7623A's power
domains are the subset of MT7623 SoC's ones. As MT7623 SoC has full
features whereas MT7623A is being designed just for router applications.
Thus, MT7623A doesn't include those power domains multimedia function
belongs to. In order to avoid certain errors undoubtedly happening at
registering those power domains on MT7623A SoC using the existing MT7623
SCPSYS driver, it's required to define another setup specifically for
MT7623A SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 5346f33..fc55faa 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -24,6 +24,7 @@
 #include <dt-bindings/power/mt2712-power.h>
 #include <dt-bindings/power/mt6797-power.h>
 #include <dt-bindings/power/mt7622-power.h>
+#include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
 
 #define SPM_VDE_PWR_CON			0x0210
@@ -795,6 +796,47 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
 };
 
 /*
+ * MT7623A power domain support
+ */
+
+static const struct scp_domain_data scp_domain_data_mt7623a[] = {
+	[MT7623A_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = SPM_CONN_PWR_CON,
+		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
+				 MT2701_TOP_AXI_PROT_EN_CONN_S,
+		.clk_id = {CLK_NONE},
+		.active_wakeup = true,
+	},
+	[MT7623A_POWER_DOMAIN_ETH] = {
+		.name = "eth",
+		.sta_mask = PWR_STATUS_ETH,
+		.ctl_offs = SPM_ETH_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_ETHIF},
+		.active_wakeup = true,
+	},
+	[MT7623A_POWER_DOMAIN_HIF] = {
+		.name = "hif",
+		.sta_mask = PWR_STATUS_HIF,
+		.ctl_offs = SPM_HIF_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_ETHIF},
+		.active_wakeup = true,
+	},
+	[MT7623A_POWER_DOMAIN_IFR_MSC] = {
+		.name = "ifr_msc",
+		.sta_mask = PWR_STATUS_IFR_MSC,
+		.ctl_offs = SPM_IFR_MSC_PWR_CON,
+		.clk_id = {CLK_NONE},
+		.active_wakeup = true,
+	},
+};
+
+/*
  * MT8173 power domain support
  */
 
@@ -935,6 +977,16 @@ static const struct scp_soc_data mt7622_data = {
 	.bus_prot_reg_update = true,
 };
 
+static const struct scp_soc_data mt7623a_data = {
+	.domains = scp_domain_data_mt7623a,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt7623a),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
+	},
+	.bus_prot_reg_update = true,
+};
+
 static const struct scp_soc_data mt8173_data = {
 	.domains = scp_domain_data_mt8173,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt8173),
@@ -965,6 +1017,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 		.compatible = "mediatek,mt7622-scpsys",
 		.data = &mt7622_data,
 	}, {
+		.compatible = "mediatek,mt7623a-scpsys",
+		.data = &mt7623a_data,
+	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,
 	}, {
-- 
2.7.4
