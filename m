Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9592086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pK8ELFG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfARQPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:15:07 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:55536 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfARQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:15:06 -0500
Received: by mail-it1-f202.google.com with SMTP id j3so4137464itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5LVynhbNulaKwqSUfCuVd5OKAuOmA6joY7YHWKe61BE=;
        b=pK8ELFG73xxugBocSGDSUnJNvyIwt/ohjdBBzz0Lfb6JLLaL8FHzw/nzHvQXQp96m/
         lBw4vsgTGxcinCLs7piaU+dxMdyYvqsJU78prIqb11Oi3n22vwAiANkZQHoZD5iFirxn
         o9dEh8zlzHsTQ8HkJuvtU8RcM9/vSPaGo+YaDLVHZ07JnT1IKBA7QioWqxGWI1TfprLs
         aOHwOOZV3JE6DCJghvuybtywai8beQYUqR86HH2xoEnPK31pKk4uY8a7onZs5XLHIAU8
         W/LYw/QCyafekdnJ8Lq/cPg0PyMUrDJjHVr/apGUdtV939ItwCapB1N0RKTbw79hrx08
         Zy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5LVynhbNulaKwqSUfCuVd5OKAuOmA6joY7YHWKe61BE=;
        b=n0JCmkQitCldVWgzw6ChFXWxMVPPOjRXgsREHR3lBIJbWABS7pa4lsb2RYvfhgMFxz
         CwuKg91nA7dRpyM7WrT7xHbd2W2/SkCdue+s4/zaycwDcjNtUZmJkGKqNP+1KgnBlgwy
         J/rC2xByjeEkpL0ytWnVwInS4vlVpV23ctRQRFtqt/ujux/zVnCkNnmgN3mKRResgDPR
         B6RNiHfPhT3OuP5LE8Rb5VsD5rMYAegA2ZkDRJlqYxgQDD4W9E9yPhVHHeHdMNTXWjBX
         eFRkU1CrAqBwYCdo0AHgXY02mwsN7WjPEObVokWfLs4ZMAqbaUT6Ih/vrXGBr7FCm3uD
         QlDQ==
X-Gm-Message-State: AJcUukffvpez08sOENVq7FeAH85iONZlcLGvsxMfClssoYSbikmpJOAL
        C5dNTBGp3i2ekPNfs8ClCOlgrsJanw==
X-Google-Smtp-Source: ALg8bN6Q1AsznvuU/aVkHTxiuYPcSwkewBljenfXIaGdUzU3IdByf4DK+AhQ0a2HYCjsb/Zk9KuyMFgz6g==
X-Received: by 2002:a24:5f49:: with SMTP id r70mr648398itb.22.1547828105167;
 Fri, 18 Jan 2019 08:15:05 -0800 (PST)
Date:   Fri, 18 Jan 2019 17:14:39 +0100
In-Reply-To: <20190118161440.220134-1-jannh@google.com>
Message-Id: <20190118161440.220134-2-jannh@google.com>
Mime-Version: 1.0
References: <20190118161440.220134-1-jannh@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v4 2/3] fs: don't let getdents return bogus names
From:   Jann Horn <jannh@google.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        jannh@google.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Pavel Machek <pavel@ucw.cz>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
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
---
I ordered this fix before the refactoring one so that it can easily be
backported.

changed in v2:
 - move bogus_dirent_name() out of the #ifdef (kbuild test robot)
changed in v3:
 - change calling convention (Al Viro)
 - comment fix
changed in v4:
 - use EFSCORRUPTED instead of EUCLEAN (Dave Chinner)

 arch/alpha/kernel/osf_sys.c |  4 ++++
 fs/readdir.c                | 35 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h          |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 792586038808..db1c2144d477 100644
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
+		return -EFSCORRUPTED;
 	buf->error = -EINVAL;	/* only used if we fail */
 	if (reclen > buf->count)
 		return -EINVAL;
diff --git a/fs/readdir.c b/fs/readdir.c
index 2f6a4534e0df..58088510bb9c 100644
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
+		return -EFSCORRUPTED;
+	}
+	if (memchr(name, '/', namlen)) {
+		pr_err_once("%s: filesystem returned bogus name '%*pEhp' (contains slash)\n",
+			    __func__, namlen, name);
+		return -EFSCORRUPTED;
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
+		return -EFSCORRUPTED;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -173,6 +196,9 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 
+	buf->error = check_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return -EFSCORRUPTED;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -259,6 +285,9 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 
+	buf->error = check_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return -EFSCORRUPTED;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -358,6 +387,9 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
 
 	if (buf->result)
 		return -EINVAL;
+	buf->result = check_dirent_name(name, namlen);
+	if (unlikely(buf->result))
+		return -EFSCORRUPTED;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -427,6 +459,9 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
 		namlen + 2, sizeof(compat_long_t));
 
+	buf->error = check_dirent_name(name, namlen);
+	if (unlikely(buf->error))
+		return -EFSCORRUPTED;
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
2.20.1.321.g9e740568ce-goog

