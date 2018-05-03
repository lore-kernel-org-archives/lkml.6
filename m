Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeECLOc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:14:32 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:53647 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751495AbeECLOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:14:20 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520870400";
   d="scan'208";a="447815"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="7302706"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        linux-mmc@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/10] scsi: ufshcd: fix possible unclocked register access
Date: Thu,  3 May 2018 16:37:17 +0530
Message-Id: <7f237069f86547afedcbbdf673cf85dfb20d05fa.1525343531.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1525341340.git.asutoshd@codeaurora.org>
References: <cover.1525341340.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1525343531.git.asutoshd@codeaurora.org>
References: <cover.1525343531.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

vendor specific setup_clocks ops may depend on clocks managed by ufshcd
driver so if the vendor specific setup_clocks callback is called when
the required clocks are turned off, it results into unclocked register
access.

This change make sure that required clocks are enabled before vendor
specific setup_clocks callback is called.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 838ba8f0..dfeb194 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6780,9 +6780,16 @@ static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
 	if (list_empty(head))
 		goto out;
 
-	ret = ufshcd_vops_setup_clocks(hba, on, PRE_CHANGE);
-	if (ret)
-		return ret;
+	/*
+	 * vendor specific setup_clocks ops may depend on clocks managed by
+	 * this standard driver hence call the vendor specific setup_clocks
+	 * before disabling the clocks managed here.
+	 */
+	if (!on) {
+		ret = ufshcd_vops_setup_clocks(hba, on, PRE_CHANGE);
+		if (ret)
+			return ret;
+	}
 
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
@@ -6806,9 +6813,16 @@ static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
 		}
 	}
 
-	ret = ufshcd_vops_setup_clocks(hba, on, POST_CHANGE);
-	if (ret)
-		return ret;
+	/*
+	 * vendor specific setup_clocks ops may depend on clocks managed by
+	 * this standard driver hence call the vendor specific setup_clocks
+	 * after enabling the clocks managed here.
+	 */
+	if (on) {
+		ret = ufshcd_vops_setup_clocks(hba, on, POST_CHANGE);
+		if (ret)
+			return ret;
+	}
 
 out:
 	if (ret) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
