Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9862421533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9862421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbeIUKQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:16:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeIUKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:16:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2DE8060F35; Fri, 21 Sep 2018 04:29:01 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F5AD60E5C;
        Fri, 21 Sep 2018 04:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F5AD60E5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=quic_cang@quicinc.com
From:   Can Guo <quic_cang@quicinc.com>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     Can Guo <cang@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list:GENERIC PHY FRAMEWORK)
Subject: [PATCH v9 3/7] phy: Add QMP phy based UFS phy support for sdm845
Date:   Thu, 20 Sep 2018 21:27:56 -0700
Message-Id: <1537504081-29976-4-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
References: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

Add UFS PHY support to make SDM845 UFS work with common PHY framework.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 172 +++++++++++++++++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h |  15 ++++
 2 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 9be9754..de7ff18 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -156,6 +156,11 @@ enum qphy_reg_layout {
 	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
 };
 
+static const unsigned int sdm845_ufsphy_regs_layout[] = {
+	[QPHY_START_CTRL]		= 0x00,
+	[QPHY_PCS_READY_STATUS]		= 0x160,
+};
+
 static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
 	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x10),
@@ -601,6 +606,83 @@ enum qphy_reg_layout {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
 };
 
+static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xda),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE1, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE1, 0xc1),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE1, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE1, 0x0f),
+
+	/* Rate B */
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
+};
+
+static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
+};
+
+static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_CTRL2, 0x6e),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TX_LARGE_AMP_DRV_LVL, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SYM_RESYNC_CTRL, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_CTRL1, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_MIN_HIBERN8_TIME, 0x9a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MULTI_LANE_CTRL1, 0x02),
+};
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
@@ -654,6 +736,9 @@ struct qmp_phy_cfg {
 	/* Register offset of secondary tx/rx lanes for USB DP combo PHY */
 	unsigned int tx_b_lane_offset;
 	unsigned int rx_b_lane_offset;
+
+	/* true, if PCS block has no separate SW_RESET register */
+	bool no_pcs_sw_reset;
 };
 
 /**
@@ -750,6 +835,10 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	"aux", "cfg_ahb", "ref", "com_aux",
 };
 
+static const char * const sdm845_ufs_phy_clk_l[] = {
+	"ref", "ref_aux",
+};
+
 /* list of resets */
 static const char * const msm8996_pciephy_reset_l[] = {
 	"phy", "common", "cfg",
@@ -919,6 +1008,35 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
 };
 
+static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
+	.type			= PHY_TYPE_UFS,
+	.nlanes			= 2,
+
+	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes_tbl),
+	.tx_tbl			= sdm845_ufsphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx_tbl),
+	.rx_tbl			= sdm845_ufsphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx_tbl),
+	.pcs_tbl		= sdm845_ufsphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs_tbl),
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sdm845_ufsphy_regs_layout,
+
+	.start_ctrl		= SERDES_START,
+	.pwrdn_ctrl		= SW_PWRDN,
+	.mask_pcs_ready		= PCS_READY,
+
+	.is_dual_lane_phy	= true,
+	.tx_b_lane_offset	= 0x400,
+	.rx_b_lane_offset	= 0x400,
+
+	.no_pcs_sw_reset	= true,
+};
+
 static void qcom_qmp_phy_configure(void __iomem *base,
 				   const unsigned int *regs,
 				   const struct qmp_phy_init_tbl tbl[],
@@ -1131,6 +1249,14 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	/*
+	 * UFS PHY requires the deassert of software reset before serdes start.
+	 * For UFS PHYs that do not have software reset control bits, defer
+	 * starting serdes until the power on callback.
+	 */
+	if ((cfg->type == PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
+		goto out;
+
+	/*
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
 	 */
@@ -1159,6 +1285,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	}
 	qmp->phy_initialized = true;
 
+out:
 	return ret;
 
 err_pcs_ready:
@@ -1181,7 +1308,8 @@ static int qcom_qmp_phy_exit(struct phy *phy)
 	clk_disable_unprepare(qphy->pipe_clk);
 
 	/* PHY reset */
-	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+	if (!cfg->no_pcs_sw_reset)
+		qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
 	/* stop SerDes and Phy-Coding-Sublayer */
 	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
@@ -1199,6 +1327,44 @@ static int qcom_qmp_phy_exit(struct phy *phy)
 	return 0;
 }
 
+static int qcom_qmp_phy_poweron(struct phy *phy)
+{
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
+	struct qcom_qmp *qmp = qphy->qmp;
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *pcs = qphy->pcs;
+	void __iomem *status;
+	unsigned int mask, val;
+	int ret = 0;
+
+	if (cfg->type != PHY_TYPE_UFS)
+		return 0;
+
+	/*
+	 * For UFS PHY that has not software reset control, serdes start
+	 * should only happen when UFS driver explicitly calls phy_power_on
+	 * after it deasserts software reset.
+	 */
+	if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
+	    (qmp->init_count != 0)) {
+		/* start SerDes and Phy-Coding-Sublayer */
+		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
+
+		status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
+		mask = cfg->mask_pcs_ready;
+
+		ret = readl_poll_timeout(status, val, !(val & mask), 1,
+					 PHY_INIT_COMPLETE_TIMEOUT);
+		if (ret) {
+			dev_err(qmp->dev, "phy initialization timed-out\n");
+			return ret;
+		}
+		qmp->phy_initialized = true;
+	}
+
+	return ret;
+}
+
 static int qcom_qmp_phy_set_mode(struct phy *phy, enum phy_mode mode)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
