Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5024C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0F2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="REaVZV+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfAKXCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:02:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41016 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAKXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:02:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so7388901plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KydVlJwK6Ys8i69HFMTYvx3bGzRdoFbTK+K9HJAEBI=;
        b=REaVZV+gUaM60DzHiNMe0Mff2cM3pV30tfWJQyLgRsTN+AoG0ydepeVRVxnA/vfvXK
         OnmEVyTXTP9XXkYufawHYaUZz3N6NFDTntHQg/L19NK9EhlmJRJZRERRhWyG8Te8Tog9
         p0eU/Fn6JVAIiaL+XN0kxlP7nsLQX8pp3Hps0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KydVlJwK6Ys8i69HFMTYvx3bGzRdoFbTK+K9HJAEBI=;
        b=m2rG3ZMXhFiAGU3wPVRUdPr49X2JhitTE6k3y9qoDBkIk63l8yk1gAgcQvDqmloQUS
         qAGYzTgMos0DBLPCZ69TbiNI2AfMfuWTOiIkeoQlq4akDBVwOAfxHBBDLbWeGAFDf5UU
         YgjjG0B7r6irrYNKiep8P0Yfgo03/Uh1fqvWnbfVqa5G8qtRCVnMmb9Bebm9xktNZGmg
         uGek5PRaGhI/qx3MTdPf4GpWIhEVDzcZTzxC7QiiP3Dc85S+0ySrB/QFUWbeZaIekZGM
         kPQCQrwWsxvQzXTAJoRrn6nZqfZtB7869Bpo1s+oiJv3QMk9wYUIkkrKq6wBgS63JBGz
         dBeA==
X-Gm-Message-State: AJcUukccvtcnd5UywFIKw4VSB1qiCO8+cGkYqvoTB+YiPlfjJ4rYZZTV
        oUvx5qZ16Bgvg1buqxhF511gCg==
X-Google-Smtp-Source: ALg8bN7cCF6Wr9MgK2MuoASVT+xpe/sQZ9mILNlJMdQHtv70uUgwp2LJTDTFmJ/MWNcoQr5udwvx4w==
X-Received: by 2002:a17:902:2868:: with SMTP id e95mr16529191plb.317.1547247730301;
        Fri, 11 Jan 2019 15:02:10 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm116045186pfr.55.2019.01.11.15.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 15:02:09 -0800 (PST)
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
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/8] scsi: ufs: qcom: Expose the reset controller for PHY
Date:   Fri, 11 Jan 2019 15:01:26 -0800
Message-Id: <20190111230129.127037-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190111230129.127037-1-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a reset controller that the phy can use to perform its
initialization in a single callback.

Also, change the use of the phy functions from ufs-qcom such that
phy_poweron actually fires up the phy, and phy_poweroff actually
powers it down.

Signed-off-by: Evan Green <evgreen@chromium.org>

---
Note: This change depends on the remaining changes in this series,
since UFS PHY reset now needs to be done by the PHY driver.

 drivers/scsi/ufs/Kconfig    |   1 +
 drivers/scsi/ufs/ufs-qcom.c | 110 +++++++++++++++++++++---------------
 drivers/scsi/ufs/ufs-qcom.h |   4 ++
 3 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 2ddbb26d9c265..63c5c4115981f 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -100,6 +100,7 @@ config SCSI_UFS_QCOM
 	tristate "QCOM specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
 	select PHY_QCOM_UFS
+	select RESET_CONTROLLER
 	help
 	  This selects the QCOM specific additions to UFSHCD platform driver.
 	  UFS host on QCOM needs some vendor specific configuration before
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 3aeadb14aae1e..db46f9a64b54c 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/reset.h>
 
 #include "ufshcd.h"
 #include "ufshcd-pltfrm.h"
@@ -49,6 +50,11 @@ static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
 static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 						       u32 clk_cycles);
 
+static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
+{
+	return container_of(rcd, struct ufs_qcom_host, rcdev);
+}
+
 static void ufs_qcom_dump_regs_wrapper(struct ufs_hba *hba, int offset, int len,
 				       const char *prefix, void *priv)
 {
@@ -255,11 +261,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
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
@@ -268,15 +269,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
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
@@ -290,7 +282,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	return 0;
 
 out_disable_phy:
-	ufs_qcom_assert_reset(hba);
 	phy_exit(phy);
 out:
 	return ret;
@@ -554,21 +545,10 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ufs_qcom_disable_lane_clks(host);
 		phy_power_off(phy);
 
-		/* Assert PHY soft reset */
-		ufs_qcom_assert_reset(hba);
-		goto out;
-	}
-
-	/*
-	 * If UniPro link is not active, PHY ref_clk, main PHY analog power
-	 * rail and low noise analog power rail for PLL can be switched off.
-	 */
-	if (!ufs_qcom_is_link_active(hba)) {
+	} else if (!ufs_qcom_is_link_active(hba)) {
 		ufs_qcom_disable_lane_clks(host);
-		phy_power_off(phy);
 	}
 
