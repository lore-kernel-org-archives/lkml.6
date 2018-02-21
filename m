Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeBUFG4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:06:56 -0500
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:54422 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750708AbeBUFGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:06:55 -0500
X-IronPort-AV: E=Sophos;i="5.46,542,1511798400";
   d="scan'208";a="1470"
X-IronPort-AV: E=McAfee;i="5900,7806,8810"; a="2386723"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/9] scsi: ufs: fix exception event handling
Date: Wed, 21 Feb 2018 10:26:34 +0530
Message-Id: <4a1bc83d4554e5f343de9e95fec8a33e203b321e.1519120988.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
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
index cc7eb1e..8d3f8ce 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4972,6 +4972,7 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 	hba = container_of(work, struct ufs_hba, eeh_work);
 
 	pm_runtime_get_sync(hba->dev);
+	scsi_block_requests(hba->host);
 	err = ufshcd_get_ee_status(hba, &status);
 	if (err) {
 		dev_err(hba->dev, "%s: failed to get exception status %d\n",
@@ -4985,6 +4986,7 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
 		ufshcd_bkops_exception_event_handler(hba);
 
 out:
+	scsi_unblock_requests(hba->host);
 	pm_runtime_put_sync(hba->dev);
 	return;
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
