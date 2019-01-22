Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7CFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C33217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170716;
	bh=rC35aJkPnD1oaQK7PPAqzOSVqzzi5/Vxkd8otbY99vY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J0NRg1P7BdkFzHsnQ0kdJjM4AzpME0cie2BRIkqAYSN5/N8IRMKYOWAZZHNf4Kr1a
	 V+E7Fq+dKSC2cFU/ASFgDxFn6t0u0KPpqY2z4yGDEg/Z5CnesbLsC34cEAc4cd/LMT
	 jhyOir3v/VHNejinB+HMYfpDp9Z1YHcCgHixHboU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfAVPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:24:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbfAVPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:24:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1553620855;
        Tue, 22 Jan 2019 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170642;
        bh=rC35aJkPnD1oaQK7PPAqzOSVqzzi5/Vxkd8otbY99vY=;
        h=From:To:Cc:Subject:Date:From;
        b=CTTD/Ch/3pEVFcsl6nrRxmIn7hHxS9ghFLcSJyKMMhBIPQS37CDCaN8FimvFeHtxl
         JsAcjznUTGbUjHRWRoH69KzG5hXkmHjPWNTdel9MMfQpDn214dxf3FgF3TRr2npnti
         saHyZljpxqe9+VOPCYxfwqnxrRSRK0PWI83NBy6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH] gfs: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:51 +0100
Message-Id: <20190122152151.16139-52-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

There is no need to save the dentries for the debugfs files, so drop
those variables to save a bit of space and make the code simpler.

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/glock.c  | 70 ++++++++++--------------------------------------
 fs/gfs2/glock.h  |  4 +--
 fs/gfs2/incore.h |  3 ---
 fs/gfs2/main.c   |  6 +----
 4 files changed, 17 insertions(+), 66 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b92740edc416..f66773c71bcd 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2131,71 +2131,29 @@ static const struct file_operations gfs2_sbstats_fops = {
 	.release = seq_release,
 };
 
-int gfs2_create_debugfs_file(struct gfs2_sbd *sdp)
-{
-	struct dentry *dent;
-
-	dent = debugfs_create_dir(sdp->sd_table_name, gfs2_root);
-	if (IS_ERR_OR_NULL(dent))
-		goto fail;
-	sdp->debugfs_dir = dent;
-
-	dent = debugfs_create_file("glocks",
-				   S_IFREG | S_IRUGO,
-				   sdp->debugfs_dir, sdp,
-				   &gfs2_glocks_fops);
-	if (IS_ERR_OR_NULL(dent))
-		goto fail;
-	sdp->debugfs_dentry_glocks = dent;
-
-	dent = debugfs_create_file("glstats",
-				   S_IFREG | S_IRUGO,
-				   sdp->debugfs_dir, sdp,
-				   &gfs2_glstats_fops);
-	if (IS_ERR_OR_NULL(dent))
-		goto fail;
-	sdp->debugfs_dentry_glstats = dent;
-
-	dent = debugfs_create_file("sbstats",
-				   S_IFREG | S_IRUGO,
-				   sdp->debugfs_dir, sdp,
-				   &gfs2_sbstats_fops);
-	if (IS_ERR_OR_NULL(dent))
-		goto fail;
-	sdp->debugfs_dentry_sbstats = dent;
+void gfs2_create_debugfs_file(struct gfs2_sbd *sdp)
+{
+	sdp->debugfs_dir = debugfs_create_dir(sdp->sd_table_name, gfs2_root);
 
-	return 0;
-fail:
-	gfs2_delete_debugfs_file(sdp);
-	return dent ? PTR_ERR(dent) : -ENOMEM;
+	debugfs_create_file("glocks", S_IFREG | S_IRUGO, sdp->debugfs_dir, sdp,
+			    &gfs2_glocks_fops);
+
+	debugfs_create_file("glstats", S_IFREG | S_IRUGO, sdp->debugfs_dir, sdp,
+			    &gfs2_glstats_fops);
+
+	debugfs_create_file("sbstats", S_IFREG | S_IRUGO, sdp->debugfs_dir, sdp,
+			    &gfs2_sbstats_fops);
 }
 
 void gfs2_delete_debugfs_file(struct gfs2_sbd *sdp)
 {
-	if (sdp->debugfs_dir) {
-		if (sdp->debugfs_dentry_glocks) {
-			debugfs_remove(sdp->debugfs_dentry_glocks);
-			sdp->debugfs_dentry_glocks = NULL;
-		}
-		if (sdp->debugfs_dentry_glstats) {
-			debugfs_remove(sdp->debugfs_dentry_glstats);
-			sdp->debugfs_dentry_glstats = NULL;
-		}
-		if (sdp->debugfs_dentry_sbstats) {
-			debugfs_remove(sdp->debugfs_dentry_sbstats);
-			sdp->debugfs_dentry_sbstats = NULL;
-		}
-		debugfs_remove(sdp->debugfs_dir);
-		sdp->debugfs_dir = NULL;
-	}
+	debugfs_remove_recursive(sdp->debugfs_dir);
+	sdp->debugfs_dir = NULL;
 }
 
-int gfs2_register_debugfs(void)
+void gfs2_register_debugfs(void)
 {
 	gfs2_root = debugfs_create_dir("gfs2", NULL);
-	if (IS_ERR(gfs2_root))
-		return PTR_ERR(gfs2_root);
-	return gfs2_root ? 0 : -ENOMEM;
 }
 
 void gfs2_unregister_debugfs(void)
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 8949bf28b249..936b3295839c 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -243,9 +243,9 @@ extern void gfs2_glock_free(struct gfs2_glock *gl);
 extern int __init gfs2_glock_init(void);
 extern void gfs2_glock_exit(void);
 
-extern int gfs2_create_debugfs_file(struct gfs2_sbd *sdp);
+extern void gfs2_create_debugfs_file(struct gfs2_sbd *sdp);
 extern void gfs2_delete_debugfs_file(struct gfs2_sbd *sdp);
-extern int gfs2_register_debugfs(void);
+extern void gfs2_register_debugfs(void);
 extern void gfs2_unregister_debugfs(void);
 
 extern const struct lm_lockops gfs2_dlm_ops;
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e10e0b0a7cd5..cdf07b408f54 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -853,9 +853,6 @@ struct gfs2_sbd {
 
 	unsigned long sd_last_warning;
 	struct dentry *debugfs_dir;    /* debugfs directory */
-	struct dentry *debugfs_dentry_glocks;
-	struct dentry *debugfs_dentry_glstats;
-	struct dentry *debugfs_dentry_sbstats;
 };
 
 static inline void gfs2_glstats_inc(struct gfs2_glock *gl, int which)
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index c7603063f861..136484ef35d3 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -178,16 +178,12 @@ static int __init init_gfs2_fs(void)
 	if (!gfs2_page_pool)
 		goto fail_mempool;
 
-	error = gfs2_register_debugfs();
-	if (error)
-		goto fail_debugfs;
+	gfs2_register_debugfs();
 
 	pr_info("GFS2 installed\n");
 
 	return 0;
 
-fail_debugfs:
-	mempool_destroy(gfs2_page_pool);
 fail_mempool:
 	destroy_workqueue(gfs2_freeze_wq);
 fail_wq3:
-- 
2.20.1

