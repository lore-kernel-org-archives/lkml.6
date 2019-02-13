Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C8C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A2421901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfBMDJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:09:33 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:32660 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbfBMDJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:09:30 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 5BB06A1069;
        Wed, 13 Feb 2019 04:09:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id YhxrrQ6RS05X; Wed, 13 Feb 2019 04:09:22 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v5 1/5] namei: split out nd->dfd handling to dirfd_path_init
Date:   Wed, 13 Feb 2019 14:08:47 +1100
Message-Id: <20190213030851.1881-2-cyphar@cyphar.com>
In-Reply-To: <20190213030851.1881-1-cyphar@cyphar.com>
References: <20190213030851.1881-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, path_init's handling of *at(dfd, ...) was only done once,
but with O_BENEATH (and O_THISROOT) we have to parse the initial
nd->path at different times (before or after absolute path handling)
depending on whether we have been asked to scope resolution within a
root.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c | 103 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a85deb55d0c9..4fdcb36f7c01 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2168,9 +2168,59 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	}
 }
 
+/*
+ * Configure nd->path based on the nd->dfd. This is only used as part of
+ * path_init().
+ */
+static inline int dirfd_path_init(struct nameidata *nd)
+{
+	if (nd->dfd == AT_FDCWD) {
+		if (nd->flags & LOOKUP_RCU) {
+			struct fs_struct *fs = current->fs;
+			unsigned seq;
+
+			do {
+				seq = read_seqcount_begin(&fs->seq);
+				nd->path = fs->pwd;
+				nd->inode = nd->path.dentry->d_inode;
+				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
+			} while (read_seqcount_retry(&fs->seq, seq));
+		} else {
+			get_fs_pwd(current->fs, &nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+	} else {
+		/* Caller must check execute permissions on the starting path component */
+		struct fd f = fdget_raw(nd->dfd);
+		struct dentry *dentry;
+
+		if (!f.file)
+			return -EBADF;
+
+		dentry = f.file->f_path.dentry;
+
+		if (*nd->name->name && unlikely(!d_can_lookup(dentry))) {
+			fdput(f);
+			return -ENOTDIR;
+		}
+
+		nd->path = f.file->f_path;
+		if (nd->flags & LOOKUP_RCU) {
+			nd->inode = nd->path.dentry->d_inode;
+			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
+		} else {
+			path_get(&nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+		fdput(f);
+	}
+	return 0;
+}
+
 /* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
+	int error;
 	const char *s = nd->name->name;
 
 	if (!*s)
@@ -2204,52 +2254,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->m_seq = read_seqbegin(&mount_lock);
 	if (*s == '/') {
-		set_root(nd);
-		if (likely(!nd_jump_root(nd)))
-			return s;
-		return ERR_PTR(-ECHILD);
-	} else if (nd->dfd == AT_FDCWD) {
-		if (flags & LOOKUP_RCU) {
-			struct fs_struct *fs = current->fs;
-			unsigned seq;
-
-			do {
-				seq = read_seqcount_begin(&fs->seq);
-				nd->path = fs->pwd;
-				nd->inode = nd->path.dentry->d_inode;
-				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
-			} while (read_seqcount_retry(&fs->seq, seq));
-		} else {
-			get_fs_pwd(current->fs, &nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		return s;
-	} else {
-		/* Caller must check execute permissions on the starting path component */
-		struct fd f = fdget_raw(nd->dfd);
-		struct dentry *dentry;
-
-		if (!f.file)
-			return ERR_PTR(-EBADF);
-
-		dentry = f.file->f_path.dentry;
-
-		if (*s && unlikely(!d_can_lookup(dentry))) {
-			fdput(f);
-			return ERR_PTR(-ENOTDIR);
-		}
-
-		nd->path = f.file->f_path;
-		if (flags & LOOKUP_RCU) {
-			nd->inode = nd->path.dentry->d_inode;
-			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
-		} else {
-			path_get(&nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		fdput(f);
+		if (likely(!nd->root.mnt))
+			set_root(nd);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			s = ERR_PTR(error);
 		return s;
 	}
+	error = dirfd_path_init(nd);
+	if (unlikely(error))
+		return ERR_PTR(error);
+	return s;
 }
 
 static const char *trailing_symlink(struct nameidata *nd)
-- 
2.20.1

