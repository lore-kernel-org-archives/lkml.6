Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF56C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F7620894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F7620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbeGZNm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:42:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32969 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730097AbeGZNm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:42:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B6C7BA0AF727D;
        Thu, 26 Jul 2018 20:25:46 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 26 Jul
 2018 20:25:40 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, <weidu.du@huawei.com>, <hsiangkao@aol.com>,
        <chao@kernel.org>
Subject: [PATCH 11/25] staging: erofs: introduce error injection infrastructure
Date:   Thu, 26 Jul 2018 20:21:54 +0800
Message-ID: <1532607728-103372-12-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch introduces error injection infrastructure, with it, we can
inject error in any kernel exported common functions which erofs used,
so that it can force erofs running into error paths, it turns out that
tests can cover real rare paths more easily to find bugs.

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/Kconfig    |  6 +++++
 drivers/staging/erofs/inode.c    |  3 ++-
 drivers/staging/erofs/internal.h | 57 ++++++++++++++++++++++++++++++++++++++++
 drivers/staging/erofs/super.c    | 38 +++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index 1a5ec1b..edda055 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -71,3 +71,9 @@ config EROFS_FS_USE_VM_MAP_RAM
 
 	  If you don't know what these are, say N.
 
+config EROFS_FAULT_INJECTION
+	bool "EROFS fault injection facility"
+	depends on EROFS_FS
+	help
+	  Test EROFS to inject faults such as ENOMEM, EIO, and so on.
+	  If unsure, say N.
diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index c011811..a6d3e12 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -113,6 +113,7 @@ static int read_inode(struct inode *inode, void *data)
 static int fill_inline_data(struct inode *inode, void *data, unsigned m_pofs)
 {
 	struct erofs_vnode *vi = EROFS_V(inode);
+	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	int mode = vi->data_mapping_mode;
 
 	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
@@ -123,7 +124,7 @@ static int fill_inline_data(struct inode *inode, void *data, unsigned m_pofs)
 
 	/* fast symlink (following ext4) */
 	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
-		char *lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
+		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
 
 		if (unlikely(lnk == NULL))
 			return -ENOMEM;
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 5862705..ca22486 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -42,6 +42,22 @@
 #define DBG_BUGON(...)          ((void)0)
 #endif
 
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+enum {
+	FAULT_KMALLOC,
+	FAULT_MAX,
+};
+
+extern char *erofs_fault_name[FAULT_MAX];
+#define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
+
+struct erofs_fault_info {
+	atomic_t inject_ops;
+	unsigned int inject_rate;
+	unsigned int inject_type;
+};
+#endif
+
 /* EROFS_SUPER_MAGIC_V1 to represent the whole file system */
 #define EROFS_SUPER_MAGIC   EROFS_SUPER_MAGIC_V1
 
@@ -70,14 +86,55 @@ struct erofs_sb_info {
 	char *dev_name;
 
 	unsigned int mount_opt;
+
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+	struct erofs_fault_info fault_info;	/* For fault injection */
+#endif
 };
 
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+#define erofs_show_injection_info(type)					\
+	infoln("inject %s in %s of %pS", erofs_fault_name[type],        \
+		__func__, __builtin_return_address(0))
+
+static inline bool time_to_inject(struct erofs_sb_info *sbi, int type)
+{
+	struct erofs_fault_info *ffi = &sbi->fault_info;
+
+	if (!ffi->inject_rate)
+		return false;
+
+	if (!IS_FAULT_SET(ffi, type))
+		return false;
+
+	atomic_inc(&ffi->inject_ops);
+	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
+		atomic_set(&ffi->inject_ops, 0);
+		return true;
+	}
+	return false;
+}
+#endif
+
+static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
+					size_t size, gfp_t flags)
+{
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+	if (time_to_inject(sbi, FAULT_KMALLOC)) {
+		erofs_show_injection_info(FAULT_KMALLOC);
+		return NULL;
+	}
+#endif
+	return kmalloc(size, flags);
+}
+
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
 #define EROFS_I_SB(inode) ((struct erofs_sb_info *)(inode)->i_sb->s_fs_info)
 
 /* Mount flags set via mount options or defaults */
 #define EROFS_MOUNT_XATTR_USER		0x00000010
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
+#define EROFS_MOUNT_FAULT_INJECTION	0x00000040
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 4a8a266..701425f 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -129,6 +129,26 @@ static int superblock_read(struct super_block *sb)
 	return ret;
 }
 
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+char *erofs_fault_name[FAULT_MAX] = {
+	[FAULT_KMALLOC]		= "kmalloc",
+};
+
+static void erofs_build_fault_attr(struct erofs_sb_info *sbi,
+						unsigned int rate)
+{
+	struct erofs_fault_info *ffi = &sbi->fault_info;
+
+	if (rate) {
+		atomic_set(&ffi->inject_ops, 0);
+		ffi->inject_rate = rate;
+		ffi->inject_type = (1 << FAULT_MAX) - 1;
+	} else {
+		memset(ffi, 0, sizeof(struct erofs_fault_info));
+	}
+}
+#endif
+
 static void default_options(struct erofs_sb_info *sbi)
 {
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -145,6 +165,7 @@ enum {
 	Opt_nouser_xattr,
 	Opt_acl,
 	Opt_noacl,
+	Opt_fault_injection,
 	Opt_err
 };
 
@@ -153,6 +174,7 @@ enum {
 	{Opt_nouser_xattr, "nouser_xattr"},
 	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
+	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_err, NULL}
 };
 
@@ -160,6 +182,7 @@ static int parse_options(struct super_block *sb, char *options)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *p;
+	int arg = 0;
 
 	if (!options)
 		return 0;
@@ -204,6 +227,16 @@ static int parse_options(struct super_block *sb, char *options)
 			infoln("noacl options not supported");
 			break;
 #endif
+		case Opt_fault_injection:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+			erofs_build_fault_attr(EROFS_SB(sb), arg);
+			set_opt(EROFS_SB(sb), FAULT_INJECTION);
+#else
+			infoln("FAULT_INJECTION was not selected");
+#endif
+			break;
 		default:
 			errln("Unrecognized mount option \"%s\" "
 					"or missing value", p);
@@ -453,6 +486,11 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 	else
 		seq_puts(seq, ",noacl");
 #endif
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+	if (test_opt(sbi, FAULT_INJECTION))
+		seq_printf(seq, ",fault_injection=%u",
+				sbi->fault_info.inject_rate);
+#endif
 	return 0;
 }
 
-- 
1.9.1

