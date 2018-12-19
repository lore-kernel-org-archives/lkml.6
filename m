Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A07F2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeLSP4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:56:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730425AbeLSP4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:56:00 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 361BF1A9E0C6B;
        Wed, 19 Dec 2018 23:55:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Dec 2018 23:55:45 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 6/8] scsi: hisi_sas: Add debugfs CQ file and add file operations
Date:   Wed, 19 Dec 2018 23:56:44 +0800
Message-ID: <1545235006-151716-7-git-send-email-john.garry@huawei.com>
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

This patch create debugfs file for CQ and add file operations.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 70 +++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index fbd9b4a..ce0a9dc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2630,12 +2630,68 @@ static int hisi_sas_debugfs_port_open(struct inode *inode, struct file *filp)
 	.owner = THIS_MODULE,
 };
 
+static int hisi_sas_show_row_32(struct seq_file *s, int index,
+				int sz, u32 *ptr)
+{
+	int i;
+
+	/* completion header size not fixed per HW version */
+	seq_printf(s, "index %04d:\n\t", index);
+	for (i = 1; i <= sz / 4; i++, ptr++) {
+		if (!(i % 4))
+			seq_puts(s, "\n\t");
+	}
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int hisi_sas_cq_show_slot(struct seq_file *s, int slot, void *cq_ptr)
+{
+	struct hisi_sas_cq *cq = cq_ptr;
+	struct hisi_hba *hisi_hba = cq->hisi_hba;
+	void *complete_queue = hisi_hba->debugfs_complete_hdr[cq->id];
+	void *complete_hdr = complete_queue +
+			(hisi_hba->hw->complete_hdr_size * slot);
+
+	return hisi_sas_show_row_32(s, slot,
+				hisi_hba->hw->complete_hdr_size,
+				complete_hdr);
+}
+
+static int hisi_sas_debugfs_cq_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_cq *cq = s->private;
+	int slot, ret;
+
+	for (slot = 0; slot < HISI_SAS_QUEUE_SLOTS; slot++) {
+		ret = hisi_sas_cq_show_slot(s, slot, cq);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int hisi_sas_debugfs_cq_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_cq_show, inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_cq_fops = {
+	.open = hisi_sas_debugfs_cq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 {
 	struct dentry *dump_dentry;
 	struct dentry *dentry;
 	char name[256];
 	int p;
+	int c;
 
 	/* Create dump dir inside device dir */
 	dump_dentry = debugfs_create_dir("dump", hisi_hba->debugfs_dir);
@@ -2661,6 +2717,20 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 			goto fail;
 	}
 
+	/* Create CQ dir and files */
+	dentry = debugfs_create_dir("cq", dump_dentry);
+	if (!dentry)
+		goto fail;
+
+	for (c = 0; c < hisi_hba->queue_count; c++) {
+		snprintf(name, 256, "%d", c);
+
+		if (!debugfs_create_file(name, 0400, dentry,
+					 &hisi_hba->cq[c],
+					 &hisi_sas_debugfs_cq_fops))
+			goto fail;
+	}
+
 	return;
 fail:
 	debugfs_remove_recursive(hisi_hba->debugfs_dir);
-- 
1.9.1

