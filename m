Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73DBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770E1217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170302;
	bh=qIEJE3c9qVLw4o2nokNarR3zPr4YKvfBJxLZ7gI6A5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CmJ5MonZz93IuukWYgyvkvPjutuFkIaGJszxiMAuni137QrOaMLvz+fFG6irXuoy3
	 KMN+rIqQU1uWSdp4HzQxfF92LCJRVYUYWNVuf/rmqK8MafnvrGM63lynifZiGqhxFV
	 G7p4uA58s8cDd7cfJ5zDIvfYKrWE0EArzgPGoMWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfAVPSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfAVPSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B9120879;
        Tue, 22 Jan 2019 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170297;
        bh=qIEJE3c9qVLw4o2nokNarR3zPr4YKvfBJxLZ7gI6A5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHwrLtPC7u9F7L0HVP0TKtMHXEaHRk+Roo0Oxg/gX5UYpR/lrZyzOSvKsq1nkhdo+
         mzkLsIihnD3r4vEdcGqBZhqhI2369EQ8oE9D4JkMk2hAgDl8bZRXx2i14RpFFW6me6
         1txoKSKQkkcFLGqeMMNWONIyJFkILi0E7TGiDIpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH 3/8] infiniband: hfi1: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:17:55 +0100
Message-Id: <20190122151800.15092-4-gregkh@linuxfoundation.org>
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
 drivers/infiniband/hw/hfi1/debugfs.c |  2 --
 drivers/infiniband/hw/hfi1/fault.c   | 50 ++++++++++------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index 52c00c67056f..961009e66047 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -1335,8 +1335,6 @@ DEBUGFS_FILE_OPS(driver_stats);
 void hfi1_dbg_init(void)
 {
 	hfi1_dbg_root  = debugfs_create_dir(DRIVER_NAME, NULL);
-	if (!hfi1_dbg_root)
-		pr_warn("init of debugfs failed\n");
 	debugfs_create_file("driver_stats_names", 0444, hfi1_dbg_root, NULL, &_driver_stats_names_file_ops);
 	debugfs_create_file("driver_stats", 0444, hfi1_dbg_root, NULL, &_driver_stats_file_ops);
 }
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index dd09b8544568..195fe81e13ea 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -250,6 +250,7 @@ void hfi1_fault_exit_debugfs(struct hfi1_ibdev *ibd)
 int hfi1_fault_init_debugfs(struct hfi1_ibdev *ibd)
 {
 	struct dentry *parent = ibd->hfi1_ibdev_dbg;
+	struct dentry *fault_dir;
 
 	ibd->fault = kzalloc(sizeof(*ibd->fault), GFP_KERNEL);
 	if (!ibd->fault)
@@ -269,46 +270,31 @@ int hfi1_fault_init_debugfs(struct hfi1_ibdev *ibd)
 	bitmap_zero(ibd->fault->opcodes,
 		    sizeof(ibd->fault->opcodes) * BITS_PER_BYTE);
 
-	ibd->fault->dir =
-		fault_create_debugfs_attr("fault", parent,
-					  &ibd->fault->attr);
-	if (IS_ERR(ibd->fault->dir)) {
+	fault_dir = fault_create_debugfs_attr("fault", parent,
+					      &ibd->fault->attr);
+	if (IS_ERR(fault_dir)) {
 		kfree(ibd->fault);
 		ibd->fault = NULL;
 		return -ENOENT;
 	}
+	ibd->fault->dir = fault_dir;
 
-	debugfs_create_file("fault_stats", 0444, ibd->fault->dir, ibd,
+	debugfs_create_file("fault_stats", 0444, fault_dir, ibd,
 			    &_fault_stats_file_ops);
-	if (!debugfs_create_bool("enable", 0600, ibd->fault->dir,
-				 &ibd->fault->enable))
-		goto fail;
-	if (!debugfs_create_bool("suppress_err", 0600,
-				 ibd->fault->dir,
-				 &ibd->fault->suppress_err))
-		goto fail;
-	if (!debugfs_create_bool("opcode_mode", 0600, ibd->fault->dir,
-				 &ibd->fault->opcode))
-		goto fail;
-	if (!debugfs_create_file("opcodes", 0600, ibd->fault->dir,
-				 ibd->fault, &__fault_opcodes_fops))
-		goto fail;
-	if (!debugfs_create_u64("skip_pkts", 0600,
-				ibd->fault->dir,
-				&ibd->fault->fault_skip))
-		goto fail;
-	if (!debugfs_create_u64("skip_usec", 0600,
-				ibd->fault->dir,
-				&ibd->fault->fault_skip_usec))
-		goto fail;
-	if (!debugfs_create_u8("direction", 0600, ibd->fault->dir,
-			       &ibd->fault->direction))
-		goto fail;
+	debugfs_create_bool("enable", 0600, fault_dir, &ibd->fault->enable);
+	debugfs_create_bool("suppress_err", 0600, fault_dir,
+			    &ibd->fault->suppress_err);
+	debugfs_create_bool("opcode_mode", 0600, fault_dir,
+			    &ibd->fault->opcode);
+	debugfs_create_file("opcodes", 0600, fault_dir, ibd->fault,
+			    &__fault_opcodes_fops);
+	debugfs_create_u64("skip_pkts", 0600, fault_dir,
+			   &ibd->fault->fault_skip);
+	debugfs_create_u64("skip_usec", 0600, fault_dir,
+			   &ibd->fault->fault_skip_usec);
+	debugfs_create_u8("direction", 0600, fault_dir, &ibd->fault->direction);
 
 	return 0;
-fail:
-	hfi1_fault_exit_debugfs(ibd);
-	return -ENOMEM;
 }
 
 bool hfi1_dbg_fault_suppress_err(struct hfi1_ibdev *ibd)
-- 
2.20.1

