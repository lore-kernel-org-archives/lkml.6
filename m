Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E767AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E68206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E68206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeGQJZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:25:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13286 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728624AbeGQJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:24:22 -0400
X-UUID: 49e045650648474d9ea53ea30ec216b5-20180717
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1055421502; Tue, 17 Jul 2018 16:52:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 17 Jul 2018 16:52:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 16:52:35 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Mars Cheng <mars.cheng@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v5 07/11] soc: mediatek: add MT6765 subdomain support
Date:   Tue, 17 Jul 2018 16:52:28 +0800
Message-ID: <1531817552-17221-8-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add extend data, parent_n for domain-subdomain corresponse.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys-ext.c |  132 ++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
index 965e64d..e649a06 100644
--- a/drivers/soc/mediatek/mtk-scpsys-ext.c
+++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
@@ -13,7 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/infracfg.h>
 #include <linux/soc/mediatek/scpsys-ext.h>
-
+#include <dt-bindings/power/mt6765-power.h>
 
 #define MAX_CLKS		10
 #define INFRA			"infracfg"
@@ -65,6 +65,21 @@ struct bus_mask_ops {
 			   u32 sta_ofs, u32 mask);
 };
 
+static struct scpsys_ext_attr *__get_attr_node(const char *scpd_n)
+{
+	struct scpsys_ext_attr *attr;
+
+	if (!scpd_n)
+		return ERR_PTR(-EINVAL);
+
+	list_for_each_entry(attr, &ext_attr_map_list, attr_list) {
+		if (attr->scpd_n && !strcmp(scpd_n, attr->scpd_n))
+			return attr;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static struct scpsys_ext_attr *__get_attr_parent(const char *parent_n)
 {
 	struct scpsys_ext_attr *attr;
@@ -353,8 +368,123 @@ int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
 	return 0;
 }
 
+/*
+ * MT6765 extend power domain support
+ */
+
+#define INFRA_TOPAXI_PROTECTEN_SET_MT6765	0x02A0
+#define INFRA_TOPAXI_PROTECTEN_STA1_MT6765	0x0228
+#define INFRA_TOPAXI_PROTECTEN_CLR_MT6765	0x02A4
+
+#define INFRA_TOPAXI_PROTECTEN_1_SET_MT6765	0x02A8
+#define INFRA_TOPAXI_PROTECTEN_STA1_1_MT6765	0x0258
+#define INFRA_TOPAXI_PROTECTEN_1_CLR_MT6765	0x02AC
+
+#define SMI_COMMON_SMI_CLAMP_MT6765		0x03C0
+#define SMI_COMMON_SMI_CLAMP_SET_MT6765	0x03C4
+#define SMI_COMMON_SMI_CLAMP_CLR_MT6765	0x03C8
+
+static struct ext_reg_ctrl infra_bus_regs_0_mt6765 = {
+	.type = IFR_TYPE,
+	.set_ofs = INFRA_TOPAXI_PROTECTEN_SET_MT6765,
+	.clr_ofs = INFRA_TOPAXI_PROTECTEN_CLR_MT6765,
+	.sta_ofs = INFRA_TOPAXI_PROTECTEN_STA1_MT6765,
+};
+
+#define BUS_IFR0_MT6765(_mask) {				\
+		.regs = &infra_bus_regs_0_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct ext_reg_ctrl infra_bus_regs_1_mt6765 = {
+	.type = IFR_TYPE,
+	.set_ofs = INFRA_TOPAXI_PROTECTEN_1_SET_MT6765,
+	.clr_ofs = INFRA_TOPAXI_PROTECTEN_1_CLR_MT6765,
+	.sta_ofs = INFRA_TOPAXI_PROTECTEN_STA1_1_MT6765,
+};
+
+#define BUS_IFR1_MT6765(_mask) {				\
+		.regs = &infra_bus_regs_1_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct ext_reg_ctrl smi_bus_regs_0_mt6765 = {
+	.type = SMI_TYPE,
+	.set_ofs = SMI_COMMON_SMI_CLAMP_SET_MT6765,
+	.clr_ofs = SMI_COMMON_SMI_CLAMP_CLR_MT6765,
+	.sta_ofs = SMI_COMMON_SMI_CLAMP_MT6765,
+};
+
+#define BUS_SMI0_MT6765(_mask) {				\
+		.regs = &smi_bus_regs_0_mt6765,		\
+		.mask = _mask,				\
+		.ops = &bus_mask_set_clr_ctrl,		\
+	}
+
+static struct scpsys_ext_attr scp_ext_attr_mt6765[] = {
+	[MT6765_POWER_DOMAIN_ISP] = {
+		.scpd_n = "isp",
+		.mask =  {
+			BUS_IFR1_MT6765(BIT(20)),
+			BUS_SMI0_MT6765(BIT(2)),
+		},
+		.parent_n = "mm",
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_MM] = {
+		.scpd_n = "mm",
+		.mask = {
+			BUS_IFR1_MT6765(BIT(16) | BIT(17)),
+			BUS_IFR0_MT6765(BIT(10) | BIT(11)),
+			BUS_IFR0_MT6765(BIT(1) | BIT(2)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_CONN] = {
+		.scpd_n = "conn",
+		.mask = {
+			BUS_IFR0_MT6765(BIT(13)),
+			BUS_IFR1_MT6765(BIT(18)),
+			BUS_IFR0_MT6765(BIT(14) | BIT(16)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_MFG] = {
+		.scpd_n = "mfg",
+		.mask = {
+			BUS_IFR0_MT6765(BIT(25)),
+			BUS_IFR0_MT6765(BIT(21) | BIT(22)),
+		},
+		.bus_ops = &ext_bus_ctrl,
+	},
+	[MT6765_POWER_DOMAIN_CAM] = {
+		.scpd_n = "cam",
+		.mask = {
+			BUS_IFR1_MT6765(BIT(19) | BIT(21)),
+			BUS_IFR0_MT6765(BIT(20)),
+			BUS_SMI0_MT6765(BIT(3)),
+		},
+		.parent_n = "mm",
+		.bus_ops = &ext_bus_ctrl,
+		.cg_ops = &ext_cg_ctrl,
+	},
+};
+
+static const struct scpsys_ext_data scp_ext_data_mt6765 = {
+	.attr = scp_ext_attr_mt6765,
+	.num_attr = ARRAY_SIZE(scp_ext_attr_mt6765),
+	.get_attr = __get_attr_node,
+};
+
 static const struct of_device_id of_scpsys_ext_match_tbl[] = {
 	{
+		.compatible = "mediatek,mt6765-scpsys",
+		.data = &scp_ext_data_mt6765,
+	}, {
 		/* sentinel */
 	}
 };
-- 
1.7.9.5

