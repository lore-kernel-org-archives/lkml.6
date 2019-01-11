Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D44C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FFA21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGuE8jgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfAKXCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:02:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44927 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAKXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:02:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so7597305pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUHnc+wg8uvlPoMEfQzRuLKMBmh3tzh5bMrl0Ofbpb4=;
        b=IGuE8jgUxjWgZwY+lY6ExMAl2fkykA0Rs47aK5PMXNDbMhZkKeRb6PJ/v2cCQpcwGR
         HFnIa2dk7zgxCFgcTTIfkGOAxJmtl0eGDFpAypCxiJClqfKXU+NP9r0BvCgv4iZoBeJJ
         pa5VE3Wn9ZIlbGpFY6HT6/JmgJUxKRJpp7Jjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VUHnc+wg8uvlPoMEfQzRuLKMBmh3tzh5bMrl0Ofbpb4=;
        b=C/55LdKDGFVcX2vBMlqlTOQIFKO+h5KG1ouNj7NVbYK8zftT+jvDe9TOWmxdzTEZgO
         qrpwYrwNZQlIqWbyI9A64YOvBAiTTUr9tsGCPo0EXn2ychFBuppsEYOGHrXTPBG79GqI
         GCwcYp1sM4MTmvuilLQpCg2GUd6/wCTCuWAjIShgYuAu0XZk7o4f52kRKwHgYA0XMxz0
         mitvMaO6DNznVh3krSO2j7EX73MYSCWebg6VAs0/GaAczXYGhYqt0cUZXXhuMt7/Qo32
         w6yX+3hAvbCebhXKzbETvQEv2gc6MLIx/hUuiozYswNz4E5PylMYwN2nUvLcaY8ukac9
         DT/w==
X-Gm-Message-State: AJcUukdRovag9BVaR7hIemvjWRl4tMoU44bBUxQJuYnSJw8N/8Xm65c7
        wZLyHrbTOvS1ashYi/FaS4GlUQ==
X-Google-Smtp-Source: ALg8bN6BFQX0yiCO8vp78vFgpVAtWy/cN2Jv3iBo6WZhESodOIW0k+iVPBODwt36Rifg5dQv44S57A==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr5001013pgj.321.1547247738332;
        Fri, 11 Jan 2019 15:02:18 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:02:17 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v1 7/8] phy: qcom-qmp: Move UFS phy to phy_poweron/off
Date:   Fri, 11 Jan 2019 15:01:28 -0800
Message-Id: <20190111230129.127037-8-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For UFS, move the actual firing up of the PHY to phy_poweron and
phy_poweroff callbacks, rather than init/exit. UFS calls
phy_poweroff during suspend, so now all clocks and regulators for
the phy can be powered down during suspend.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

 drivers/phy/qualcomm/phy-qcom-qmp.c | 82 ++++++++---------------------
 1 file changed, 23 insertions(+), 59 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index eb1cac8f0fd4e..7766c6384d0a8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1209,8 +1209,7 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
 	return 0;
 }
 
