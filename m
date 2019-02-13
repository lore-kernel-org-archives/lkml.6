Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC0FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C15222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eWG5HMtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393018AbfBMX0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391179AbfBMX0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so1908592pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUWn5i6kFyi3ctVdq6jlMqS1XR9D0DIIis5PdwQb1TQ=;
        b=eWG5HMtUgKklYz2LH40pJAKrX0ecavGBko/aig7HOZi3snnBS2TvJ9FosfqC1mpUqg
         7VB/eIYt8mLI5igL0kdkmiaQD2i4ogL7TLSZuiUBi+E78+sb3VYSSI4KMNjIuj+fZHQ3
         RbppSTqFd+EeIphinCNwrBXh9OhRcjQPagwII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUWn5i6kFyi3ctVdq6jlMqS1XR9D0DIIis5PdwQb1TQ=;
        b=ovtgCoEto/plpgaVK6l7DF+I/Ofkf1qtouTtVFPr0SGNQde3f8aHjMAnonO7MRQOFk
         m/fJqk0KlW4cbQkLSRmUEN11/lXYao2zdV2UvD7mYGoyQAIav0HBdnyfu3u5aH1NvXOp
         q+cSN+J54FwL4pX4SJO18Q3TbD1YBwh/M8qGQq3wQ+s5uZ6MLIT0B0bYRqvfN2ZmBJsW
         l0F/lT1AiEH8TfK+zxgggi7hUo2VpO4xk2B0mfpYumIChR0nQdtcNXURRB2TrAiKjElZ
         2B9TKs4jx0n9+z1CaUNlxSl9R/ef3yvJuU5u/+ardRF8Fr+MxT7ZVfkZxFgw880gjsl7
         JWkQ==
X-Gm-Message-State: AHQUAuYqcQBx7giAoL/tYgxN5+yMcer9/qPLQcu5yqmHywCkdiPjkg9I
        Vl3v14qKIm+susMkQcew+0PEjQ==
X-Google-Smtp-Source: AHgI3IY6dQIAVehCyhvxET9eZDdmAdJEjY5EoVkOvcSBySCvT2XO43a5RU2tmk4Rjhsa/Lx14ewcSQ==
X-Received: by 2002:a62:e086:: with SMTP id d6mr699640pfm.247.1550100392096;
        Wed, 13 Feb 2019 15:26:32 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:31 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
Subject: [PATCH v4 7/8] phy: qcom: Utilize UFS reset controller
Date:   Wed, 13 Feb 2019 15:25:25 -0800
Message-Id: <20190213232526.26995-8-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213232526.26995-1-evgreen@chromium.org>
References: <20190213232526.26995-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PHY reset from ufs-qcom into the respective PHYs. This will
allow us to merge the two phases of UFS PHY initialization.

Signed-off-by: Evan Green <evgreen@chromium.org>

---

Changes in v4:
- Do reset_control_* unconditionally since null is handled (Stephen).

Changes in v3:
- Refactored to move reset control in a single commit (Stephen)
- Use no_pcs_sw_reset as an indicator of UFS reset in qmp-phy (Stephen).
- Assign ret = PTR_ERR() earlier, for better reuse (Stephen).

