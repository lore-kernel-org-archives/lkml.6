Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756339AbeEHSjC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:39:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754622AbeEHSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:03 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 10/76] security: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:30 -0700
Message-Id: <20180508180436.716-11-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 security/apparmor/apparmorfs.c       |  4 ++--
 security/commoncap.c                 |  8 ++++----
 security/inode.c                     |  2 +-
 security/integrity/evm/evm_crypto.c  |  4 ++--
 security/integrity/ima/ima_policy.c  |  4 ++--
 security/integrity/integrity_audit.c |  2 +-
 security/lsm_audit.c                 | 10 +++++-----
 security/selinux/hooks.c             | 23 ++++++++++++-----------
 security/smack/smack_lsm.c           | 26 +++++++++++++-------------
 security/tomoyo/condition.c          |  2 +-
 10 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index a9428daa69f3..862a4bd89597 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -181,7 +181,7 @@ static int __aafs_setup_d_inode(struct inode *dir, struct dentry *dentry,
 			       const struct file_operations *fops,
 			       const struct inode_operations *iops)
 {
-	struct inode *inode = new_inode(dir->i_sb);
+	struct inode *inode = new_inode(inode_sb(dir));
 
 	AA_BUG(!dir);
 	AA_BUG(!dentry);
@@ -2349,7 +2349,7 @@ static int aa_mk_null_file(struct dentry *parent)
 		error = PTR_ERR(dentry);
 		goto out;
 	}
