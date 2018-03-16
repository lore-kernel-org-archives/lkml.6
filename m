Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeCPJpz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:45:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeCPJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:45:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73CB460314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH 6/6] phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845
Date: Fri, 16 Mar 2018 15:14:59 +0530
Message-Id: <1521193500-4696-7-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
References: <1521193500-4696-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two QUSB2 PHYs present on sdm845. Update PHY
registers programming for both the PHYs related to
electrical parameters to improve eye diagram.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 40fdef8..1a608a9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -174,6 +174,27 @@ enum qusb2phy_reg_layout {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_CHG_CTRL2, 0x0),
 };
 
+static const struct qusb2_phy_init_tbl sdm845_init_tbl_1[] = {
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_BIAS_CONTROL_1, 0x40),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_BIAS_CONTROL_2, 0x20),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PWR_CTRL2, 0x21),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_IMP_CTRL1, 0x8),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_IMP_CTRL2, 0x58),
+
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0x45),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x29),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0xca),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0x04),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE5, 0x03),
+
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_CHG_CTRL2, 0x0),
+};
+
 struct qusb2_phy_cfg {
 	const struct qusb2_phy_init_tbl *tbl;
 	/* number of entries in the table */
@@ -220,6 +241,18 @@ struct qusb2_phy_cfg {
 	.autoresume_en	  = BIT(0),
 };
 
+static const struct qusb2_phy_cfg sdm845_phy_cfg_1 = {
+	.tbl		= sdm845_init_tbl_1,
+	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl_1),
+	.regs		= qusb2_v2_regs_layout,
+
+	.disable_ctrl	= (PWR_CTRL1_VREF_SUPPLY_TRIM | PWR_CTRL1_CLAMP_N_EN |
+			   POWER_DOWN),
+	.mask_core_ready = CORE_READY_STATUS,
+	.has_pll_override = true,
+	.autoresume_en	  = BIT(0),
+};
+
 static const char * const qusb2_phy_vreg_names[] = {
 	"vdda-pll", "vdda-phy-dpdm",
 };
@@ -649,6 +682,12 @@ static int qusb2_phy_exit(struct phy *phy)
 	}, {
 		.compatible	= "qcom,qusb2-v2-phy",
 		.data		= &qusb2_v2_phy_cfg,
+	}, {
+		.compatible	= "qcom,sdm845-1-qusb2-phy",
+		.data		= &sdm845_phy_cfg_1,
+	}, {
+		.compatible	= "qcom,sdm845-2-qusb2-phy",
+		.data		= &qusb2_v2_phy_cfg,
 	},
 	{ },
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
