Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeBUFEF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:04:05 -0500
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:64584 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751180AbeBUFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:03:23 -0500
X-IronPort-AV: E=Sophos;i="5.46,542,1511798400";
   d="scan'208";a="719"
X-IronPort-AV: E=McAfee;i="5900,7806,8810"; a="2373330"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/9] scsi: ufs: Add LCC quirk for host and device
Date: Wed, 21 Feb 2018 10:26:33 +0530
Message-Id: <9ba83c0585b9354f6d521c51fbfdc4acf6bf760e.1519120988.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

LCC (Line Control Command) is being used for communication between
UFS host and UFS device. But some hosts might have the issue with
issuing the LCC commands to UFS device and in this case LCC could be
explicitly disabled.

But there could be a need where we don't want to disable the LCC
on both host & device; hence this change splits the quirk in 2 parts
one for host and one for device.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 16 ++++++++++++++++
 drivers/scsi/ufs/ufshcd.h | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d74d529..cc7eb1e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4121,6 +4121,11 @@ static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
 	return err;
 }
 
+static inline int ufshcd_disable_host_tx_lcc(struct ufs_hba *hba)
+{
+	return ufshcd_disable_tx_lcc(hba, false);
+}
+
 static inline int ufshcd_disable_device_tx_lcc(struct ufs_hba *hba)
 {
 	return ufshcd_disable_tx_lcc(hba, true);
@@ -4175,6 +4180,17 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 		ufshcd_dme_set(hba, UIC_ARG_MIB(TX_LCC_ENABLE), 1);
 	}
 
+	if (hba->quirks & UFSHCD_BROKEN_LCC_PROCESSING_ON_HOST) {
+		ret = ufshcd_disable_device_tx_lcc(hba);
+		if (ret)
+			goto out;
+	}
+
+	if (hba->quirks & UFSHCD_BROKEN_LCC_PROCESSING_ON_DEVICE) {
+		ret = ufshcd_disable_host_tx_lcc(hba);
+		if (ret)
+			goto out;
+	}
 	if (link_startup_again) {
 		link_startup_again = false;
 		retries = DME_LINKSTARTUP_RETRIES;
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1332e54..7a2dad3 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -591,6 +591,17 @@ struct ufs_hba {
 	 */
 	#define UFSHCD_QUIRK_PRDT_BYTE_GRAN			0x80
 
+	/*
+	 * If UFS device is having issue in processing LCC (Line Control
+	 * Command) coming from UFS host controller then enable this quirk.
+	 * When this quirk is enabled, host controller driver should disable
+	 * the LCC transmission on UFS host controller (by clearing
+	 * TX_LCC_ENABLE attribute of host to 0).
+	 */
+	#define UFSHCD_BROKEN_LCC_PROCESSING_ON_DEVICE		0x100
+
+	#define UFSHCD_BROKEN_LCC_PROCESSING_ON_HOST		0x200
+
 	unsigned int quirks;	/* Deviations from standard UFSHCI spec. */
 
 	/* Device deviations from standard UFS device spec. */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
