Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeC2LGN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:06:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeC2LGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:06:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC844600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@codeaurora.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, vivek.gautam@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH v4 2/7] phy: qcom-qmp: Enable pipe_clk before PHY initialization
Date: Thu, 29 Mar 2018 16:34:21 +0530
Message-Id: <1522321466-21755-3-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMP PHY for USB/PCIE requires pipe_clk for locking of
retime buffers at the pipe interface. Driver checks for
PHY_STATUS without enabling pipe_clk due to which
phy_init() fails with initialization timeout.
Though pipe_clk is output from PHY (after PLL is programmed
during initialization sequence) to GCC clock_ctl and then fed
back to PHY but for PHY_STATUS register to reflect successful
initialization pipe_clk from GCC must be present.
Since, clock driver now ignores status_check for pipe_clk on
clk_enable/disable, driver can safely enable/disable pipe_clk
from phy_init/exit.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 6470c5d..fddb1c9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -793,19 +793,6 @@ static void qcom_qmp_phy_configure(void __iomem *base,
 	}
 }
 
-static int qcom_qmp_phy_poweron(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	int ret;
-
-	ret = clk_prepare_enable(qphy->pipe_clk);
-	if (ret)
-		dev_err(qmp->dev, "pipe_clk enable failed, err=%d\n", ret);
-
-	return ret;
-}
-
 static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -974,6 +961,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 		}
 	}
 
+	ret = clk_prepare_enable(qphy->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		goto err_clk_enable;
+	}
+
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
 	/* Configuration for other LANE for USB-DP combo PHY */
@@ -1019,6 +1012,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	return ret;
 
 err_pcs_ready:
+	clk_disable_unprepare(qphy->pipe_clk);
+err_clk_enable:
 	if (cfg->has_lane_rst)
 		reset_control_assert(qphy->lane_rst);
 err_lane_rst:
@@ -1283,7 +1278,6 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 static const struct phy_ops qcom_qmp_phy_gen_ops = {
 	.init		= qcom_qmp_phy_init,
 	.exit		= qcom_qmp_phy_exit,
-	.power_on	= qcom_qmp_phy_poweron,
 	.set_mode	= qcom_qmp_phy_set_mode,
 	.owner		= THIS_MODULE,
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