-/* PHY Initialization */
-static int qcom_qmp_phy_init(struct phy *phy)
+static int qcom_qmp_phy_enable(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -1224,7 +1223,6 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	int ret;
 
 	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
-
 	if (cfg->has_ufsphy_reset) {
 		/*
 		 * Get UFS reset, which is delayed until now to avoid a
@@ -1292,14 +1290,6 @@ static int qcom_qmp_phy_init(struct phy *phy)
 		}
 	}
 
-	/*
-	 * UFS PHY requires the deassert of software reset before serdes start.
-	 * For UFS PHYs that do not have software reset control bits, defer
-	 * starting serdes until the power on callback.
-	 */
-	if ((cfg->type == PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
-		goto out;
-
 	/*
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
@@ -1311,7 +1301,9 @@ static int qcom_qmp_phy_init(struct phy *phy)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
 
 	/* Pull PHY out of reset state */
-	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+	if (!cfg->no_pcs_sw_reset)
+		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
 	if (cfg->has_phy_dp_com_ctrl)
 		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
@@ -1328,11 +1320,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 		goto err_pcs_ready;
 	}
 	qmp->phy_initialized = true;
-
-out:
-	return ret;
+	return 0;
 
 err_pcs_ready:
+	if (qmp->ufs_reset)
+		reset_control_assert(qmp->ufs_reset);
+
 	clk_disable_unprepare(qphy->pipe_clk);
 err_clk_enable:
 	if (cfg->has_lane_rst)
@@ -1343,7 +1336,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
 	return ret;
 }
 
-static int qcom_qmp_phy_exit(struct phy *phy)
+static int qcom_qmp_phy_disable(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
@@ -1360,7 +1353,6 @@ static int qcom_qmp_phy_exit(struct phy *phy)
 
 	/* Put PHY into POWER DOWN state: active low */
 	qphy_clrbits(qphy->pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
-
 	if (cfg->has_lane_rst)
 		reset_control_assert(qphy->lane_rst);
 
@@ -1371,44 +1363,6 @@ static int qcom_qmp_phy_exit(struct phy *phy)
 	return 0;
 }
 
-static int qcom_qmp_phy_poweron(struct phy *phy)
-{
-	struct qmp_phy *qphy = phy_get_drvdata(phy);
-	struct qcom_qmp *qmp = qphy->qmp;
-	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *pcs = qphy->pcs;
-	void __iomem *status;
-	unsigned int mask, val;
-	int ret = 0;
-
-	if (cfg->type != PHY_TYPE_UFS)
-		return 0;
-
-	/*
-	 * For UFS PHY that has not software reset control, serdes start
-	 * should only happen when UFS driver explicitly calls phy_power_on
-	 * after it deasserts software reset.
-	 */
-	if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
-	    (qmp->init_count != 0)) {
-		/* start SerDes and Phy-Coding-Sublayer */
-		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
-
-		status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
-		mask = cfg->mask_pcs_ready;
-
-		ret = readl_poll_timeout(status, val, !(val & mask), 1,
-					 PHY_INIT_COMPLETE_TIMEOUT);
-		if (ret) {
-			dev_err(qmp->dev, "phy initialization timed-out\n");
-			return ret;
-		}
-		qmp->phy_initialized = true;
-	}
-
-	return ret;
-}
-
 static int qcom_qmp_phy_set_mode(struct phy *phy,
 				 enum phy_mode mode, int submode)
 {
@@ -1658,9 +1612,15 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 }
 
 static const struct phy_ops qcom_qmp_phy_gen_ops = {
-	.init		= qcom_qmp_phy_init,
-	.exit		= qcom_qmp_phy_exit,
-	.power_on	= qcom_qmp_phy_poweron,
+	.init		= qcom_qmp_phy_enable,
+	.exit		= qcom_qmp_phy_disable,
+	.set_mode	= qcom_qmp_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops qcom_qmp_ufs_ops = {
+	.power_on	= qcom_qmp_phy_enable,
+	.power_off	= qcom_qmp_phy_disable,
 	.set_mode	= qcom_qmp_phy_set_mode,
 	.owner		= THIS_MODULE,
 };
@@ -1671,6 +1631,7 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
 	struct phy *generic_phy;
 	struct qmp_phy *qphy;
+	const struct phy_ops *ops = &qcom_qmp_phy_gen_ops;
 	char prop_name[MAX_PROP_NAME];
 	int ret;
 
@@ -1757,7 +1718,10 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
 		}
 	}
 
-	generic_phy = devm_phy_create(dev, np, &qcom_qmp_phy_gen_ops);
+	if (qmp->cfg->type == PHY_TYPE_UFS)
+		ops = &qcom_qmp_ufs_ops;
+
+	generic_phy = devm_phy_create(dev, np, ops);
 	if (IS_ERR(generic_phy)) {
 		ret = PTR_ERR(generic_phy);
 		dev_err(dev, "failed to create qphy %d\n", ret);
-- 
2.18.1

