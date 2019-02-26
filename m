Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF2AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DFB20842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfBZLBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:01:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfBZLBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:01:33 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A75D99A98E5EFC4FDC7D;
        Tue, 26 Feb 2019 19:01:31 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Feb 2019 19:01:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: trace f2fs_ioc_shutdown
Date:   Tue, 26 Feb 2019 19:01:15 +0800
Message-ID: <20190226110116.36759-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports to trace f2fs_ioc_shutdown.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c              |  3 +++
 include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2e7ae5974633..4b852cab21f8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1993,6 +1993,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 out:
 	if (in != F2FS_GOING_DOWN_FULLSYNC)
 		mnt_drop_write_file(filp);
+
+	trace_f2fs_shutdown(sbi, in, ret);
+
 	return ret;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index bbbfc9bc0686..4683ee10fe61 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -149,6 +149,14 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
 		{ CP_RECOVER_DIR,	"dir needs recovery" })
 
+#define show_shutdown_mode(type)					\
+	__print_symbolic(type,						\
+		{ F2FS_GOING_DOWN_FULLSYNC,	"full sync" },		\
+		{ F2FS_GOING_DOWN_METASYNC,	"meta sync" },		\
+		{ F2FS_GOING_DOWN_NOSYNC,	"no sync" },		\
+		{ F2FS_GOING_DOWN_METAFLUSH,	"meta flush" },		\
+		{ F2FS_GOING_DOWN_NEED_FSCK,	"need fsck" })
+
 struct f2fs_sb_info;
 struct f2fs_io_info;
 struct extent_info;
@@ -1619,6 +1627,30 @@ DEFINE_EVENT(f2fs_sync_dirty_inodes, f2fs_sync_dirty_inodes_exit,
 	TP_ARGS(sb, type, count)
 );
 
+TRACE_EVENT(f2fs_shutdown,
+
+	TP_PROTO(struct f2fs_sb_info *sbi, unsigned int mode, int ret),
+
+	TP_ARGS(sbi, mode, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(unsigned int, mode)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sbi->sb->s_dev;
+		__entry->mode = mode;
+		__entry->ret = ret;
+	),
+
+	TP_printk("dev = (%d,%d), mode: %s, ret:%d",
+		show_dev(__entry->dev),
+		show_shutdown_mode(__entry->mode),
+		__entry->ret)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.18.0.rc1

