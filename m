Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ECEC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A1121723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A1121723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeHHLzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:55:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40057 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbeHHLzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:55:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E81B7A4A348A;
        Wed,  8 Aug 2018 17:36:52 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 17:36:43 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support fault_type mount option
Date:   Wed, 8 Aug 2018 17:36:41 +0800
Message-ID: <20180808093641.84280-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, once fault injection is on, by default, all kind of faults
will be injected to f2fs, if we want to trigger single or specified
combined type during the test, we need to configure sysfs entry, it will
be a little inconvenient to integrate sysfs configuring into testsuit,
such as xfstest.

So this patch introduces a new mount option 'fault_type' to assist old
option 'fault_injection', with these two mount options, we can specify
any fault rate/type at mount-time.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 18 ++++++++++++++++
 fs/f2fs/checkpoint.c               |  2 +-
 fs/f2fs/f2fs.h                     |  7 ++++--
 fs/f2fs/super.c                    | 34 ++++++++++++++++++++++++------
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 69f8de995739..e5edd29687b5 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -157,6 +157,24 @@ data_flush             Enable data flushing before checkpoint in order to
                        persist data of regular and symlink.
 fault_injection=%d     Enable fault injection in all supported types with
                        specified injection rate.
+fault_type=%d          Support configuring fault injection type, should be
+                       enabled with fault_injection option, fault type value
+                       is shown below, it supports single or combined type.
+                       Type_Name		Type_Value
+                       FAULT_KMALLOC		0x000000001
+                       FAULT_KVMALLOC		0x000000002
+                       FAULT_PAGE_ALLOC		0x000000004
+                       FAULT_PAGE_GET		0x000000008
+                       FAULT_ALLOC_BIO		0x000000010
+                       FAULT_ALLOC_NID		0x000000020
+                       FAULT_ORPHAN		0x000000040
+                       FAULT_BLOCK		0x000000080
+                       FAULT_DIR_DEPTH		0x000000100
+                       FAULT_EVICT_INODE	0x000000200
+                       FAULT_TRUNCATE		0x000000400
+                       FAULT_IO			0x000000800
+                       FAULT_CHECKPOINT		0x000001000
+                       FAULT_DISCARD		0x000002000
 mode=%s                Control block allocation mode which supports "adaptive"
                        and "lfs". In "lfs" mode, there should be no random
                        writes towards main area.
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 31561026ac9a..3ab7a00c0641 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -28,7 +28,7 @@ struct kmem_cache *f2fs_inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
-	f2fs_build_fault_attr(sbi, 0);
+	f2fs_build_fault_attr(sbi, 0, 0);
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e07fcd7f580..f05ae7c46e14 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -60,6 +60,8 @@ enum {
 	FAULT_MAX,
 };
 
+#define F2FS_ALL_FAULT_TYPE		((1 << FAULT_MAX) - 1)
+
 struct f2fs_fault_info {
 	atomic_t inject_ops;
 	unsigned int inject_rate;
@@ -3437,9 +3439,10 @@ static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
 }
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate);
+extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
+							unsigned int type);
 #else
-#define f2fs_build_fault_attr(sbi, rate)		do { } while (0)
+#define f2fs_build_fault_attr(sbi, rate, type)		do { } while (0)
 #endif
 
 #endif
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 254f74a6b481..5717838888b4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -58,17 +58,21 @@ char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_DISCARD]		= "discard error",
 };
 
-void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate)
+void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
+							unsigned int type)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
 	if (rate) {
 		atomic_set(&ffi->inject_ops, 0);
 		ffi->inject_rate = rate;
-		ffi->inject_type = (1 << FAULT_MAX) - 1;
-	} else {
-		memset(ffi, 0, sizeof(struct f2fs_fault_info));
 	}
+
+	if (type)
+		ffi->inject_type = type;
+
+	if (!rate && !type)
+		memset(ffi, 0, sizeof(struct f2fs_fault_info));
 }
 #endif
 
@@ -113,6 +117,7 @@ enum {
 	Opt_mode,
 	Opt_io_size_bits,
 	Opt_fault_injection,
+	Opt_fault_type,
 	Opt_lazytime,
 	Opt_nolazytime,
 	Opt_quota,
@@ -170,6 +175,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_mode, "mode=%s"},
 	{Opt_io_size_bits, "io_bits=%u"},
 	{Opt_fault_injection, "fault_injection=%u"},
+	{Opt_fault_type, "fault_type=%u"},
 	{Opt_lazytime, "lazytime"},
 	{Opt_nolazytime, "nolazytime"},
 	{Opt_quota, "quota"},
@@ -600,7 +606,18 @@ static int parse_options(struct super_block *sb, char *options)
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-			f2fs_build_fault_attr(sbi, arg);
+			f2fs_build_fault_attr(sbi, arg, F2FS_ALL_FAULT_TYPE);
+			set_opt(sbi, FAULT_INJECTION);
+#else
+			f2fs_msg(sb, KERN_INFO,
+				"FAULT_INJECTION was not selected");
+#endif
+			break;
+		case Opt_fault_type:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+			f2fs_build_fault_attr(sbi, 0, arg);
 			set_opt(sbi, FAULT_INJECTION);
 #else
 			f2fs_msg(sb, KERN_INFO,
@@ -1321,9 +1338,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	if (F2FS_IO_SIZE_BITS(sbi))
 		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (test_opt(sbi, FAULT_INJECTION))
+	if (test_opt(sbi, FAULT_INJECTION)) {
 		seq_printf(seq, ",fault_injection=%u",
 				F2FS_OPTION(sbi).fault_info.inject_rate);
+		seq_printf(seq, ",fault_type=%u",
+				F2FS_OPTION(sbi).fault_info.inject_type);
+	}
 #endif
 #ifdef CONFIG_QUOTA
 	if (test_opt(sbi, QUOTA))
@@ -1393,7 +1413,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, POSIX_ACL);
 #endif
 
-	f2fs_build_fault_attr(sbi, 0);
+	f2fs_build_fault_attr(sbi, 0, 0);
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.18.0.rc1

