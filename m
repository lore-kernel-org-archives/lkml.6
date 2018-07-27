Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D70EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2646208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2646208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbeG0S4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:56:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388563AbeG0S4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:56:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0738D81663CE;
        Fri, 27 Jul 2018 17:33:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41FED2166BA3;
        Fri, 27 Jul 2018 17:33:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/38] vfs: Remove unused code after filesystem context
 changes [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:33:10 +0100
Message-ID: <153271279077.9458.15820103670259697234.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:33:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:33:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code that is now unused after the filesystem context changes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/internal.h              |    2 -
 fs/super.c                 |   62 --------------------------------------------
 include/linux/lsm_hooks.h  |    3 --
 include/linux/security.h   |    7 -----
 security/security.c        |    5 ----
 security/selinux/hooks.c   |   20 --------------
 security/smack/smack_lsm.c |   33 -----------------------
 7 files changed, 132 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 546302e98a04..e5bdfc52b9a1 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -109,8 +109,6 @@ extern struct file *get_empty_filp(void);
 extern int do_remount_sb(struct super_block *, int, void *, size_t, int,
 			 struct fs_context *);
 extern bool trylock_super(struct super_block *sb);
-extern struct dentry *mount_fs(struct file_system_type *,
-			       int, const char *, void *, size_t);
 extern struct super_block *user_get_super(dev_t);
 
 /*
diff --git a/fs/super.c b/fs/super.c
index 7c5541453081..bbef5a5057c0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1442,68 +1442,6 @@ struct dentry *mount_single(struct file_system_type *fs_type,
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
index 60a9a40bd46c..b1a62dc0b8d9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1519,8 +1519,6 @@ union security_list_options {
 	void (*sb_free_security)(struct super_block *sb);
 	int (*sb_copy_data)(char *orig, size_t orig_size, char *copy);
 	int (*sb_remount)(struct super_block *sb, void *data, size_t data_size);
-	int (*sb_kern_mount)(struct super_block *sb, int flags,
-			     void *data, size_t data_size);
 	int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs)(struct dentry *dentry);
 	int (*sb_mount)(const char *dev_name, const struct path *path,
@@ -1868,7 +1866,6 @@ struct security_hook_heads {
 	struct hlist_head sb_free_security;
 	struct hlist_head sb_copy_data;
 	struct hlist_head sb_remount;
-	struct hlist_head sb_kern_mount;
 	struct hlist_head sb_show_options;
 	struct hlist_head sb_statfs;
 	struct hlist_head sb_mount;
diff --git a/include/linux/security.h b/include/linux/security.h
index a8b1056ed6e4..c73d9ba863bc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -241,7 +241,6 @@ int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, size_t orig_size, char *copy);
 int security_sb_remount(struct super_block *sb, void *data, size_t data_size);
-int security_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(const char *dev_name, const struct path *path,
@@ -591,12 +590,6 @@ static inline int security_sb_remount(struct super_block *sb, void *data, size_t
 	return 0;
 }
 
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
index 9bdc21ae645c..2439a5613813 100644
--- a/security/security.c
+++ b/security/security.c
@@ -420,11 +420,6 @@ int security_sb_remount(struct super_block *sb, void *data, size_t data_size)
 	return call_int_hook(sb_remount, 0, sb, data, data_size);
 }
 
-int security_sb_kern_mount(struct super_block *sb, int flags, void *data, size_t data_size)
-{
-	return call_int_hook(sb_kern_mount, 0, sb, flags, data, data_size);
-}
-
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
 	return call_int_hook(sb_show_options, 0, m, sb);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9774d1f0e99f..3d5b09c256c1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2924,25 +2924,6 @@ static int selinux_sb_remount(struct super_block *sb, void *data, size_t data_si
 	goto out_free_opts;
 }
 
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
@@ -7200,7 +7181,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_copy_data, selinux_sb_copy_data),
 	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
-	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
 	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
 	LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
 	LSM_HOOK_INIT(sb_mount, selinux_mount),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 339ac4d42785..5f2938325ddf 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1178,38 +1178,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
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
@@ -4989,7 +4957,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
 	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
 	LSM_HOOK_INIT(sb_copy_data, smack_sb_copy_data),
-	LSM_HOOK_INIT(sb_kern_mount, smack_sb_kern_mount),
 	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
 	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
 	LSM_HOOK_INIT(sb_parse_opts_str, smack_parse_opts_str),

