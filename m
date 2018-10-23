Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153D9207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ie4tanoQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HlPqxJz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153D9207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJWM5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:57:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJWM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:57:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6098360F72; Tue, 23 Oct 2018 04:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269376;
        bh=9TaJT/jh32MNAfbqU6Iwa704Nc/844JyOTeJMp1o+bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ie4tanoQaHN/x+dxUBfqvGNk6M+ywBjV0fhjNkYXsd3bABLJc88EMZgv0mfOCOR9B
         Gca8fcq7W09HeXFZ4ufJt4lKrd2NO0MswkPGxLeTnLkNCASyPcTP34rRcqR35H2dtq
         DXq77PqaoyTdJ5vorNNHOTJWRM4ok0jUauVPRUwA=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2AF260F72;
        Tue, 23 Oct 2018 04:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269375;
        bh=9TaJT/jh32MNAfbqU6Iwa704Nc/844JyOTeJMp1o+bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlPqxJz7rF10j/6jezLpashYlIKNAbtL7OE1OHu3vxOIag68SDZOaC5MhXNXsTVkK
         vaW+Akqknjvh1mXAO+XV5CyTg4PMUmFOHPSjAc++Fmc8BTklY8U3UaIEAVWBRxkHAv
         aTVPKwr1I+05tWH5JuudSQiaSV7ivlzPk+DJJDFs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2AF260F72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v10 1/6] phy: Update PHY power control sequence
Date:   Mon, 22 Oct 2018 21:35:56 -0700
Message-Id: <1540269361-28185-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
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

