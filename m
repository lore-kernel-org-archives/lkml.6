Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A61C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA33B2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAnSL5qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA33B2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeKOKou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeKOKou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:44:50 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACAF2080D;
        Thu, 15 Nov 2018 00:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542242355;
        bh=0MKDlrXw5jQ3zo77QBVDQY8pkmh9w2KwKHWT542yzr4=;
        h=From:To:Cc:Subject:Date:From;
        b=sAnSL5qRJEo8fuVo+PcZItbQIknGEwZ/DtSmYfVr209BgILblpG0Z1F0St/JyGpfg
         52OqKS5J2xc+X236XFuIer9mqkXMD3G+YkxQoXKunZXyKCjB44KjOwH8FNH6wGXAVB
         9zqtqoNX4cBWj4KO4As0nQcDsR/6tBvqUJuKX0u8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] userfaultfd: convert userfaultfd_ctx::refcount to refcount_t
Date:   Wed, 14 Nov 2018 16:36:41 -0800
Message-Id: <20181115003641.62828-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Reference counters should use refcount_t rather than atomic_t, since the
refcount_t implementation can prevent overflows, reducing the
exploitability of reference leak bugs.  userfaultfd_ctx::refcount is a
reference counter with the usual semantics, so convert it to refcount_t.

Note: I replaced the BUG() on incrementing a 0 refcount with just
refcount_inc(), since already part of the semantics of refcount_t is
that that incrementing a 0 refcount is not allowed; with
CONFIG_REFCOUNT_FULL, refcount_inc() checks for it and warns.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/userfaultfd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 356d2b8568c14..8375faac2790d 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -53,7 +53,7 @@ struct userfaultfd_ctx {
 	/* a refile sequence protected by fault_pending_wqh lock */
 	struct seqcount refile_seq;
 	/* pseudo fd refcounting */
-	atomic_t refcount;
+	refcount_t refcount;
 	/* userfaultfd syscall flags */
 	unsigned int flags;
 	/* features requested from the userspace */
@@ -140,8 +140,7 @@ static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
  */
 static void userfaultfd_ctx_get(struct userfaultfd_ctx *ctx)
 {
-	if (!atomic_inc_not_zero(&ctx->refcount))
-		BUG();
+	refcount_inc(&ctx->refcount);
 }
 
 /**
@@ -154,7 +153,7 @@ static void userfaultfd_ctx_get(struct userfaultfd_ctx *ctx)
  */
 static void userfaultfd_ctx_put(struct userfaultfd_ctx *ctx)
 {
-	if (atomic_dec_and_test(&ctx->refcount)) {
+	if (refcount_dec_and_test(&ctx->refcount)) {
 		VM_BUG_ON(spin_is_locked(&ctx->fault_pending_wqh.lock));
 		VM_BUG_ON(waitqueue_active(&ctx->fault_pending_wqh));
 		VM_BUG_ON(spin_is_locked(&ctx->fault_wqh.lock));
@@ -686,7 +685,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 			return -ENOMEM;
 		}
 
-		atomic_set(&ctx->refcount, 1);
+		refcount_set(&ctx->refcount, 1);
 		ctx->flags = octx->flags;
 		ctx->state = UFFD_STATE_RUNNING;
 		ctx->features = octx->features;
@@ -1911,7 +1910,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	if (!ctx)
 		return -ENOMEM;
 
-	atomic_set(&ctx->refcount, 1);
+	refcount_set(&ctx->refcount, 1);
 	ctx->flags = flags;
 	ctx->features = 0;
 	ctx->state = UFFD_STATE_WAIT_API;
-- 
2.19.1.930.g4563a0d9d0-goog

