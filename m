Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A5AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E3521902
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545973341;
	bh=2EvVsJwT7PohD2FVSHOn2LkR9g8Q9EYeBe1XKtulr0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KOYU0HXOGxbwHId32K5NV6edrk33NthDyfTtnu0lXyYi2eujIeQRdu9DfXUISDKWR
	 mNNt+lLw/wTuvg9ZqJf+w7bcZr4/90b+9ncjJVJcuVGif+WE5rFchfMm4SNoZ21l7x
	 uuU/HXMjcWhd8UT0fDHzvLjbovq4eGjA26BYewow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeL1FCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 00:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeL1FCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 00:02:11 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6225218FE;
        Fri, 28 Dec 2018 05:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545973330;
        bh=2EvVsJwT7PohD2FVSHOn2LkR9g8Q9EYeBe1XKtulr0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMmUJsPEYh+D1REQSmkq04YOdBrDMY889jMGQuDpCzOBAnc7faOUwlS4HexSPvqwd
         zUqWGwM9bFDe5c/UmNR2AsSgpAcDMFqQYwzDhccdoNV29ON+jM1Lz4sTosTw6BjVhO
         wg3EtFrxzJYSsQ+OqhKGPsPN+tHPcq/e+U5WpCqI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] locking/lockdep: Simplify mark_held_locks()
Date:   Fri, 28 Dec 2018 06:02:00 +0100
Message-Id: <1545973321-24422-2-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545973321-24422-1-git-send-email-frederic@kernel.org>
References: <1545973321-24422-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum mark_type appears a bit artificial here. We can directly pass
the base enum lock_usage_bit value to mark_held_locks(). All we need
then is to add the read index for each lock if necessary. It makes the
code clearer.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5c837a5..118a554 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2709,35 +2709,28 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-enum mark_type {
-#define LOCKDEP_STATE(__STATE)	__STATE,
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
 /*
  * Mark all held locks with a usage bit:
  */
 static int
-mark_held_locks(struct task_struct *curr, enum mark_type mark)
+mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
 {
-	enum lock_usage_bit usage_bit;
 	struct held_lock *hlock;
 	int i;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
+		enum lock_usage_bit hlock_bit = base_bit;
 		hlock = curr->held_locks + i;
 
-		usage_bit = 2 + (mark << 2); /* ENABLED */
 		if (hlock->read)
-			usage_bit += 1; /* READ */
+			hlock_bit += 1; /* READ */
 
-		BUG_ON(usage_bit >= LOCK_USAGE_STATES);
+		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
 
 		if (!hlock->check)
 			continue;
 
-		if (!mark_lock(curr, hlock, usage_bit))
+		if (!mark_lock(curr, hlock, hlock_bit))
 			return 0;
 	}
 
@@ -2758,7 +2751,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 * We are going to turn hardirqs on, so set the
 	 * usage bit for all held locks:
 	 */
-	if (!mark_held_locks(curr, HARDIRQ))
+	if (!mark_held_locks(curr, LOCK_ENABLED_HARDIRQ))
 		return;
 	/*
 	 * If we have softirqs enabled, then set the usage
@@ -2766,7 +2759,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 * this bit from being set before)
 	 */
 	if (curr->softirqs_enabled)
-		if (!mark_held_locks(curr, SOFTIRQ))
+		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
 			return;
 
 	curr->hardirq_enable_ip = ip;
@@ -2880,7 +2873,7 @@ void trace_softirqs_on(unsigned long ip)
 	 * enabled too:
 	 */
 	if (curr->hardirqs_enabled)
-		mark_held_locks(curr, SOFTIRQ);
+		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
 	current->lockdep_recursion = 0;
 }
 
-- 
2.7.4

