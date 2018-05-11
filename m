Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeEKAzc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 20:55:32 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:39488
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752122AbeEKAz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 20:55:29 -0400
X-YMail-OSG: iaOgK6kVM1nEqRAGkf3i17QYBAHMYYVaqGgGKChxTlu3OBejWG7nJ51uJcq4AhE
 KiGw2gVxOHZPJzuZQ0WvWIu.ASUh9CrNkPt3dta1JHwAqUvaOGg7lW6HXMHkG28Nj8UQuN8nlWdl
 XOCJZ2yNygXUY6TWFwga2djgCxLq7qkt2ZWpCzogdm3rM.DnrtLS5TjJWB5bfhweimzzgb_u1iV5
 57ovW5kpwjUHZVBOpR3FxAyXYjajZMZpXO.sl0bn7VrDm84b3zdAWjqiuZlCzxSoi7AwU4IScsox
 _fd7F16DbfFwLQTu.T8W0a02_up.wnLuHEroSH26TzwzTr5x.xRESdTHcqAskkc1oCxVyBH7s0Vf
 a3DSA5rcsUrCSbvHJHB1vqINaj.K5cbsDp4AEWXaxCrTLXtWIyhB27lvrtjtIP.nF28FUYyxXjEI
 Lp5WnJuSmHBJp_Prz.uIoMuYBnRsd3r2z7Qj2pi1tvLkKaYENzMGy3STGnzjU52pUGiihZzRgg2N
 EJl44pzdwhnANEhXAa30XxX.fnpvszEFNbu60Wsx_g7X5zrb_BFUq2B9UpfdHYoNnFVXE6.DJ4Fy
 tLgrzvUPcYkf2xB2SxCgN.kfaqdEduENIkBTPXGs0miLEMbZUVcc7lyEGuPe0NBfAqyOQ9B5asKX
 rV20-
Subject: [PATCH 17/23] LSM: Allow mount options from multiple security modules
To: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ba09c442-e57d-ad35-ffdb-25bedb2ecd60@schaufler-ca.com>
Date: Thu, 10 May 2018 17:55:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 15:10:46 -0700
Subject: [PATCH 17/23] LSM: Allow mount options from multiple security modules

Both SELinux and Smack use mount options that apply to
filesystems generally. Remove the failure case where the
security modules don't recognize an option. SELinux does
not recognize Smack's options, and vis versa.

