Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE12C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C3320878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C3320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbeGKJSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:18:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732495AbeGKJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:18:16 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LbItu-1gNoR70C1y-00kwA0; Wed, 11 Jul 2018 11:14:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     adilger.kernel@dilger.ca
Cc:     arnd@arndb.de, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com, tytso@mit.edu,
        y2038@lists.linaro.org
Subject: [PATCH v2 6/6] ext4: super: extend timestamps to 40 bits
Date:   Wed, 11 Jul 2018 11:14:14 +0200
Message-Id: <20180711091414.1494843-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711091414.1494843-1-arnd@arndb.de>
References: <20180711091414.1494843-1-arnd@arndb.de>
X-Provags-ID: V03:K1:20Wchcr3kLso94smYgixxLckDSeH2idv+oOepEOCqYyI9iQpkjn
 BebCENWmuw08kHSrBOPapDRRdQm7QaV4umeaJuTFUHpQgawkRENkPQx32hocvtHokSrjuwG
 8Zd+yF5ElZkjR2TXQcK+2kmPAVigtIwz+afz/l+vIBDd/D3QCP+m8HnwMENbHWG+U6upfxU
 Zq8Rmuqc80A7hBai6VYbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uI8gAj6IHnI=:POsO6RWEndsVb7ad646Y/l
 Zk+E57bZ0mM0Ef4O4qGAqbn/8D2abArfwO5CZuhdiHBhpQD2vGcXljHrNnGiqhpX9qkWCSVyM
 iG78YN5oh2vP6KBjeAOnoJaD/cxuAjWGvrDhwxlXgUKrbowbPMaWa+FXG8oE/GZERBxbT5sdE
 H5xxuaz0ptMcC318hZhIraVNIjaijHL5tIkynx404F16SLRFoXB9bh/5UHnMSpagktE4HMJxc
 nuJdVjUujCCvhJbdQz0sPzRLuNN5fKKvMVh8TqDHzdLO5ipU9Rql1cn7tNYos73y06jQmrTSL
 ZWLlE4W14TAK9vi/9uLIQWCA6aiGiiPpky+EyZeyTqiLgo9vGxkqZBYe6cqeEL0j0dwjdniG2
 AWhJ813YR/3KUzH+SPuU3Qj/1OWSzP6RMEHnLXf6HD6b4+BOs+4TxjmcEsqVIEfyE8q/0qlRf
 Z/cXQSKZyeXIP3xwPeD1IydUaDgDKhc/0WzXVplsY5BrqdDrZcmAcr0j9nHXNHsEmjDCvj8PY
 YH5MUYC/aZ4Bti731DsQiTJNNEWoeTfnVKWGuBEWl9gMIUiLACLMHM08Lew1Z0dUOFFivMkZj
 xtSHbqXK0y4JSdJDJRmI0SoKfwiMCHmPP8otxVjQT9iLTcwkqp86olTvSYyKevTjsAoPyIOnI
 fMPntocDStNdyaPqdTZPpPicmAXbnNLU9l863iLAicqGGSuGNgDYHmCvi6Ia58YSTy9o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inode timestamps use 34 bits in ext4, but the various timestamps in
the superblock are limited to 32 bits. If every user accesses these as
'unsigned', then this is good until year 2106, but it seems better to
extend this a bit further in the process of removing the deprecated
get_seconds() function.

This adds another byte for each timestamp in the superblock, making
them long enough to store timestamps beyond what is in the inodes,
which seems good enough here (in ocfs2, they are already 64-bit wide,
which is appropriate for a new layout).

I did not modify e2fsprogs, which obviously needs the same change to
actually interpret future timestamps correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: drop 'RFC' from subject
    minor changes as suggested by Andreas Dilger
---
 fs/ext4/ext4.h  |  9 ++++++++-
 fs/ext4/super.c | 39 ++++++++++++++++++++++++++++++---------
 fs/ext4/sysfs.c | 19 +++++++++++++++++--
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f71ccafe8f9f..3ee9f198c698 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1295,7 +1295,14 @@ struct ext4_super_block {
 	__le32	s_lpf_ino;		/* Location of the lost+found inode */
 	__le32	s_prj_quota_inum;	/* inode for tracking project quota */
 	__le32	s_checksum_seed;	/* crc32c(uuid) if csum_seed set */
-	__le32	s_reserved[98];		/* Padding to the end of the block */
+	__u8	s_wtime_hi;
+	__u8	s_mtime_hi;
+	__u8	s_mkfs_time_hi;
+	__u8	s_lastcheck_hi;
+	__u8	s_first_error_time_hi;
+	__u8	s_last_error_time_hi;
+	__u8	s_pad[2];
+	__le32	s_reserved[96];		/* Padding to the end of the block */
 	__le32	s_checksum;		/* crc32c(superblock) */
 };
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 86e3d13787e6..aaf29e3981db 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -313,6 +313,24 @@ void ext4_itable_unused_set(struct super_block *sb,
 		bg->bg_itable_unused_hi = cpu_to_le16(count >> 16);
 }
 
+static void __ext4_update_tstamp(__le32 *lo, __u8 *hi)
+{
+	time64_t now = ktime_get_real_seconds();
+
+	now = clamp_val(now, 0, (1ull << 40) - 1);
+
+	*lo = cpu_to_le32(lower_32_bits(now));
+	*hi = upper_32_bits(now);
+}
+
+static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
+{
+	return ((time64_t)(*hi) << 32) + le32_to_cpu(*lo);
+}
+#define ext4_update_tstamp(es, tstamp) \
+	__ext4_update_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
+#define ext4_get_tstamp(es, tstamp) \
+	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
 
 static void __save_error_info(struct super_block *sb, const char *func,
 			    unsigned int line)
