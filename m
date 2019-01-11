Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B743C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4886B21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P5PsoN9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfAKXCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:02:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39166 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAKXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:02:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so7608717pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nc8zOqvU/BYO5yX/GyinA9uO6UDOhslefwMFhbwZSoI=;
        b=P5PsoN9HWf6UOB5fqArSwWe5wQSGMEm60qsES6NfGSoyPg8BhLa1H6O4Tr5gvThSB8
         1sJUxnqmiggQQGF6lwq2Sl3Qt/en0wtFi5o+gr0oYfdbLi27CG/+JJK8jSP9BXoEe0i+
         LwDlM9ezew0z1Lpy4tUdNAWDJI84S9XISu3Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nc8zOqvU/BYO5yX/GyinA9uO6UDOhslefwMFhbwZSoI=;
        b=eHsRx665h6X5BQezGFjiLok8Pf6uXyMsmutHFIGVKubgZfVa/jODfFztIghs+Q4NgY
         locKO5M/Vf9YqikmELnKVGyroj7nvlmxlWZYo75sGj6x8wufgO1skuTXq8o4o74+XrOA
         d28MgFhmzQhGr4R0hbOBxgC5dlgladbCBxaT5DqaPYRXLKByHxDCeS4OT+7i0OXlJhA3
         w1jo09be8vZMj5LKdKDTL00Lr77t6Pd8ZhQxz0ZLuXVRYfSNstimEeVdey78hBE5Od+A
         YT4/7jfbwFSRKFZjMRByGEODELhj8alwQqo38DzD/VKA9SF/JOdGdQaTpdyyayU4b6V4
         QkXw==
X-Gm-Message-State: AJcUukfzdwC4+SUtWW8W2oqIvyE8wy+c6b+Wwbh+GOTBDsKWVZxVqyjj
        sner3yB4zGlW6jaBGIMzjnucmw==
X-Google-Smtp-Source: ALg8bN684BXwqhN1BtTlZt1EyatKdKlCqs0Mf+jfOQmY1MkMt8jQV+4NLa3Rq8VRM1MgGQqTeDqG+A==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr12777106pgh.265.1547247741982;
        Fri, 11 Jan 2019 15:02:21 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:02:21 -0800 (PST)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v1 8/8] phy: qcom-ufs: Refactor all init steps into phy_poweron
Date:   Fri, 11 Jan 2019 15:01:29 -0800
Message-Id: <20190111230129.127037-9-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy code was using implicit sequencing between the PHY driver
and the UFS driver to implement certain hardware requirements.
Specifically, the PHY reset register in the UFS controller needs
to be deasserted before serdes start occurs in the PHY.

Before this change, the code was doing this by utilizing the two
phy callbacks, phy_init and phy_poweron, as "init step 1" and
"init step 2", where the UFS driver would deassert reset between
these two steps.

This makes it challenging to power off the regulators in suspend,
as regulators are initialized in init, not in poweron, but only
poweroff is called during suspend, not exit.

Consolidate the initialization code into phy_poweron, and utilize
the reset controller exported from the UFS driver to explicitly
perform all the steps needed to initialize the PHY.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/phy/qualcomm/phy-qcom-ufs-i.h        |  5 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c | 25 +--------
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c | 25 +--------
 drivers/phy/qualcomm/phy-qcom-ufs.c          | 57 +++++++++++++++-----
 4 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
index 681644e43248c..404b365c114df 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
+++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -113,11 +114,10 @@ struct ufs_qcom_phy {
 	char name[UFS_QCOM_PHY_NAME_LEN];
 	struct ufs_qcom_phy_calibration *cached_regs;
 	int cached_regs_table_size;
-	bool is_powered_on;
-	bool is_started;
 	struct ufs_qcom_phy_specific_ops *phy_spec_ops;
 
 	enum phy_mode mode;
+	struct reset_control *ufs_reset;
 };
 
 /**
@@ -132,6 +132,7 @@ struct ufs_qcom_phy {
  * and writes to QSERDES_RX_SIGDET_CNTRL attribute
  */
 struct ufs_qcom_phy_specific_ops {
+	int (*calibrate)(struct ufs_qcom_phy *ufs_qcom_phy, bool is_rate_B);
 	void (*start_serdes)(struct ufs_qcom_phy *phy);
 	int (*is_physical_coding_sublayer_ready)(struct ufs_qcom_phy *phy);
 	void (*set_tx_lane_enable)(struct ufs_qcom_phy *phy, u32 val);
diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
index 1e0d4f2046a45..4815546f228cd 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
@@ -42,28 +42,6 @@ void ufs_qcom_phy_qmp_14nm_advertise_quirks(struct ufs_qcom_phy *phy_common)
 		UFS_QCOM_PHY_QUIRK_HIBERN8_EXIT_AFTER_PHY_PWR_COLLAPSE;
 }
 
