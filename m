Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeBUFEY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:04:24 -0500
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:64432 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750709AbeBUFDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:03:21 -0500
X-IronPort-AV: E=Sophos;i="5.46,542,1511798400";
   d="scan'208";a="716"
X-IronPort-AV: E=McAfee;i="5900,7806,8810"; a="2373334"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/9] scsi: ufs: add reference counting for scsi block requests
Date: Wed, 21 Feb 2018 10:26:36 +0530
Message-Id: <ff8f06512eca0c6275d3d486af0d430d8111c451.1519120988.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

Currently we call the scsi_block_requests()/scsi_unblock_requests()
whenever we want to block/unblock scsi requests but as there is no
reference counting, nesting of these calls could leave us in undesired
state sometime. Consider following call flow sequence:
1. func1() calls scsi_block_requests() but calls func2() before
   calling scsi_unblock_requests()
2. func2() calls scsi_block_requests()
3. func2() calls scsi_unblock_requests()
4. func1() calls scsi_unblock_requests()

As there is no reference counting, we will have scsi requests unblocked
after #3 instead of it to be unblocked only after #4. Though we may not
have failures seen with this, we might run into some failures in future.
Better solution would be to fix this by adding reference counting.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 44 +++++++++++++++++++++++++++++++++++++-------
 drivers/scsi/ufs/ufshcd.h |  5 +++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 7a4df95..987b81b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -264,6 +264,36 @@ static inline void ufshcd_disable_irq(struct ufs_hba *hba)
 	}
 }
 
+void ufshcd_scsi_unblock_requests(struct ufs_hba *hba)
+{
+	unsigned long flags;
+	bool unblock = false;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	hba->scsi_block_reqs_cnt--;
+	unblock = !hba->scsi_block_reqs_cnt;
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	if (unblock)
+		scsi_unblock_requests(hba->host);
+}
+EXPORT_SYMBOL(ufshcd_scsi_unblock_requests);
+
+static inline void __ufshcd_scsi_block_requests(struct ufs_hba *hba)
+{
+	if (!hba->scsi_block_reqs_cnt++)
+		scsi_block_requests(hba->host);
+}
+
+void ufshcd_scsi_block_requests(struct ufs_hba *hba)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(hba->host->host_lock, flags);
+	__ufshcd_scsi_block_requests(hba);
+	spin_unlock_irqrestore(hba->host->host_lock, flags);
+}
+EXPORT_SYMBOL(ufshcd_scsi_block_requests);
+
 /* replace non-printable or non-ASCII characters with spaces */
 static inline void ufshcd_remove_non_printable(char *val)
 {
@@ -1079,12 +1109,12 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
 	 * make sure that there are no outstanding requests when
 	 * clock scaling is in progress
 	 */
-	scsi_block_requests(hba->host);
+	ufshcd_scsi_block_requests(hba);
 	down_write(&hba->clk_scaling_lock);
 	if (ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
 		ret = -EBUSY;
 		up_write(&hba->clk_scaling_lock);
-		scsi_unblock_requests(hba->host);
+		ufshcd_scsi_unblock_requests(hba);
 	}
 
 	return ret;
@@ -1093,7 +1123,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
 static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba)
 {
 	up_write(&hba->clk_scaling_lock);
-	scsi_unblock_requests(hba->host);
+	ufshcd_scsi_unblock_requests(hba);
 }
 
 /**
@@ -1413,7 +1443,7 @@ static void ufshcd_ungate_work(struct work_struct *work)
 		hba->clk_gating.is_suspended = false;
 	}
 unblock_reqs:
-	scsi_unblock_requests(hba->host);
+	ufshcd_scsi_unblock_requests(hba);
 }
 
 /**
@@ -1469,7 +1499,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 * work and to enable clocks.
 		 */
 	case CLKS_OFF:
-		scsi_block_requests(hba->host);
+		__ufshcd_scsi_block_requests(hba);
 		hba->clk_gating.state = REQ_CLKS_ON;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
@@ -5197,7 +5227,7 @@ static void ufshcd_err_handler(struct work_struct *work)
 
 out:
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	scsi_unblock_requests(hba->host);
+	ufshcd_scsi_unblock_requests(hba);
 	ufshcd_release(hba);
 	pm_runtime_put_sync(hba->dev);
 }
@@ -5299,7 +5329,7 @@ static void ufshcd_check_errors(struct ufs_hba *hba)
 		/* handle fatal errors only when link is functional */
 		if (hba->ufshcd_state == UFSHCD_STATE_OPERATIONAL) {
 			/* block commands from scsi mid-layer */
-			scsi_block_requests(hba->host);
+			__ufshcd_scsi_block_requests(hba);
 
 			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED;
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 7a2dad3..4385741 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -498,6 +498,7 @@ struct ufs_stats {
  * @urgent_bkops_lvl: keeps track of urgent bkops level for device
  * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
  *  device is known or not.
+ * @scsi_block_reqs_cnt: reference counting for scsi block requests
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -690,6 +691,7 @@ struct ufs_hba {
 
 	struct rw_semaphore clk_scaling_lock;
 	struct ufs_desc_size desc_size;
+	int scsi_block_reqs_cnt;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
@@ -862,6 +864,9 @@ int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 
 u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba);
 
+void ufshcd_scsi_block_requests(struct ufs_hba *hba);
+void ufshcd_scsi_unblock_requests(struct ufs_hba *hba);
+
 /* Wrapper functions for safely calling variant operations */
 static inline const char *ufshcd_get_var_name(struct ufs_hba *hba)
 {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
