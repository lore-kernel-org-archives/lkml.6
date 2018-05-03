Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbeECLOZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:14:25 -0400
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:12748 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751453AbeECLOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:14:15 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520870400";
   d="scan'208";a="443707"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="7390446"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        linux-mmc@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/10] scsi: ufs: fix exception event handling
Date: Thu,  3 May 2018 16:37:16 +0530
Message-Id: <01e6421c38e4eb1f67f3c98a8dab44a85f791ef2.1525343531.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1525341340.git.asutoshd@codeaurora.org>
References: <cover.1525341340.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1525343531.git.asutoshd@codeaurora.org>
References: <cover.1525343531.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maya Erez <merez@codeaurora.org>

The device can set the exception event bit in one of the response UPIU,
for example to notify the need for urgent BKOPs operation.
In such a case the host driver calls ufshcd_exception_event_handler to
handle this notification.
When trying to check the exception event status (for finding the cause for
the exception event), the device may be busy with additional SCSI commands
handling and may not respond within the 100ms timeout.

To prevent that, we need to block SCSI commands during handling of
exception events and allow retransmissions of the query requests,
in case of timeout.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 6dabce8..838ba8f0 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4967,6 +4967,7 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 	hba = container_of(work, struct ufs_hba, eeh_work);
 
 	pm_runtime_get_sync(hba->dev);
+	scsi_block_requests(hba->host);
 	err = ufshcd_get_ee_status(hba, &status);
 	if (err) {
 		dev_err(hba->dev, "%s: failed to get exception status %d\n",
@@ -4980,6 +4981,7 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 		ufshcd_bkops_exception_event_handler(hba);
 
 out:
+	scsi_unblock_requests(hba->host);
 	pm_runtime_put_sync(hba->dev);
 	return;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
