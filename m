Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27342C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028152133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbeLSP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:56:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730420AbeLSP4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:56:00 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31813130E497F;
        Wed, 19 Dec 2018 23:55:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Dec 2018 23:55:46 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 7/8] scsi: hisi_sas: Add debugfs DQ file and add file operations
Date:   Wed, 19 Dec 2018 23:56:45 +0800
Message-ID: <1545235006-151716-8-git-send-email-john.garry@huawei.com>
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

This patch create debugfs file for DQ and add file operations

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index ce0a9dc..45a0be2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2685,6 +2685,43 @@ static int hisi_sas_debugfs_cq_open(struct inode *inode, struct file *filp)
 	.owner = THIS_MODULE,
 };
 
+static int hisi_sas_dq_show_slot(struct seq_file *s, int slot, void *dq_ptr)
+{
+	struct hisi_sas_dq *dq = dq_ptr;
+	struct hisi_hba *hisi_hba = dq->hisi_hba;
+	void *cmd_queue = hisi_hba->debugfs_cmd_hdr[dq->id];
+	void *cmd_hdr = cmd_queue +
+		hisi_hba->hw->complete_hdr_size * slot;
+
+	return hisi_sas_show_row_32(s, slot, sizeof(struct hisi_sas_cmd_hdr),
+				    cmd_hdr);
+}
+
+static int hisi_sas_debugfs_dq_show(struct seq_file *s, void *p)
+{
+	int slot, ret;
+
+	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++) {
+		ret = hisi_sas_dq_show_slot(s, slot, s->private);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int hisi_sas_debugfs_dq_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_dq_show, inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_dq_fops = {
+	.open = hisi_sas_debugfs_dq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 {
 	struct dentry *dump_dentry;
@@ -2692,6 +2729,7 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 	char name[256];
 	int p;
 	int c;
+	int d;
 
 	/* Create dump dir inside device dir */
 	dump_dentry = debugfs_create_dir("dump", hisi_hba->debugfs_dir);
@@ -2731,6 +2769,20 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 			goto fail;
 	}
 
+	/* Create DQ dir and files */
+	dentry = debugfs_create_dir("dq", dump_dentry);
+	if (!dentry)
+		goto fail;
+
+	for (d = 0; d < hisi_hba->queue_count; d++) {
+		snprintf(name, 256, "%d", d);
+
+		if (!debugfs_create_file(name, 0400, dentry,
+					 &hisi_hba->dq[d],
+					 &hisi_sas_debugfs_dq_fops))
+			goto fail;
+	}
+
 	return;
 fail:
 	debugfs_remove_recursive(hisi_hba->debugfs_dir);
-- 
1.9.1

