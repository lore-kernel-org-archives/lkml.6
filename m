Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491DCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F0B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F0B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbeK0Xer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:34:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbeK0Xer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:34:47 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 962E8941D2A09;
        Tue, 27 Nov 2018 20:36:54 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Tue, 27 Nov 2018 20:36:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: introduce preen mode 2
Date:   Tue, 27 Nov 2018 20:36:35 +0800
Message-ID: <20181127123635.123303-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Michael reported:

after updating to f2fs-tools 1.12.0, a routine fsck of my file systems
took quite a while and output ten-thousands instances of the following
line:

> [FIX] (fsck_chk_inode_blk: 954)  --> Regular: 0xXYZ reset i_gc_failures from 0x1 to 0x00

The reason is that:

We start to support reseting .i_gc_failures's value to zero in fsck since
91bb7b21f740 ("f2fs-tools: fix to reset i_gc_failures offline"), this is
because if .i_gc_failures continues increasing and exceed threshold, it
can make f2fs break atomic_write semantics during GC, so I added that
patch to avoid such condition.

But the problem here is even .i_gc_failures's value is one which was
initialized duing inode creation by old kernel, and it never be increased
by GC flow, we will still trigger such fix in fsck. I think it's not
necessary.

As Jaegeuk suggested, we introduce a new preen mode 2 to handle such
condition:
  - 2: same as 0, but skip some checks for old kernel

Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reported-by: Michael Laß <bevan@bi-co.net>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 8 +++++++-
 fsck/fsck.h | 1 +
 fsck/main.c | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 970d150df5e8..bcda78142471 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -941,7 +941,13 @@ skip_blkcnt_fix:
 	}
 
 	i_gc_failures = le16_to_cpu(node_blk->i.i_gc_failures);
-	if (ftype == F2FS_FT_REG_FILE && i_gc_failures) {
+
+	/*
+	 * old kernel initialized i_gc_failures as 0x01, in preen mode 2,
+	 * let's skip repairing.
+	 */
+	if (ftype == F2FS_FT_REG_FILE && i_gc_failures &&
+		(c.preen_mode != PREEN_MODE_2 || i_gc_failures != 0x01)) {
 
 		DBG(1, "Regular Inode: 0x%x [%s] depth: %d\n\n",
 				le32_to_cpu(node_blk->footer.ino), en,
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b2227d2746d1..cbd6e9332d7c 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -21,6 +21,7 @@ struct quota_ctx;
 enum {
 	PREEN_MODE_0,
 	PREEN_MODE_1,
+	PREEN_MODE_2,
 	PREEN_MODE_MAX
 };
 
diff --git a/fsck/main.c b/fsck/main.c
index bb79f6e9fc89..65bdb5d5a401 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -216,6 +216,8 @@ void f2fs_parse_options(int argc, char *argv[])
 				/* preen mode has different levels:
 				 *  0: default level, the same as -a
 				 *  1: check meta
+				 *  2: same as 0, but will skip some
+				 *     check for old kernel
 				 */
 				if (optarg[0] == '-' || !is_digits(optarg) ||
 							optind == argc) {
@@ -230,7 +232,8 @@ void f2fs_parse_options(int argc, char *argv[])
 					c.preen_mode = PREEN_MODE_0;
 				else if (c.preen_mode >= PREEN_MODE_MAX)
 					c.preen_mode = PREEN_MODE_MAX - 1;
-				if (c.preen_mode == PREEN_MODE_0)
+				if (c.preen_mode == PREEN_MODE_0 ||
+					c.preen_mode == PREEN_MODE_2)
 					c.auto_fix = 1;
 				MSG(0, "Info: Fix the reported corruption in "
 					"preen mode %d\n", c.preen_mode);
-- 
2.18.0.rc1

