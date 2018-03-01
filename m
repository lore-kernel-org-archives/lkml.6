Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032682AbeCAPlD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032669AbeCAPlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:41:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EE120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to restore old mount option in ->remount_fs
Date: Thu,  1 Mar 2018 23:40:32 +0800
Message-Id: <20180301154032.6325-2-chao@kernel.org>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20180301154032.6325-1-chao@kernel.org>
References: <20180301154032.6325-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patch fixes to restore old mount option once we encounter failure
in ->remount_fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d8357ba19159..36c5e582c1f2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1340,6 +1340,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
 	int old_whint_mode = sbi->whint_mode;
 	int old_alloc_mode = sbi->alloc_mode;
+	int old_inline_xattr_size = sbi->inline_xattr_size;
+	block_t old_root_reserved_blocks = sbi->root_reserved_blocks;
+	kuid_t old_resuid = sbi->s_resuid;
+	kgid_t old_resgid = sbi->s_resgid;
+	int old_write_io_size_bits = sbi->write_io_size_bits;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct f2fs_fault_info ffi = sbi->fault_info;
 #endif
@@ -1489,6 +1494,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		sbi->s_qf_names[i] = s_qf_names[i];
 	}
 #endif
+	sbi->write_io_size_bits = old_write_io_size_bits;
+	sbi->s_resgid = old_resgid;
+	sbi->s_resuid = old_resuid;
+	sbi->root_reserved_blocks = old_root_reserved_blocks;
+	sbi->inline_xattr_size = old_inline_xattr_size;
 	sbi->alloc_mode = old_alloc_mode;
 	sbi->whint_mode = old_whint_mode;
 	sbi->mount_opt = org_mount_opt;
-- 
2.14.1.145.gb3622a4ee
