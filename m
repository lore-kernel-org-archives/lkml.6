Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeE2Eiu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:38:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44760 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754621AbeE2EiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:38:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAAAE6044B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From: Can Guo <cang@codeaurora.org>
To: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH v6 1/3] phy: Update PHY power control sequence
Date: Tue, 29 May 2018 12:37:49 +0800
Message-Id: <20180529043751.10580-2-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20180529043751.10580-1-cang@codeaurora.org>
References: <20180529043751.10580-1-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All PHYs should be powered on before register configuration starts. And
only PCIe PHYs need an extra power control before deasserts reset state.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 97ef942..f779b0f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -982,6 +982,8 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
 	if (cfg->has_phy_com_ctrl)
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
 			     SW_PWRDN);
+	else
+		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
 
 	if (cfg->has_phy_dp_com_ctrl) {
 		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
@@ -1127,7 +1129,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
 	 */
-	qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
+	if (cfg->type == PHY_TYPE_PCIE)
+		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
 
 	if (cfg->has_pwrdn_delay)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
