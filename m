Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FDCC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA92089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEA92089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933528AbeGIPcD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:32:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933299AbeGIPcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B72881A4EA6;
        Mon,  9 Jul 2018 15:32:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5B912166BA2;
        Mon,  9 Jul 2018 15:31:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180708234630.GB700@sol.localdomain>
References: <20180708234630.GB700@sol.localdomain> <20180708210154.10423-1-ebiggers3@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH vfs/for-next 00/18] fs_context fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31354.1531150319.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 09 Jul 2018 16:31:59 +0100
Message-ID: <31355.1531150319@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 15:32:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 15:32:00 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

Okay, I've folded in all your changes to my mount-context branch, apart from
patch 07 (the legacy wrapper double free fix) which I think needed doing
differently.

> Also, mount(..., MS_REMOUNT|MS_BIND, ...) now validates the mount options
> string, which breaks systemd unit files with ProtectControlGroups=yes (e.g.
> systemd-networkd.service) when systemd does the following to change a cgroup
> (v1) mount to read-only:
> 
>     mount(NULL, "/run/systemd/unit-root/sys/fs/cgroup/systemd", NULL, MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL)
> 
> ... when the kernel has CONFIG_CGROUPS=y but no cgroup subsystems enabled, since
> in that case the error "cgroup1: Need name or subsystem set" is hit when the
> mount options string is empty.
> 
> Probably it doesn't make sense to validate the mount options string at all in
> the MS_REMOUNT|MS_BIND case, though maybe you had something else in mind.

How about the attached?  I need to separate it out anyway if I want to
implement a mount_setattr() syscall.

David
---
commit f24ee400978ad41e48e679f1d422277fc353521c
Author: David Howells <dhowells@redhat.com>
Date:   Mon Jul 9 16:24:27 2018 +0100

    vfs: Separate changing mount flags full remount
    
    Separate just the changing of mount flags (MS_REMOUNT|MS_BIND) from full
    remount because the mount data now gets parsed with the new fs_context
    stuff prior to doing a remount - and this causes the syscall under some
    circumstances.

diff --git a/fs/namespace.c b/fs/namespace.c
index 58c1ace07bb6..39e9744beab9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -275,13 +275,13 @@ static struct mount *alloc_vfsmnt(const char *name)
  * mnt_want/drop_write() will _keep_ the filesystem
  * r/w.
  */
-int __mnt_is_readonly(struct vfsmount *mnt)
+bool __mnt_is_readonly(struct vfsmount *mnt)
 {
 	if (mnt->mnt_flags & MNT_READONLY)
-		return 1;
+		return true;
 	if (sb_rdonly(mnt->mnt_sb))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 EXPORT_SYMBOL_GPL(__mnt_is_readonly);
 
@@ -596,11 +596,12 @@ static int mnt_make_readonly(struct mount *mnt)
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
@@ -2307,21 +2308,85 @@ SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
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
+static int change_mount_ro_state(struct vfsmount *mnt, unsigned int mnt_flags)
+{
+	bool readonly_request = true;
+
+	if (mnt_flags & MNT_READONLY)
 		readonly_request = 1;
 	if (readonly_request == __mnt_is_readonly(mnt))
 		return 0;
 
-	if (readonly_request)
-		error = mnt_make_readonly(real_mount(mnt));
-	else
-		__mnt_unmake_readonly(real_mount(mnt));
-	return error;
+	if (!readonly_request)
+		return mnt_make_readonly(real_mount(mnt));
+
+	return __mnt_unmake_readonly(real_mount(mnt));
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
+	if (path->dentry != path->mnt->mnt_root)
+		return -EINVAL;
+
+	if (!can_change_locked_flags(mnt, mnt_flags))
+		return -EPERM;
+
+	down_write(&sb->s_umount);
+	ret = change_mount_ro_state(path->mnt, mnt_flags);
+	if (ret == 0) {
+		lock_mount_hash();
+		mnt_flags |= mnt->mnt.mnt_flags & ~MNT_USER_SETTABLE_MASK;
+		mnt->mnt.mnt_flags = mnt_flags;
+		touch_mnt_namespace(mnt->mnt_ns);
+		unlock_mount_hash();
+	}
+	up_write(&sb->s_umount);
+	return ret;
 }
 
 /*
@@ -2358,32 +2423,8 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
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
-		return -EPERM;
-	}
-	if ((mnt->mnt.mnt_flags & MNT_LOCK_ATIME) &&
-	    ((mnt->mnt.mnt_flags & MNT_ATIME_MASK) != (mnt_flags & MNT_ATIME_MASK))) {
+	if (!can_change_locked_flags(mnt, mnt_flags))
 		return -EPERM;
-	}
 
 	if (type->init_fs_context) {
 		fc = vfs_sb_reconfig(path, sb_flags);
@@ -2410,9 +2451,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	}
 
 	down_write(&sb->s_umount);
-	if (ms_flags & MS_BIND)
-		err = change_mount_flags(path->mnt, ms_flags);
-	else if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
+	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		err = -EPERM;
 	else
 		err = do_remount_sb(sb, sb_flags, data, data_size, 0, fc);
@@ -2961,7 +3000,9 @@ long do_mount(const char *dev_name, const char __user *dir_name,
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
