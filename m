Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C55C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9247217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170304;
	bh=wB/JvBapYiDQgVtr2jp6q96gzmLv5iZIbGKk6+Bq2cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7FNGHOGIerMIRUAJE1AZp+hZqHJcY3CPorSIwpwJvLhI/0Uv98lB8Jwu7Z3C3/6g
	 PRwh1g7doyaWyew7h6zNdZwQQEqr3VwYNbpVnry3oKhHPFA6yqhKnGKl5muoBJ6NJg
	 MhGZXeRkY5TwW5bD+9jMOS8SzAv8a6EEMLAzfyrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfAVPSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729248AbfAVPSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFEDB217D6;
        Tue, 22 Jan 2019 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170300;
        bh=wB/JvBapYiDQgVtr2jp6q96gzmLv5iZIbGKk6+Bq2cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzqbXGWqht/z7C/Kl6NIQBjT9BPvnxBCVLmafCxk4S0Yi4z2G+lcAE+KaE2IEzKg0
         hTwc6KHCKbBvMiLOewTkiYV0gg/4pUnNK68RD4pcZPPZAobZfG4IrjQTpiEdcWb0dX
         tRTBkQTeg6QCOsfp9c0nxErjiTlDQG4/3L9xzWAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH 4/8] infiniband: qib: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:17:56 +0100
Message-Id: <20190122151800.15092-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151800.15092-1-gregkh@linuxfoundation.org>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/qib/qib_debugfs.c | 26 +++++++------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_debugfs.c b/drivers/infiniband/hw/qib/qib_debugfs.c
index 5ed1ed93380f..8546e69c6a07 100644
--- a/drivers/infiniband/hw/qib/qib_debugfs.c
+++ b/drivers/infiniband/hw/qib/qib_debugfs.c
@@ -66,15 +66,6 @@ static const struct file_operations _##name##_file_ops = { \
 	.release = seq_release \
 };
 
-#define DEBUGFS_FILE_CREATE(name) \
-do { \
-	struct dentry *ent; \
-	ent = debugfs_create_file(#name , 0400, ibd->qib_ibdev_dbg, \
-		ibd, &_##name##_file_ops); \
-	if (!ent) \
-		pr_warn("create of " #name " failed\n"); \
-} while (0)
-
 static void *_opcode_stats_seq_start(struct seq_file *s, loff_t *pos)
 {
 	struct qib_opcode_stats_perctx *opstats;
@@ -249,17 +240,16 @@ DEBUGFS_FILE(qp_stats)
 
 void qib_dbg_ibdev_init(struct qib_ibdev *ibd)
 {
+	struct dentry *root;
 	char name[10];
 
 	snprintf(name, sizeof(name), "qib%d", dd_from_dev(ibd)->unit);
-	ibd->qib_ibdev_dbg = debugfs_create_dir(name, qib_dbg_root);
-	if (!ibd->qib_ibdev_dbg) {
-		pr_warn("create of %s failed\n", name);
-		return;
-	}
-	DEBUGFS_FILE_CREATE(opcode_stats);
-	DEBUGFS_FILE_CREATE(ctx_stats);
-	DEBUGFS_FILE_CREATE(qp_stats);
+	root = debugfs_create_dir(name, qib_dbg_root);
+	ibd->qib_ibdev_dbg = root;
+
+	debugfs_create_file("opcode_stats", 0400, root, ibd, &_opcode_stats_file_ops);
+	debugfs_create_file("ctx_stats", 0400, root, ibd, &_ctx_stats_file_ops);
+	debugfs_create_file("qp_stats", 0400, root, ibd, &_qp_stats_file_ops);
 }
 
 void qib_dbg_ibdev_exit(struct qib_ibdev *ibd)
@@ -274,8 +264,6 @@ void qib_dbg_ibdev_exit(struct qib_ibdev *ibd)
 void qib_dbg_init(void)
 {
 	qib_dbg_root = debugfs_create_dir(QIB_DRV_NAME, NULL);
-	if (!qib_dbg_root)
-		pr_warn("init of debugfs failed\n");
 }
 
 void qib_dbg_exit(void)
-- 
2.20.1

