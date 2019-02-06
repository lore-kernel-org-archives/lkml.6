Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337BFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F247A217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfBFKwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:52:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfBFKwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:52:32 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2D632969FCB81E003F3;
        Wed,  6 Feb 2019 18:52:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Feb 2019 18:52:24 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/6] scsi: hisi_sas: Add manual trigger for debugfs dump
Date:   Wed, 6 Feb 2019 18:52:52 +0800
Message-ID: <1549450376-114929-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
References: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

Add an interface to manually trigger a debugfs dump.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 1a3d31d4258c..35619bdad1d5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2977,6 +2977,36 @@ static void hisi_sas_debugfs_snapshot_regs(struct hisi_hba *hisi_hba)
 	hisi_hba->hw->snapshot_restore(hisi_hba);
 }
 
+static ssize_t hisi_sas_debugfs_trigger_dump_write(struct file *file,
+						   const char __user *user_buf,
+						   size_t count, loff_t *ppos)
+{
+	struct hisi_hba *hisi_hba = file->f_inode->i_private;
+	char buf[8];
+
+	/* A bit racy, but don't care too much since it's only debugfs */
+	if (hisi_hba->debugfs_snapshot)
+		return -EFAULT;
+
+	if (count > 8)
+		return -EFAULT;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	if (buf[0] != '1')
+		return -EFAULT;
+
+	queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
+
+	return count;
+}
+
+static const struct file_operations hisi_sas_debugfs_trigger_dump_fops = {
+	.write = &hisi_sas_debugfs_trigger_dump_write,
+	.owner = THIS_MODULE,
+};
+
 void hisi_sas_debugfs_work_handler(struct work_struct *work)
 {
 	struct hisi_hba *hisi_hba =
@@ -2999,6 +3029,10 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 
 	hisi_hba->debugfs_dir = debugfs_create_dir(dev_name(dev),
 						   hisi_sas_debugfs_dir);
+	debugfs_create_file("trigger_dump", 0600,
+			    hisi_hba->debugfs_dir,
+			    hisi_hba,
+			    &hisi_sas_debugfs_trigger_dump_fops);
 
 	/* Alloc buffer for global */
 	sz = hisi_hba->hw->debugfs_reg_global->count * 4;
-- 
2.17.1