The btrfs code had some misconceptions about the generality
of security modules and mount options. That has been
corrected.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/btrfs/super.c           | 10 +++---
 include/linux/security.h   | 45 ++++++++++++++++-------
 security/security.c        | 14 ++++++--
 security/selinux/hooks.c   | 90 +++++++++++++++++++++++-----------------------
 security/smack/smack_lsm.c | 54 ++++++++++++++--------------
 5 files changed, 122 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0628092b0b1b..a678d956248f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1487,15 +1487,15 @@ static int setup_security_options(struct btrfs_fs_info *fs_info,
 		return ret;
 
 #ifdef CONFIG_SECURITY
-	if (!fs_info->security_opts.num_mnt_opts) {
+	if (fs_info->security_opts.selinux.num_mnt_opts != 0 ||
+	    fs_info->security_opts.smack.num_mnt_opts != 0) {
 		/* first time security setup, copy sec_opts to fs_info */
 		memcpy(&fs_info->security_opts, sec_opts, sizeof(*sec_opts));
 	} else {
 		/*
-		 * Since SELinux (the only one supporting security_mnt_opts)
-		 * does NOT support changing context during remount/mount of
-		 * the same sb, this must be the same or part of the same
-		 * security options, just free it.
+		 * Since no modules support changing context during
+		 * remount/mount of the same sb, this must be the same
+		 * or part of the same security options, just free it.
 		 */
 		security_free_mnt_opts(sec_opts);
 	}
diff --git a/include/linux/security.h b/include/linux/security.h
index 9afe7a509030..221665f411c0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -161,34 +161,55 @@ typedef int (*initxattrs) (struct inode *inode,
 
 #ifdef CONFIG_SECURITY
 
-struct security_mnt_opts {
+struct lsm_mnt_opts {
 	char **mnt_opts;
 	int *mnt_opts_flags;
 	int num_mnt_opts;
 };
 
+
+struct security_mnt_opts {
+#ifdef CONFIG_SECURITY_STACKING
+	struct lsm_mnt_opts     selinux;
+	struct lsm_mnt_opts     smack;
+#else
+	union {
+		struct lsm_mnt_opts     selinux;
+		struct lsm_mnt_opts     smack;
+	};
+#endif
+};
+
 int call_lsm_notifier(enum lsm_event event, void *data);
 int register_lsm_notifier(struct notifier_block *nb);
 int unregister_lsm_notifier(struct notifier_block *nb);
 
 static inline void security_init_mnt_opts(struct security_mnt_opts *opts)
 {
-	opts->mnt_opts = NULL;
-	opts->mnt_opts_flags = NULL;
-	opts->num_mnt_opts = 0;
+	memset(opts, 0, sizeof(*opts));
 }
 
 static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 {
 	int i;
-	if (opts->mnt_opts)
-		for (i = 0; i < opts->num_mnt_opts; i++)
-			kfree(opts->mnt_opts[i]);
-	kfree(opts->mnt_opts);
-	opts->mnt_opts = NULL;
-	kfree(opts->mnt_opts_flags);
-	opts->mnt_opts_flags = NULL;
-	opts->num_mnt_opts = 0;
+
+	if (opts->selinux.mnt_opts)
+		for (i = 0; i < opts->selinux.num_mnt_opts; i++)
+			kfree(opts->selinux.mnt_opts[i]);
+	kfree(opts->selinux.mnt_opts);
+	opts->selinux.mnt_opts = NULL;
+	kfree(opts->selinux.mnt_opts_flags);
+	opts->selinux.mnt_opts_flags = NULL;
+	opts->selinux.num_mnt_opts = 0;
+
+	if (opts->smack.mnt_opts)
+		for (i = 0; i < opts->smack.num_mnt_opts; i++)
+			kfree(opts->smack.mnt_opts[i]);
+	kfree(opts->smack.mnt_opts);
+	opts->smack.mnt_opts = NULL;
+	kfree(opts->smack.mnt_opts_flags);
+	opts->smack.mnt_opts_flags = NULL;
+	opts->smack.num_mnt_opts = 0;
 }
 
 /* prototypes */
diff --git a/security/security.c b/security/security.c
index e0f01cdd1830..3d1293e8b19b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -782,9 +782,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-				opts->num_mnt_opts ? -EOPNOTSUPP : 0, sb,
-				opts, kern_flags, set_kern_flags);
+	int nobody = 0;
+
+	/*
+	 * Additional security modules that use mount options
+	 * need to be added here.
+	 */
+	if (opts->selinux.num_mnt_opts != 0 || opts->smack.num_mnt_opts != 0)
+		nobody = -EOPNOTSUPP;
+
+	return call_int_hook(sb_set_mnt_opts, nobody, sb, opts, kern_flags,
+				set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1b81b74b8f84..47f672152892 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -569,21 +569,23 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 	/* count the number of mount options for this sb */
 	for (i = 0; i < NUM_SEL_MNT_OPTS; i++) {
 		if (tmp & 0x01)
-			opts->num_mnt_opts++;
+			opts->selinux.num_mnt_opts++;
 		tmp >>= 1;
 	}
 	/* Check if the Label support flag is set */
 	if (sbsec->flags & SBLABEL_MNT)
-		opts->num_mnt_opts++;
+		opts->selinux.num_mnt_opts++;
 
-	opts->mnt_opts = kcalloc(opts->num_mnt_opts, sizeof(char *), GFP_ATOMIC);
-	if (!opts->mnt_opts) {
+	opts->selinux.mnt_opts = kcalloc(opts->selinux.num_mnt_opts,
+						sizeof(char *), GFP_ATOMIC);
+	if (!opts->selinux.mnt_opts) {
 		rc = -ENOMEM;
 		goto out_free;
 	}
 
-	opts->mnt_opts_flags = kcalloc(opts->num_mnt_opts, sizeof(int), GFP_ATOMIC);
-	if (!opts->mnt_opts_flags) {
+	opts->selinux.mnt_opts_flags = kcalloc(opts->selinux.num_mnt_opts,
+						sizeof(int), GFP_ATOMIC);
+	if (!opts->selinux.mnt_opts_flags) {
 		rc = -ENOMEM;
 		goto out_free;
 	}
@@ -594,8 +596,8 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = FSCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = FSCONTEXT_MNT;
 	}
 	if (sbsec->flags & CONTEXT_MNT) {
 		rc = security_sid_to_context(&selinux_state,
@@ -603,16 +605,16 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = CONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = CONTEXT_MNT;
 	}
 	if (sbsec->flags & DEFCONTEXT_MNT) {
 		rc = security_sid_to_context(&selinux_state, sbsec->def_sid,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = DEFCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = DEFCONTEXT_MNT;
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
 		struct dentry *root = sbsec->sb->s_root;
@@ -622,15 +624,15 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = ROOTCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = ROOTCONTEXT_MNT;
 	}
 	if (sbsec->flags & SBLABEL_MNT) {
-		opts->mnt_opts[i] = NULL;
-		opts->mnt_opts_flags[i++] = SBLABEL_MNT;
+		opts->selinux.mnt_opts[i] = NULL;
+		opts->selinux.mnt_opts_flags[i++] = SBLABEL_MNT;
 	}
 
-	BUG_ON(i != opts->num_mnt_opts);
+	BUG_ON(i != opts->selinux.num_mnt_opts);
 
 	return 0;
 
@@ -676,9 +678,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
-	char **mount_options = opts->mnt_opts;
-	int *flags = opts->mnt_opts_flags;
-	int num_opts = opts->num_mnt_opts;
+	char **mount_options = opts->selinux.mnt_opts;
+	int *flags = opts->selinux.mnt_opts_flags;
+	int num_opts = opts->selinux.num_mnt_opts;
 
 	mutex_lock(&sbsec->lock);
 
@@ -1039,7 +1041,7 @@ static int selinux_parse_opts_str(char *options,
 	char *fscontext = NULL, *rootcontext = NULL;
 	int rc, num_mnt_opts = 0;
 
-	opts->num_mnt_opts = 0;
+	opts->selinux.num_mnt_opts = 0;
 
 	/* Standard string-based options. */
 	while ((p = strsep(&options, "|")) != NULL) {
@@ -1106,41 +1108,39 @@ static int selinux_parse_opts_str(char *options,
 		case Opt_labelsupport:
 			break;
 		default:
-			rc = -EINVAL;
 			printk(KERN_WARNING "SELinux:  unknown mount option\n");
-			goto out_err;
-
+			break;
 		}
 	}
 
 	rc = -ENOMEM;
-	opts->mnt_opts = kcalloc(NUM_SEL_MNT_OPTS, sizeof(char *), GFP_KERNEL);
-	if (!opts->mnt_opts)
+	opts->selinux.mnt_opts = kcalloc(NUM_SEL_MNT_OPTS, sizeof(char *), GFP_KERNEL);
+	if (!opts->selinux.mnt_opts)
 		goto out_err;
 
-	opts->mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
+	opts->selinux.mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
 				       GFP_KERNEL);
-	if (!opts->mnt_opts_flags)
+	if (!opts->selinux.mnt_opts_flags)
 		goto out_err;
 
 	if (fscontext) {
-		opts->mnt_opts[num_mnt_opts] = fscontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = fscontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
 	}
 	if (context) {
-		opts->mnt_opts[num_mnt_opts] = context;
-		opts->mnt_opts_flags[num_mnt_opts++] = CONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = context;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = CONTEXT_MNT;
 	}
 	if (rootcontext) {
-		opts->mnt_opts[num_mnt_opts] = rootcontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = ROOTCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = rootcontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = ROOTCONTEXT_MNT;
 	}
 	if (defcontext) {
-		opts->mnt_opts[num_mnt_opts] = defcontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = DEFCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = defcontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = DEFCONTEXT_MNT;
 	}
 
-	opts->num_mnt_opts = num_mnt_opts;
+	opts->selinux.num_mnt_opts = num_mnt_opts;
 	return 0;
 
 out_err:
@@ -1185,15 +1185,15 @@ static void selinux_write_opts(struct seq_file *m,
 	int i;
 	char *prefix;
 
-	for (i = 0; i < opts->num_mnt_opts; i++) {
+	for (i = 0; i < opts->selinux.num_mnt_opts; i++) {
 		char *has_comma;
 
-		if (opts->mnt_opts[i])
-			has_comma = strchr(opts->mnt_opts[i], ',');
+		if (opts->selinux.mnt_opts[i])
+			has_comma = strchr(opts->selinux.mnt_opts[i], ',');
 		else
 			has_comma = NULL;
 
-		switch (opts->mnt_opts_flags[i]) {
+		switch (opts->selinux.mnt_opts_flags[i]) {
 		case CONTEXT_MNT:
 			prefix = CONTEXT_STR;
 			break;
@@ -1219,7 +1219,7 @@ static void selinux_write_opts(struct seq_file *m,
 		seq_puts(m, prefix);
 		if (has_comma)
 			seq_putc(m, '\"');
-		seq_escape(m, opts->mnt_opts[i], "\"\n\\");
+		seq_escape(m, opts->selinux.mnt_opts[i], "\"\n\\");
 		if (has_comma)
 			seq_putc(m, '\"');
 	}
@@ -2794,10 +2794,10 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	if (rc)
 		goto out_free_secdata;
 
-	mount_options = opts.mnt_opts;
-	flags = opts.mnt_opts_flags;
+	mount_options = opts.selinux.mnt_opts;
+	flags = opts.selinux.mnt_opts_flags;
 
-	for (i = 0; i < opts.num_mnt_opts; i++) {
+	for (i = 0; i < opts.selinux.num_mnt_opts; i++) {
 		u32 sid;
 
 		if (flags[i] == SBLABEL_MNT)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4cc3d6e04e10..6528757ef6c0 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -601,7 +601,7 @@ static int smack_parse_opts_str(char *options,
 	int num_mnt_opts = 0;
 	int token;
 
-	opts->num_mnt_opts = 0;
+	opts->smack.num_mnt_opts = 0;
 
 	if (!options)
 		return 0;
@@ -651,43 +651,45 @@ static int smack_parse_opts_str(char *options,
 				goto out_err;
 			break;
 		default:
-			rc = -EINVAL;
 			pr_warn("Smack:  unknown mount option\n");
-			goto out_err;
+			break;
 		}
 	}
 
-	opts->mnt_opts = kcalloc(NUM_SMK_MNT_OPTS, sizeof(char *), GFP_KERNEL);
-	if (!opts->mnt_opts)
+	opts->smack.mnt_opts = kcalloc(NUM_SMK_MNT_OPTS, sizeof(char *),
+					GFP_KERNEL);
+	if (!opts->smack.mnt_opts)
 		goto out_err;
 
-	opts->mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
-			GFP_KERNEL);
-	if (!opts->mnt_opts_flags)
+	opts->smack.mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
+					GFP_KERNEL);
+	if (!opts->smack.mnt_opts_flags) {
+		kfree(opts->smack.mnt_opts);
 		goto out_err;
+	}
 
 	if (fsdefault) {
-		opts->mnt_opts[num_mnt_opts] = fsdefault;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSDEFAULT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsdefault;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSDEFAULT_MNT;
 	}
 	if (fsfloor) {
-		opts->mnt_opts[num_mnt_opts] = fsfloor;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSFLOOR_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsfloor;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSFLOOR_MNT;
 	}
 	if (fshat) {
-		opts->mnt_opts[num_mnt_opts] = fshat;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSHAT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fshat;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSHAT_MNT;
 	}
 	if (fsroot) {
-		opts->mnt_opts[num_mnt_opts] = fsroot;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSROOT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsroot;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSROOT_MNT;
 	}
 	if (fstransmute) {
-		opts->mnt_opts[num_mnt_opts] = fstransmute;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSTRANS_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fstransmute;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSTRANS_MNT;
 	}
 
-	opts->num_mnt_opts = num_mnt_opts;
+	opts->smack.num_mnt_opts = num_mnt_opts;
 	return 0;
 
 out_opt_err:
@@ -726,7 +728,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct inode_smack *isp;
 	struct smack_known *skp;
 	int i;
-	int num_opts = opts->num_mnt_opts;
+	int num_opts = opts->smack.num_mnt_opts;
 	int transmute = 0;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -760,33 +762,33 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	sp->smk_flags |= SMK_SB_INITIALIZED;
 
 	for (i = 0; i < num_opts; i++) {
-		switch (opts->mnt_opts_flags[i]) {
+		switch (opts->smack.mnt_opts_flags[i]) {
 		case FSDEFAULT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_default = skp;
 			break;
 		case FSFLOOR_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_floor = skp;
 			break;
 		case FSHAT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_hat = skp;
 			break;
 		case FSROOT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_root = skp;
 			break;
 		case FSTRANS_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_root = skp;
-- 
2.14.3
