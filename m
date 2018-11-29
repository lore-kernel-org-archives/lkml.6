Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0757C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7D22146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV3GLq0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7D22146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbeK3B3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbeK3B3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED766213A2;
        Thu, 29 Nov 2018 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501423;
        bh=cQgmg0kfKx1jKdzBJOfG1ZsMIDka3SCVBMwDSncxVBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV3GLq0+Bm5wTtc1a/66o3IUqQqLqzlH57aPI865aDatcgHf+H/Asw2EnZp9NzioV
         g1akCS09MWfpONsUNCxYzCYjOFPtNkDV3Krn/GiDljy/EuqbRixGAIXZzEIoiT4olh
         b9ECvQ+XYL3gtO7Ar/H0IO4RslFHfKH2D5MFPg0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Loic <hackurx@opensec.fr>
Subject: [PATCH 4.9 84/92] namei: allow restricted O_CREAT of FIFOs and regular files
Date:   Thu, 29 Nov 2018 15:12:53 +0100
Message-Id: <20181129140113.433177659@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Salvatore Mesoraca <s.mesoraca16@gmail.com>

commit 30aba6656f61ed44cba445a3c0d38b296fa9e8f5 upstream.

Disallows open of FIFOs or regular files not owned by the user in world
writable sticky directories, unless the owner is the same as that of the
directory or the file is opened without the O_CREAT flag.  The purpose
is to make data spoofing attacks harder.  This protection can be turned
on and off separately for FIFOs and regular files via sysctl, just like
the symlinks/hardlinks protection.  This patch is based on Openwall's
"HARDEN_FIFO" feature by Solar Designer.

This is a brief list of old vulnerabilities that could have been prevented
by this feature, some of them even allow for privilege escalation:

CVE-2000-1134
CVE-2007-3852
CVE-2008-0525
CVE-2009-0416
CVE-2011-4834
CVE-2015-1838
CVE-2015-7442
CVE-2016-7489

This list is not meant to be complete.  It's difficult to track down all
vulnerabilities of this kind because they were often reported without any
mention of this particular attack vector.  In fact, before
hardlinks/symlinks restrictions, fifos/regular files weren't the favorite
vehicle to exploit them.

[s.mesoraca16@gmail.com: fix bug reported by Dan Carpenter]
  Link: https://lkml.kernel.org/r/20180426081456.GA7060@mwanda
  Link: http://lkml.kernel.org/r/1524829819-11275-1-git-send-email-s.mesoraca16@gmail.com
[keescook@chromium.org: drop pr_warn_ratelimited() in favor of audit changes in the future]
[keescook@chromium.org: adjust commit subjet]
Link: http://lkml.kernel.org/r/20180416175918.GA13494@beast
Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Suggested-by: Solar Designer <solar@openwall.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Loic <hackurx@opensec.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/sysctl/fs.txt |   36 +++++++++++++++++++++++++++++
 fs/namei.c                  |   53 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h          |    2 +
 kernel/sysctl.c             |   18 ++++++++++++++
 4 files changed, 106 insertions(+), 3 deletions(-)

--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -34,7 +34,9 @@ Currently, these files are in /proc/sys/
 - overflowgid
 - pipe-user-pages-hard
 - pipe-user-pages-soft
+- protected_fifos
 - protected_hardlinks
+- protected_regular
 - protected_symlinks
 - suid_dumpable
 - super-max
@@ -182,6 +184,24 @@ applied.
 
 ==============================================================
 
+protected_fifos:
+
+The intent of this protection is to avoid unintentional writes to
+an attacker-controlled FIFO, where a program expected to create a regular
+file.
+
+When set to "0", writing to FIFOs is unrestricted.
+
+When set to "1" don't allow O_CREAT open on FIFOs that we don't own
+in world writable sticky directories, unless they are owned by the
+owner of the directory.
+
+When set to "2" it also applies to group writable sticky directories.
+
+This protection is based on the restrictions in Openwall.
+
+==============================================================
+
 protected_hardlinks:
 
 A long-standing class of security issues is the hardlink-based
