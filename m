Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A59C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6852C206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391994AbfAPK1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:27:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:31384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbfAPK1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 02:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="118910341"
Received: from elena-thinkpad-x230.fi.intel.com ([10.237.68.34])
  by orsmga003.jf.intel.com with ESMTP; 16 Jan 2019 02:27:20 -0800
From:   Elena Reshetova <elena.reshetova@intel.com>
To:     akpm@linux-foundation.org
Cc:     aryabinin@virtuozzo.com, anders.roxell@linaro.org,
        mark.rutland@arm.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        peterz@infradead.org, Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH] kcov: convert kcov.refcount to refcount_t
Date:   Wed, 16 Jan 2019 12:27:09 +0200
Message-Id: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_t variables are currently used to implement reference
counters with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable kcov.refcount is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in lib/refcount.c
have different memory ordering guarantees than their atomic
counterparts.
The full comparison can be seen in
https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
in state to be merged to the documentation tree.
Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in
some rare cases it might matter.
Please double check that you don't have some undocumented
memory guarantees for this variable usage.

For the kcov.refcount it might make a difference
in following places:
 - kcov_put(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and control dependency on success
   vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 kernel/kcov.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index c2277db..051e86e 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -20,6 +20,7 @@
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
 #include <linux/kcov.h>
+#include <linux/refcount.h>
 #include <asm/setup.h>
 
 /* Number of 64-bit words written per one comparison: */
@@ -44,7 +45,7 @@ struct kcov {
 	 *  - opened file descriptor
 	 *  - task with enabled coverage (we can't unwire it from another task)
 	 */
-	atomic_t		refcount;
+	refcount_t		refcount;
 	/* The lock protects mode, size, area and t. */
 	spinlock_t		lock;
 	enum kcov_mode		mode;
@@ -228,12 +229,12 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
 
 static void kcov_get(struct kcov *kcov)
 {
-	atomic_inc(&kcov->refcount);
+	refcount_inc(&kcov->refcount);
 }
 
 static void kcov_put(struct kcov *kcov)
 {
-	if (atomic_dec_and_test(&kcov->refcount)) {
+	if (refcount_dec_and_test(&kcov->refcount)) {
 		vfree(kcov->area);
 		kfree(kcov);
 	}
@@ -312,7 +313,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
 	if (!kcov)
 		return -ENOMEM;
 	kcov->mode = KCOV_MODE_DISABLED;
-	atomic_set(&kcov->refcount, 1);
+	refcount_set(&kcov->refcount, 1);
 	spin_lock_init(&kcov->lock);
 	filep->private_data = kcov;
 	return nonseekable_open(inode, filep);
-- 
2.7.4

