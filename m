Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34956C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042F221726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169778;
	bh=W2aJwUuD0l96sWGdi4GivbJSuhGIwbocE7usV93YfwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kgEKeTgSR/PxKMMADkZFniX8ZknINHLtmINPO9PHJVV8W5wFbGM2rVva1er6P2bTa
	 LeLlojjijc3mv94yYA/+d20H2F5sZIICb3aOO29Le6MM0al4zI7Kh7qZpuodKEEVJ3
	 Za2mzbR7zd4hV4E7V7j8LIN4MOrHgxsufGAH2xaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfAVPJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfAVPJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F80621726;
        Tue, 22 Jan 2019 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169773;
        bh=W2aJwUuD0l96sWGdi4GivbJSuhGIwbocE7usV93YfwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQ/FTO2rwSVjU1x+AuINRZj/aN033VRwOhTlTBGkycIdbXkN9PQn7sTey8D8ya78x
         OH4KXgibk6Du+2f0butaBc1LLrD6n6/5y9Fn2gswCxzjy62tu48sO9bLymjn3sWf89
         3RBBPG2Pnph2lpJLNxTB6A7Y9dQAa0y5LIjbij80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        QLogic-Storage-Upstream@cavium.com
Subject: [PATCH 6/7] scsi: qlogic: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:09:05 +0100
Message-Id: <20190122150906.12470-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122150906.12470-1-gregkh@linuxfoundation.org>
References: <20190122150906.12470-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: QLogic-Storage-Upstream@cavium.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qedf/qedf_debugfs.c | 18 ++----------------
 drivers/scsi/qedi/qedi_debugfs.c | 17 ++---------------
 2 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index c29c162a494f..a32d8ee4666e 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -27,30 +27,19 @@ qedf_dbg_host_init(struct qedf_dbg_ctx *qedf,
 		    const struct file_operations *fops)
 {
 	char host_dirname[32];
-	struct dentry *file_dentry = NULL;
 
 	QEDF_INFO(qedf, QEDF_LOG_DEBUGFS, "Creating debugfs host node\n");
 	/* create pf dir */
 	sprintf(host_dirname, "host%u", qedf->host_no);
 	qedf->bdf_dentry = debugfs_create_dir(host_dirname, qedf_dbg_root);
-	if (!qedf->bdf_dentry)
-		return;
 
 	/* create debugfs files */
 	while (dops) {
 		if (!(dops->name))
 			break;
 
-		file_dentry = debugfs_create_file(dops->name, 0600,
-						  qedf->bdf_dentry, qedf,
-						  fops);
-		if (!file_dentry) {
-			QEDF_INFO(qedf, QEDF_LOG_DEBUGFS,
-				   "Debugfs entry %s creation failed\n",
-				   dops->name);
-			debugfs_remove_recursive(qedf->bdf_dentry);
-			return;
-		}
+		debugfs_create_file(dops->name, 0600, qedf->bdf_dentry, qedf,
+				    fops);
 		dops++;
 		fops++;
 	}
@@ -80,9 +69,6 @@ qedf_dbg_init(char *drv_name)
 
 	/* create qed dir in root of debugfs. NULL means debugfs root */
 	qedf_dbg_root = debugfs_create_dir(drv_name, NULL);
-	if (!qedf_dbg_root)
-		QEDF_INFO(NULL, QEDF_LOG_DEBUGFS, "Init of debugfs "
-			   "failed\n");
 }
 
 /**
diff --git a/drivers/scsi/qedi/qedi_debugfs.c b/drivers/scsi/qedi/qedi_debugfs.c
index fd914ca4149a..5667e4752e2e 100644
--- a/drivers/scsi/qedi/qedi_debugfs.c
+++ b/drivers/scsi/qedi/qedi_debugfs.c
@@ -23,27 +23,16 @@ qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
 		   const struct file_operations *fops)
 {
 	char host_dirname[32];
-	struct dentry *file_dentry = NULL;
 
 	sprintf(host_dirname, "host%u", qedi->host_no);
 	qedi->bdf_dentry = debugfs_create_dir(host_dirname, qedi_dbg_root);
-	if (!qedi->bdf_dentry)
-		return;
 
 	while (dops) {
 		if (!(dops->name))
 			break;
 
-		file_dentry = debugfs_create_file(dops->name, 0600,
-						  qedi->bdf_dentry, qedi,
-						  fops);
-		if (!file_dentry) {
-			QEDI_INFO(qedi, QEDI_LOG_DEBUGFS,
-				  "Debugfs entry %s creation failed\n",
-				  dops->name);
-			debugfs_remove_recursive(qedi->bdf_dentry);
-			return;
-		}
+		debugfs_create_file(dops->name, 0600, qedi->bdf_dentry, qedi,
+				    fops);
 		dops++;
 		fops++;
 	}
@@ -60,8 +49,6 @@ void
 qedi_dbg_init(char *drv_name)
 {
 	qedi_dbg_root = debugfs_create_dir(drv_name, NULL);
-	if (!qedi_dbg_root)
-		QEDI_INFO(NULL, QEDI_LOG_DEBUGFS, "Init of debugfs failed\n");
 }
 
 void
-- 
2.20.1

