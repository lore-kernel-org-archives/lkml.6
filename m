Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D268208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="REGTiutZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="REGTiutZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D268208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeGaLtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:49:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaLtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:49:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD40B60B19; Tue, 31 Jul 2018 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031769;
        bh=9TaJT/jh32MNAfbqU6Iwa704Nc/844JyOTeJMp1o+bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REGTiutZc/M3eU5jvFGYtbJqKG+93wEnmsofXhHDrcv8V+PnuMDHM8Wdl+8kqGvYl
         1P0KSy6f4rgWRWJ6vSEXYt2kV/Qvub8uMoZBv0qwOMu5NCTXFsulCBnzJAPwVNLKUE
         OCqflPy7kk5YAElTP5sZAlInyiIJuRVnE5pAF14c=
Received: from CANG02.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B17E60585;
        Tue, 31 Jul 2018 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031769;
        bh=9TaJT/jh32MNAfbqU6Iwa704Nc/844JyOTeJMp1o+bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REGTiutZc/M3eU5jvFGYtbJqKG+93wEnmsofXhHDrcv8V+PnuMDHM8Wdl+8kqGvYl
         1P0KSy6f4rgWRWJ6vSEXYt2kV/Qvub8uMoZBv0qwOMu5NCTXFsulCBnzJAPwVNLKUE
         OCqflPy7kk5YAElTP5sZAlInyiIJuRVnE5pAF14c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B17E60585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v8 1/5] phy: Update PHY power control sequence
Date:   Tue, 31 Jul 2018 18:09:10 +0800
Message-Id: <20180731100914.19856-2-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20180731100914.19856-1-cang@codeaurora.org>
References: <20180731100914.19856-1-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All PHYs should be powered on before register configuration starts. And
only PCIe PHYs need an extra power control before deasserts reset state.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Manu Gautam <mgautam@codeaurora.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 97ef942..ccb8578 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -935,10 +935,12 @@ static void qcom_qmp_phy_configure(void __iomem *base,
 	}
 }
 
-static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
+static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
 {
+	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *serdes = qmp->serdes;
+	void __iomem *pcs = qphy->pcs;
 	void __iomem *dp_com = qmp->dp_com;
 	int ret, i;
 
@@ -979,10 +981,6 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
 		goto err_rst;
 	}
 
-	if (cfg->has_phy_com_ctrl)
-		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
-			     SW_PWRDN);
-
 	if (cfg->has_phy_dp_com_ctrl) {
 		qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
 			     SW_PWRDN);
@@ -1000,6 +998,12 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
 			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 	}
 
+	if (cfg->has_phy_com_ctrl)
+		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
+			     SW_PWRDN);
+	else
+		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
+
 	/* Serdes configuration */
 	qcom_qmp_phy_configure(serdes, cfg->regs, cfg->serdes_tbl,
 			       cfg->serdes_tbl_num);
@@ -1090,7 +1094,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
 
 	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
 
-	ret = qcom_qmp_phy_com_init(qmp);
+	ret = qcom_qmp_phy_com_init(qphy);
 	if (ret)
 		return ret;
 
@@ -1127,7 +1131,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
 	 */
-	qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
+	if(cfg->type == PHY_TYPE_PCIE)
+		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
 
 	if (cfg->has_pwrdn_delay)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

