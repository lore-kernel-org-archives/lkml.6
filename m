Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754179AbeEHDjp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:39:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753846AbeEHDjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:39:44 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid race during access gc_thread pointer
Date: Tue, 8 May 2018 11:39:21 +0800
Message-ID: <20180508033921.21703-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thread A			Thread B
- f2fs_remount
 - stop_gc_thread
				- f2fs_sbi_store
   sbi->gc_thread = NULL;
				  access sbi->gc_thread->gc_*

Previously, we allocate memory for sbi->gc_thread based on background
gc thread mount option, the memory can be released if we turn off
that mount option, but still there are several places access gc_thread
pointer without considering race condition, result in NULL point
dereference.

In order to fix this issue, use sb->s_umount to exclude those operations.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f3c3fb4cbb0d..0aec4db7fa02 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -179,6 +179,7 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	unsigned long t;
 	unsigned int *ui;
 	ssize_t ret;
+	bool gc_entry = (a->struct_type == GC_THREAD);
 
 	ptr = __struct_ptr(sbi, a->struct_type);
 	if (!ptr)
@@ -277,8 +278,14 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (gc_entry)
+		down_read(&sbi->sb->s_umount);
+
 	*ui = t;
 
+	if (gc_entry)
+		up_read(&sbi->sb->s_umount);
+
 	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
 		f2fs_reset_iostat(sbi);
 	return count;
-- 
2.17.0.391.g1f1cddd558b5