@@ -202,6 +222,22 @@ This protection is based on the restrict
 
 ==============================================================
 
+protected_regular:
+
+This protection is similar to protected_fifos, but it
+avoids writes to an attacker-controlled regular file, where a program
+expected to create one.
+
+When set to "0", writing to regular files is unrestricted.
+
+When set to "1" don't allow O_CREAT open on regular files that we
+don't own in world writable sticky directories, unless they are
+owned by the owner of the directory.
+
+When set to "2" it also applies to group writable sticky directories.
+
+==============================================================
+
 protected_symlinks:
 
 A long-standing class of security issues is the symlink-based
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -892,6 +892,8 @@ static inline void put_link(struct namei
 
 int sysctl_protected_symlinks __read_mostly = 0;
 int sysctl_protected_hardlinks __read_mostly = 0;
+int sysctl_protected_fifos __read_mostly;
+int sysctl_protected_regular __read_mostly;
 
 /**
  * may_follow_link - Check symlink following for unsafe situations
@@ -1005,6 +1007,45 @@ static int may_linkat(struct path *link)
 	return -EPERM;
 }
 
+/**
+ * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
+ *			  should be allowed, or not, on files that already
+ *			  exist.
+ * @dir: the sticky parent directory
+ * @inode: the inode of the file to open
+ *
+ * Block an O_CREAT open of a FIFO (or a regular file) when:
+ *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
+ *   - the file already exists
+ *   - we are in a sticky directory
+ *   - we don't own the file
+ *   - the owner of the directory doesn't own the file
+ *   - the directory is world writable
+ * If the sysctl_protected_fifos (or sysctl_protected_regular) is set to 2
+ * the directory doesn't have to be world writable: being group writable will
+ * be enough.
+ *
+ * Returns 0 if the open is allowed, -ve on error.
+ */
+static int may_create_in_sticky(struct dentry * const dir,
+				struct inode * const inode)
+{
+	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
+	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
+	    likely(!(dir->d_inode->i_mode & S_ISVTX)) ||
+	    uid_eq(inode->i_uid, dir->d_inode->i_uid) ||
+	    uid_eq(current_fsuid(), inode->i_uid))
+		return 0;
+
+	if (likely(dir->d_inode->i_mode & 0002) ||
+	    (dir->d_inode->i_mode & 0020 &&
+	     ((sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) ||
+	      (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode))))) {
+		return -EACCES;
+	}
+	return 0;
+}
+
 static __always_inline
 const char *get_link(struct nameidata *nd)
 {
@@ -3356,9 +3397,15 @@ finish_open:
 	if (error)
 		return error;
 	audit_inode(nd->name, nd->path.dentry, 0);
-	error = -EISDIR;
-	if ((open_flag & O_CREAT) && d_is_dir(nd->path.dentry))
-		goto out;
+	if (open_flag & O_CREAT) {
+		error = -EISDIR;
+		if (d_is_dir(nd->path.dentry))
+			goto out;
+		error = may_create_in_sticky(dir,
+					     d_backing_inode(nd->path.dentry));
+		if (unlikely(error))
+			goto out;
+	}
 	error = -ENOTDIR;
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		goto out;
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -69,6 +69,8 @@ extern struct inodes_stat_t inodes_stat;
 extern int leases_enable, lease_break_time;
 extern int sysctl_protected_symlinks;
 extern int sysctl_protected_hardlinks;
+extern int sysctl_protected_fifos;
+extern int sysctl_protected_regular;
 
 struct buffer_head;
 typedef int (get_block_t)(struct inode *inode, sector_t iblock,
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1795,6 +1795,24 @@ static struct ctl_table fs_table[] = {
 		.extra2		= &one,
 	},
 	{
+		.procname	= "protected_fifos",
+		.data		= &sysctl_protected_fifos,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &two,
+	},
+	{
+		.procname	= "protected_regular",
+		.data		= &sysctl_protected_regular,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &two,
+	},
+	{
 		.procname	= "suid_dumpable",
 		.data		= &suid_dumpable,
 		.maxlen		= sizeof(int),


