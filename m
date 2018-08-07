Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B550BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B47215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZAMD0t91";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IBusA7B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B47215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403849AbeHGUD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:03:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbeHGUD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:03:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 389A060BFA; Tue,  7 Aug 2018 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533664079;
        bh=byN8EJpkilHi0lBBr+pNGYym4JWbt3WYJTmSCqK2es4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZAMD0t91Pab7jIoP6mjDQvAkskDogajVuUpKfS7kjCfW+J1q3OU2+QHnQfI7bbxef
         XzGTPgAxXnMFaiEZDHXD1JcCM2W7BJUHKRkN3LB6xfW78+urM2f4pGz35aDmtDiYX+
         KVMlZR6DiA8JsudaS0Ju0gLkKO5kJ8ir4JxxAHH4=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D4C5F60BE3;
        Tue,  7 Aug 2018 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533664070;
        bh=byN8EJpkilHi0lBBr+pNGYym4JWbt3WYJTmSCqK2es4=;
        h=From:To:Cc:Subject:Date:From;
        b=IBusA7B0Xz6k3p5X/cbMSu+phjoWSNxaI7/QGW0xPU1dgb94+1M3oQNR8MY8/qDqX
         EYKUmHnONfMhDP4XLQeWUrBjc6RtiR2Yovlb2LCH/zJJD2A84pYVGFBJ+xsDky6f/F
         TTwVsr9T1DuswOQrOI1zuK9H8lcZjkd78s61+LXY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4C5F60BE3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 1/1] scsi/ufshcd: Fix NULL pointer dereference for in ufshcd_init
Date:   Tue,  7 Aug 2018 23:17:39 +0530
Message-Id: <20180807174739.23379-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error paths in ufshcd_init() ufshcd_hba_exit() killed clk_scaling
workqueue when the workqueue is actually created quite late in
ufshcd_init().
So, we end up getting NULL pointer dereference in such error paths.
Fix this by moving clk_scaling initialization and kill codes to
two separate methods, and call them at required places.

Fixes: 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during clock
gating")

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
---

Bjorn, Subhash,
I am not certain of some of these devfreq, and clk_scaling bits
that are moved as part of this patch. Please help in reviewing the
change in the light of these features, and related sequence should
be followed.
Thanks.

 drivers/scsi/ufs/ufshcd.c | 53 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 397081d320b1..7273aec95a6c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1749,6 +1749,34 @@ static ssize_t ufshcd_clkgate_enable_store(struct device *dev,
 	return count;
 }
 
+static void ufshcd_init_clk_scaling(struct ufs_hba *hba)
+{
+	char wq_name[sizeof("ufs_clkscaling_00")];
+
+	if (!ufshcd_is_clkscaling_supported(hba))
+		return;
+
+	INIT_WORK(&hba->clk_scaling.suspend_work,
+		  ufshcd_clk_scaling_suspend_work);
+	INIT_WORK(&hba->clk_scaling.resume_work,
+		  ufshcd_clk_scaling_resume_work);
+
+	snprintf(wq_name, sizeof(wq_name), "ufs_clkscaling_%d",
+		 hba->host->host_no);
+	hba->clk_scaling.workq = create_singlethread_workqueue(wq_name);
+
+	ufshcd_clkscaling_init_sysfs(hba);
+}
+
+static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
+{
+	if (!ufshcd_is_clkscaling_supported(hba))
+		return;
+
+	destroy_workqueue(hba->clk_scaling.workq);
+	ufshcd_devfreq_remove(hba);
+}
+
 static void ufshcd_init_clk_gating(struct ufs_hba *hba)
 {
 	char wq_name[sizeof("ufs_clk_gating_00")];
@@ -6652,6 +6680,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	 */
 	if (ret && !ufshcd_eh_in_progress(hba) && !hba->pm_op_in_progress) {
 		pm_runtime_put_sync(hba->dev);
+		ufshcd_exit_clk_scaling(hba);
 		ufshcd_hba_exit(hba);
 	}
 
@@ -7187,12 +7216,9 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 		ufshcd_variant_hba_exit(hba);
 		ufshcd_setup_vreg(hba, false);
 		ufshcd_suspend_clkscaling(hba);
-		if (ufshcd_is_clkscaling_supported(hba)) {
+		if (ufshcd_is_clkscaling_supported(hba))
 			if (hba->devfreq)
 				ufshcd_suspend_clkscaling(hba);
-			destroy_workqueue(hba->clk_scaling.workq);
-			ufshcd_devfreq_remove(hba);
-		}
 		ufshcd_setup_clocks(hba, false);
 		ufshcd_setup_hba_vreg(hba, false);
 		hba->is_powered = false;
@@ -7867,6 +7893,7 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufshcd_disable_intr(hba, hba->intr_mask);
 	ufshcd_hba_stop(hba, true);
 
+	ufshcd_exit_clk_scaling(hba);
 	ufshcd_exit_clk_gating(hba);
 	if (ufshcd_is_clkscaling_supported(hba))
 		device_remove_file(hba->dev, &hba->clk_scaling.enable_attr);
@@ -8031,6 +8058,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 
 	ufshcd_init_clk_gating(hba);
 
+	ufshcd_init_clk_scaling(hba);
+
 	/*
 	 * In order to avoid any spurious interrupt immediately after
 	 * registering UFS controller interrupt handler, clear any pending UFS
@@ -8069,21 +8098,6 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto out_remove_scsi_host;
 	}
 
-	if (ufshcd_is_clkscaling_supported(hba)) {
-		char wq_name[sizeof("ufs_clkscaling_00")];
-
-		INIT_WORK(&hba->clk_scaling.suspend_work,
-			  ufshcd_clk_scaling_suspend_work);
-		INIT_WORK(&hba->clk_scaling.resume_work,
-			  ufshcd_clk_scaling_resume_work);
-
-		snprintf(wq_name, sizeof(wq_name), "ufs_clkscaling_%d",
-			 host->host_no);
-		hba->clk_scaling.workq = create_singlethread_workqueue(wq_name);
-
-		ufshcd_clkscaling_init_sysfs(hba);
-	}
-
 	/*
 	 * Set the default power management level for runtime and system PM.
 	 * Default power saving mode is to keep UFS link in Hibern8 state
@@ -8121,6 +8135,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 out_remove_scsi_host:
 	scsi_remove_host(hba->host);
 exit_gating:
+	ufshcd_exit_clk_scaling(hba);
 	ufshcd_exit_clk_gating(hba);
 out_disable:
 	hba->is_irq_enabled = false;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