-	inode = new_inode(parent->d_inode->i_sb);
+	inode = new_inode(inode_sb(parent->d_inode));
 	if (!inode) {
 		error = -ENOMEM;
 		goto out1;
diff --git a/security/commoncap.c b/security/commoncap.c
index 48620c93d697..f85a10da2ba2 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -400,7 +400,7 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 	if (ret < 0)
 		return ret;
 
-	fs_ns = inode->i_sb->s_user_ns;
+	fs_ns = inode_sb(inode)->s_user_ns;
 	cap = (struct vfs_cap_data *) tmpbuf;
 	if (is_v2header((size_t) ret, cap)) {
 		/* If this is sizeof(vfs_cap_data) then we're ok with the
@@ -486,7 +486,7 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 	__u32 magic, nsmagic;
 	struct inode *inode = d_backing_inode(dentry);
 	struct user_namespace *task_ns = current_user_ns(),
-		*fs_ns = inode->i_sb->s_user_ns;
+		*fs_ns = inode_sb(inode)->s_user_ns;
 	kuid_t rootid;
 	size_t newsize;
 
@@ -497,7 +497,7 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 	if (!capable_wrt_inode_uidgid(inode, CAP_SETFCAP))
 		return -EPERM;
 	if (size == XATTR_CAPS_SZ_2)
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
+		if (ns_capable(inode_sb(inode)->s_user_ns, CAP_SETFCAP))
 			/* user is privileged, just write the v2 */
 			return size;
 
@@ -589,7 +589,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
 	if (!inode)
 		return -ENODATA;
 
-	fs_ns = inode->i_sb->s_user_ns;
+	fs_ns = inode_sb(inode)->s_user_ns;
 	size = __vfs_getxattr((struct dentry *)dentry, inode,
 			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
 	if (size == -ENODATA || size == -EOPNOTSUPP)
diff --git a/security/inode.c b/security/inode.c
index 8dd9ca8848e4..6a3d08901054 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -131,7 +131,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		goto out1;
 	}
 
-	inode = new_inode(dir->i_sb);
+	inode = new_inode(inode_sb(dir));
 	if (!inode) {
 		error = -ENOMEM;
 		goto out1;
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 691f3e09154c..979bf5068d46 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -170,8 +170,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
 	    type != EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, &inode->i_sb->s_uuid.b[0],
-				    sizeof(inode->i_sb->s_uuid));
+		crypto_shash_update(desc, &inode_sb(inode)->s_uuid.b[0],
+				    sizeof(inode_sb(inode)->s_uuid));
 	crypto_shash_final(desc, digest);
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 915f5572c6ff..61ded57e0427 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -265,10 +265,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	    (!(rule->mask & mask) && func != POST_SETATTR))
 		return false;
 	if ((rule->flags & IMA_FSMAGIC)
-	    && rule->fsmagic != inode->i_sb->s_magic)
+	    && rule->fsmagic != inode_sb(inode)->s_magic)
 		return false;
 	if ((rule->flags & IMA_FSUUID) &&
-	    !uuid_equal(&rule->fsuuid, &inode->i_sb->s_uuid))
+	    !uuid_equal(&rule->fsuuid, &inode_sb(inode)->s_uuid))
 		return false;
 	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
 		return false;
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 90987d15b6fe..62e569589dc8 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -57,7 +57,7 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 	}
 	if (inode) {
 		audit_log_format(ab, " dev=");
-		audit_log_untrustedstring(ab, inode->i_sb->s_id);
+		audit_log_untrustedstring(ab, inode_sb(inode)->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
 	}
 	audit_log_format(ab, " res=%d", !result);
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 67703dbe29ea..90d557cf7819 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -240,7 +240,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		inode = d_backing_inode(a->u.path.dentry);
 		if (inode) {
 			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
+			audit_log_untrustedstring(ab, inode_sb(inode)->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
 		break;
@@ -253,7 +253,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		inode = file_inode(a->u.file);
 		if (inode) {
 			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
+			audit_log_untrustedstring(ab, inode_sb(inode)->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
 		break;
@@ -266,7 +266,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		inode = a->u.op->path.dentry->d_inode;
 		if (inode) {
 			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
+			audit_log_untrustedstring(ab, inode_sb(inode)->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
 
@@ -282,7 +282,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		inode = d_backing_inode(a->u.dentry);
 		if (inode) {
 			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
+			audit_log_untrustedstring(ab, inode_sb(inode)->s_id);
 			audit_log_format(ab, " ino=%lu", inode->i_ino);
 		}
 		break;
@@ -300,7 +300,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 			dput(dentry);
 		}
 		audit_log_format(ab, " dev=");
-		audit_log_untrustedstring(ab, inode->i_sb->s_id);
+		audit_log_untrustedstring(ab, inode_sb(inode)->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
 		break;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8644d864e3c1..55bb29dd6726 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -331,7 +331,7 @@ static void inode_free_rcu(struct rcu_head *head)
 static void inode_free_security(struct inode *inode)
 {
 	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct superblock_security_struct *sbsec = inode_sb(inode)->s_security;
 
 	/*
 	 * As not all inode security structures are in a list, we check for
@@ -1500,7 +1500,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = inode_sb(inode)->s_security;
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -1581,7 +1581,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			if (rc != -ENODATA) {
 				printk(KERN_WARNING "SELinux: %s:  getxattr returned "
 				       "%d for dev=%s ino=%ld\n", __func__,
-				       -rc, inode->i_sb->s_id, inode->i_ino);
+				       -rc, inode_sb(inode)->s_id,
+				       inode->i_ino);
 				kfree(context);
 				goto out;
 			}
@@ -1593,7 +1594,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 							     sbsec->def_sid,
 							     GFP_NOFS);
 			if (rc) {
-				char *dev = inode->i_sb->s_id;
+				char *dev = inode_sb(inode)->s_id;
 				unsigned long ino = inode->i_ino;
 
 				if (rc == -EINVAL) {
@@ -1873,7 +1874,7 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
 				 const struct qstr *name, u16 tclass,
 				 u32 *_new_isid)
 {
-	const struct superblock_security_struct *sbsec = dir->i_sb->s_security;
+	const struct superblock_security_struct *sbsec = inode_sb(dir)->s_security;
 
 	if ((sbsec->flags & SE_SBINITIALIZED) &&
 	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
@@ -1903,7 +1904,7 @@ static int may_create(struct inode *dir,
 	int rc;
 
 	dsec = inode_security(dir);
-	sbsec = dir->i_sb->s_security;
+	sbsec = inode_sb(dir)->s_security;
 
 	sid = tsec->sid;
 
@@ -2106,7 +2107,7 @@ static inline u32 open_file_to_av(struct file *file)
 	u32 av = file_to_av(file);
 	struct inode *inode = file_inode(file);
 
-	if (selinux_policycap_openperm && inode->i_sb->s_magic != SOCKFS_MAGIC)
+	if (selinux_policycap_openperm && inode_sb(inode)->s_magic != SOCKFS_MAGIC)
 		av |= FILE__OPEN;
 
 	return av;
@@ -2939,7 +2940,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	int rc;
 	char *context;
 
-	sbsec = dir->i_sb->s_security;
+	sbsec = inode_sb(dir)->s_security;
 
 	newsid = tsec->create_sid;
 
@@ -3127,7 +3128,7 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
 	if (selinux_policycap_openperm &&
-	    inode->i_sb->s_magic != SOCKFS_MAGIC &&
+	    inode_sb(inode)->s_magic != SOCKFS_MAGIC &&
 	    (ia_valid & ATTR_SIZE) &&
 	    !(ia_valid & ATTR_FILE))
 		av |= FILE__OPEN;
@@ -3172,7 +3173,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 	}
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = inode_sb(inode)->s_security;
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
@@ -3253,7 +3254,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to map context to SID"
 		       "for (%s, %lu), rc=%d\n",
-		       inode->i_sb->s_id, inode->i_ino, -rc);
+		       inode_sb(inode)->s_id, inode->i_ino, -rc);
 		return;
 	}
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 03fdecba93bb..cf1dacb55d48 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -170,7 +170,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
 		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
-			inode->i_sb->s_id, inode->i_ino, current->comm);
+			inode_sb(inode)->s_id, inode->i_ino, current->comm);
 
 	if (rc <= 0)
 		return rc;
@@ -184,7 +184,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 
 	pr_info("Smack %s: (%s %s %s) inode=(%s %ld) %s\n", smk_bu_mess[rc],
 		tsp->smk_task->smk_known, isp->smk_inode->smk_known, acc,
-		inode->i_sb->s_id, inode->i_ino, current->comm);
+		inode_sb(inode)->s_id, inode->i_ino, current->comm);
 	return 0;
 }
 #else
@@ -202,7 +202,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
 		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
-			inode->i_sb->s_id, inode->i_ino, current->comm);
+			inode_sb(inode)->s_id, inode->i_ino, current->comm);
 
 	if (rc <= 0)
 		return rc;
@@ -212,7 +212,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 	smk_bu_mode(mode, acc);
 	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
 		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
-		inode->i_sb->s_id, inode->i_ino, file,
+		inode_sb(inode)->s_id, inode->i_ino, file,
 		current->comm);
 	return 0;
 }
@@ -232,7 +232,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
 		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
-			inode->i_sb->s_id, inode->i_ino, current->comm);
+			inode_sb(inode)->s_id, inode->i_ino, current->comm);
 
 	if (rc <= 0)
 		return rc;
@@ -242,7 +242,7 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 	smk_bu_mode(mode, acc);
 	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
 		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
-		inode->i_sb->s_id, inode->i_ino, file,
+		inode_sb(inode)->s_id, inode->i_ino, file,
 		current->comm);
 	return 0;
 }
@@ -924,7 +924,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
-	sbsp = inode->i_sb->s_security;
+	sbsp = inode_sb(inode)->s_security;
 	if ((sbsp->smk_flags & SMK_SB_UNTRUSTED) &&
 	    isp->smk_task != sbsp->smk_root)
 		return 0;
@@ -1213,7 +1213,7 @@ static int smack_inode_rename(struct inode *old_inode,
  */
 static int smack_inode_permission(struct inode *inode, int mask)
 {
-	struct superblock_smack *sbsp = inode->i_sb->s_security;
+	struct superblock_smack *sbsp = inode_sb(inode)->s_security;
 	struct smk_audit_info ad;
 	int no_block = mask & MAY_NOT_BLOCK;
 	int rc;
@@ -1493,7 +1493,7 @@ static int smack_inode_getsecurity(struct inode *inode,
 		/*
 		 * The rest of the Smack xattrs are only on sockets.
 		 */
-		sbp = ip->i_sb;
+		sbp = inode_sb(ip);
 		if (sbp->s_magic != SOCKFS_MAGIC)
 			return -EOPNOTSUPP;
 
@@ -1737,7 +1737,7 @@ static int smack_mmap_file(struct file *file,
 	isp = file_inode(file)->i_security;
 	if (isp->smk_mmap == NULL)
 		return 0;
-	sbsp = file_inode(file)->i_sb->s_security;
+	sbsp = inode_sb(file_inode(file))->s_security;
 	if (sbsp->smk_flags & SMK_SB_UNTRUSTED &&
 	    isp->smk_mmap != sbsp->smk_root)
 		return -EACCES;
@@ -1884,7 +1884,7 @@ static int smack_file_receive(struct file *file)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 
-	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
+	if (inode_sb(inode)->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
 		ssp = sock->sk->sk_security;
 		tsp = current_security();
@@ -2759,7 +2759,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	/*
 	 * The rest of the Smack xattrs are only on sockets.
 	 */
-	if (inode->i_sb->s_magic != SOCKFS_MAGIC)
+	if (inode_sb(inode)->s_magic != SOCKFS_MAGIC)
 		return -EOPNOTSUPP;
 
 	sock = SOCKET_I(inode);
@@ -3414,7 +3414,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 	if (isp->smk_flags & SMK_INODE_INSTANT)
 		goto unlockandout;
 
-	sbp = inode->i_sb;
+	sbp = inode_sb(inode);
 	sbsp = sbp->s_security;
 	/*
 	 * We're going to use the superblock default label
diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
index 8d0e1b9c9c57..3422f5f57e43 100644
--- a/security/tomoyo/condition.c
+++ b/security/tomoyo/condition.c
@@ -722,7 +722,7 @@ void tomoyo_get_attributes(struct tomoyo_obj_info *obj)
 			stat->gid  = inode->i_gid;
 			stat->ino  = inode->i_ino;
 			stat->mode = inode->i_mode;
-			stat->dev  = inode->i_sb->s_dev;
+			stat->dev  = inode_sb(inode)->s_dev;
 			stat->rdev = inode->i_rdev;
 			obj->stat_valid[i] = true;
 		}
-- 
2.15.1
