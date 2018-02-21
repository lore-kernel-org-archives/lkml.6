Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBUFD2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:03:28 -0500
Received: from alexa-out-tai-01.qualcomm.com ([103.229.16.226]:64584 "EHLO
        alexa-out-tai-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751417AbeBUFDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:03:25 -0500
X-IronPort-AV: E=Sophos;i="5.46,542,1511798400";
   d="scan'208";a="707"
X-IronPort-AV: E=McAfee;i="5900,7806,8810"; a="2400694"
From: Asutosh Das <asutoshd@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, Vijay Viswanath <vviswana@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 9/9] scsi: ufs: Add clock ungating to a separate workqueue
Date: Wed, 21 Feb 2018 10:26:40 +0530
Message-Id: <1c92a979dce897db920d9b9a625923d64cba2266.1519120988.git.asutoshd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
In-Reply-To: <cover.1519120988.git.asutoshd@codeaurora.org>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Viswanath <vviswana@codeaurora.org>

UFS driver can receive a request during memory reclaim by kswapd.
So when ufs driver puts the ungate work in queue, and if there are no
idle workers, kthreadd is invoked to create a new kworker. Since
kswapd task holds a mutex which kthreadd also needs, this can cause
a deadlock situation. So ungate work must be done in a separate
work queue with WQ__RECLAIM flag enabled.Such a workqueue will have
a rescue thread which will be called when the above deadlock
condition is possible.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 10 +++++++++-
 drivers/scsi/ufs/ufshcd.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 6541e1d..bb3382a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1503,7 +1503,8 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		hba->clk_gating.state = REQ_CLKS_ON;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
 					hba->clk_gating.state);
-		schedule_work(&hba->clk_gating.ungate_work);
+		queue_work(hba->clk_gating.clk_gating_workq,
+			   &hba->clk_gating.ungate_work);
 		/*
 		 * fall through to check if we should wait for this
 		 * work to be done or not.
@@ -1689,6 +1690,8 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 
 static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 {
+	char wq_name[sizeof("ufs_clk_gating_00")];
+
 	if (!ufshcd_is_clkgating_allowed(hba))
 		return;
 
@@ -1696,6 +1699,10 @@ static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 	INIT_DELAYED_WORK(&hba->clk_gating.gate_work, ufshcd_gate_work);
 	INIT_WORK(&hba->clk_gating.ungate_work, ufshcd_ungate_work);
 
+	snprintf(wq_name, ARRAY_SIZE(wq_name), "ufs_clk_gating_%d",
+		 hba->host->host_no);
+	hba->clk_gating.clk_gating_workq = create_singlethread_workqueue(wq_name);
+
 	hba->clk_gating.is_enabled = true;
 
 	hba->clk_gating.delay_attr.show = ufshcd_clkgate_delay_show;
@@ -1723,6 +1730,7 @@ static void ufshcd_exit_clk_gating(struct ufs_hba *hba)
 	device_remove_file(hba->dev, &hba->clk_gating.enable_attr);
 	cancel_work_sync(&hba->clk_gating.ungate_work);
 	cancel_delayed_work_sync(&hba->clk_gating.gate_work);
+	destroy_workqueue(hba->clk_gating.clk_gating_workq);
 }
 
 /* Must be called with host lock acquired */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 4385741..570c33e 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -361,6 +361,7 @@ struct ufs_clk_gating {
 	struct device_attribute enable_attr;
 	bool is_enabled;
 	int active_reqs;
+	struct workqueue_struct *clk_gating_workq;
 };
 
 struct ufs_saved_pwr_info {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
