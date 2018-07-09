Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5D1C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8758B2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8758B2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeGIV5w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:57:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933328AbeGIV5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:57:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC2BC81A4EB7;
        Mon,  9 Jul 2018 21:57:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E80802026D65;
        Mon,  9 Jul 2018 21:57:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180709155618.GH30522@ZenIV.linux.org.uk>
References: <20180709155618.GH30522@ZenIV.linux.org.uk> <20180708234630.GB700@sol.localdomain> <20180708210154.10423-1-ebiggers3@gmail.com> <31355.1531150319@warthog.procyon.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers3@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH vfs/for-next 00/18] fs_context fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6565.1531173467.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 09 Jul 2018 22:57:47 +0100
Message-ID: <6566.1531173467@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 21:57:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 21:57:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, how about the attached?

David
---
commit 0f067bdbfeca03264a50461db21339dbcd97e8f3
Author: David Howells <dhowells@redhat.com>
Date:   Mon Jul 9 16:24:27 2018 +0100

    vfs: Separate changing mount flags full remount
    
    Separate just the changing of mount flags (MS_REMOUNT|MS_BIND) from full
    remount because the mount data now gets parsed with the new fs_context
    stuff prior to doing a remount - and this causes the syscall under some
    circumstances.

diff --git a/fs/namespace.c b/fs/namespace.c
index 58c1ace07bb6..a6fbfba8e448 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -275,13 +275,9 @@ static struct mount *alloc_vfsmnt(const char *name)
  * mnt_want/drop_write() will _keep_ the filesystem
  * r/w.
  */
-int __mnt_is_readonly(struct vfsmount *mnt)
+bool __mnt_is_readonly(struct vfsmount *mnt)
 {
-	if (mnt->mnt_flags & MNT_READONLY)
-		return 1;
-	if (sb_rdonly(mnt->mnt_sb))
-		return 1;
-	return 0;
+	return (mnt->mnt_flags & MNT_READONLY) || sb_rdonly(mnt->mnt_sb);
 }
 EXPORT_SYMBOL_GPL(__mnt_is_readonly);
 
@@ -596,11 +592,12 @@ static int mnt_make_readonly(struct mount *mnt)
 	return ret;
 }
 
-static void __mnt_unmake_readonly(struct mount *mnt)
+static int __mnt_unmake_readonly(struct mount *mnt)
 {
 	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
 	unlock_mount_hash();
+	return 0;
 }
 
 int sb_prepare_remount_readonly(struct super_block *sb)
@@ -2307,21 +2304,91 @@ SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
 	return error;
 }
 
