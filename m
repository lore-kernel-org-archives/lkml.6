Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeECLPs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:15:48 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:12748 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751128AbeECLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:14:17 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520870400";
   d="scan'208";a="443714"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="7390445"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        linux-mmc@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/10] scsi: ufs: Allowing power mode change
Date: Thu,  3 May 2018 16:37:13 +0530
Message-Id: <75e5ea5901004ef95b37aed719686214910f6541.1525343531.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1525341340.git.asutoshd@codeaurora.org>
References: <cover.1525341340.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1525343531.git.asutoshd@codeaurora.org>
References: <cover.1525343531.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaniv Gardi <ygardi@codeaurora.org>

Due to M-PHY issues, moving from HS to any other mode or gear or
even Hibern8 may cause some un-predicted behavior
of the device.
This patch adds provides a quirk to address that.

Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 8 +++++++-
 drivers/scsi/ufs/ufshcd.h | 7 +++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5bc9dc1..f3083fe 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4162,9 +4162,15 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 			goto out;
 	} while (ret && retries--);
 
-	if (ret)
+	if (ret) {
 		/* failed to get the link up... retire */
 		goto out;
+	}
+
+	if (hba->quirks & UFSHCD_QUIRK_BROKEN_PWR_MODE_CHANGE) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 0);
+		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 1);
+	}
 
 	if (link_startup_again) {
 		link_startup_again = false;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index cbe46f6..bb4ecfb 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -591,6 +591,13 @@ struct ufs_hba {
 	 */
 	#define UFSHCD_QUIRK_PRDT_BYTE_GRAN			UFS_BIT(7)
 
+	/*
+	 * Needs to be enabled if moving from HS to any other gear/mode or even
+	 * hibern8 causes unpredicted behavior of device.
+	 * If this quirk is enabled, standard UFS driver will disable/enable
+	 * TX_LCC.
+	 */
+	#define UFSHCD_QUIRK_BROKEN_PWR_MODE_CHANGE		UFS_BIT(8)
 	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */
 
 	/* Device deviations from standard UFS device spec. */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