Changes in v2:
- Use devm_* to get the reset (Stephen)
- Clear ufs_reset on error getting it
- Remove needless error print (Stephen)

 drivers/phy/qualcomm/phy-qcom-qmp.c          | 34 ++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-ufs-i.h        |  3 ++
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c |  8 +++++
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c |  8 +++++
 drivers/phy/qualcomm/phy-qcom-ufs.c          | 23 +++++++++++++
 drivers/scsi/ufs/ufs-qcom.c                  | 18 -----------
 6 files changed, 76 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 08d6f6f7f039..a808887ab4e2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -897,6 +897,7 @@ struct qmp_phy {
  * @init_count: phy common block initialization count
  * @phy_initialized: indicate if PHY has been initialized
  * @mode: current PHY mode
+ * @ufs_reset: optional UFS PHY reset handle
  */
 struct qcom_qmp {
 	struct device *dev;
@@ -914,6 +915,8 @@ struct qcom_qmp {
 	int init_count;
 	bool phy_initialized;
 	enum phy_mode mode;
+
+	struct reset_control *ufs_reset;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -1314,6 +1317,7 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
 		return 0;
 	}
 
+	reset_control_assert(qmp->ufs_reset);
 	if (cfg->has_phy_com_ctrl) {
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
 			     SERDES_START | PCS_START);
@@ -1351,6 +1355,33 @@ static int qcom_qmp_phy_init(struct phy *phy)
 
 	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
 
+	if (cfg->no_pcs_sw_reset) {
+		/*
+		 * Get UFS reset, which is delayed until now to avoid a
+		 * circular dependency where UFS needs its PHY, but the PHY
+		 * needs this UFS reset.
+		 */
+		if (!qmp->ufs_reset) {
+			qmp->ufs_reset =
+				devm_reset_control_get_exclusive(qmp->dev,
+								 "ufsphy");
+
+			if (IS_ERR(qmp->ufs_reset)) {
+				ret = PTR_ERR(qmp->ufs_reset);
+				dev_err(qmp->dev,
+					"failed to get UFS reset: %d\n",
+					ret);
+
+				qmp->ufs_reset = NULL;
+				return ret;
+			}
+		}
+
+		ret = reset_control_assert(qmp->ufs_reset);
+		if (ret)
+			goto err_lane_rst;
+	}
+
 	ret = qcom_qmp_phy_com_init(qphy);
 	if (ret)
 		return ret;
@@ -1383,6 +1414,9 @@ static int qcom_qmp_phy_init(struct phy *phy)
 				       cfg->rx_tbl, cfg->rx_tbl_num);
 
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+	ret = reset_control_deassert(qmp->ufs_reset);
+	if (ret)
+		goto err_lane_rst;
 
 	/*
 	 * UFS PHY requires the deassert of software reset before serdes start.
diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
index f798fb64de94..ba77348d807c 100644
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
@@ -101,6 +102,7 @@ struct ufs_qcom_phy {
 	struct ufs_qcom_phy_specific_ops *phy_spec_ops;
 
 	enum phy_mode mode;
+	struct reset_control *ufs_reset;
 };
 
 /**
@@ -132,6 +134,7 @@ struct phy *ufs_qcom_phy_generic_probe(struct platform_device *pdev,
 			struct ufs_qcom_phy *common_cfg,
 			const struct phy_ops *ufs_qcom_phy_gen_ops,
 			struct ufs_qcom_phy_specific_ops *phy_spec_ops);
+int ufs_qcom_phy_get_reset(struct ufs_qcom_phy *phy_common);
 int ufs_qcom_phy_calibrate(struct ufs_qcom_phy *ufs_qcom_phy,
 			struct ufs_qcom_phy_calibration *tbl_A, int tbl_size_A,
 			struct ufs_qcom_phy_calibration *tbl_B, int tbl_size_B,
diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
index 1e0d4f2046a4..cc343517a2ca 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
@@ -48,6 +48,14 @@ static int ufs_qcom_phy_qmp_14nm_init(struct phy *generic_phy)
 	bool is_rate_B = false;
 	int ret;
 
+	ret = ufs_qcom_phy_get_reset(phy_common);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(phy_common->ufs_reset);
+	if (ret)
+		return ret;
+
 	if (phy_common->mode == PHY_MODE_UFS_HS_B)
 		is_rate_B = true;
 
diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
index aef40f7a41d4..54b2af9d8702 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
@@ -67,6 +67,14 @@ static int ufs_qcom_phy_qmp_20nm_init(struct phy *generic_phy)
 	bool is_rate_B = false;
 	int ret;
 
+	ret = ufs_qcom_phy_get_reset(phy_common);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(phy_common->ufs_reset);
+	if (ret)
+		return ret;
+
 	if (phy_common->mode == PHY_MODE_UFS_HS_B)
 		is_rate_B = true;
 
diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/phy-qcom-ufs.c
index f2979ccad00a..fe59785a55f2 100644
--- a/drivers/phy/qualcomm/phy-qcom-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
@@ -147,6 +147,22 @@ struct phy *ufs_qcom_phy_generic_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(ufs_qcom_phy_generic_probe);
 
+int ufs_qcom_phy_get_reset(struct ufs_qcom_phy *phy_common)
+{
+	struct reset_control *reset;
+
+	if (phy_common->ufs_reset)
+		return 0;
+
+	reset = devm_reset_control_get_exclusive_by_index(phy_common->dev, 0);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	phy_common->ufs_reset = reset;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ufs_qcom_phy_get_reset);
+
 static int __ufs_qcom_phy_clk_get(struct device *dev,
 			 const char *name, struct clk **clk_out, bool err_print)
 {
@@ -533,6 +549,12 @@ int ufs_qcom_phy_power_on(struct phy *generic_phy)
 	if (phy_common->is_powered_on)
 		return 0;
 
+	err = reset_control_deassert(phy_common->ufs_reset);
+	if (err) {
+		dev_err(dev, "Failed to assert UFS PHY reset");
+		return err;
+	}
+
 	if (!phy_common->is_started) {
 		err = ufs_qcom_phy_start_serdes(phy_common);
 		if (err)
@@ -620,6 +642,7 @@ int ufs_qcom_phy_power_off(struct phy *generic_phy)
 
 	ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_pll);
 	ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_phy);
+	reset_control_assert(phy_common->ufs_reset);
 	phy_common->is_powered_on = false;
 
 	return 0;
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index ab05ef5cfdcd..1c25b1c82314 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -261,11 +261,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (is_rate_B)
 		phy_set_mode(phy, PHY_MODE_UFS_HS_B);
 
-	/* Assert PHY reset and apply PHY calibration values */
-	ufs_qcom_assert_reset(hba);
-	/* provide 1ms delay to let the reset pulse propagate */
-	usleep_range(1000, 1100);
-
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
 	if (ret) {
@@ -274,15 +269,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		goto out;
 	}
 
-	/* De-assert PHY reset and start serdes */
-	ufs_qcom_deassert_reset(hba);
-
-	/*
-	 * after reset deassertion, phy will need all ref clocks,
-	 * voltage, current to settle down before starting serdes.
-	 */
-	usleep_range(1000, 1100);
-
 	/* power on phy - start serdes and phy's power and clocks */
 	ret = phy_power_on(phy);
 	if (ret) {
@@ -296,7 +282,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	return 0;
 
 out_disable_phy:
-	ufs_qcom_assert_reset(hba);
 	phy_exit(phy);
 out:
 	return ret;
@@ -559,9 +544,6 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		 */
 		ufs_qcom_disable_lane_clks(host);
 		phy_power_off(phy);
-
-		/* Assert PHY soft reset */
-		ufs_qcom_assert_reset(hba);
 		goto out;
 	}
 
-- 
2.20.1

