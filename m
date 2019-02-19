Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96820C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660CC2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfBSOmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:42:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbfBSOmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:42:38 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0D444EC450C9B8530DA;
        Tue, 19 Feb 2019 22:42:30 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 22:42:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: hisi_sas: remove duplicated code
Date:   Tue, 19 Feb 2019 22:40:38 +0800
Message-ID: <20190219144038.26384-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move some functions to hisi_sas_main.c,
which can eliminate redundant code.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  6 ++++++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 37 +++++++++++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 38 ----------------------------------
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 37 ---------------------------------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 37 ---------------------------------
 5 files changed, 43 insertions(+), 112 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 6c87bd3..3b00bf6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -561,4 +561,10 @@ extern void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba);
 extern void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba);
 extern void hisi_sas_debugfs_exit(struct hisi_hba *hisi_hba);
 extern void hisi_sas_debugfs_work_handler(struct work_struct *work);
+u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off);
+u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off);
+void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val);
+void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
+			  u32 off, u32 val);
+u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba, int phy_no, u32 off);
 #endif
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9232966..56e98fc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -28,6 +28,43 @@ static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
 				  struct domain_device *device);
 static void hisi_sas_dev_gone(struct domain_device *device);
 
+u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
+{
+	void __iomem *regs = hisi_hba->regs + off;
+
+	return readl(regs);
+}
+
+u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
+{
+	void __iomem *regs = hisi_hba->regs + off;
+
+	return readl_relaxed(regs);
+}
+
+void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val)
+{
+	void __iomem *regs = hisi_hba->regs + off;
+
+	writel(val, regs);
+}
+
+void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
+			  u32 off, u32 val)
+{
+	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
+
+	writel(val, regs);
+}
+
+u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
+			int phy_no, u32 off)
+{
+	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
+
+	return readl(regs);
+}
+
 u8 hisi_sas_get_ata_protocol(struct host_to_dev_fis *fis, int direction)
 {
 	switch (fis->command) {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 2938074..41671b2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -416,44 +416,6 @@ enum {
 	(HISI_SAS_PHY_MAX_INT_NR + HISI_SAS_CQ_MAX_INT_NR +\
 	HISI_SAS_FATAL_INT_NR)
 
-static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl(regs);
-}
-
-static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl_relaxed(regs);
-}
-
-static void hisi_sas_write32(struct hisi_hba *hisi_hba,
-				    u32 off, u32 val)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	writel(val, regs);
-}
-
-static void hisi_sas_phy_write32(struct hisi_hba *hisi_hba,
-					int phy_no, u32 off, u32 val)
-{
-	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
-
-	writel(val, regs);
-}
-
-static u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
-				      int phy_no, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
-
-	return readl(regs);
-}
-
 static void config_phy_opt_mode_v1_hw(struct hisi_hba *hisi_hba, int phy_no)
 {
 	u32 cfg = hisi_sas_phy_read32(hisi_hba, phy_no, PHY_CFG);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index e40cc6b..3827d11 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -731,43 +731,6 @@ enum {
 
 static void link_timeout_disable_link(struct timer_list *t);
 
-static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl(regs);
-}
-
-static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl_relaxed(regs);
-}
-
-static void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	writel(val, regs);
-}
-
-static void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
-				 u32 off, u32 val)
-{
-	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
-
-	writel(val, regs);
-}
-
-static u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
-				      int phy_no, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
-
-	return readl(regs);
-}
-
 /* This function needs to be protected from pre-emption. */
 static int
 slot_index_alloc_quirk_v2_hw(struct hisi_hba *hisi_hba,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0420df2..4f30eda 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -418,43 +418,6 @@ module_param(auto_affine_msi_experimental, bool, 0444);
 MODULE_PARM_DESC(auto_affine_msi_experimental, "Enable auto-affinity of MSI IRQs as experimental:\n"
 		 "default is off");
 
-static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl(regs);
-}
-
-static u32 hisi_sas_read32_relaxed(struct hisi_hba *hisi_hba, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	return readl_relaxed(regs);
-}
-
-static void hisi_sas_write32(struct hisi_hba *hisi_hba, u32 off, u32 val)
-{
-	void __iomem *regs = hisi_hba->regs + off;
-
-	writel(val, regs);
-}
-
-static void hisi_sas_phy_write32(struct hisi_hba *hisi_hba, int phy_no,
-				 u32 off, u32 val)
-{
-	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
-
-	writel(val, regs);
-}
-
-static u32 hisi_sas_phy_read32(struct hisi_hba *hisi_hba,
-				      int phy_no, u32 off)
-{
-	void __iomem *regs = hisi_hba->regs + (0x400 * phy_no) + off;
-
-	return readl(regs);
-}
-
 #define hisi_sas_read32_poll_timeout(off, val, cond, delay_us,		\
 				     timeout_us)			\
 ({									\
-- 
2.7.0


