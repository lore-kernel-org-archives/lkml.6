Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8273C218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPWThKxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391495AbfBMX0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46125 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390800AbfBMX0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so1968348pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9HThurJ83+fFieMaOoSrsodQvyRmZformqtiIRg6h8=;
        b=mPWThKxgFRvWtE9dGW9KJ04d/XALQHxc6gmot78iBuNRpVlOr49U8OKBbn93BjB0Qc
         OGpgP1ga7x+di9wqTPAJVnR0/KbWFzu8CEnCfmG4Jx1ebQBdmuxhG4jMHTjEA/nDlsfL
         zIWxjxugdCaQuY/Fjat/fdIBITDKot3VnaeEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9HThurJ83+fFieMaOoSrsodQvyRmZformqtiIRg6h8=;
        b=a8dAq6EyVZj4KCyydtOSonryLmEoVT6xNmn8437iB77uPMAEFyEt3KCETtUoUEWgqm
         fMjw0NsZqmEU5rOF/RFBnjcpMA2eEYe9BBIdkUa8TCmuDOgPlKr7nE+e+mS9CUlJzGwC
         ouThxtsXlVWCgWsQ2P0uu/36XI4EOTzuS3/cGPgZJdCZqodjcKD2Sr+FQnxFMbN5JKj9
         O79lSnUOkDbJCqaH5PNfVzMnq+F38zFKTQcSLIGHAbzxfM2nzNtUMAe5PI3B8OFNjNQj
         I1KhGwC+2kpJMnP1DNX1WbvtlkHpTe/ySlDC97B2P55KifMCDXEcvLq2CFRzBb9kwLwk
         hhng==
X-Gm-Message-State: AHQUAuZBk9i/UvP7p2CLX0x431tFy2Wg/Txsm7rf2HdOL7ewvvQMOGk0
        mbxC7zDJw0O6clFi36Rz2UZMZcDAEW4=
X-Google-Smtp-Source: AHgI3IYN1uHkqYSPZjl+Bg8kEaQJtM4zYetKBDROADjTN4/G0pReWxyRUKa5qmphjL0kHoJvMzjTVw==
X-Received: by 2002:a17:902:8304:: with SMTP id bd4mr704929plb.329.1550100389771;
        Wed, 13 Feb 2019 15:26:29 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:29 -0800 (PST)
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
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] scsi: ufs: qcom: Expose the reset controller for PHY
Date:   Wed, 13 Feb 2019 15:25:24 -0800
Message-Id: <20190213232526.26995-7-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213232526.26995-1-evgreen@chromium.org>
References: <20190213232526.26995-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a reset controller that the phy will later use to control its
own PHY reset in the UFS controller. This will enable the combining
of PHY init functionality into a single function.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

---
Note: The remaining changes in this series need this change, since
the PHYs now depend on getting the reset controller.

Changes in v4: None
Changes in v3:
- Refactor to only expose the reset controller in one change (Stephen).
- Add period to comment (Stephen).
- Reset err to 0 in ignored error case (Stephen).
- Add include of reset-controller.h (Stephen)

Changes in v2:
- Remove include of reset.h (Stephen)
- Fix error print of phy_power_on (Stephen)
- Comment for reset controller warnings on id != 0 (Stephen)
- Add static to ufs_qcom_reset_ops (Stephen).

 drivers/scsi/ufs/Kconfig    |  1 +
 drivers/scsi/ufs/ufs-qcom.c | 52 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-qcom.h |  4 +++
 3 files changed, 57 insertions(+)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 2ddbb26d9c26..63c5c4115981 100644
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
index 3aeadb14aae1..ab05ef5cfdcd 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/reset-controller.h>
 
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
@@ -1147,6 +1153,41 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 	return err;
 }
 
+static int
+ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
+
+	/* Currently this code only knows about a single reset. */
+	WARN_ON(id);
+	ufs_qcom_assert_reset(host->hba);
+	/* provide 1ms delay to let the reset pulse propagate. */
+	usleep_range(1000, 1100);
+	return 0;
+}
+
+static int
+ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
+
+	/* Currently this code only knows about a single reset. */
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
+static const struct reset_control_ops ufs_qcom_reset_ops = {
+	.assert = ufs_qcom_reset_assert,
+	.deassert = ufs_qcom_reset_deassert,
+};
+
 #define	ANDROID_BOOT_DEV_MAX	30
 static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
 
@@ -1191,6 +1232,17 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	host->hba = hba;
 	ufshcd_set_variant(hba, host);
 
+	/* Fire up the reset controller. Failure here is non-fatal. */
+	host->rcdev.of_node = dev->of_node;
+	host->rcdev.ops = &ufs_qcom_reset_ops;
+	host->rcdev.owner = dev->driver->owner;
+	host->rcdev.nr_resets = 1;
+	err = devm_reset_controller_register(dev, &host->rcdev);
+	if (err) {
+		dev_warn(dev, "Failed to register reset controller\n");
+		err = 0;
+	}
+
 	/*
 	 * voting/devoting device ref_clk source is time consuming hence
 	 * skip devoting it during aggressive clock gating. This clock
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index c114826316eb..68a880185752 100644
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
2.20.1

