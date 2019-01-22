Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9898C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BD1217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170298;
	bh=21At4KPCPHw9aGcSSzvn4L7mevHls1BG4oiz9ozugyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wW5+zKjjjZCYm/3zUbMAGJIl/h3nuAbVEUa5HCK9J5S1wZOFn+EeaNxJgQU9UecEA
	 1MbesWSWH+QO3OOB4KbTW/9/afq43SlPIyJy30p6zKi4a55leGY0mkyd40hQW7QXrG
	 LiXuFi8PnwKsmtwH304ujBn05O2CGXwX8J3MI4TA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfAVPSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfAVPSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB05217D4;
        Tue, 22 Jan 2019 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170294;
        bh=21At4KPCPHw9aGcSSzvn4L7mevHls1BG4oiz9ozugyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snE0ytX7Y29YFM17kSnTQX1UH72LfecM4MwY+mk4e3Qd03AB5wuV4aS4tZ/K2tsYY
         sDawkTRtbu7dogZBVDtGRNW+k8Y5kIFqe9Jffdkr0awXrWq190TR/sKCo/ron01Ezl
         AIFIA98Y9uxIVDYkNqXsbju2iaXGcehHvHStbGio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH 2/8] infiniband: hfi1: drop crazy DEBUGFS_SEQ_FILE_CREATE() macro
Date:   Tue, 22 Jan 2019 16:17:54 +0100
Message-Id: <20190122151800.15092-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151800.15092-1-gregkh@linuxfoundation.org>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro was just making things harder to follow, and audit, so remove
it and call debugfs_create_file() directly.  Also, the macro did not
need to warn about the call failing as no one should ever care about any
debugfs functions failing.

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/debugfs.c | 50 ++++++++++++----------------
 drivers/infiniband/hw/hfi1/debugfs.h | 12 -------
 drivers/infiniband/hw/hfi1/fault.c   |  3 +-
 3 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index 0a557795563c..52c00c67056f 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -1167,6 +1167,7 @@ void hfi1_dbg_ibdev_init(struct hfi1_ibdev *ibd)
 	char link[10];
 	struct hfi1_devdata *dd = dd_from_dev(ibd);
 	struct hfi1_pportdata *ppd;
+	struct dentry *root;
 	int unit = dd->unit;
 	int i, j;
 
@@ -1174,31 +1175,26 @@ void hfi1_dbg_ibdev_init(struct hfi1_ibdev *ibd)
 		return;
 	snprintf(name, sizeof(name), "%s_%d", class_name(), unit);
 	snprintf(link, sizeof(link), "%d", unit);
-	ibd->hfi1_ibdev_dbg = debugfs_create_dir(name, hfi1_dbg_root);
-	if (!ibd->hfi1_ibdev_dbg) {
-		pr_warn("create of %s failed\n", name);
-		return;
-	}
+	root = debugfs_create_dir(name, hfi1_dbg_root);
+	ibd->hfi1_ibdev_dbg = root;
+
 	ibd->hfi1_ibdev_link =
 		debugfs_create_symlink(link, hfi1_dbg_root, name);
-	if (!ibd->hfi1_ibdev_link) {
-		pr_warn("create of %s symlink failed\n", name);
-		return;
-	}
-	DEBUGFS_SEQ_FILE_CREATE(opcode_stats, ibd->hfi1_ibdev_dbg, ibd);
-	DEBUGFS_SEQ_FILE_CREATE(tx_opcode_stats, ibd->hfi1_ibdev_dbg, ibd);
-	DEBUGFS_SEQ_FILE_CREATE(ctx_stats, ibd->hfi1_ibdev_dbg, ibd);
-	DEBUGFS_SEQ_FILE_CREATE(qp_stats, ibd->hfi1_ibdev_dbg, ibd);
-	DEBUGFS_SEQ_FILE_CREATE(sdes, ibd->hfi1_ibdev_dbg, ibd);
-	DEBUGFS_SEQ_FILE_CREATE(rcds, ibd->hfi1_ibdev_dbg, ibd);
-	DEBUGFS_SEQ_FILE_CREATE(pios, ibd->hfi1_ibdev_dbg, ibd);
-	DEBUGFS_SEQ_FILE_CREATE(sdma_cpu_list, ibd->hfi1_ibdev_dbg, ibd);
+
+	debugfs_create_file("opcode_stats", 0444, root, ibd, &_opcode_stats_file_ops);
+	debugfs_create_file("tx_opcode_stats", 0444, root, ibd, &_tx_opcode_stats_file_ops);
+	debugfs_create_file("ctx_stats", 0444, root, ibd, &_ctx_stats_file_ops);
+	debugfs_create_file("qp_stats", 0444, root, ibd, &_qp_stats_file_ops);
+	debugfs_create_file("sdes", 0444, root, ibd, &_sdes_file_ops);
+	debugfs_create_file("rcds", 0444, root, ibd, &_rcds_file_ops);
+	debugfs_create_file("pios", 0444, root, ibd, &_pios_file_ops);
+	debugfs_create_file("sdma_cpu_list", 0444, root, ibd, &_sdma_cpu_list_file_ops);
+
 	/* dev counter files */
 	for (i = 0; i < ARRAY_SIZE(cntr_ops); i++)
