Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91096C282C7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619C8218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAYOWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:22:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728892AbfAYOWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:09 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B916DE4DE27FD796834;
        Fri, 25 Jan 2019 22:21:59 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 22:21:51 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 03/13] scsi: hisi_sas: Add debugfs ITCT file and add file operations
Date:   Fri, 25 Jan 2019 22:22:29 +0800
Message-ID: <1548426159-225679-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
References: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

This patch create debugfs file for ITCT and add file operations.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 73a545a..c0aacb0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2773,6 +2773,36 @@ static int hisi_sas_debugfs_iost_open(struct inode *inode, struct file *filp)
 	.owner = THIS_MODULE,
 };
 
+static int hisi_sas_debugfs_itct_show(struct seq_file *s, void *p)
+{
+	int i, ret;
+	struct hisi_hba *hisi_hba = s->private;
+	struct hisi_sas_itct *debugfs_itct = hisi_hba->debugfs_itct;
+	__le64 *itct = &debugfs_itct->qw0;
+
+	for (i = 0; i < HISI_SAS_MAX_ITCT_ENTRIES; i++, debugfs_itct++) {
+		ret = hisi_sas_show_row_64(s, i, sizeof(*debugfs_itct),
+					   itct);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int hisi_sas_debugfs_itct_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_itct_show, inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_itct_fops = {
+	.open = hisi_sas_debugfs_itct_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 {
 	struct dentry *dump_dentry;
@@ -2819,6 +2849,9 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 	debugfs_create_file("iost", 0400, dump_dentry, hisi_hba,
 			    &hisi_sas_debugfs_iost_fops);
 
+	debugfs_create_file("itct", 0400, dump_dentry, hisi_hba,
+			    &hisi_sas_debugfs_itct_fops);
+
 	return;
 }
 
-- 
1.9.1

