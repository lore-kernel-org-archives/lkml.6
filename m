Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEDWoi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:44:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33678 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeEDWoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:44:34 -0400
X-Google-Smtp-Source: AB8JxZoEJt480UNQ8nJEM25AyF+PXF0V1SpopZaMteCM1zzKVDLzozZ5xNIVoB7Cpl2g0wsWAXHEOA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 2/2] scsi: ufs: Use freq table with devfreq
Date: Fri,  4 May 2018 15:44:27 -0700
Message-Id: <20180504224427.32606-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504224427.32606-1-bjorn.andersson@linaro.org>
References: <20180504224427.32606-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devfreq requires that the client operates on actual frequencies, not
only 0 and UMAX_INT and as such UFS brok with the introduction of
f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency").

This patch registers the frequencies of the first clock as opp levels
and use these to determine if we're trying to step up or down.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Chances since v1:
- Register min_freq and max_freq as opp levels.
- Unregister opp levels on removal, to make e.g. probe defer working

 drivers/scsi/ufs/ufshcd.c | 47 +++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 2253f24309ec..257614b889bd 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1168,16 +1168,13 @@ static int ufshcd_devfreq_target(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	ktime_t start;
 	bool scale_up, sched_clk_scaling_suspend_work = false;
+	struct list_head *clk_list = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
 	unsigned long irq_flags;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return -EINVAL;
 
-	if ((*freq > 0) && (*freq < UINT_MAX)) {
-		dev_err(hba->dev, "%s: invalid freq = %lu\n", __func__, *freq);
-		return -EINVAL;
-	}
-
 	spin_lock_irqsave(hba->host->host_lock, irq_flags);
 	if (ufshcd_eh_in_progress(hba)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
@@ -1187,7 +1184,13 @@ static int ufshcd_devfreq_target(struct device *dev,
 	if (!hba->clk_scaling.active_reqs)
 		sched_clk_scaling_suspend_work = true;
 
-	scale_up = (*freq == UINT_MAX) ? true : false;
+	if (list_empty(clk_list)) {
+		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
+		goto out;
+	}
+
+	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+	scale_up = (*freq == clki->max_freq) ? true : false;
 	if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 		ret = 0;
@@ -1257,16 +1260,29 @@ static struct devfreq_dev_profile ufs_devfreq_profile = {
 
 static int ufshcd_devfreq_init(struct ufs_hba *hba)
 {
+	struct list_head *clk_list = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
 	struct devfreq *devfreq;
 	int ret;
 
-	devfreq = devm_devfreq_add_device(hba->dev,
+	/* Skip devfreq if we don't have any clocks in the list */
+	if (list_empty(clk_list))
+		return 0;
+
+	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
+	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+
+	devfreq = devfreq_add_device(hba->dev,
 			&ufs_devfreq_profile,
 			"simple_ondemand",
 			NULL);
 	if (IS_ERR(devfreq)) {
 		ret = PTR_ERR(devfreq);
 		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
+
+		dev_pm_opp_remove(hba->dev, clki->min_freq);
+		dev_pm_opp_remove(hba->dev, clki->max_freq);
 		return ret;
 	}
 
@@ -1275,6 +1291,22 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 	return 0;
 }
 
+static void ufshcd_devfreq_remove(struct ufs_hba *hba)
+{
+	struct list_head *clk_list = &hba->clk_list_head;
+	struct ufs_clk_info *clki;
+
+	if (!hba->devfreq)
+		return;
+
+	devfreq_remove_device(hba->devfreq);
+	hba->devfreq = NULL;
+
+	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+	dev_pm_opp_remove(hba->dev, clki->min_freq);
+	dev_pm_opp_remove(hba->dev, clki->max_freq);
+}
+
 static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
 {
 	unsigned long flags;
@@ -6966,6 +6998,7 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 			if (hba->devfreq)
 				ufshcd_suspend_clkscaling(hba);
 			destroy_workqueue(hba->clk_scaling.workq);
+			ufshcd_devfreq_remove(hba);
 		}
 		ufshcd_setup_clocks(hba, false);
 		ufshcd_setup_hba_vreg(hba, false);
-- 
2.17.0
