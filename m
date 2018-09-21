Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5B621567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5B621567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbeIUWWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:22:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390065AbeIUWWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:22:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B433588E68;
        Fri, 21 Sep 2018 16:32:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7552B18959;
        Fri, 21 Sep 2018 16:32:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/34] vfs: Remove unused code after filesystem context
 changes [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:32:19 +0100
Message-ID: <153754753909.17872.8351213526463748096.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 21 Sep 2018 16:32:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code that is now unused after the filesystem context changes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/internal.h              |    2 -
 fs/super.c                 |   62 --------------------------
 include/linux/lsm_hooks.h  |   12 -----
 include/linux/security.h   |   13 -----
 security/security.c        |   10 ----
 security/selinux/hooks.c   |  106 --------------------------------------------
 security/smack/smack_lsm.c |   33 --------------
 7 files changed, 238 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index fc2da60abbcd..73942ff5aa09 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -116,8 +116,6 @@ extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
  */
 extern int reconfigure_super(struct fs_context *);
 extern bool trylock_super(struct super_block *sb);
-extern struct dentry *mount_fs(struct file_system_type *,
-			       int, const char *, void *, size_t);
 extern struct super_block *user_get_super(dev_t);
 
 /*
diff --git a/fs/super.c b/fs/super.c
index df8c4cebd000..de43b140bbb1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1478,68 +1478,6 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 }
 EXPORT_SYMBOL(mount_single);
 
-struct dentry *
-mount_fs(struct file_system_type *type, int flags, const char *name,
-	 void *data, size_t data_size)
-{
-	struct dentry *root;
-	struct super_block *sb;
-	char *secdata = NULL;
-	int error = -ENOMEM;
-
-	if (data && !(type->fs_flags & FS_BINARY_MOUNTDATA)) {
-		secdata = alloc_secdata();
-		if (!secdata)
-			goto out;
-
-		error = security_sb_copy_data(data, data_size, secdata);
-		if (error)
-			goto out_free_secdata;
-	}
-
-	root = type->mount(type, flags, name, data, data_size);
-	if (IS_ERR(root)) {
-		error = PTR_ERR(root);
-		goto out_free_secdata;
-	}
-	sb = root->d_sb;
-	BUG_ON(!sb);
-	WARN_ON(!sb->s_bdi);
-
-	/*
-	 * Write barrier is for super_cache_count(). We place it before setting
-	 * SB_BORN as the data dependency between the two functions is the
-	 * superblock structure contents that we just set up, not the SB_BORN
-	 * flag.
-	 */
-	smp_wmb();
-	sb->s_flags |= SB_BORN;
-
-	error = security_sb_kern_mount(sb, flags, secdata, data_size);
-	if (error)
-		goto out_sb;
-
-	/*
-	 * filesystems should never set s_maxbytes larger than MAX_LFS_FILESIZE
-	 * but s_maxbytes was an unsigned long long for many releases. Throw
-	 * this warning for a little while to try and catch filesystems that
-	 * violate this rule.
-	 */
-	WARN((sb->s_maxbytes < 0), "%s set sb->s_maxbytes to "
-		"negative value (%lld)\n", type->name, sb->s_maxbytes);
-
-	up_write(&sb->s_umount);
-	free_secdata(secdata);
-	return root;
-out_sb:
-	dput(root);
-	deactivate_locked_super(sb);
-out_free_secdata:
-	free_secdata(secdata);
-out:
-	return ERR_PTR(error);
-}
-
 /*
  * Setup private BDI for given superblock. It gets automatically cleaned up
  * in generic_shutdown_super().
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7e50bfa1aee0..fff43b0523a9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -160,13 +160,6 @@
  *	@orig_data is the size of the original data
  *	@copy copied data which will be passed to the security module.
  *	Returns 0 if the copy was successful.
- * @sb_remount:
- *	Extracts security system specific mount options and verifies no changes
- *	are being made to those options.
- *	@sb superblock being remounted
- *	@data contains the filesystem-specific data.
- *	@data_size contains the size of the data.
- *	Return 0 if permission is granted.
  * @sb_umount:
  *	Check permission before the @mnt file system is unmounted.
  *	@mnt contains the mounted file system.
@@ -1522,9 +1515,6 @@ union security_list_options {
 	int (*sb_alloc_security)(struct super_block *sb);
 	void (*sb_free_security)(struct super_block *sb);
 	int (*sb_copy_data)(char *orig, size_t orig_size, char *copy);
-	int (*sb_remount)(struct super_block *sb, void *data, size_t data_size);
-	int (*sb_kern_mount)(struct super_block *sb, int flags,
-			     void *data, size_t data_size);
 	int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs)(struct dentry *dentry);
 	int (*sb_mount)(const char *dev_name, const struct path *path,
@@ -1872,8 +1862,6 @@ struct security_hook_heads {
 	struct hlist_head sb_alloc_security;
 	struct hlist_head sb_free_security;
 	struct hlist_head sb_copy_data;
-	struct hlist_head sb_remount;
-	struct hlist_head sb_kern_mount;
 	struct hlist_head sb_show_options;
 	struct hlist_head sb_statfs;
 	struct hlist_head sb_mount;
diff --git a/include/linux/security.h b/include/linux/security.h
index bae191a96c73..11157798d4f8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -261,8 +261,6 @@ int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, size_t orig_size, char *copy);
-int security_sb_remount(struct super_block *sb, void *data, size_t data_size);
-int security_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(const char *dev_name, const struct path *path,
@@ -608,17 +606,6 @@ static inline int security_sb_copy_data(char *orig, size_t orig_size, char *copy
 	return 0;
 }
 
-static inline int security_sb_remount(struct super_block *sb, void *data, size_t data_size)
-{
-	return 0;
-}
-
-static inline int security_sb_kern_mount(struct super_block *sb, int flags,
-					 void *data, size_t data_size)
-{
-	return 0;
-}
-
 static inline int security_sb_show_options(struct seq_file *m,
 					   struct super_block *sb)
 {
diff --git a/security/security.c b/security/security.c
index 64304d20aae1..d902810f2749 100644
--- a/security/security.c
+++ b/security/security.c
@@ -420,16 +420,6 @@ int security_sb_copy_data(char *orig, size_t data_size, char *copy)
 }
 EXPORT_SYMBOL(security_sb_copy_data);
 
-int security_sb_remount(struct super_block *sb, void *data, size_t data_size)
-{
-	return call_int_hook(sb_remount, 0, sb, data, data_size);
-}
-
-int security_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size)
-{
-	return call_int_hook(sb_kern_mount, 0, sb, flags, data, data_size);
-}
-
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
 	return call_int_hook(sb_show_options, 0, m, sb);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5f2af9dd44fa..99c2c40c5d7a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2832,110 +2832,6 @@ static int selinux_sb_copy_data(char *orig, size_t data_size, char *copy)
 	return rc;
 }
 
-static int selinux_sb_remount(struct super_block *sb, void *data, size_t data_size)
-{
-	int rc, i, *flags;
-	struct security_mnt_opts opts;
-	char *secdata, **mount_options;
-	struct superblock_security_struct *sbsec = sb->s_security;
-
-	if (!(sbsec->flags & SE_SBINITIALIZED))
-		return 0;
-
-	if (!data)
-		return 0;
-
-	if (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
-		return 0;
-
-	security_init_mnt_opts(&opts);
-	secdata = alloc_secdata();
-	if (!secdata)
-		return -ENOMEM;
-	rc = selinux_sb_copy_data(data, data_size, secdata);
-	if (rc)
-		goto out_free_secdata;
-
-	rc = selinux_parse_opts_str(secdata, &opts);
-	if (rc)
-		goto out_free_secdata;
-
-	mount_options = opts.mnt_opts;
-	flags = opts.mnt_opts_flags;
-
-	for (i = 0; i < opts.num_mnt_opts; i++) {
-		u32 sid;
-
-		if (flags[i] == SBLABEL_MNT)
-			continue;
-		rc = security_context_str_to_sid(&selinux_state,
-						 mount_options[i], &sid,
-						 GFP_KERNEL);
-		if (rc) {
-			pr_warn("SELinux: security_context_str_to_sid"
-			       "(%s) failed for (dev %s, type %s) errno=%d\n",
-			       mount_options[i], sb->s_id, sb->s_type->name, rc);
-			goto out_free_opts;
-		}
-		rc = -EINVAL;
-		switch (flags[i]) {
-		case FSCONTEXT_MNT:
-			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid, sid))
-				goto out_bad_option;
-			break;
-		case CONTEXT_MNT:
-			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid, sid))
-				goto out_bad_option;
-			break;
-		case ROOTCONTEXT_MNT: {
-			struct inode_security_struct *root_isec;
-			root_isec = backing_inode_security(sb->s_root);
-
-			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
-				goto out_bad_option;
-			break;
-		}
-		case DEFCONTEXT_MNT:
-			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid, sid))
-				goto out_bad_option;
-			break;
-		default:
-			goto out_free_opts;
-		}
-	}
-
-	rc = 0;
-out_free_opts:
-	security_free_mnt_opts(&opts);
-out_free_secdata:
-	free_secdata(secdata);
-	return rc;
-out_bad_option:
-	pr_warn("SELinux: unable to change security options "
-	       "during remount (dev %s, type=%s)\n", sb->s_id,
-	       sb->s_type->name);
-	goto out_free_opts;
-}
-
-static int selinux_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size)
-{
-	const struct cred *cred = current_cred();
-	struct common_audit_data ad;
-	int rc;
-
-	rc = superblock_doinit(sb, data);
-	if (rc)
-		return rc;
-
-	/* Allow all mounts performed by the kernel */
-	if (flags & MS_KERNMOUNT)
-		return 0;
-
-	ad.type = LSM_AUDIT_DATA_DENTRY;
-	ad.u.dentry = sb->s_root;
-	return superblock_has_perm(cred, sb, FILESYSTEM__MOUNT, &ad);
-}
-
 static int selinux_sb_statfs(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
@@ -7205,8 +7101,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
-	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
-	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
 	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
 	LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
 	LSM_HOOK_INIT(sb_mount, selinux_mount),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index da7121d24bce..1f51a8ac11d7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1164,38 +1164,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	return 0;
 }
 
-/**
- * smack_sb_kern_mount - Smack specific mount processing
- * @sb: the file system superblock
- * @flags: the mount flags
- * @data: the smack mount options
- *
- * Returns 0 on success, an error code on failure
- */
-static int smack_sb_kern_mount(struct super_block *sb, int flags,
-			       void *data, size_t data_size)
-{
-	int rc = 0;
-	char *options = data;
-	struct security_mnt_opts opts;
-
-	security_init_mnt_opts(&opts);
-
-	if (!options)
-		goto out;
-
-	rc = smack_parse_opts_str(options, &opts);
-	if (rc)
-		goto out_err;
-
-out:
-	rc = smack_set_mnt_opts(sb, &opts, 0, NULL);
-
-out_err:
-	security_free_mnt_opts(&opts);
-	return rc;
-}
-
 /**
  * smack_sb_statfs - Smack check on statfs
  * @dentry: identifies the file system in question
@@ -4985,7 +4953,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
 	LSM_HOOK_INIT(sb_copy_data, smack_sb_copy_data),
-	LSM_HOOK_INIT(sb_kern_mount, smack_sb_kern_mount),
 	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
 	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
 	LSM_HOOK_INIT(sb_parse_opts_str, smack_parse_opts_str),

