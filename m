Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7421902
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545973337;
	bh=XKV5OBswjcoUlEHNzPzPwkeCRzdC8ws0ndr0j2F/Jn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pk1oQOesKo4L3n47DdgTkCZpjV38/qFIObcGq8HU8aNuEPEbfTv0y762ITBrDzRIf
	 co8n3/vNer8VGcItucVuPDqIiQTPXyOj+NWUl4LGK1bx4auyohwtv+m7t6a/Zc9ij+
	 uI6Uz1jdExiXO8njSoCe1gh9/sSeUGiam72GymJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeL1FCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 00:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbeL1FCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 00:02:13 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF4E21901;
        Fri, 28 Dec 2018 05:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545973332;
        bh=XKV5OBswjcoUlEHNzPzPwkeCRzdC8ws0ndr0j2F/Jn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsipIGL3sf4EoCLcNRODelIlS8CwC/9f96aRFxLBlUHKD15zPqa5o0552ITVyk30g
         OKO1brlqTH2YL4e0NTNEbnfsA/Gx8cDxlSc/UbsBaDb9Dk1IB+njocdD20PPNFJsNL
         hks0s5X74JRS7gFDFTBhy63bAmU03xQytkAsEt8k=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] locking/lockdep: Provide enum lock_usage_bit mask names
Date:   Fri, 28 Dec 2018 06:02:01 +0100
Message-Id: <1545973321-24422-3-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545973321-24422-1-git-send-email-frederic@kernel.org>
References: <1545973321-24422-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes the code more self-explanatory and tells throughout the code
what magic number refers to:

* state (Hardirq/Softirq)
* direction (used in or enabled above state)
* read or write

We can even remove some comments that were compensating for the lack of
those constant names.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c           | 33 +++++++++++----------------------
 kernel/locking/lockdep_internals.h |  4 ++++
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 118a554..115d43e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1624,29 +1624,18 @@ static const char *state_rnames[] = {
 
 static inline const char *state_name(enum lock_usage_bit bit)
 {
-	return (bit & 1) ? state_rnames[bit >> 2] : state_names[bit >> 2];
+	return (bit & LOCK_USAGE_READ_MASK) ? state_rnames[bit >> 2] : state_names[bit >> 2];
 }
 
 static int exclusive_bit(int new_bit)
 {
-	/*
-	 * USED_IN
-	 * USED_IN_READ
-	 * ENABLED
-	 * ENABLED_READ
-	 *
-	 * bit 0 - write/read
-	 * bit 1 - used_in/enabled
-	 * bit 2+  state
-	 */
-
-	int state = new_bit & ~3;
-	int dir = new_bit & 2;
+	int state = new_bit & LOCK_USAGE_STATE_MASK;
+	int dir = new_bit & LOCK_USAGE_DIR_MASK;
 
 	/*
 	 * keep state, bit flip the direction and strip read.
 	 */
-	return state | (dir ^ 2);
+	return state | (dir ^ LOCK_USAGE_DIR_MASK);
 }
 
 static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
@@ -2662,8 +2651,8 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit new_bit)
 {
 	int excl_bit = exclusive_bit(new_bit);
-	int read = new_bit & 1;
-	int dir = new_bit & 2;
+	int read = new_bit & LOCK_USAGE_READ_MASK;
+	int dir = new_bit & LOCK_USAGE_DIR_MASK;
 
 	/*
 	 * mark USED_IN has to look forwards -- to ensure no dependency
@@ -2687,19 +2676,19 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~1)))
+			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
 	 * Check for read in write conflicts
 	 */
 	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + 1))
+		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + 1,
-				state_name(new_bit + 1)))
+			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
+				state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
 
@@ -2723,7 +2712,7 @@ mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
 		hlock = curr->held_locks + i;
 
 		if (hlock->read)
-			hlock_bit += 1; /* READ */
+			hlock_bit += LOCK_USAGE_READ_MASK;
 
 		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 88c847a..2ebb9d0 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -22,6 +22,10 @@ enum lock_usage_bit {
 	LOCK_USAGE_STATES
 };
 
+#define LOCK_USAGE_READ_MASK 1
+#define LOCK_USAGE_DIR_MASK  2
+#define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
+
 /*
  * Usage-state bitmasks:
  */
-- 
2.7.4

