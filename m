Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E60DC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A66F20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A66F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeJCDFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64411 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJCDFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:05:46 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB70330014DC;
        Tue,  2 Oct 2018 20:20:41 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24C94308BDA0;
        Tue,  2 Oct 2018 20:20:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/5] locking/lockdep: Remove add_chain_cache_classes()
Date:   Tue,  2 Oct 2018 16:19:16 -0400
Message-Id: <1538511560-10090-2-git-send-email-longman@redhat.com>
In-Reply-To: <1538511560-10090-1-git-send-email-longman@redhat.com>
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 02 Oct 2018 20:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline function add_chain_cache_classes() is defined, but has no
caller. Just remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 70 ----------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dd13f865ad40..8f9de7cd11ab 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2147,76 +2147,6 @@ static int check_no_collision(struct task_struct *curr,
 	return 1;
 }
 
-/*
- * This is for building a chain between just two different classes,
- * instead of adding a new hlock upon current, which is done by
- * add_chain_cache().
- *
- * This can be called in any context with two classes, while
- * add_chain_cache() must be done within the lock owener's context
- * since it uses hlock which might be racy in another context.
- */
-static inline int add_chain_cache_classes(unsigned int prev,
-					  unsigned int next,
-					  unsigned int irq_context,
-					  u64 chain_key)
-{
-	struct hlist_head *hash_head = chainhashentry(chain_key);
-	struct lock_chain *chain;
-
-	/*
-	 * Allocate a new chain entry from the static array, and add
-	 * it to the hash:
-	 */
-
-	/*
-	 * We might need to take the graph lock, ensure we've got IRQs
-	 * disabled to make this an IRQ-safe lock.. for recursion reasons
-	 * lockdep won't complain about its own locking errors.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return 0;
-
-	if (unlikely(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
-		dump_stack();
-		return 0;
-	}
-
-	chain = lock_chains + nr_lock_chains++;
-	chain->chain_key = chain_key;
-	chain->irq_context = irq_context;
-	chain->depth = 2;
-	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
-		chain->base = nr_chain_hlocks;
-		nr_chain_hlocks += chain->depth;
-		chain_hlocks[chain->base] = prev - 1;
-		chain_hlocks[chain->base + 1] = next -1;
-	}
-#ifdef CONFIG_DEBUG_LOCKDEP
-	/*
-	 * Important for check_no_collision().
-	 */
-	else {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
-		dump_stack();
-		return 0;
-	}
-#endif
-
-	hlist_add_head_rcu(&chain->entry, hash_head);
-	debug_atomic_inc(chain_lookup_misses);
-	inc_chains();
-
-	return 1;
-}
-
 /*
  * Adds a dependency chain into chain hashtable. And must be called with
  * graph_lock held.
-- 
2.18.0

