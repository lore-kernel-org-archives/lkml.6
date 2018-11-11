Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C03C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68BD206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhQFIJVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68BD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404145AbeKLIo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403972AbeKLIW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:56 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CDE32245E;
        Sun, 11 Nov 2018 22:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975579;
        bh=WHzMzIQRAfDMI/kwkO28klyYlERdAo3lKIdkrzpTODc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhQFIJVd0xlhLGAbu6bmUxBosC10BbV57UgXaCwBxho0l8JN/9/vpUYPn5R53D7ay
         2UiXWzRBTutkhsSqW9KQSXC0CF8Y+ZGbqdrR6iSK7T4SwtabvBX3Ssz3apfGvyicmv
         Wmepkr03TbtGsIp750+rBoDm47HQU+jUu9SZiLY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.14 140/222] ext4: fix use-after-free race in ext4_remount()s error path
Date:   Sun, 11 Nov 2018 14:23:57 -0800
Message-Id: <20181111221700.046077218@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 33458eaba4dfe778a426df6a19b7aad2ff9f7eec upstream.

It's possible for ext4_show_quota_options() to try reading
s_qf_names[i] while it is being modified by ext4_remount() --- most
notably, in ext4_remount's error path when the original values of the
quota file name gets restored.

Reported-by: syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 3.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4.h  |    3 +-
 fs/ext4/super.c |   73 ++++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 50 insertions(+), 26 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1421,7 +1421,8 @@ struct ext4_sb_info {
 	u32 s_min_batch_time;
 	struct block_device *journal_bdev;
 #ifdef CONFIG_QUOTA
-	char *s_qf_names[EXT4_MAXQUOTAS];	/* Names of quota files with journalled quota */
+	/* Names of quota files with journalled quota */
+	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -855,6 +855,18 @@ static inline void ext4_quota_off_umount
 	for (type = 0; type < EXT4_MAXQUOTAS; type++)
 		ext4_quota_off(sb, type);
 }
+
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
 #else
 static inline void ext4_quota_off_umount(struct super_block *sb)
 {
@@ -907,7 +919,7 @@ static void ext4_put_super(struct super_
 	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(sbi->s_qf_names[i]);
+		kfree(get_qf_name(sb, sbi, i));
 #endif
 
 	/* Debugging code just in case the in-memory inode orphan list
@@ -1473,11 +1485,10 @@ static const char deprecated_msg[] =
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
@@ -1494,8 +1505,8 @@ static int set_qf_name(struct super_bloc
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
@@ -1508,7 +1519,7 @@ static int set_qf_name(struct super_bloc
 			"quotafile must be on filesystem root");
 		goto errout;
 	}
-	sbi->s_qf_names[qtype] = qname;
+	rcu_assign_pointer(sbi->s_qf_names[qtype], qname);
 	set_opt(sb, QUOTA);
 	return 1;
 errout:
@@ -1520,15 +1531,16 @@ static int clear_qf_name(struct super_bl
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
@@ -1901,7 +1913,7 @@ static int parse_options(char *options,
 			 int is_remount)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *p;
+	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
 
@@ -1932,11 +1944,13 @@ static int parse_options(char *options,
 			 "Cannot enable project quota enforcement.");
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
@@ -1970,6 +1984,7 @@ static inline void ext4_show_quota_optio
 {
 #if defined(CONFIG_QUOTA)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	char *usr_qf_name, *grp_qf_name;
 
 	if (sbi->s_jquota_fmt) {
 		char *fmtname = "";
@@ -1988,11 +2003,14 @@ static inline void ext4_show_quota_optio
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
 
@@ -5038,6 +5056,7 @@ static int ext4_remount(struct super_blo
 	int err = 0;
 #ifdef CONFIG_QUOTA
 	int i, j;
+	char *to_free[EXT4_MAXQUOTAS];
 #endif
 	char *orig_data = kstrdup(data, GFP_KERNEL);
 
@@ -5054,8 +5073,9 @@ static int ext4_remount(struct super_blo
 	old_opts.s_jquota_fmt = sbi->s_jquota_fmt;
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
 		if (sbi->s_qf_names[i]) {
-			old_opts.s_qf_names[i] = kstrdup(sbi->s_qf_names[i],
-							 GFP_KERNEL);
+			char *qf_name = get_qf_name(sb, sbi, i);
+
+			old_opts.s_qf_names[i] = kstrdup(qf_name, GFP_KERNEL);
 			if (!old_opts.s_qf_names[i]) {
 				for (j = 0; j < i; j++)
 					kfree(old_opts.s_qf_names[j]);
@@ -5277,9 +5297,12 @@ restore_opts:
 #ifdef CONFIG_QUOTA
 	sbi->s_jquota_fmt = old_opts.s_jquota_fmt;
 	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-		kfree(sbi->s_qf_names[i]);
-		sbi->s_qf_names[i] = old_opts.s_qf_names[i];
+		to_free[i] = get_qf_name(sb, sbi, i);
+		rcu_assign_pointer(sbi->s_qf_names[i], old_opts.s_qf_names[i]);
 	}
+	synchronize_rcu();
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(to_free[i]);
 #endif
 	kfree(orig_data);
 	return err;
@@ -5469,7 +5492,7 @@ static int ext4_write_info(struct super_
  */
 static int ext4_quota_on_mount(struct super_block *sb, int type)
 {
-	return dquot_quota_on_mount(sb, EXT4_SB(sb)->s_qf_names[type],
+	return dquot_quota_on_mount(sb, get_qf_name(sb, EXT4_SB(sb), type),
 					EXT4_SB(sb)->s_jquota_fmt, type);
 }
 


