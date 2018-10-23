Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A7FECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0620824
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nkR6hU11";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jl8APOrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD0620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJWM6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:58:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeJWM57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:57:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA9B460CEB; Tue, 23 Oct 2018 04:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269381;
        bh=F+KHbB3PpFrkT7xB1cpiw08eGGYAJp7u0yoB6WRm4ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkR6hU11+sCzcFug6DKNvbsdItNyCjI/vHIVtWFV98Kgq5Is37ACE7rz4j0zLyrMr
         osBqGC8EQvaFAoTrfk8hACOmvIMOPbVib9qdOOtHMXcZlhdVZW8d9g+EzT5RX5brIo
         ShpL9ewetL1hBP4KY/0OJcB4PnW4ysS0pVKRd/R4=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08FA260CEB;
        Tue, 23 Oct 2018 04:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269380;
        bh=F+KHbB3PpFrkT7xB1cpiw08eGGYAJp7u0yoB6WRm4ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jl8APOrH7VwCCyH2u1Uj73CvTg6YCTxZQKcYGd5Y4CC+cCDHEF63vTDxZc/qcyxqe
         XQfQRwppSYnay9h7BP9nRNuKs0ENUZ/7G7BPOK1Aj2qaOt3qRpcGlfpYiHVfdl65Hi
         vsiz3kRKHuOlANsyEOPzsyteMvTba0E5jbLXkUAU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08FA260CEB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dov Levenglick <dovl@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH v10 4/6] scsi: ufs: Add core reset support
Date:   Mon, 22 Oct 2018 21:35:59 -0700
Message-Id: <1540269361-28185-5-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dov Levenglick <dovl@codeaurora.org>

Enables core reset support. Add full initialization of the PHY and the
controller before initializing UFS PHY and during link recovery.

Signed-off-by: Dov Levenglick <dovl@codeaurora.org>
Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufs-qcom.c      | 30 ++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-pltfrm.c | 22 ++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c        | 13 +++++++++++++
 drivers/scsi/ufs/ufshcd.h        | 12 ++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 2b38db2..698b92d 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -616,6 +616,35 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	return err;
 }
 
+static int ufs_qcom_core_reset(struct ufs_hba *hba)
+{
+	int ret = -ENOTSUPP;
+
+	if (!hba->core_reset) {
+		dev_err(hba->dev, "%s: failed, err = %d\n", __func__,
+				ret);
+		goto out;
+	}
+
+	ret = reset_control_assert(hba->core_reset);
+	if (ret) {
+		dev_err(hba->dev, "core_reset assert failed, err = %d\n",
+				ret);
+		goto out;
+	}
+
+	/* As per spec, delay is required to let reset assert go through */
+	usleep_range(1, 2);
+
+	ret = reset_control_deassert(hba->core_reset);
+	if (ret)
+		dev_err(hba->dev, "core_reset deassert failed, err = %d\n",
+				ret);
+
+out:
+	return ret;
+}
+
 struct ufs_qcom_dev_params {
 	u32 pwm_rx_gear;	/* pwm rx gear to work in */
 	u32 pwm_tx_gear;	/* pwm tx gear to work in */
@@ -1670,6 +1699,7 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 	.apply_dev_quirks	= ufs_qcom_apply_dev_quirks,
 	.suspend		= ufs_qcom_suspend,
 	.resume			= ufs_qcom_resume,
+	.core_reset		= ufs_qcom_core_reset,
 	.dbg_register_dump	= ufs_qcom_dump_dbg_regs,
 };
 
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index e82bde0..dab11a7 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -42,6 +42,22 @@
 
 #define UFSHCD_DEFAULT_LANES_PER_DIRECTION		2
 
+static int ufshcd_parse_reset_info(struct ufs_hba *hba)
+{
+	int ret = 0;
+
+	hba->core_reset = devm_reset_control_get_optional_exclusive(hba->dev,
+				"rst");
+	if (IS_ERR(hba->core_reset)) {
+		ret = PTR_ERR(hba->core_reset);
+		dev_err(hba->dev, "core_reset unavailable,err = %d\n",
+				ret);
+		hba->core_reset = NULL;
+	}
+
+	return ret;
+}
+
 static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 {
 	int ret = 0;
@@ -340,6 +356,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
+	err = ufshcd_parse_reset_info(hba);
+	if (err) {
+		dev_err(&pdev->dev, "%s: reset parse failed %d\n",
+				__func__, err);
+	}
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a355d98..d18c3af 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3657,6 +3657,15 @@ static int ufshcd_link_recovery(struct ufs_hba *hba)
 	ufshcd_set_eh_in_progress(hba);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
 
+	if (hba->core_reset) {
+		ret = ufshcd_vops_core_reset(hba);
+		if (ret)
+			dev_err(hba->dev,
+				"full reset returned %d, trying to recover the link\n",
+				ret);
+		return ret;
+	}
+
 	ret = ufshcd_host_reset_and_restore(hba);
 
 	spin_lock_irqsave(hba->host->host_lock, flags);
@@ -7948,6 +7957,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 		goto exit_gating;
 	}
 
+	/* Reset controller to power on reset (POR) state */
+	if (hba->core_reset)
+		ufshcd_vops_core_reset(hba);
+
 	/* Host controller enable */
 	err = ufshcd_hba_enable(hba);
 	if (err) {
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1332e54..aa046a1 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -55,6 +55,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include "unipro.h"
 
 #include <asm/irq.h>
@@ -295,6 +296,8 @@ struct ufs_pwr_mode_info {
  * @apply_dev_quirks: called to apply device specific quirks
  * @suspend: called during host controller PM callback
  * @resume: called during host controller PM callback
+ * @core_reset:  called before UFS PHY init and during link recovery for
+ *		 handling variant specific implementations of resetting the hci
  * @dbg_register_dump: used to dump controller debug information
  * @phy_initialization: used to initialize phys
  */
@@ -323,6 +326,7 @@ struct ufs_hba_variant_ops {
 	int	(*apply_dev_quirks)(struct ufs_hba *);
 	int     (*suspend)(struct ufs_hba *, enum ufs_pm_op);
 	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
+	int	(*core_reset)(struct ufs_hba *);
 	void	(*dbg_register_dump)(struct ufs_hba *hba);
 	int	(*phy_initialization)(struct ufs_hba *);
 };
@@ -678,6 +682,7 @@ struct ufs_hba {
 	bool is_urgent_bkops_lvl_checked;
 
 	struct rw_semaphore clk_scaling_lock;
+	struct reset_control *core_reset;
 	struct ufs_desc_size desc_size;
 };
 
@@ -979,6 +984,13 @@ static inline int ufshcd_vops_resume(struct ufs_hba *hba, enum ufs_pm_op op)
 	return 0;
 }
 
+static inline int ufshcd_vops_core_reset(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->core_reset)
+		return hba->vops->core_reset(hba);
+	return 0;
+}
+
 static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
 {
 	if (hba->vops && hba->vops->dbg_register_dump)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

