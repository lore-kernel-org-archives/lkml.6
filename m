Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7DFC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4DE2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfBCOVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55796 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730474AbfBCOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:24 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeA-0006Qf-BT; Sun, 03 Feb 2019 14:21:22 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006tz-KM; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.963835896@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 077/305] ext4: fix use-after-free race in
 ext4_remount()'s error path
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 33458eaba4dfe778a426df6a19b7aad2ff9f7eec upstream.

It's possible for ext4_show_quota_options() to try reading
s_qf_names[i] while it is being modified by ext4_remount() --- most
notably, in ext4_remount's error path when the original values of the
quota file name gets restored.

Reported-by: syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16:
 - s/EXT4_MAXQUOTAS/MAXQUOTAS/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1300,7 +1300,8 @@ struct ext4_sb_info {
 	u32 s_min_batch_time;
 	struct block_device *journal_bdev;
 #ifdef CONFIG_QUOTA
-	char *s_qf_names[MAXQUOTAS];		/* Names of quota files with journalled quota */
+	/* Names of quota files with journalled quota */
+	char __rcu *s_qf_names[MAXQUOTAS];
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -780,6 +780,20 @@ static void dump_orphan_list(struct supe
 	}
 }
 
+#ifdef CONFIG_QUOTA
+/*
+ * This is a helper function which is used in the mount/remount
+ * codepaths (which holds s_umount) to fetch the quota file name.
+ */
+static inline char *get_qf_name(struct super_block *sb,
+				struct ext4_sb_info *sbi,
+				int type)
+{
+	return rcu_dereference_protected(sbi->s_qf_names[type],
+					 lockdep_is_held(&sb->s_umount));
+}
+#endif
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -833,7 +847,7 @@ static void ext4_put_super(struct super_
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
-		kfree(sbi->s_qf_names[i]);
+		kfree(get_qf_name(sb, sbi, i));
 #endif
 
 	/* Debugging code just in case the in-memory inode orphan list
@@ -1293,11 +1307,10 @@ static char deprecated_msg[] = "Mount op
 static int set_qf_name(struct super_block *sb, int qtype, substring_t *args)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *qname;
+	char *qname, *old_qname = get_qf_name(sb, sbi, qtype);
 	int ret = -1;
 
-	if (sb_any_quota_loaded(sb) &&
-		!sbi->s_qf_names[qtype]) {
+	if (sb_any_quota_loaded(sb) && !old_qname) {
 		ext4_msg(sb, KERN_ERR,
 			"Cannot change journaled "
 			"quota options when quota turned on");
@@ -1314,8 +1327,8 @@ static int set_qf_name(struct super_bloc
 			"Not enough memory for storing quotafile name");
 		return -1;
 	}
-	if (sbi->s_qf_names[qtype]) {
-		if (strcmp(sbi->s_qf_names[qtype], qname) == 0)
+	if (old_qname) {
+		if (strcmp(old_qname, qname) == 0)
 			ret = 1;
 		else
 			ext4_msg(sb, KERN_ERR,
@@ -1328,7 +1341,7 @@ static int set_qf_name(struct super_bloc
 			"quotafile must be on filesystem root");
 		goto errout;
 	}
-	sbi->s_qf_names[qtype] = qname;
+	rcu_assign_pointer(sbi->s_qf_names[qtype], qname);
 	set_opt(sb, QUOTA);
 	return 1;
 errout:
@@ -1340,15 +1353,16 @@ static int clear_qf_name(struct super_bl
 {
 
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	char *old_qname = get_qf_name(sb, sbi, qtype);
 
-	if (sb_any_quota_loaded(sb) &&
-		sbi->s_qf_names[qtype]) {
+	if (sb_any_quota_loaded(sb) && old_qname) {
 		ext4_msg(sb, KERN_ERR, "Cannot change journaled quota options"
 			" when quota turned on");
 		return -1;
 	}
-	kfree(sbi->s_qf_names[qtype]);
-	sbi->s_qf_names[qtype] = NULL;
+	rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
+	synchronize_rcu();
+	kfree(old_qname);
 	return 1;
 }
 #endif
@@ -1677,7 +1691,7 @@ static int parse_options(char *options,
 			 int is_remount)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *p;
+	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
 
@@ -1704,11 +1718,13 @@ static int parse_options(char *options,
 			 "feature is enabled");
 		return 0;
 	}
-	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
-		if (test_opt(sb, USRQUOTA) && sbi->s_qf_names[USRQUOTA])
+	usr_qf_name = get_qf_name(sb, sbi, USRQUOTA);
+	grp_qf_name = get_qf_name(sb, sbi, GRPQUOTA);
+	if (usr_qf_name || grp_qf_name) {
+		if (test_opt(sb, USRQUOTA) && usr_qf_name)
 			clear_opt(sb, USRQUOTA);
 
-		if (test_opt(sb, GRPQUOTA) && sbi->s_qf_names[GRPQUOTA])
+		if (test_opt(sb, GRPQUOTA) && grp_qf_name)
 			clear_opt(sb, GRPQUOTA);
 
 		if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
@@ -1742,6 +1758,7 @@ static inline void ext4_show_quota_optio
 {
 #if defined(CONFIG_QUOTA)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	char *usr_qf_name, *grp_qf_name;
 
 	if (sbi->s_jquota_fmt) {
 		char *fmtname = "";
@@ -1760,11 +1777,14 @@ static inline void ext4_show_quota_optio
 		seq_printf(seq, ",jqfmt=%s", fmtname);
 	}
 
-	if (sbi->s_qf_names[USRQUOTA])
-		seq_show_option(seq, "usrjquota", sbi->s_qf_names[USRQUOTA]);
-
-	if (sbi->s_qf_names[GRPQUOTA])
-		seq_show_option(seq, "grpjquota", sbi->s_qf_names[GRPQUOTA]);
+	rcu_read_lock();
+	usr_qf_name = rcu_dereference(sbi->s_qf_names[USRQUOTA]);
+	grp_qf_name = rcu_dereference(sbi->s_qf_names[GRPQUOTA]);
+	if (usr_qf_name)
+		seq_show_option(seq, "usrjquota", usr_qf_name);
+	if (grp_qf_name)
+		seq_show_option(seq, "grpjquota", grp_qf_name);
+	rcu_read_unlock();
 #endif
 }
 
@@ -4936,6 +4956,7 @@ static int ext4_remount(struct super_blo
 	int err = 0;
 #ifdef CONFIG_QUOTA
 	int i, j;
+	char *to_free[MAXQUOTAS];
 #endif
 	char *orig_data = kstrdup(data, GFP_KERNEL);
 
@@ -4952,8 +4973,9 @@ static int ext4_remount(struct super_blo
 	old_opts.s_jquota_fmt = sbi->s_jquota_fmt;
 	for (i = 0; i < MAXQUOTAS; i++)
 		if (sbi->s_qf_names[i]) {
-			old_opts.s_qf_names[i] = kstrdup(sbi->s_qf_names[i],
-							 GFP_KERNEL);
+			char *qf_name = get_qf_name(sb, sbi, i);
+
+			old_opts.s_qf_names[i] = kstrdup(qf_name, GFP_KERNEL);
 			if (!old_opts.s_qf_names[i]) {
 				for (j = 0; j < i; j++)
 					kfree(old_opts.s_qf_names[j]);
@@ -5141,9 +5163,12 @@ restore_opts:
 #ifdef CONFIG_QUOTA
 	sbi->s_jquota_fmt = old_opts.s_jquota_fmt;
 	for (i = 0; i < MAXQUOTAS; i++) {
-		kfree(sbi->s_qf_names[i]);
-		sbi->s_qf_names[i] = old_opts.s_qf_names[i];
+		to_free[i] = get_qf_name(sb, sbi, i);
+		rcu_assign_pointer(sbi->s_qf_names[i], old_opts.s_qf_names[i]);
 	}
+	synchronize_rcu();
+	for (i = 0; i < MAXQUOTAS; i++)
+		kfree(to_free[i]);
 #endif
 	kfree(orig_data);
 	return err;
@@ -5291,7 +5316,7 @@ static int ext4_write_info(struct super_
  */
 static int ext4_quota_on_mount(struct super_block *sb, int type)
 {
-	return dquot_quota_on_mount(sb, EXT4_SB(sb)->s_qf_names[type],
+	return dquot_quota_on_mount(sb, get_qf_name(sb, EXT4_SB(sb), type),
 					EXT4_SB(sb)->s_jquota_fmt, type);
 }
 

