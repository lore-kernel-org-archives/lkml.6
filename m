Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9454FECDFBD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A00B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xP02erl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A00B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeGTAfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:35:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60381 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeGTAfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:35:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3762584484;
        Fri, 20 Jul 2018 11:50:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532044222;
        bh=8MAIhG8lQ2ZEhHg672YwOgM5R0pJ6ZLo8eOGztyQt18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xP02erl8DYSpTLzZabxDkrAgkwtO7egEYhz0wJI52dOhW90TnXhsJ/yi7Si9FdX1c
         3qNdZJWoCyazdTlQd/9coPEETqNiydengiDnaMJpZKai6oy+iG7GLbam/UQswWh5WP
         Uc9FfqBuuRTm2mK6kgUvAj0fd/OsPvIVYzhBs6PI=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5123be0001>; Fri, 20 Jul 2018 11:50:22 +1200
Received: from theunsv-dl.ws.atlnz.lc (theunsv-dl.ws.atlnz.lc [10.33.14.29])
        by smtp (Postfix) with ESMTP id 06C7913EF62;
        Fri, 20 Jul 2018 11:50:23 +1200 (NZST)
Received: by theunsv-dl.ws.atlnz.lc (Postfix, from userid 1451)
        id E62745A0097; Fri, 20 Jul 2018 11:50:21 +1200 (NZST)
From:   Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
Subject: [PATCH 2/2] jffs2: Provide jffs2_sync files to track gc POLL progress
Date:   Fri, 20 Jul 2018 11:50:12 +1200
Message-Id: <f1c6c3cc0c8850e143594afd57b50d30cd8bb5f8.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When executing secure deletion under JFFS2 via the -POLL forced cleanup
option, userspace may need to know when the process has safely completed.
Provide debugfs files per mount that, when read, blocks while cleanup
is in progress: once the read completes it is safe to assume that all
obsoleted sensitive information has been erased.

If CONFIG_JFFS2_FS_SYNC is configured, create
/sys/kernel/debug/jffs2_sync_<fs name> files that block on read
while forced gc is in progress.

Signed-off-by: Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
---
 fs/jffs2/Kconfig |  8 ++++++++
 fs/jffs2/super.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index ad850c5bf2ca..191272729f06 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -96,6 +96,14 @@ config JFFS2_FS_SECURITY
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
 
+config JFFS2_FS_SYNC
+	bool "JFFS2 jffs2_sync file support"
+	depends on JFFS2_FS
+	help
+	  This enables creation of jffs2_sync files for tracking
+	  POLL forced garbage collection.  It is used as part of FIPS
+	  secure deletion support.
+
 config JFFS2_COMPRESSION_OPTIONS
 	bool "Advanced compression options for JFFS2"
 	depends on JFFS2_FS
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 87bdf0f4cba1..264f68ab2e91 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -27,6 +27,7 @@
 #include <linux/namei.h>
 #include <linux/seq_file.h>
 #include <linux/exportfs.h>
+#include <linux/debugfs.h>
 #include "compr.h"
 #include "nodelist.h"
 
@@ -34,6 +35,26 @@ static void jffs2_put_super(struct super_block *);
 
 static struct kmem_cache *jffs2_inode_cachep;
 
+#ifdef CONFIG_JFFS2_FS_SYNC
+#define JFFS2_FS_SYNC_NAME "jffs2_sync"
+static struct dentry *jffs2_debugfs_dir;
+
+ssize_t jffs2_sync_file_read(struct file *f,
+	      char __user *b, size_t len, loff_t *ofs)
+{
+	struct jffs2_sb_info *c = file_inode(f)->i_private;
+
+	while (c->tidemark)
+		schedule();
+
+	return 0;
+}
+const struct file_operations jffs2_sync_ops = {
+	.owner   = THIS_MODULE,
+	.read    = jffs2_sync_file_read,
+};
+#endif
+
 static struct inode *jffs2_alloc_inode(struct super_block *sb)
 {
 	struct jffs2_inode_info *f;
@@ -307,6 +328,17 @@ static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_flags |= SB_POSIXACL;
 #endif
 	ret = jffs2_do_fill_super(sb, data, silent);
+
+#ifdef CONFIG_JFFS2_FS_SYNC
+	if (jffs2_debugfs_dir) {
+		char fname[128];
+
+		snprintf(fname, sizeof(fname), "%s_%s",
+				JFFS2_FS_SYNC_NAME, sb->s_mtd->name);
+		debugfs_create_file(fname, 0444,
+				jffs2_debugfs_dir, c, &jffs2_sync_ops);
+	}
+#endif
 	return ret;
 }
 
@@ -405,6 +437,11 @@ static int __init init_jffs2_fs(void)
 		pr_err("error: Failed to register filesystem\n");
 		goto out_slab;
 	}
+
+#ifdef CONFIG_JFFS2_FS_SYNC
+	jffs2_debugfs_dir = debugfs_create_dir("jffs2", NULL);
+#endif
+
 	return 0;
 
  out_slab:
@@ -419,6 +456,9 @@ static int __init init_jffs2_fs(void)
 static void __exit exit_jffs2_fs(void)
 {
 	unregister_filesystem(&jffs2_fs_type);
+#ifdef CONFIG_JFFS2_FS_SYNC
+	debugfs_remove_recursive(jffs2_debugfs_dir);
+#endif
 	jffs2_destroy_slab_caches();
 	jffs2_compressors_exit();
 
-- 
2.18.0

