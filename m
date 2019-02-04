Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60654C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27767217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UGKNErGQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MuzqncBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfBDIHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:07:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfBDIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:07:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C40560908; Mon,  4 Feb 2019 08:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549267627;
        bh=S9SIdrxB6OY0XToSAtvdaUB+qTct87uknQf9VVQtSG8=;
        h=From:To:Cc:Subject:Date:From;
        b=UGKNErGQhPAxLdZgrpRJe+sFsHKiKYhFFM0hVeAMt//OVSTudu+GYfUSPBXtlDa6K
         F9DnZctEesrSJKznEkrSNqSKeeE2p+Ag/L5I+Ow+AsW4V3dRtuLQVUoTjz6grW2kBz
         dux1KGVshOva38abBwxheOcS3GrqYHTK4+asrYcs=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D8676032C;
        Mon,  4 Feb 2019 08:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549267626;
        bh=S9SIdrxB6OY0XToSAtvdaUB+qTct87uknQf9VVQtSG8=;
        h=From:To:Cc:Subject:Date:From;
        b=MuzqncBTuqw8GNMvyw05GU+svBhlg4fNorHa8FcLXiS1/jKqfPS5aR53veQgf4KWx
         sUBIsbi4PFeybu+dOjZAFpMreQ5aayNYVKd1UEvmubs3+MHHRdpKHxUWMbrDgqo39S
         tsQDWiG7SpiXzp7cgAHbIbWmfALpKKS/2MW01dos=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D8676032C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: do not use mutex lock in atomic context
Date:   Mon,  4 Feb 2019 13:36:53 +0530
Message-Id: <1549267613-9288-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warning coming because of using mutex lock in atomic context.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:98
in_atomic(): 1, irqs_disabled(): 0, pid: 585, name: sh
Preemption disabled at: __radix_tree_preload+0x28/0x130
Call trace:
 dump_backtrace+0x0/0x2b4
 show_stack+0x20/0x28
 dump_stack+0xa8/0xe0
 ___might_sleep+0x144/0x194
 __might_sleep+0x58/0x8c
 mutex_lock+0x2c/0x48
 f2fs_trace_pid+0x88/0x14c
 f2fs_set_node_page_dirty+0xd0/0x184

Do not use f2fs_radix_tree_insert() to avoid doing cond_resched() with
spin_lock() acquired.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/trace.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index ce2a5eb..d0ab533 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -14,7 +14,7 @@
 #include "trace.h"
 
 static RADIX_TREE(pids, GFP_ATOMIC);
-static struct mutex pids_lock;
+static spinlock_t pids_lock;
 static struct last_io_info last_io;
 
 static inline void __print_last_io(void)
@@ -58,23 +58,29 @@ void f2fs_trace_pid(struct page *page)
 
 	set_page_private(page, (unsigned long)pid);
 
+retry:
 	if (radix_tree_preload(GFP_NOFS))
 		return;
 
-	mutex_lock(&pids_lock);
+	spin_lock(&pids_lock);
 	p = radix_tree_lookup(&pids, pid);
 	if (p == current)
 		goto out;
 	if (p)
 		radix_tree_delete(&pids, pid);
 
-	f2fs_radix_tree_insert(&pids, pid, current);
+	if (radix_tree_insert(&pids, pid, current)) {
+		spin_unlock(&pids_lock);
+		radix_tree_preload_end();
+		cond_resched();
+		goto retry;
+	}
 
 	trace_printk("%3x:%3x %4x %-16s\n",
 			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
 			pid, current->comm);
 out:
-	mutex_unlock(&pids_lock);
+	spin_unlock(&pids_lock);
 	radix_tree_preload_end();
 }
 
@@ -119,7 +125,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 
 void f2fs_build_trace_ios(void)
 {
-	mutex_init(&pids_lock);
+	spin_lock_init(&pids_lock);
 }
 
 #define PIDVEC_SIZE	128
@@ -147,7 +153,7 @@ void f2fs_destroy_trace_ios(void)
 	pid_t next_pid = 0;
 	unsigned int found;
 
-	mutex_lock(&pids_lock);
+	spin_lock(&pids_lock);
 	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
 		unsigned idx;
 
@@ -155,5 +161,5 @@ void f2fs_destroy_trace_ios(void)
 		for (idx = 0; idx < found; idx++)
 			radix_tree_delete(&pids, pid[idx]);
 	}
-	mutex_unlock(&pids_lock);
+	spin_unlock(&pids_lock);
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

