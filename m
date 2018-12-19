Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E667C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397C42133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeLSP4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:56:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727982AbeLSPz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:55:58 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 16C9171D09B7B;
        Wed, 19 Dec 2018 23:55:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Dec 2018 23:55:43 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/8] scsi: hisi_sas: Create root and device debugfs directories
Date:   Wed, 19 Dec 2018 23:56:39 +0800
Message-ID: <1545235006-151716-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
References: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

This patch creates root directory at hisi_sas_init() and generate device
directory when we probe device driver.

And we remove the root directory at hisi_sas_exit(), but recursively
delete device directory when we remove device driver.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  9 +++++++++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 27 +++++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index af29194..3ad8746 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/dmapool.h>
 #include <linux/iopoll.h>
 #include <linux/lcm.h>
@@ -332,6 +333,8 @@ struct hisi_hba {
 	u32 phy_state;
 	u32 intr_coal_ticks;	/* Time of interrupt coalesce in us */
 	u32 intr_coal_count;	/* Interrupt count to coalesce */
+
+	struct dentry *debugfs_dir;
 };
 
 /* Generic HW DMA host memory structures */
@@ -461,6 +464,10 @@ struct hisi_sas_slot_buf_table {
 };
 
 extern struct scsi_transport_template *hisi_sas_stt;
+
+extern bool hisi_sas_debugfs_enable;
+extern struct dentry *hisi_sas_debugfs_dir;
+
 extern void hisi_sas_stop_phys(struct hisi_hba *hisi_hba);
 extern int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct Scsi_Host *shost);
 extern void hisi_sas_free(struct hisi_hba *hisi_hba);
@@ -493,4 +500,6 @@ extern bool hisi_sas_notify_phy_event(struct hisi_sas_phy *phy,
 extern u8 hisi_sas_get_prog_phy_linkrate_mask(enum sas_linkrate max);
 extern void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba);
 extern void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba);
+extern void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba);
+extern void hisi_sas_debugfs_exit(struct hisi_hba *hisi_hba);
 #endif
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index eed7fc5..919cd3b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2457,6 +2457,23 @@ int hisi_sas_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(hisi_sas_probe);
 
+struct dentry *hisi_sas_debugfs_dir;
+
+void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
+{
+	struct device *dev = hisi_hba->dev;
+
+	hisi_hba->debugfs_dir = debugfs_create_dir(dev_name(dev),
+						   hisi_sas_debugfs_dir);
+}
+EXPORT_SYMBOL_GPL(hisi_sas_debugfs_init);
+
+void hisi_sas_debugfs_exit(struct hisi_hba *hisi_hba)
+{
+	debugfs_remove_recursive(hisi_hba->debugfs_dir);
+}
+EXPORT_SYMBOL_GPL(hisi_sas_debugfs_exit);
+
 int hisi_sas_remove(struct platform_device *pdev)
 {
 	struct sas_ha_struct *sha = platform_get_drvdata(pdev);
@@ -2475,18 +2492,28 @@ int hisi_sas_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(hisi_sas_remove);
 
+bool hisi_sas_debugfs_enable;
+EXPORT_SYMBOL_GPL(hisi_sas_debugfs_enable);
+module_param_named(debugfs_enable, hisi_sas_debugfs_enable, bool, 0444);
+MODULE_PARM_DESC(hisi_sas_debugfs_enable, "Enable driver debugfs (default disabled)");
+
 static __init int hisi_sas_init(void)
 {
 	hisi_sas_stt = sas_domain_attach_transport(&hisi_sas_transport_ops);
 	if (!hisi_sas_stt)
 		return -ENOMEM;
 
+	if (hisi_sas_debugfs_enable)
+		hisi_sas_debugfs_dir = debugfs_create_dir("hisi_sas", NULL);
+
 	return 0;
 }
 
 static __exit void hisi_sas_exit(void)
 {
 	sas_release_transport(hisi_sas_stt);
+
+	debugfs_remove(hisi_sas_debugfs_dir);
 }
 
 module_init(hisi_sas_init);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index add7616..d2e1c85 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2509,6 +2509,9 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 		sha->sas_port[i] = &hisi_hba->port[i].sas_port;
 	}
 
+	if (hisi_sas_debugfs_enable)
+		hisi_sas_debugfs_init(hisi_hba);
+
 	rc = scsi_add_host(shost, dev);
 	if (rc)
 		goto err_out_ha;
@@ -2567,6 +2570,8 @@ static void hisi_sas_v3_remove(struct pci_dev *pdev)
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
 	struct Scsi_Host *shost = sha->core.shost;
 
+	hisi_sas_debugfs_exit(hisi_hba);
+
 	if (timer_pending(&hisi_hba->timer))
 		del_timer(&hisi_hba->timer);
 
-- 
1.9.1