-		DEBUGFS_FILE_CREATE(cntr_ops[i].name,
-				    ibd->hfi1_ibdev_dbg,
-				    dd,
-				    &cntr_ops[i].ops, S_IRUGO);
+		debugfs_create_file(cntr_ops[i].name, 0444, root, dd,
+				    &cntr_ops[i].ops);
+
 	/* per port files */
 	for (ppd = dd->pport, j = 0; j < dd->num_pports; j++, ppd++)
 		for (i = 0; i < ARRAY_SIZE(port_cntr_ops); i++) {
@@ -1206,12 +1202,10 @@ void hfi1_dbg_ibdev_init(struct hfi1_ibdev *ibd)
 				 sizeof(name),
 				 port_cntr_ops[i].name,
 				 j + 1);
-			DEBUGFS_FILE_CREATE(name,
-					    ibd->hfi1_ibdev_dbg,
-					    ppd,
-					    &port_cntr_ops[i].ops,
+			debugfs_create_file(name,
 					    !port_cntr_ops[i].ops.write ?
-					    S_IRUGO : S_IRUGO | S_IWUSR);
+					    S_IRUGO : S_IRUGO | S_IWUSR,
+					    root, ppd, &port_cntr_ops[i].ops);
 		}
 
 	hfi1_fault_init_debugfs(ibd);
@@ -1343,8 +1337,8 @@ void hfi1_dbg_init(void)
 	hfi1_dbg_root  = debugfs_create_dir(DRIVER_NAME, NULL);
 	if (!hfi1_dbg_root)
 		pr_warn("init of debugfs failed\n");
-	DEBUGFS_SEQ_FILE_CREATE(driver_stats_names, hfi1_dbg_root, NULL);
-	DEBUGFS_SEQ_FILE_CREATE(driver_stats, hfi1_dbg_root, NULL);
+	debugfs_create_file("driver_stats_names", 0444, hfi1_dbg_root, NULL, &_driver_stats_names_file_ops);
+	debugfs_create_file("driver_stats", 0444, hfi1_dbg_root, NULL, &_driver_stats_file_ops);
 }
 
 void hfi1_dbg_exit(void)
diff --git a/drivers/infiniband/hw/hfi1/debugfs.h b/drivers/infiniband/hw/hfi1/debugfs.h
index d5d824459fcc..57e582caa5eb 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.h
+++ b/drivers/infiniband/hw/hfi1/debugfs.h
@@ -49,16 +49,6 @@
 
 struct hfi1_ibdev;
 
-#define DEBUGFS_FILE_CREATE(name, parent, data, ops, mode)	\
-do { \
-	struct dentry *ent; \
-	const char *__name = name; \
-	ent = debugfs_create_file(__name, mode, parent, \
-		data, ops); \
-	if (!ent) \
-		pr_warn("create of %s failed\n", __name); \
-} while (0)
-
 #define DEBUGFS_SEQ_FILE_OPS(name) \
 static const struct seq_operations _##name##_seq_ops = { \
 	.start = _##name##_seq_start, \
@@ -89,8 +79,6 @@ static const struct file_operations _##name##_file_ops = { \
 	.release = seq_release \
 }
 
-#define DEBUGFS_SEQ_FILE_CREATE(name, parent, data) \
-	DEBUGFS_FILE_CREATE(#name, parent, data, &_##name##_file_ops, 0444)
 
 ssize_t hfi1_seq_read(struct file *file, char __user *buf, size_t size,
 		      loff_t *ppos);
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index e2290f32c8d9..dd09b8544568 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -278,7 +278,8 @@ int hfi1_fault_init_debugfs(struct hfi1_ibdev *ibd)
 		return -ENOENT;
 	}
 
-	DEBUGFS_SEQ_FILE_CREATE(fault_stats, ibd->fault->dir, ibd);
+	debugfs_create_file("fault_stats", 0444, ibd->fault->dir, ibd,
+			    &_fault_stats_file_ops);
 	if (!debugfs_create_bool("enable", 0600, ibd->fault->dir,
 				 &ibd->fault->enable))
 		goto fail;
-- 
2.20.1

