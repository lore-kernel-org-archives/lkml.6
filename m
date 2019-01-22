Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C41C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8566F217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170547;
	bh=nZ0M9twGJD8LAfaJzrFl8VYsq0r/7+p6enj2M7fargA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gRow7Llsvih3o61zR1dc03KVurzHBdWIyiQfloZPy9O+vXmwbsrTajO6jwu0zob6I
	 4+Di6Xo8VgBpoHoik3wJTqAzeqaAzvau9R+i4fqbwqkGkKLqrZC5SiexMFmGlikkt4
	 tIuAO/Pj04/3ipOQR9FZCIYEae018zy62gakEVL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfAVPW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfAVPWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:22:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1A5217D4;
        Tue, 22 Jan 2019 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170543;
        bh=nZ0M9twGJD8LAfaJzrFl8VYsq0r/7+p6enj2M7fargA=;
        h=From:To:Cc:Subject:Date:From;
        b=NrufUabFRi74GElQ/Aa2DE9PepN7dtTPoT5M1hEvUv6flGsGBrxsyqkW1gnZtOSwW
         eZunQ6qfCoPIApKHrkb+fL5TCmTNVqIreydmm9LmCd6phcRgT9/EbeEYJng98PE2oj
         o+eVTSAbIkcRLx/llqwOh0TO2yHoCfTuH5QAtOqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH] edac: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:16 +0100
Message-Id: <20190122152151.16139-17-gregkh@linuxfoundation.org>
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

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/debugfs.c     | 45 ++++++++++----------------------------
 drivers/edac/edac_module.h |  4 ++--
 2 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 92dbb7e2320c..fd27ea0453a3 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -44,10 +44,6 @@ static const struct file_operations debug_fake_inject_fops = {
 int __init edac_debugfs_init(void)
 {
 	edac_debugfs = debugfs_create_dir("edac", NULL);
-	if (IS_ERR(edac_debugfs)) {
-		edac_debugfs = NULL;
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -56,50 +52,31 @@ void edac_debugfs_exit(void)
 	debugfs_remove_recursive(edac_debugfs);
 }
 
-int edac_create_debugfs_nodes(struct mem_ctl_info *mci)
+void edac_create_debugfs_nodes(struct mem_ctl_info *mci)
 {
-	struct dentry *d, *parent;
+	struct dentry *parent;
 	char name[80];
 	int i;
 
-	if (!edac_debugfs)
-		return -ENODEV;
-
-	d = debugfs_create_dir(mci->dev.kobj.name, edac_debugfs);
-	if (!d)
-		return -ENOMEM;
-	parent = d;
+	parent = debugfs_create_dir(mci->dev.kobj.name, edac_debugfs);
 
 	for (i = 0; i < mci->n_layers; i++) {
 		sprintf(name, "fake_inject_%s",
 			     edac_layer_name[mci->layers[i].type]);
-		d = debugfs_create_u8(name, S_IRUGO | S_IWUSR, parent,
-				      &mci->fake_inject_layer[i]);
-		if (!d)
-			goto nomem;
+		debugfs_create_u8(name, S_IRUGO | S_IWUSR, parent,
+				  &mci->fake_inject_layer[i]);
 	}
 
-	d = debugfs_create_bool("fake_inject_ue", S_IRUGO | S_IWUSR, parent,
-				&mci->fake_inject_ue);
-	if (!d)
-		goto nomem;
+	debugfs_create_bool("fake_inject_ue", S_IRUGO | S_IWUSR, parent,
+			    &mci->fake_inject_ue);
 
-	d = debugfs_create_u16("fake_inject_count", S_IRUGO | S_IWUSR, parent,
-				&mci->fake_inject_count);
-	if (!d)
-		goto nomem;
+	debugfs_create_u16("fake_inject_count", S_IRUGO | S_IWUSR, parent,
+			   &mci->fake_inject_count);
 
-	d = debugfs_create_file("fake_inject", S_IWUSR, parent,
-				&mci->dev,
-				&debug_fake_inject_fops);
-	if (!d)
-		goto nomem;
+	debugfs_create_file("fake_inject", S_IWUSR, parent, &mci->dev,
+			    &debug_fake_inject_fops);
 
 	mci->debugfs = parent;
-	return 0;
-nomem:
-	edac_debugfs_remove_recursive(mci->debugfs);
-	return -ENOMEM;
 }
 
 /* Create a toplevel dir under EDAC's debugfs hierarchy */
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index dec88dcea036..bc63a6a9dd0a 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -71,7 +71,7 @@ extern void *edac_align_ptr(void **p, unsigned size, int n_elems);
 #ifdef CONFIG_EDAC_DEBUG
 int edac_debugfs_init(void);
 void edac_debugfs_exit(void);
-int edac_create_debugfs_nodes(struct mem_ctl_info *mci);
+void edac_create_debugfs_nodes(struct mem_ctl_info *mci);
 struct dentry *edac_debugfs_create_dir(const char *dirname);
 struct dentry *
 edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent);
@@ -85,7 +85,7 @@ edac_debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent, u
 #else
 static inline int edac_debugfs_init(void)					{ return -ENODEV; }
 static inline void edac_debugfs_exit(void)					{ }
-static inline int edac_create_debugfs_nodes(struct mem_ctl_info *mci)		{ return 0; }
+static inline void edac_create_debugfs_nodes(struct mem_ctl_info *mci)		{ }
 static inline struct dentry *edac_debugfs_create_dir(const char *dirname)	{ return NULL; }
 static inline struct dentry *
 edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent)		{ return NULL; }
-- 
2.20.1

