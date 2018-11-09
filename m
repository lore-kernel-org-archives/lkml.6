Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95A0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE00520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeKIXp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728026AbeKIXpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:53 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD0B255EAAD;
        Fri,  9 Nov 2018 22:05:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 9 Nov 2018 22:04:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] scsi: hisi_sas: Create separate host attributes per HBA
Date:   Fri, 9 Nov 2018 22:06:32 +0800
Message-ID: <1541772396-161814-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1541772396-161814-1-git-send-email-john.garry@huawei.com>
References: <1541772396-161814-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Currently all the three HBA (v1/v2/v3 HW) share the same host attribute.

To support each HBA having separate attributes in future, create per-HBA
attributes.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       | 1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 6 ------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 7 ++++++-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 7 ++++++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 7 ++++++-
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 0ddb53c..94a9e13 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -468,7 +468,6 @@ extern int hisi_sas_probe(struct platform_device *pdev,
 extern int hisi_sas_slave_configure(struct scsi_device *sdev);
 extern int hisi_sas_scan_finished(struct Scsi_Host *shost, unsigned long time);
 extern void hisi_sas_scan_start(struct Scsi_Host *shost);
-extern struct device_attribute *host_attrs[];
 extern int hisi_sas_host_reset(struct Scsi_Host *shost, int reset_type);
 extern void hisi_sas_phy_down(struct hisi_hba *hisi_hba, int phy_no, int rdy);
 extern void hisi_sas_slot_task_free(struct hisi_hba *hisi_hba,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index b3f01d5..8633ff9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1994,12 +1994,6 @@ void hisi_sas_kill_tasklets(struct hisi_hba *hisi_hba)
 struct scsi_transport_template *hisi_sas_stt;
 EXPORT_SYMBOL_GPL(hisi_sas_stt);
 
-struct device_attribute *host_attrs[] = {
-	&dev_attr_phy_event_threshold,
-	NULL,
-};
-EXPORT_SYMBOL_GPL(host_attrs);
-
 static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_dev_found		= hisi_sas_dev_found,
 	.lldd_dev_gone		= hisi_sas_dev_gone,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index f0e457e..d24342b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1799,6 +1799,11 @@ static int hisi_sas_v1_init(struct hisi_hba *hisi_hba)
 	return 0;
 }
 
+static struct device_attribute *host_attrs_v1_hw[] = {
+	&dev_attr_phy_event_threshold,
+	NULL
+};
+
 static struct scsi_host_template sht_v1_hw = {
 	.name			= DRV_NAME,
 	.module			= THIS_MODULE,
@@ -1817,7 +1822,7 @@ static int hisi_sas_v1_init(struct hisi_hba *hisi_hba)
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
-	.shost_attrs		= host_attrs,
+	.shost_attrs		= host_attrs_v1_hw,
 };
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index cc36b64..e78a97e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3554,6 +3554,11 @@ static void wait_cmds_complete_timeout_v2_hw(struct hisi_hba *hisi_hba,
 	dev_dbg(dev, "wait commands complete %dms\n", time);
 }
 
+struct device_attribute *host_attrs_v2_hw[] = {
+	&dev_attr_phy_event_threshold,
+	NULL
+};
+
 static struct scsi_host_template sht_v2_hw = {
 	.name			= DRV_NAME,
 	.module			= THIS_MODULE,
@@ -3572,7 +3577,7 @@ static void wait_cmds_complete_timeout_v2_hw(struct hisi_hba *hisi_hba,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
-	.shost_attrs		= host_attrs,
+	.shost_attrs		= host_attrs_v2_hw,
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index bd4ce38..68a6ec2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2091,6 +2091,11 @@ static void wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,
 	dev_dbg(dev, "wait commands complete %dms\n", time);
 }
 
+struct device_attribute *host_attrs_v3_hw[] = {
+	&dev_attr_phy_event_threshold,
+	NULL
+};
+
 static struct scsi_host_template sht_v3_hw = {
 	.name			= DRV_NAME,
 	.module			= THIS_MODULE,
@@ -2109,7 +2114,7 @@ static void wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,
 	.eh_target_reset_handler = sas_eh_target_reset_handler,
 	.target_destroy		= sas_target_destroy,
 	.ioctl			= sas_ioctl,
-	.shost_attrs		= host_attrs,
+	.shost_attrs		= host_attrs_v3_hw,
 	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,
 };
 
-- 
1.9.1

