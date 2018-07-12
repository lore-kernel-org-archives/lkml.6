Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C2DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DCA208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DCA208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeGLLLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:24 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58372 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeGLLLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A16CC18188FA1;
        Thu, 12 Jul 2018 13:02:19 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/5] ubifs: Rework ubifs_assert()
Date:   Thu, 12 Jul 2018 13:01:58 +0200
Message-Id: <20180712110200.13054-4-richard@nod.at>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712110200.13054-1-richard@nod.at>
References: <20180712110200.13054-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With having access to struct ubifs_info in ubifs_assert() we can
give more information when an assert is failing.
By using ubifs_err() we can tell which UBIFS instance failed.

Also multiple actions can be taken now.
We support:
 - report: This is what UBIFS did so far, just report the failure and go
   on.
 - read-only: Switch to read-only mode.
 - panic: shoot the kernel in the head.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/debug.c | 22 ++++++++++++++++++++++
 fs/ubifs/debug.h | 10 ++++++----
 fs/ubifs/ubifs.h | 14 ++++++++++++++
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 1a626484f8ae..564e330d05b1 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -3081,6 +3081,28 @@ void dbg_debugfs_exit(void)
 		debugfs_remove_recursive(dfs_rootdir);
 }
 
+void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
+			 const char *file, int line)
+{
+	ubifs_err(c, "UBIFS assert failed: %s, in %s:%u", expr, file, line);
+
+	switch (c->assert_action) {
+		case ASSACT_PANIC:
+		BUG();
+		break;
+
+		case ASSACT_RO:
+		ubifs_ro_mode(c, -EINVAL);
+		break;
+
+		case ASSACT_REPORT:
+		default:
+		dump_stack();
+		break;
+
+	}
+}
+
 /**
  * ubifs_debugging_init - initialize UBIFS debugging.
  * @c: UBIFS file-system description object
diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
index 981a3fa081f3..64c6977c189b 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -148,18 +148,20 @@ struct ubifs_global_debug_info {
 	unsigned int tst_rcvry:1;
 };
 
+void ubifs_assert_failed(struct ubifs_info *c, const char *expr,
+	const char *file, int line);
+
 #define ubifs_assert(c, expr) do {                                             \
 	if (unlikely(!(expr))) {                                               \
-		pr_crit("UBIFS assert failed in %s at %u (pid %d)\n",          \
-		       __func__, __LINE__, current->pid);                      \
-		dump_stack();                                                  \
+		ubifs_assert_failed((struct ubifs_info *)c, #expr, __FILE__,   \
+		 __LINE__);                                                    \
 	}                                                                      \
 } while (0)
 
 #define ubifs_assert_cmt_locked(c) do {                                        \
 	if (unlikely(down_write_trylock(&(c)->commit_sem))) {                  \
 		up_write(&(c)->commit_sem);                                    \
-		pr_crit("commit lock is not locked!\n");                       \
+		ubifs_err(c, "commit lock is not locked!\n");                  \
 		ubifs_assert(c, 0);                                            \
 	}                                                                      \
 } while (0)
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 5bdf5ba146cb..b01dc6bb1f43 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -258,6 +258,18 @@ enum {
 	LEB_RETAINED,
 };
 
+/*
+ * Action taken upon a failed ubifs_assert().
+ * @ASSACT_REPORT: just report the failed assertion
+ * @ASSACT_RO: switch to read-only mode
+ * @ASSACT_PANIC: call BUG() and possible panic the kernel
+ */
+enum {
+	ASSACT_REPORT = 0,
+	ASSACT_RO,
+	ASSACT_PANIC,
+};
+
 /**
  * struct ubifs_old_idx - index node obsoleted since last commit start.
  * @rb: rb-tree node
@@ -1015,6 +1027,7 @@ struct ubifs_debug_info;
  * @bulk_read: enable bulk-reads
  * @default_compr: default compression algorithm (%UBIFS_COMPR_LZO, etc)
  * @rw_incompat: the media is not R/W compatible
+ * @assert_action: action to take when a ubifs_assert() fails
  *
  * @tnc_mutex: protects the Tree Node Cache (TNC), @zroot, @cnext, @enext, and
  *             @calc_idx_sz
@@ -1256,6 +1269,7 @@ struct ubifs_info {
 	unsigned int bulk_read:1;
 	unsigned int default_compr:2;
 	unsigned int rw_incompat:1;
+	unsigned int assert_action:2;
 
 	struct mutex tnc_mutex;
 	struct ubifs_zbranch zroot;
-- 
2.18.0

