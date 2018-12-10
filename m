Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB57C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F282082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F282082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeLJHdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:33:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45267 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726688AbeLJHdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:33:14 -0500
X-UUID: 2fd3825e189044cd9625636f096745c2-20181210
X-UUID: 2fd3825e189044cd9625636f096745c2-20181210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 383681395; Mon, 10 Dec 2018 15:32:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Dec 2018 15:32:52 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Dec 2018 15:32:52 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v3 11/12] soc: mediatek: Add MT8183 scpsys support
Date:   Mon, 10 Dec 2018 15:32:39 +0800
Message-ID: <20181210073240.32278-13-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210073240.32278-1-weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scpsys driver for MT8183

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 226 ++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 98ccef566ce1..58d84fe33d2a 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -21,6 +21,7 @@
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
+#include <dt-bindings/power/mt8183-power.h>
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
@@ -1158,6 +1159,217 @@ static const struct scp_subdomain scp_subdomain_mt8173[] = {
 	{MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
 };
 
+/*
+ * MT8183 power domain support
+ */
+
+static const struct scp_domain_data scp_domain_data_mt8183[] = {
+	[MT8183_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = 0x0314,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.basic_clk_name = {"audio", "audio1", "audio2"},
+	},
+	[MT8183_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(13) | BIT(14), BIT(13) | BIT(14)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
+		.sta_mask = PWR_STATUS_MFG_ASYNC,
+		.ctl_offs = 0x0334,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.basic_clk_name = {"mfg"},
+	},
+	[MT8183_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_CORE0] = {
+		.name = "mfg_core0",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x034c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_CORE1] = {
+		.name = "mfg_core1",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x0310,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_2D] = {
+		.name = "mfg_2d",
+		.sta_mask = PWR_STATUS_MFG_2D,
+		.ctl_offs = 0x0348,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
+				BIT(19) | BIT(20) | BIT(21),
+				BIT(19) | BIT(20) | BIT(21)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(21) | BIT(22), BIT(21) | BIT(22)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x030c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.basic_clk_name = {"mm"},
+		.subsys_clk_prefix = "mm",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
+				BIT(16) | BIT(17), BIT(16) | BIT(17)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(10) | BIT(11), BIT(10) | BIT(11)),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				GENMASK(7, 0), GENMASK(7, 0)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"cam"},
+		.subsys_clk_prefix = "cam",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(4) | BIT(5) | BIT(9) | BIT(13),
+				BIT(4) | BIT(5) | BIT(9) | BIT(13)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(28), BIT(28)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(11), 0),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(3) | BIT(4), BIT(3) | BIT(4)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = 0x0308,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"isp"},
+		.subsys_clk_prefix = "isp",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(3) | BIT(8), BIT(3) | BIT(8)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(10), 0),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(2), BIT(2)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0300,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(7), BIT(7)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = 0x0304,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_table = {
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(1), BIT(1)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_TOP] = {
+		.name = "vpu_top",
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x0324,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.basic_clk_name = {"vpu", "vpu1"},
+		.subsys_clk_prefix = "vpu",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				GENMASK(9, 6) | BIT(12),
+				GENMASK(9, 6) | BIT(12)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(27), BIT(27)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(10) | BIT(11), BIT(10) | BIT(11)),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(5) | BIT(6), BIT(5) | BIT(6)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_CORE0] = {
+		.name = "vpu_core0",
+		.sta_mask = BIT(27),
+		.ctl_offs = 0x33c,
+		.sram_iso_ctrl = true,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"vpu2"},
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(6), BIT(6)),
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(0) | BIT(2) | BIT(4),
+				BIT(0) | BIT(2) | BIT(4)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_CORE1] = {
+		.name = "vpu_core1",
+		.sta_mask = BIT(28),
+		.ctl_offs = 0x0340,
+		.sram_iso_ctrl = true,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"vpu3"},
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(7), BIT(7)),
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(1) | BIT(3) | BIT(5),
+				BIT(1) | BIT(3) | BIT(5)),
+		},
+	},
+};
+
+static const struct scp_subdomain scp_subdomain_mt8183[] = {
+	{MT8183_POWER_DOMAIN_MFG_ASYNC, MT8183_POWER_DOMAIN_MFG},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_2D},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE0},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE1},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_CAM},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_ISP},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VDEC},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VENC},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VPU_TOP},
+	{MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE0},
+	{MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE1},
+};
+
 static const struct scp_soc_data mt2701_data = {
 	.domains = scp_domain_data_mt2701,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
@@ -1224,6 +1436,17 @@ static const struct scp_soc_data mt8173_data = {
 	.bus_prot_reg_update = true,
 };
 
+static const struct scp_soc_data mt8183_data = {
+	.domains = scp_domain_data_mt8183,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt8183),
+	.subdomains = scp_subdomain_mt8183,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8183),
+	.regs = {
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184
+	}
+};
+
 /*
  * scpsys driver init
  */
@@ -1247,6 +1470,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,
+	}, {
+		.compatible = "mediatek,mt8183-scpsys",
+		.data = &mt8183_data,
 	}, {
 		/* sentinel */
 	}
-- 
2.18.0

