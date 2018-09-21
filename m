Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A74C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E3E21567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E3E21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391187AbeIUWYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390646AbeIUWYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7576E308402B;
        Fri, 21 Sep 2018 16:34:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C74F382A04;
        Fri, 21 Sep 2018 16:34:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock for
 reconfiguration [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, torvalds@linux-foundation.org,
        dhowells@redhat.com, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:34:20 +0100
Message-ID: <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 21 Sep 2018 16:34:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an fspick() system call that can be used to pick an existing
mountpoint into an fs_context which can thereafter be used to reconfigure a
superblock (equivalent of the superblock side of -o remount).

This looks like:

	int fd = fspick(AT_FDCWD, "/mnt",
			FSPICK_CLOEXEC | FSPICK_NO_AUTOMOUNT);
	fsconfig(fd, FSCONFIG_SET_FLAG, "intr", NULL, 0);
	fsconfig(fd, FSCONFIG_SET_FLAG, "noac", NULL, 0);
	fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);

At the point of fspick being called, the file descriptor referring to the
filesystem context is in exactly the same state as the one that was created
by fsopen() after fsmount() has been successfully called.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-api@vger.kernel.org
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl |    1 +
 fs/fsopen.c                            |   54 ++++++++++++++++++++++++++++++++
 include/linux/syscalls.h               |    1 +
 include/uapi/linux/fs.h                |    5 +++
 5 files changed, 62 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c78b68256f8a..d1eb6c815790 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -403,3 +403,4 @@
 389	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
 390	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 391	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
+392	i386	fspick			sys_fspick			__ia32_sys_fspick
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index d44ead5d4368..d3ab703c02bb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -348,6 +348,7 @@
 337	common	fsopen			__x64_sys_fsopen
 338	common	fsconfig		__x64_sys_fsconfig
 339	common	fsmount			__x64_sys_fsmount
+340	common	fspick			__x64_sys_fspick
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 5955a6b65596..9ead9220e2cb 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -155,6 +155,60 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	return ret;
 }
 
+/*
+ * Pick a superblock into a context for reconfiguration.
+ */
+SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
+{
+	struct fs_context *fc;
+	struct path target;
+	unsigned int lookup_flags;
+	int ret;
+
+	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if ((flags & ~(FSPICK_CLOEXEC |
+		       FSPICK_SYMLINK_NOFOLLOW |
+		       FSPICK_NO_AUTOMOUNT |
+		       FSPICK_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	if (flags & FSPICK_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & FSPICK_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (flags & FSPICK_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+	ret = user_path_at(dfd, path, lookup_flags, &target);
+	if (ret < 0)
+		goto err;
+
+	fc = vfs_new_fs_context(target.dentry->d_sb->s_type, target.dentry,
+				0, 0, FS_CONTEXT_FOR_RECONFIGURE);
+	if (IS_ERR(fc)) {
+		ret = PTR_ERR(fc);
+		goto err_path;
+	}
+
+	fc->phase = FS_CONTEXT_RECONF_PARAMS;
+
+	ret = fscontext_alloc_log(fc);
+	if (ret < 0)
+		goto err_fc;
+
+	path_put(&target);
+	return fscontext_create_fd(fc, flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0);
+
+err_fc:
+	put_fs_context(fc);
+err_path:
+	path_put(&target);
+err:
+	return ret;
+}
+
 /*
  * Check the state and apply the configuration.  Note that this function is
  * allowed to 'steal' the value by setting param->xxx to NULL before returning.
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 4697fad47789..eb8d62f4ee24 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -914,6 +914,7 @@ asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
 asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
 			     const void __user *value, int aux);
 asmlinkage long sys_fsmount(int fs_fd, unsigned int flags, unsigned int ms_flags);
+asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 10281d582e28..7f01503a9e9b 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -351,6 +351,11 @@ typedef int __bitwise __kernel_rwf_t;
 
 #define FSMOUNT_CLOEXEC		0x00000001
 
+#define FSPICK_CLOEXEC		0x00000001
+#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
+#define FSPICK_NO_AUTOMOUNT	0x00000004
+#define FSPICK_EMPTY_PATH	0x00000008
+
 /*
  * The type of fsconfig() call made.
  */

