Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDINYT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:24:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59032 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeDINYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:24:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA8EF601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: martin.petersen@oracle.com, kishon@ti.com
Cc: jejb@linux.vnet.ibm.com, subhashj@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/1] scsi/ufs: qcom: Don't enable PHY_QCOM_UFS by default
Date: Mon,  9 Apr 2018 18:54:04 +0530
Message-Id: <20180409132404.20876-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we try to transition from a separate ufs phy driver to a
more integrated qmp phy driver, don't let SCSI_UFS_QCOM to
enable PHY_QCOM_UFS config by default.
The users should enable this in their defconfigs.
Also add inline definitions for couple of functions -
a) ufs_qcom_phy_set_tx_lane_enable()
b) void ufs_qcom_phy_save_controller_version()
to enable clean build for SCSI_UFS_QCOM.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/scsi/ufs/Kconfig         |  1 -
 include/linux/phy/phy-qcom-ufs.h | 15 ++++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index e27b4d4e6ae2..7e8898b6eb67 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -91,7 +91,6 @@ config SCSI_UFS_DWC_TC_PLATFORM
 config SCSI_UFS_QCOM
 	tristate "QCOM specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
-	select PHY_QCOM_UFS
 	help
 	  This selects the QCOM specific additions to UFSHCD platform driver.
 	  UFS host on QCOM needs some vendor specific configuration before
diff --git a/include/linux/phy/phy-qcom-ufs.h b/include/linux/phy/phy-qcom-ufs.h
index 0a2c18a9771d..1388c2a2965e 100644
--- a/include/linux/phy/phy-qcom-ufs.h
+++ b/include/linux/phy/phy-qcom-ufs.h
@@ -31,8 +31,21 @@ void ufs_qcom_phy_enable_dev_ref_clk(struct phy *phy);
  */
 void ufs_qcom_phy_disable_dev_ref_clk(struct phy *phy);
 
+#if IS_ENABLED(CONFIG_PHY_QCOM_UFS)
 int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes);
 void ufs_qcom_phy_save_controller_version(struct phy *phy,
-			u8 major, u16 minor, u16 step);
+					  u8 major, u16 minor, u16 step);
+#else
+static inline int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes)
+{
+	return -ENOSYS;
+}
+
+static inline void ufs_qcom_phy_save_controller_version(struct phy *phy,
+							u8 major, u16 minor,
+							u16 step)
+{
+}
+#endif /* PHY_QCOM_UFS */
 
 #endif /* PHY_QCOM_UFS_H_ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