-out:
 	return ret;
 }
 
@@ -578,21 +558,26 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	struct phy *phy = host->generic_phy;
 	int err;
 
-	err = phy_power_on(phy);
-	if (err) {
-		dev_err(hba->dev, "%s: failed enabling regs, err = %d\n",
-			__func__, err);
-		goto out;
-	}
+	if (ufs_qcom_is_link_off(hba)) {
+		err = phy_power_on(phy);
+		if (err) {
+			dev_err(hba->dev, "%s: failed enabling regs, err = %d\n",
+				__func__, err);
+			return err;
+		}
 
-	err = ufs_qcom_enable_lane_clks(host);
-	if (err)
-		goto out;
+		err = ufs_qcom_enable_lane_clks(host);
+		if (err)
+			return err;
 
-	hba->is_sys_suspended = false;
+	} else if (!ufs_qcom_is_link_active(hba)) {
+		err = ufs_qcom_enable_lane_clks(host);
+		if (err)
+			return err;
+	}
 
-out:
-	return err;
+	hba->is_sys_suspended = false;
+	return 0;
 }
 
 struct ufs_qcom_dev_params {
@@ -1118,8 +1103,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 		return 0;
 
 	if (on && (status == POST_CHANGE)) {
-		phy_power_on(host->generic_phy);
-
 		/* enable the device ref clock for HS mode*/
 		if (ufshcd_is_hs_mode(&hba->pwr_info))
 			ufs_qcom_dev_ref_clk_ctrl(host, true);
@@ -1131,9 +1114,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 		if (!ufs_qcom_is_link_active(hba)) {
 			/* disable device ref_clk */
 			ufs_qcom_dev_ref_clk_ctrl(host, false);
-
-			/* powering off PHY during aggressive clk gating */
-			phy_power_off(host->generic_phy);
 		}
 
 		vote = host->bus_vote.min_bw_vote;
@@ -1147,6 +1127,39 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 	return err;
 }
 
+static int
+ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
+
+	WARN_ON(id);
+	ufs_qcom_assert_reset(host->hba);
+	/* provide 1ms delay to let the reset pulse propagate */
+	usleep_range(1000, 1100);
+	return 0;
+}
+
+static int
+ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
+
+	WARN_ON(id);
+	ufs_qcom_deassert_reset(host->hba);
+
+	/*
+	 * after reset deassertion, phy will need all ref clocks,
+	 * voltage, current to settle down before starting serdes.
+	 */
+	usleep_range(1000, 1100);
+	return 0;
+}
+
+const struct reset_control_ops ufs_qcom_reset_ops = {
+	.assert = ufs_qcom_reset_assert,
+	.deassert = ufs_qcom_reset_deassert,
+};
+
 #define	ANDROID_BOOT_DEV_MAX	30
 static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
 
@@ -1191,6 +1204,15 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	host->hba = hba;
 	ufshcd_set_variant(hba, host);
 
+	/* Fire up the reset controller. Failure here is non-fatal. */
+	host->rcdev.of_node = dev->of_node;
+	host->rcdev.ops = &ufs_qcom_reset_ops;
+	host->rcdev.owner = dev->driver->owner;
+	host->rcdev.nr_resets = 1;
+	err = devm_reset_controller_register(dev, &host->rcdev);
+	if (err)
+		dev_warn(dev, "Failed to register reset controller\n");
+
 	/*
 	 * voting/devoting device ref_clk source is time consuming hence
 	 * skip devoting it during aggressive clock gating. This clock
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index c114826316eb0..68a8801857529 100644
--- a/drivers/scsi/ufs/ufs-qcom.h
+++ b/drivers/scsi/ufs/ufs-qcom.h
@@ -14,6 +14,8 @@
 #ifndef UFS_QCOM_H_
 #define UFS_QCOM_H_
 
+#include <linux/reset-controller.h>
+
 #define MAX_UFS_QCOM_HOSTS	1
 #define MAX_U32                 (~(u32)0)
 #define MPHY_TX_FSM_STATE       0x41
@@ -237,6 +239,8 @@ struct ufs_qcom_host {
 	/* Bitmask for enabling debug prints */
 	u32 dbg_print_en;
 	struct ufs_qcom_testbus testbus;
+
+	struct reset_controller_dev rcdev;
 };
 
 static inline u32
-- 
2.18.1