@@ -1428,6 +1594,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 static const struct phy_ops qcom_qmp_phy_gen_ops = {
 	.init		= qcom_qmp_phy_init,
 	.exit		= qcom_qmp_phy_exit,
+	.power_on	= qcom_qmp_phy_poweron,
 	.set_mode	= qcom_qmp_phy_set_mode,
 	.owner		= THIS_MODULE,
 };
@@ -1533,6 +1700,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 	}, {
 		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
 		.data = &qmp_v3_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-ufs-phy",
+		.data = &sdm845_ufsphy_cfg,
 	},
 	{ },
 };
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 5d78d43..d201cc3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -184,6 +184,8 @@
 #define QSERDES_V3_COM_VCO_TUNE2_MODE0			0x0f8
 #define QSERDES_V3_COM_VCO_TUNE1_MODE1			0x0fc
 #define QSERDES_V3_COM_VCO_TUNE2_MODE1			0x100
+#define QSERDES_V3_COM_VCO_TUNE_INITVAL1		0x104
+#define QSERDES_V3_COM_VCO_TUNE_INITVAL2		0x108
 #define QSERDES_V3_COM_VCO_TUNE_TIMER1			0x11c
 #define QSERDES_V3_COM_VCO_TUNE_TIMER2			0x120
 #define QSERDES_V3_COM_CLK_SELECT			0x138
@@ -211,8 +213,13 @@
 /* Only for QMP V3 PHY - RX registers */
 #define QSERDES_V3_RX_UCDR_SO_GAIN_HALF			0x00c
 #define QSERDES_V3_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF		0x024
+#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER		0x028
+#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN			0x02c
 #define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN		0x030
 #define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
+#define QSERDES_V3_RX_UCDR_PI_CONTROLS			0x044
 #define QSERDES_V3_RX_RX_TERM_BW			0x07c
 #define QSERDES_V3_RX_VGA_CAL_CNTRL1			0x0bc
 #define QSERDES_V3_RX_VGA_CAL_CNTRL2			0x0c0
@@ -239,6 +246,8 @@
 #define QPHY_V3_PCS_TXMGN_V3				0x018
 #define QPHY_V3_PCS_TXMGN_V4				0x01c
 #define QPHY_V3_PCS_TXMGN_LS				0x020
+#define QPHY_V3_PCS_TX_LARGE_AMP_DRV_LVL		0x02c
+#define QPHY_V3_PCS_TX_SMALL_AMP_DRV_LVL		0x034
 #define QPHY_V3_PCS_TXDEEMPH_M6DB_V0			0x024
 #define QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0			0x028
 #define QPHY_V3_PCS_TXDEEMPH_M6DB_V1			0x02c
@@ -275,6 +284,12 @@
 #define QPHY_V3_PCS_FLL_CNT_VAL_L			0x0cc
 #define QPHY_V3_PCS_FLL_CNT_VAL_H_TOL			0x0d0
 #define QPHY_V3_PCS_FLL_MAN_CODE			0x0d4
+#define QPHY_V3_PCS_RX_SYM_RESYNC_CTRL			0x134
+#define QPHY_V3_PCS_RX_MIN_HIBERN8_TIME			0x138
+#define QPHY_V3_PCS_RX_SIGDET_CTRL1			0x13c
+#define QPHY_V3_PCS_RX_SIGDET_CTRL2			0x140
+#define QPHY_V3_PCS_TX_MID_TERM_CTRL1			0x1bc
+#define QPHY_V3_PCS_MULTI_LANE_CTRL1			0x1c4
 #define QPHY_V3_PCS_RX_SIGDET_LVL			0x1d8
 #define QPHY_V3_PCS_REFGEN_REQ_CONFIG1			0x20c
 #define QPHY_V3_PCS_REFGEN_REQ_CONFIG2			0x210
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

