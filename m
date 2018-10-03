Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F07C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388522098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388522098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJCOTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:19:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:19:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w937VwFZ2264506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 00:31:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w937Vwdc2264503;
        Wed, 3 Oct 2018 00:31:58 -0700
Date:   Wed, 3 Oct 2018 00:31:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-ce52a18db45842f5b992851a552bd7f6acb2241b@git.kernel.org>
Cc:     will.deacon@arm.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        longman@redhat.com, linux-kernel@vger.kernel.org,
        a.p.zijlstra@chello.nl, peterz@infradead.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
          will.deacon@arm.com, longman@redhat.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          a.p.zijlstra@chello.nl, mingo@kernel.org
In-Reply-To: <1538511560-10090-4-git-send-email-longman@redhat.com>
References: <1538511560-10090-4-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Add a faster path in
 __lock_release()
Git-Commit-ID: ce52a18db45842f5b992851a552bd7f6acb2241b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ce52a18db45842f5b992851a552bd7f6acb2241b
Gitweb:     https://git.kernel.org/tip/ce52a18db45842f5b992851a552bd7f6acb2241b
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 2 Oct 2018 16:19:18 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Oct 2018 08:46:03 +0200

locking/lockdep: Add a faster path in __lock_release()

When __lock_release() is called, the most likely unlock scenario is
on the innermost lock in the chain.  In this case, we can skip some of
the checks and provide a faster path to completion.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1538511560-10090-4-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a5d7db558928..511d30f88bce 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3626,6 +3626,13 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
 
+	/*
+	 * The most likely case is when the unlock is on the innermost
+	 * lock. In this case, we are done!
+	 */
+	if (i == depth-1)
+		return 1;
+
 	if (reacquire_held_locks(curr, depth, i + 1))
 		return 0;
 
@@ -3633,10 +3640,14 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 	 * We had N bottles of beer on the wall, we drank one, but now
 	 * there's not N-1 bottles of beer left on the wall...
 	 */
-	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1))
-		return 0;
+	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth-1);
 
-	return 1;
+	/*
+	 * Since reacquire_held_locks() would have called check_chain_key()
+	 * indirectly via __lock_acquire(), we don't need to do it again
+	 * on return.
+	 */
+	return 0;
 }
 
 static int __lock_is_held(const struct lockdep_map *lock, int read)