@@ -323,11 +341,12 @@ static void __save_error_info(struct super_block *sb, const char *func,
 	if (bdev_read_only(sb->s_bdev))
 		return;
 	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
-	es->s_last_error_time = cpu_to_le32(get_seconds());
+	ext4_update_tstamp(es, s_last_error_time);
 	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
 	es->s_last_error_line = cpu_to_le32(line);
 	if (!es->s_first_error_time) {
 		es->s_first_error_time = es->s_last_error_time;
+		es->s_first_error_time_hi = es->s_last_error_time_hi;
 		strncpy(es->s_first_error_func, func,
 			sizeof(es->s_first_error_func));
 		es->s_first_error_line = cpu_to_le32(line);
@@ -2175,8 +2194,8 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
 			 "warning: maximal mount count reached, "
 			 "running e2fsck is recommended");
 	else if (le32_to_cpu(es->s_checkinterval) &&
-		(le32_to_cpu(es->s_lastcheck) +
-			le32_to_cpu(es->s_checkinterval) <= get_seconds()))
+		 (ext4_get_tstamp(es, s_lastcheck) +
+		  le32_to_cpu(es->s_checkinterval) <= ktime_get_real_seconds()))
 		ext4_msg(sb, KERN_WARNING,
 			 "warning: checktime reached, "
 			 "running e2fsck is recommended");
@@ -2185,7 +2204,7 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
 	if (!(__s16) le16_to_cpu(es->s_max_mnt_count))
 		es->s_max_mnt_count = cpu_to_le16(EXT4_DFL_MAX_MNT_COUNT);
 	le16_add_cpu(&es->s_mnt_count, 1);
-	es->s_mtime = cpu_to_le32(get_seconds());
+	ext4_update_tstamp(es, s_mtime);
 	ext4_update_dynamic_rev(sb);
 	if (sbi->s_journal)
 		ext4_set_feature_journal_needs_recovery(sb);
@@ -2876,8 +2895,9 @@ static void print_daily_error_info(struct timer_list *t)
 		ext4_msg(sb, KERN_NOTICE, "error count since last fsck: %u",
 			 le32_to_cpu(es->s_error_count));
 	if (es->s_first_error_time) {
-		printk(KERN_NOTICE "EXT4-fs (%s): initial error at time %u: %.*s:%d",
-		       sb->s_id, le32_to_cpu(es->s_first_error_time),
+		printk(KERN_NOTICE "EXT4-fs (%s): initial error at time %llu: %.*s:%d",
+		       sb->s_id,
+		       ext4_get_tstamp(es, s_first_error_time),
 		       (int) sizeof(es->s_first_error_func),
 		       es->s_first_error_func,
 		       le32_to_cpu(es->s_first_error_line));
@@ -2890,8 +2910,9 @@ static void print_daily_error_info(struct timer_list *t)
 		printk(KERN_CONT "\n");
 	}
 	if (es->s_last_error_time) {
-		printk(KERN_NOTICE "EXT4-fs (%s): last error at time %u: %.*s:%d",
-		       sb->s_id, le32_to_cpu(es->s_last_error_time),
+		printk(KERN_NOTICE "EXT4-fs (%s): last error at time %llu: %.*s:%d",
+		       sb->s_id,
+		       ext4_get_tstamp(es, s_last_error_time),
 		       (int) sizeof(es->s_last_error_func),
 		       es->s_last_error_func,
 		       le32_to_cpu(es->s_last_error_line));
@@ -4822,7 +4843,7 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 	 * to complain and force a full file system check.
 	 */
 	if (!(sb->s_flags & SB_RDONLY))
-		es->s_wtime = cpu_to_le32(get_seconds());
+		ext4_update_tstamp(es, s_wtime);
 	if (sb->s_bdev->bd_part)
 		es->s_kbytes_written =
 			cpu_to_le64(EXT4_SB(sb)->s_kbytes_written +
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index b970a200f20c..e60cc5e89023 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -25,6 +25,8 @@ typedef enum {
 	attr_reserved_clusters,
 	attr_inode_readahead,
 	attr_trigger_test_error,
+	attr_first_error_time,
+	attr_last_error_time,
 	attr_feature,
 	attr_pointer_ui,
 	attr_pointer_atomic,
@@ -182,8 +184,8 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
 EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
-EXT4_RO_ATTR_ES_UI(first_error_time, s_first_error_time);
-EXT4_RO_ATTR_ES_UI(last_error_time, s_last_error_time);
+EXT4_ATTR(first_error_time, 0444, first_error_time);
+EXT4_ATTR(last_error_time, 0444, last_error_time);
 
 static unsigned int old_bump_val = 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -249,6 +251,15 @@ static void *calc_ptr(struct ext4_attr *a, struct ext4_sb_info *sbi)
 	return NULL;
 }
 
+static ssize_t __print_tstamp(char *buf, __le32 lo, __u8 hi)
+{
+	return snprintf(buf, PAGE_SIZE, "%lld",
+			((time64_t)hi << 32) + le32_to_cpu(lo));
+}
+
+#define print_tstamp(buf, es, tstamp) \
+	__print_tstamp(buf, (es)->tstamp, (es)->tstamp ## _hi)
+
 static ssize_t ext4_attr_show(struct kobject *kobj,
 			      struct attribute *attr, char *buf)
 {
@@ -287,6 +298,10 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 				atomic_read((atomic_t *) ptr));
 	case attr_feature:
 		return snprintf(buf, PAGE_SIZE, "supported\n");
+	case attr_first_error_time:
+		return print_tstamp(buf, sbi->s_es, s_first_error_time);
+	case attr_last_error_time:
+		return print_tstamp(buf, sbi->s_es, s_last_error_time);
 	}
 
 	return 0;
-- 
2.9.0