-static int change_mount_flags(struct vfsmount *mnt, int ms_flags)
+/*
+ * Don't allow locked mount flags to be cleared.
+ *
+ * No locks need to be held here while testing the various MNT_LOCK
+ * flags because those flags can never be cleared once they are set.
+ */
+static bool can_change_locked_flags(struct mount *mnt, unsigned int mnt_flags)
 {
-	int error = 0;
-	int readonly_request = 0;
+	unsigned int fl = mnt->mnt.mnt_flags;
 
-	if (ms_flags & MS_RDONLY)
-		readonly_request = 1;
-	if (readonly_request == __mnt_is_readonly(mnt))
+	if ((fl & MNT_LOCK_READONLY) &&
+	    !(mnt_flags & MNT_READONLY))
+		return false;
+
+	if ((fl & MNT_LOCK_NODEV) &&
+	    !(mnt_flags & MNT_NODEV))
+		return false;
+
+	if ((fl & MNT_LOCK_NOSUID) &&
+	    !(mnt_flags & MNT_NOSUID))
+		return false;
+
+	if ((fl & MNT_LOCK_NOEXEC) &&
+	    !(mnt_flags & MNT_NOEXEC))
+		return false;
+
+	if ((fl & MNT_LOCK_ATIME) &&
+	    ((fl & MNT_ATIME_MASK) != (mnt_flags & MNT_ATIME_MASK)))
+		return false;
+
+	return true;
+}
+
+static int change_mount_ro_state(struct mount *mnt, unsigned int mnt_flags)
+{
+	bool readonly_request = (mnt_flags & MNT_READONLY);
+
+	if (readonly_request == __mnt_is_readonly(&mnt->mnt))
 		return 0;
 
 	if (readonly_request)
-		error = mnt_make_readonly(real_mount(mnt));
-	else
-		__mnt_unmake_readonly(real_mount(mnt));
-	return error;
+		return mnt_make_readonly(mnt);
+
+	return __mnt_unmake_readonly(mnt);
+}
+
+/*
+ * Update the user-settable attributes on a mount.  The caller must hold
+ * sb->s_umount for writing.
+ */
+static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
+{
+	lock_mount_hash();
+	mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
+	mnt->mnt.mnt_flags = mnt_flags;
+	touch_mnt_namespace(mnt->mnt_ns);
+	unlock_mount_hash();
+}
+
+/*
+ * Handle reconfiguration of the mountpoint only without alteration of the
+ * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
+ * to mount(2).
+ */
+static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
+{
+	struct super_block *sb = path->mnt->mnt_sb;
+	struct mount *mnt = real_mount(path->mnt);
+	int ret;
+
+	if (!check_mnt(mnt))
+		return -EINVAL;
+
+	if (path->dentry != mnt->mnt.mnt_root)
+		return -EINVAL;
+
+	if (!can_change_locked_flags(mnt, mnt_flags))
+		return -EPERM;
+
+	down_write(&sb->s_umount);
+	ret = change_mount_ro_state(mnt, mnt_flags);
+	if (ret == 0)
+		set_mount_attributes(mnt, mnt_flags);
+	up_write(&sb->s_umount);
+	return ret;
 }
 
 /*
@@ -2358,32 +2425,8 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (path->dentry != path->mnt->mnt_root)
 		return -EINVAL;
 
-	/* Don't allow changing of locked mnt flags.
-	 *
-	 * No locks need to be held here while testing the various
-	 * MNT_LOCK flags because those flags can never be cleared
-	 * once they are set.
-	 */
-	if ((mnt->mnt.mnt_flags & MNT_LOCK_READONLY) &&
-	    !(mnt_flags & MNT_READONLY)) {
-		return -EPERM;
-	}
-	if ((mnt->mnt.mnt_flags & MNT_LOCK_NODEV) &&
-	    !(mnt_flags & MNT_NODEV)) {
-		return -EPERM;
-	}
-	if ((mnt->mnt.mnt_flags & MNT_LOCK_NOSUID) &&
-	    !(mnt_flags & MNT_NOSUID)) {
-		return -EPERM;
-	}
-	if ((mnt->mnt.mnt_flags & MNT_LOCK_NOEXEC) &&
-	    !(mnt_flags & MNT_NOEXEC)) {
+	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
-	}
-	if ((mnt->mnt.mnt_flags & MNT_LOCK_ATIME) &&
-	    ((mnt->mnt.mnt_flags & MNT_ATIME_MASK) != (mnt_flags & MNT_ATIME_MASK))) {
-		return -EPERM;
-	}
 
 	if (type->init_fs_context) {
 		fc = vfs_sb_reconfig(path, sb_flags);
@@ -2410,18 +2453,11 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	}
 
 	down_write(&sb->s_umount);
-	if (ms_flags & MS_BIND)
-		err = change_mount_flags(path->mnt, ms_flags);
-	else if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
-		err = -EPERM;
-	else
+	err = -EPERM;
+	if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
 		err = do_remount_sb(sb, sb_flags, data, data_size, 0, fc);
-	if (!err) {
-		lock_mount_hash();
-		mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
-		mnt->mnt.mnt_flags = mnt_flags;
-		touch_mnt_namespace(mnt->mnt_ns);
-		unlock_mount_hash();
+		if (!err)
+			set_mount_attributes(mnt, mnt_flags);
 	}
 	up_write(&sb->s_umount);
 err_fc:
@@ -2961,7 +2997,9 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 			    SB_LAZYTIME |
 			    SB_I_VERSION);
 
-	if (flags & MS_REMOUNT)
+	if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
+		retval = do_reconfigure_mnt(&path, mnt_flags);
+	else if (flags & MS_REMOUNT)
 		retval = do_remount(&path, flags, sb_flags, mnt_flags,
 				    data_page, data_size);
 	else if (flags & MS_BIND)
diff --git a/include/linux/mount.h b/include/linux/mount.h
index ee5af77afc06..41b6b080ffd0 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -82,7 +82,7 @@ extern void mnt_drop_write_file(struct file *file);
 extern void mntput(struct vfsmount *mnt);
 extern struct vfsmount *mntget(struct vfsmount *mnt);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
-extern int __mnt_is_readonly(struct vfsmount *mnt);
+extern bool __mnt_is_readonly(struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
 
 struct path;
