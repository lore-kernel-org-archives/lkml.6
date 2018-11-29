Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8320CC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398F21479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4398F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK3JtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:49:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3JtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:49:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94F7242BA0;
        Thu, 29 Nov 2018 22:41:56 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9C98604D0;
        Thu, 29 Nov 2018 22:41:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/lockdep: Annotate #else/#endif's that are far from #if
Date:   Thu, 29 Nov 2018 17:41:36 -0500
Message-Id: <1543531297-18349-2-git-send-email-longman@redhat.com>
In-Reply-To: <1543531297-18349-1-git-send-email-longman@redhat.com>
References: <1543531297-18349-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 29 Nov 2018 22:41:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some #else and #endif preprocessor directives that are hard
to see where the corresponding #if*'s are when they are more than a
page away. To make the code easier to read, those #else and #endif's
are now properly annotated.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1efada2..9e0d36b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -267,11 +267,11 @@ static void lock_release_holdtime(struct held_lock *hlock)
 	else
 		lock_time_inc(&stats->write_holdtime, holdtime);
 }
-#else
+#else /* CONFIG_LOCK_STAT */
 static inline void lock_release_holdtime(struct held_lock *hlock)
 {
 }
-#endif
+#endif /* CONFIG_LOCK_STAT */
 
 /*
  * We keep a global list of all lock classes. The list only grows,
@@ -1699,7 +1699,7 @@ static void inc_chains(void)
 	}
 }
 
-#else
+#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
 
 static inline int
 check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
@@ -1713,7 +1713,7 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
-#endif
+#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
 
 static void
 print_deadlock_scenario(struct held_lock *nxt,
@@ -2115,7 +2115,7 @@ static void print_collision(struct task_struct *curr,
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
 }
-#endif
+#endif /* CONFIG_DEBUG_LOCKDEP */
 
 /*
  * Checks whether the chain and the current held locks are consistent
@@ -2357,14 +2357,14 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 
 	return 1;
 }
-#else
+#else /* CONFIG_PROVE_LOCKING */
 static inline int validate_chain(struct task_struct *curr,
 	       	struct lockdep_map *lock, struct held_lock *hlock,
 		int chain_head, u64 chain_key)
 {
 	return 1;
 }
-#endif
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * We are building curr_chain_key incrementally, so double-check
@@ -4100,7 +4100,7 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(lock_acquired);
-#endif
+#endif /* CONFIG_LOCK_STAT */
 
 /*
  * Used by the testsuite, sanitize the validator state
-- 
1.8.3.1

