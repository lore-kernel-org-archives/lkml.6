Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4842CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D632064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D632064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGRQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:25:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35239 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbeGRQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:25:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so3410228wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6UJBXYdZP+k+ZkiiwKeu0yb3LJS54AlqlSDRKQ5Am98=;
        b=JrBuf4Ne121Yd77XflC7angosPREcgqJcJTkVRnLXahxowujWPxhihjnH5qUFldogS
         +iEXbIz2pwoJ6fTHIbZ/a/+Qy6pB/nkTS8q8iCJShkyDtN96PmMcNptZKk2GDFmjyyyV
         bhBOAKnw2Y/tWK9BPs0gfbEt9Zko7sscFpTtNyVWgNPFsUSBe1ApPoKydDGZeUcpDtgw
         Z1h60YCC1akMTl6Dvmz6IVfrf2aSG6DEdu83lE3uL3KUGUsGlmf58ANay0KC1LsOz6pk
         pb4GwsVwogRFzM6jHc0G81SGERQrQcM7HOmwu+rZlmwl0FDS3l2LbXn/opQ+6o79frF+
         C1+A==
X-Gm-Message-State: AOUpUlHsgPnqusiDiId9ESXv5OSqiAw8Ko0GOUIbFLSpLlUyztCWc4vD
        /O17Nachhaxutw33Vij3eABmeA==
X-Google-Smtp-Source: AAOMgpfOVUW5KYpY+F80IVC/6hlDbkZ0k7rg3305xccLpMOJ+S/B8hglDZlDvVSLbEDjOuMD6Z+4sg==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr2076647wmt.31.1531928802067;
        Wed, 18 Jul 2018 08:46:42 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id r17-v6sm5580197wrt.44.2018.07.18.08.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 08:46:41 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: make open_with_fake_path() not contribute to nr_files
Date:   Wed, 18 Jul 2018 17:46:37 +0200
Message-Id: <20180718154637.31878-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stacking file operations in overlay will store an extra open file for each
overlay file opened.

The overhead is just that of "struct file" which is about 256bytes, because
overlay already pins an extra dentry and inode when the file is open, which
add up to a much larger overhead.

For fear of breaking working setups, don't start accounting the extra file.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/file_table.c    | 69 +++++++++++++++++++++++++++++++++++++-----------------
 fs/internal.h      |  1 +
 fs/open.c          |  2 +-
 include/linux/fs.h |  3 +++
 4 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 9b70ed2bbc4e..0cc7bea6b51a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -52,7 +52,8 @@ static void file_free_rcu(struct rcu_head *head)
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	percpu_counter_dec(&nr_files);
+	if (!(f->f_mode & FMODE_NOACCOUNT))
+		percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
 }
 
@@ -91,6 +92,34 @@ int proc_nr_files(struct ctl_table *table, int write,
 }
 #endif
 
+static struct file *__alloc_file(int flags, const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
+	if (unlikely(!f))
+		return ERR_PTR(-ENOMEM);
+
+	f->f_cred = get_cred(cred);
+	error = security_file_alloc(f);
+	if (unlikely(error)) {
+		file_free_rcu(&f->f_u.fu_rcuhead);
+		return ERR_PTR(error);
+	}
+
+	atomic_long_set(&f->f_count, 1);
+	rwlock_init(&f->f_owner.lock);
+	spin_lock_init(&f->f_lock);
+	mutex_init(&f->f_pos_lock);
+	eventpoll_init_file(f);
+	f->f_flags = flags;
+	f->f_mode = OPEN_FMODE(flags);
+	/* f->f_version: 0 */
+
+	return f;
+}
+
 /* Find an unused file structure and return a pointer to it.
  * Returns an error pointer if some error happend e.g. we over file
  * structures limit, run out of memory or operation is not permitted.
@@ -105,7 +134,6 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 {
 	static long old_max;
 	struct file *f;
-	int error;
 
 	/*
 	 * Privileged users can go above max_files
@@ -119,26 +147,10 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 			goto over;
 	}
 
-	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
-	if (unlikely(!f))
-		return ERR_PTR(-ENOMEM);
-
-	f->f_cred = get_cred(cred);
-	error = security_file_alloc(f);
-	if (unlikely(error)) {
-		file_free_rcu(&f->f_u.fu_rcuhead);
-		return ERR_PTR(error);
-	}
+	f = __alloc_file(flags, cred);
+	if (!IS_ERR(f))
+		percpu_counter_inc(&nr_files);
 
-	atomic_long_set(&f->f_count, 1);
-	rwlock_init(&f->f_owner.lock);
-	spin_lock_init(&f->f_lock);
-	mutex_init(&f->f_pos_lock);
-	eventpoll_init_file(f);
-	f->f_flags = flags;
-	f->f_mode = OPEN_FMODE(flags);
-	/* f->f_version: 0 */
-	percpu_counter_inc(&nr_files);
 	return f;
 
 over:
@@ -150,6 +162,21 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 	return ERR_PTR(-ENFILE);
 }
 
+/*
+ * Variant of alloc_empty_file() that doesn't check and modify nr_files.
+ *
+ * Should not be used unless there's a very good reason to do so.
+ */
+struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
+{
+	struct file *f = __alloc_file(flags, cred);
+
+	if (!IS_ERR(f))
+		f->f_mode |= FMODE_NOACCOUNT;
+
+	return f;
+}
+
 /**
  * alloc_file - allocate and initialize a 'struct file'
  *
diff --git a/fs/internal.h b/fs/internal.h
index 52a346903748..442098fa0a84 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -94,6 +94,7 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
  * file_table.c
  */
 extern struct file *alloc_empty_file(int, const struct cred *);
+extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
 
 /*
  * super.c
diff --git a/fs/open.c b/fs/open.c
index dd15711eb658..9c6617dbb2c0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -928,7 +928,7 @@ EXPORT_SYMBOL(dentry_open);
 struct file *open_with_fake_path(const struct path *path, int flags,
 				struct inode *inode, const struct cred *cred)
 {
-	struct file *f = alloc_empty_file(flags, cred);
+	struct file *f = alloc_empty_file_noaccount(flags, cred);
 	if (!IS_ERR(f)) {
 		int error;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5ce2b413abc6..e1884840d556 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -156,6 +156,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File is capable of returning -EAGAIN if I/O will block */
 #define FMODE_NOWAIT	((__force fmode_t)0x8000000)
 
+/* File does not contribute to nr_files count */
+#define FMODE_NOACCOUNT	((__force fmode_t)0x20000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
-- 
2.14.3

