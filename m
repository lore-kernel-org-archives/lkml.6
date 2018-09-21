Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31214ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41262170B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41262170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391005AbeIUWVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390065AbeIUWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:21:44 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83DF7307D944;
        Fri, 21 Sep 2018 16:32:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D37D230912F4;
        Fri, 21 Sep 2018 16:32:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/34] vfs: Separate changing mount flags full remount [ver
 #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Eric Biggers <ebiggers@google.com>, torvalds@linux-foundation.org,
        dhowells@redhat.com, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:32:03 +0100
Message-ID: <153754752306.17872.3909085028735101015.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 21 Sep 2018 16:32:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate just the changing of mount flags (MS_REMOUNT|MS_BIND) from full
remount because the mount data will get parsed with the new fs_context
stuff prior to doing a remount - and this causes the syscall to fail under
some circumstances.

To quote Eric's explanation:

  [...] mount(..., MS_REMOUNT|MS_BIND, ...) now validates the mount options
  string, which breaks systemd unit files with ProtectControlGroups=yes
  (e.g.  systemd-networkd.service) when systemd does the following to
  change a cgroup (v1) mount to read-only:

    mount(NULL, "/run/systemd/unit-root/sys/fs/cgroup/systemd", NULL,
	  MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL)

  ... when the kernel has CONFIG_CGROUPS=y but no cgroup subsystems
  enabled, since in that case the error "cgroup1: Need name or subsystem
  set" is hit when the mount options string is empty.

  Probably it doesn't make sense to validate the mount options string at
  all in the MS_REMOUNT|MS_BIND case, though maybe you had something else
  in mind.

This is also worthwhile doing because we will need to add a mount_setattr()
syscall to take over the remount-bind function.

Reported-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c        |  146 +++++++++++++++++++++++++++++++------------------
 include/linux/mount.h |    2 -
 2 files changed, 93 insertions(+), 55 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index caf5c55ef555..059a13e1ae09 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -247,13 +247,9 @@ static struct mount *alloc_vfsmnt(const char *name)
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
 
@@ -509,11 +505,12 @@ static int mnt_make_readonly(struct mount *mnt)
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
@@ -2294,21 +2291,91 @@ SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
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
+{
+	unsigned int fl = mnt->mnt.mnt_flags;
+
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
 {
-	int error = 0;
-	int readonly_request = 0;
+	bool readonly_request = (mnt_flags & MNT_READONLY);
 
-	if (ms_flags & MS_RDONLY)
-		readonly_request = 1;
-	if (readonly_request == __mnt_is_readonly(mnt))
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
@@ -2329,50 +2396,19 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
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
 
 	err = security_sb_remount(sb, data, data_size);
 	if (err)
 		return err;
 
 	down_write(&sb->s_umount);
-	if (ms_flags & MS_BIND)
-		err = change_mount_flags(path->mnt, ms_flags);
-	else if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
-		err = -EPERM;
-	else
+	err = -EPERM;
+	if (ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
 		err = do_remount_sb(sb, sb_flags, data, data_size, 0);
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
 	return err;
@@ -2888,7 +2924,9 @@ long do_mount(const char *dev_name, const char __user *dir_name,
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
index 8a1031a511c9..c9edd284f0af 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -81,7 +81,7 @@ extern void mnt_drop_write_file(struct file *file);
 extern void mntput(struct vfsmount *mnt);
 extern struct vfsmount *mntget(struct vfsmount *mnt);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
-extern int __mnt_is_readonly(struct vfsmount *mnt);
+extern bool __mnt_is_readonly(struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
 
 struct path;

