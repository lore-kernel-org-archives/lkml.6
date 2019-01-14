Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9110320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3U6k3Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfANSXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:23:30 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52873 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfANSXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:23:30 -0500
Received: by mail-qt1-f201.google.com with SMTP id w15so25484518qtk.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SHK+IOeculRAQi6J0T4o1mQ7HU+iz1CfKWD3z3R3LeM=;
        b=F3U6k3GvdlNm75jnk4Sre+J9c+CObIcbI6OkUqWpUWUpUR6jYIOM+172p6b7lnw/np
         yrirrVquEVmkFRHdxwWxAFq2eFMNP54lMTWgTb43QLqdbJASK1b6HXNmfuoNfYxIaAgF
         eFVGv50GW2o42ZFqE4EdF1sKLJJG/S/ji6n3PHSa4ItMtb4mZBihmv92yTc6AwJwRbZ0
         9JwYuNB0tDElZgvAWjnIxYX11DtgQk4HwD/+dVvvJba0As8noRYihENfllMFVxZsjvbu
         bb+BYYlrQwNqSl5/pqziekxGxIAY2YB6kpFILeR2sd29Hvw0xeWSSEKnnPQ0GasSfhgU
         03QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SHK+IOeculRAQi6J0T4o1mQ7HU+iz1CfKWD3z3R3LeM=;
        b=N4Uu8Ug4khcfoye8BGUygQDzwlj5Q5/t3KpIxM6XxI2twg7j1TlXh2gLDCDhPwPaYR
         FYBo3+ctNawXwX3tIMcK9qSRxblqiCP6YDtERCiIMfASx7gutBrCCMU3RLLofrv1aGXh
         VP7cSTbLQYlAjo+ST7pMetPxfudAWoRAaZa7n7r11YaY8gebwS5yObgp5WumITtVSd8o
         4DIVokxc/N4eRFNp2rlMBXjyY2oZoz0I++h47DFBELuKY3QfefCV0RmowPmVSAnUKooC
         pCPjypG7jWW5pQxBQCCp4oR8son7BDrsYu9zjdNI20Fzju8GV2lMX3JW5U5ldE+tFpma
         adWQ==
X-Gm-Message-State: AJcUuke/DBuyFS2CZHJosfE25AqPUdEcO8ny93K3zuIjnXvT6DOy+ARY
        2BHKVX/0CgmHRfoU/l0Zd1J+R/57Mw==
X-Google-Smtp-Source: ALg8bN5rhvK62AjBhArzjuBFaBhYsC2duco/Jv+2/6K36/l0OMymdPazul90Q0PQkldc4GkmX1UJ4t+iEQ==
X-Received: by 2002:a0c:a8cd:: with SMTP id h13mr8893841qvc.54.1547490208796;
 Mon, 14 Jan 2019 10:23:28 -0800 (PST)
Date:   Mon, 14 Jan 2019 19:23:17 +0100
Message-Id: <20190114182318.110443-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 1/2] fs: don't let getdents return bogus names
From:   Jann Horn <jannh@google.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, jannh@google.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you e.g. run `find` on a directory for which getdents returns
"filenames" that contain slashes, `find` passes those "filenames" back to
the kernel, which then interprets them as paths. That could conceivably
cause userspace to do something bad when accessing something like an
untrusted USB stick, but I'm not aware of any specific example.

Instead of returning bogus filenames to userspace, return -EUCLEAN.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>

I ordered this fix before the refactoring one so that it can easily be
backported.
---
Bringing that half-year-old patch back to life...

changed in v2:
 - move bogus_dirent_name() out of the #ifdef (kbuild test robot)
changed in v3:
 - change calling convention (Al Viro)
 - comment fix

 arch/alpha/kernel/osf_sys.c |  4 ++++
 fs/readdir.c                | 35 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h          |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 792586038808..e60f8e72591b 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -40,6 +40,7 @@
 #include <linux/vfs.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
@@ -117,6 +118,9 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
 	unsigned int reclen = ALIGN(NAME_OFFSET + namlen + 1, sizeof(u32));
 	unsigned int d_ino;
 
+	buf->error = check_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail */
 	if (reclen > buf->count)
 		return -EINVAL;
diff --git a/fs/readdir.c b/fs/readdir.c
index 2f6a4534e0df..102b0c86a97f 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -64,6 +64,26 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 }
 EXPORT_SYMBOL(iterate_dir);
 
+/*
+ * Most filesystems don't filter out bogus directory entry names, and userspace
+ * can get very confused by such names. Behave as if a filesystem error had
+ * happened while reading directory entries.
+ */
+int check_dirent_name(const char *name, int namlen)
+{
+	if (namlen == 0) {
+		pr_err_once("%s: filesystem returned bogus empty name\n",
+			    __func__);
+		return -EUCLEAN;
+	}
+	if (memchr(name, '/', namlen)) {
+		pr_err_once("%s: filesystem returned bogus name '%*pEhp' (contains slash)\n",
+			    __func__, namlen, name);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
 /*
  * Traditional linux readdir() handling..
  *
@@ -98,6 +118,9 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
 
 	if (buf->result)
 		return -EINVAL;
+	buf->result = check_dirent_name(name, namlen);
+	if (unlikely(buf->result))
+		return -EUCLEAN;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -173,6 +196,9 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 
+	buf->error = check_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -259,6 +285,9 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 
+	buf->error = check_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -358,6 +387,9 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
 
 	if (buf->result)
 		return -EINVAL;
+	buf->result = check_dirent_name(name, namlen);
+	if (unlikely(buf->result))
+		return -EUCLEAN;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -427,6 +459,9 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
 		namlen + 2, sizeof(compat_long_t));
 
+	buf->error = check_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 811c77743dad..e14329741e3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1730,6 +1730,8 @@ struct dir_context {
 	loff_t pos;
 };
 
+int check_dirent_name(const char *name, int namlen);
+
 struct block_device_operations;
 
 /* These macros are for out of kernel modules to test that
-- 
2.20.1.97.g81188d93c3-goog