-static int ufs_qcom_phy_qmp_14nm_init(struct phy *generic_phy)
-{
-	struct ufs_qcom_phy *phy_common = get_ufs_qcom_phy(generic_phy);
-	bool is_rate_B = false;
-	int ret;
-
-	if (phy_common->mode == PHY_MODE_UFS_HS_B)
-		is_rate_B = true;
-
-	ret = ufs_qcom_phy_qmp_14nm_phy_calibrate(phy_common, is_rate_B);
-	if (!ret)
-		/* phy calibrated, but yet to be started */
-		phy_common->is_started = false;
-
-	return ret;
-}
-
-static int ufs_qcom_phy_qmp_14nm_exit(struct phy *generic_phy)
-{
-	return 0;
-}
-
 static
 int ufs_qcom_phy_qmp_14nm_set_mode(struct phy *generic_phy,
 				   enum phy_mode mode, int submode)
@@ -124,8 +102,6 @@ static int ufs_qcom_phy_qmp_14nm_is_pcs_ready(struct ufs_qcom_phy *phy_common)
 }
 
 static const struct phy_ops ufs_qcom_phy_qmp_14nm_phy_ops = {
-	.init		= ufs_qcom_phy_qmp_14nm_init,
-	.exit		= ufs_qcom_phy_qmp_14nm_exit,
 	.power_on	= ufs_qcom_phy_power_on,
 	.power_off	= ufs_qcom_phy_power_off,
 	.set_mode	= ufs_qcom_phy_qmp_14nm_set_mode,
@@ -133,6 +109,7 @@ static const struct phy_ops ufs_qcom_phy_qmp_14nm_phy_ops = {
 };
 
 static struct ufs_qcom_phy_specific_ops phy_14nm_ops = {
+	.calibrate		= ufs_qcom_phy_qmp_14nm_phy_calibrate,
 	.start_serdes		= ufs_qcom_phy_qmp_14nm_start_serdes,
 	.is_physical_coding_sublayer_ready = ufs_qcom_phy_qmp_14nm_is_pcs_ready,
 	.set_tx_lane_enable	= ufs_qcom_phy_qmp_14nm_set_tx_lane_enable,
diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
index aef40f7a41d49..f1cf819e12eae 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
@@ -61,28 +61,6 @@ void ufs_qcom_phy_qmp_20nm_advertise_quirks(struct ufs_qcom_phy *phy_common)
 		UFS_QCOM_PHY_QUIRK_HIBERN8_EXIT_AFTER_PHY_PWR_COLLAPSE;
 }
 
-static int ufs_qcom_phy_qmp_20nm_init(struct phy *generic_phy)
-{
-	struct ufs_qcom_phy *phy_common = get_ufs_qcom_phy(generic_phy);
-	bool is_rate_B = false;
-	int ret;
-
-	if (phy_common->mode == PHY_MODE_UFS_HS_B)
-		is_rate_B = true;
-
-	ret = ufs_qcom_phy_qmp_20nm_phy_calibrate(phy_common, is_rate_B);
-	if (!ret)
-		/* phy calibrated, but yet to be started */
-		phy_common->is_started = false;
-
-	return ret;
-}
-
-static int ufs_qcom_phy_qmp_20nm_exit(struct phy *generic_phy)
-{
-	return 0;
-}
-
 static
 int ufs_qcom_phy_qmp_20nm_set_mode(struct phy *generic_phy,
 				   enum phy_mode mode, int submode)
@@ -182,8 +160,6 @@ static int ufs_qcom_phy_qmp_20nm_is_pcs_ready(struct ufs_qcom_phy *phy_common)
 }
 
 static const struct phy_ops ufs_qcom_phy_qmp_20nm_phy_ops = {
-	.init		= ufs_qcom_phy_qmp_20nm_init,
-	.exit		= ufs_qcom_phy_qmp_20nm_exit,
 	.power_on	= ufs_qcom_phy_power_on,
 	.power_off	= ufs_qcom_phy_power_off,
 	.set_mode	= ufs_qcom_phy_qmp_20nm_set_mode,
@@ -191,6 +167,7 @@ static const struct phy_ops ufs_qcom_phy_qmp_20nm_phy_ops = {
 };
 
 static struct ufs_qcom_phy_specific_ops phy_20nm_ops = {
+	.calibrate		= ufs_qcom_phy_qmp_20nm_phy_calibrate,
 	.start_serdes		= ufs_qcom_phy_qmp_20nm_start_serdes,
 	.is_physical_coding_sublayer_ready = ufs_qcom_phy_qmp_20nm_is_pcs_ready,
 	.set_tx_lane_enable	= ufs_qcom_phy_qmp_20nm_set_tx_lane_enable,
diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
index f2979ccad00a3..a4cff17fef925 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
@@ -147,6 +147,21 @@ struct phy *ufs_qcom_phy_generic_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(ufs_qcom_phy_generic_probe);
 
+static int ufs_qcom_phy_get_reset(struct ufs_qcom_phy *phy_common)
+{
+	struct reset_control *reset;
+
+	if (phy_common->ufs_reset)
+		return 0;
+
+	reset = of_reset_control_get_by_index(phy_common->dev->of_node, 0);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	phy_common->ufs_reset = reset;
+	return 0;
+}
+
 static int __ufs_qcom_phy_clk_get(struct device *dev,
 			 const char *name, struct clk **clk_out, bool err_print)
 {
@@ -528,23 +543,42 @@ int ufs_qcom_phy_power_on(struct phy *generic_phy)
 {
 	struct ufs_qcom_phy *phy_common = get_ufs_qcom_phy(generic_phy);
 	struct device *dev = phy_common->dev;
+	bool is_rate_B = false;
 	int err;
 
-	if (phy_common->is_powered_on)
-		return 0;
+	err = ufs_qcom_phy_get_reset(phy_common);
+	if (err)
+		return err;
 
-	if (!phy_common->is_started) {
-		err = ufs_qcom_phy_start_serdes(phy_common);
+	if (phy_common->ufs_reset) {
+		err = reset_control_assert(phy_common->ufs_reset);
 		if (err)
 			return err;
+	}
 
-		err = ufs_qcom_phy_is_pcs_ready(phy_common);
-		if (err)
-			return err;
+	if (phy_common->mode == PHY_MODE_UFS_HS_B)
+		is_rate_B = true;
 
-		phy_common->is_started = true;
+	err = phy_common->phy_spec_ops->calibrate(phy_common, is_rate_B);
+	if (err)
+		return err;
+
+	if (phy_common->ufs_reset) {
+		err = reset_control_deassert(phy_common->ufs_reset);
+		if (err) {
+			dev_err(dev, "Failed to assert UFS PHY reset");
+			return err;
+		}
 	}
 
+	err = ufs_qcom_phy_start_serdes(phy_common);
+	if (err)
+		return err;
+
+	err = ufs_qcom_phy_is_pcs_ready(phy_common);
+	if (err)
+		return err;
+
 	err = ufs_qcom_phy_enable_vreg(dev, &phy_common->vdda_phy);
 	if (err) {
 		dev_err(dev, "%s enable vdda_phy failed, err=%d\n",
@@ -587,7 +621,6 @@ int ufs_qcom_phy_power_on(struct phy *generic_phy)
 		}
 	}
 
-	phy_common->is_powered_on = true;
 	goto out;
 
 out_disable_ref_clk:
@@ -607,9 +640,6 @@ int ufs_qcom_phy_power_off(struct phy *generic_phy)
 {
 	struct ufs_qcom_phy *phy_common = get_ufs_qcom_phy(generic_phy);
 
-	if (!phy_common->is_powered_on)
-		return 0;
-
 	phy_common->phy_spec_ops->power_control(phy_common, false);
 
 	if (phy_common->vddp_ref_clk.reg)
@@ -620,7 +650,8 @@ int ufs_qcom_phy_power_off(struct phy *generic_phy)
 
 	ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_pll);
 	ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_phy);
-	phy_common->is_powered_on = false;
+	if (phy_common->ufs_reset)
+		reset_control_assert(phy_common->ufs_reset);
 
 	return 0;
 }
-- 
2.18.1

