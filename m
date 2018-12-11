Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B25C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD3420851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="FWYWJW0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD3420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeLKWOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:14:16 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:49095 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLKWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=JwZMCMgn78abkOFENRU//jXfCeqdU/Sl/6xQSeD9x5A=; b=FWYWJW0i3zvV
        umacMLC5rzhiUd0Jf4P1n3bXzue3U7h465e8cTaQe+YJSZRT19T4d6IsBRsUbrV6UOw/hKE6uwgWe
        iolxXIt40vdD1MlbDgPj5Tn2DdgFLqlNf/l33lL4x2Oz4YVVm2tye7LLhwVsdOuhuNKXcEV9NjU6A
        4Hrdaohfwdwz/4QcbUgstSjrpuQs35gSM2OOOOYiRGvRWOOvwhOFcDa2kGD1Eh88gcH56uTdJuRYf
        DhiVknBwzxwdDR8+xfK7+ByIe2Aoq9LKDlZ9TElwOsnOzW6P/pCGtGgw7EKKyWKZYKzRxvPtlDbdX
        4R/WpxLa5bRspwkC6RG1bg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWqHt-0005M7-1A; Tue, 11 Dec 2018 23:13:57 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 3AD86C0718;
        Tue, 11 Dec 2018 23:13:55 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 10/15] locking/lockdep: Reuse lock chains that have been freed
Date:   Tue, 11 Dec 2018 14:13:16 -0800
Message-Id: <20181211221321.196536-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181211221321.196536-1-bvanassche@acm.org>
References: <20181211221321.196536-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00687719624287)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vnfMhM1+UrfQSDJlMM9Kvd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORqR5WMxx0chtw61PzHp
 /s1ZSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/lcBJ
 DmoxYxZqr5EVgTOQJPtZblmQ0+ehzpa5Z4MWZxkx3D0EfhtC7ni2dUswWTi4X1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2a65z9c+BiwuOZk3tq4BixfE4fVLz9bC8BKm8kIsu/
 qIPYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch introduced a lock chain leak. Fix that leak by reusing
lock chains that have been freed.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 48 +++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cdab3831beb2..8ba326c68253 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -299,6 +299,7 @@ static struct pending_free {
 	struct rcu_head	 rcu_head;
 	bool		 scheduled;
 	DECLARE_BITMAP(list_entries_being_freed, MAX_LOCKDEP_ENTRIES);
+	DECLARE_BITMAP(lock_chains_being_freed, MAX_LOCKDEP_CHAINS);
 } pending_free[2];
 static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);
 
@@ -2092,8 +2093,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 	return 0;
 }
 
-static unsigned long nr_lock_chains;
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
+static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 
@@ -2232,12 +2233,25 @@ static int check_no_collision(struct task_struct *curr,
  */
 long lockdep_next_lockchain(long i)
 {
-	return i + 1 < nr_lock_chains ? i + 1 : -2;
+	i = find_next_bit(lock_chains_in_use, ARRAY_SIZE(lock_chains), i + 1);
+	return i < ARRAY_SIZE(lock_chains) ? i : -2;
 }
 
 unsigned long lock_chain_count(void)
 {
-	return nr_lock_chains;
+	return bitmap_weight(lock_chains_in_use, ARRAY_SIZE(lock_chains));
+}
+
+/* Must be called with the graph lock held. */
+static struct lock_chain *alloc_lock_chain(void)
+{
+	int idx = find_first_zero_bit(lock_chains_in_use,
+				      ARRAY_SIZE(lock_chains));
+
+	if (unlikely(idx >= ARRAY_SIZE(lock_chains)))
+		return NULL;
+	__set_bit(idx, lock_chains_in_use);
+	return lock_chains + idx;
 }
 
 /*
@@ -2269,7 +2283,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return 0;
 
-	if (unlikely(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+	chain = alloc_lock_chain();
+	if (!chain) {
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
@@ -2277,7 +2292,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 		dump_stack();
 		return 0;
 	}
-	chain = lock_chains + nr_lock_chains++;
 	chain->chain_key = chain_key;
 	chain->irq_context = hlock->irq_context;
 	i = get_first_held_lock(curr, hlock);
@@ -4214,7 +4228,8 @@ void lockdep_reset(void)
 }
 
 /* Remove a class from a lock chain. Must be called with the graph lock held. */
-static void remove_class_from_lock_chain(struct lock_chain *chain,
+static void remove_class_from_lock_chain(struct pending_free *pf,
+					 struct lock_chain *chain,
 					 struct lock_class *class)
 {
 #ifdef CONFIG_PROVE_LOCKING
@@ -4252,6 +4267,7 @@ static void remove_class_from_lock_chain(struct lock_chain *chain,
 	 * hlist_for_each_entry_rcu() loop is safe.
 	 */
 	hlist_del_rcu(&chain->entry);
+	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
 	if (chain->depth == 0)
 		return;
 	/*
@@ -4260,22 +4276,19 @@ static void remove_class_from_lock_chain(struct lock_chain *chain,
 	 */
 	if (lookup_chain_cache(chain_key))
 		return;
-	if (WARN_ON_ONCE(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+	new_chain = alloc_lock_chain();
+	if (WARN_ON_ONCE(!new_chain)) {
 		debug_locks_off();
 		return;
 	}
-	/*
-	 * Leak *chain because it is not safe to reinsert it before an RCU
-	 * grace period has expired.
-	 */
-	new_chain = lock_chains + nr_lock_chains++;
 	*new_chain = *chain;
 	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
 #endif
 }
 
 /* Must be called with the graph lock held. */
-static void remove_class_from_lock_chains(struct lock_class *class)
+static void remove_class_from_lock_chains(struct pending_free *pf,
+					  struct lock_class *class)
 {
 	struct lock_chain *chain;
 	struct hlist_head *head;
@@ -4284,7 +4297,7 @@ static void remove_class_from_lock_chains(struct lock_class *class)
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
 		hlist_for_each_entry_rcu(chain, head, entry) {
-			remove_class_from_lock_chain(chain, class);
+			remove_class_from_lock_chain(pf, chain, class);
 		}
 	}
 }
@@ -4324,7 +4337,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 			  class->name);
 	}
 
-	remove_class_from_lock_chains(class);
+	remove_class_from_lock_chains(pf, class);
 }
 
 static void reinit_class(struct lock_class *class)
@@ -4373,6 +4386,11 @@ static void free_zapped_classes(struct rcu_head *ch)
 	bitmap_andnot(list_entries_in_use, list_entries_in_use,
 		      pf->list_entries_being_freed, ARRAY_SIZE(list_entries));
 	bitmap_clear(pf->list_entries_being_freed, 0, ARRAY_SIZE(list_entries));
+#ifdef CONFIG_PROVE_LOCKING
+	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
+		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
+	bitmap_clear(pf->lock_chains_being_freed, 0, ARRAY_SIZE(lock_chains));
+#endif
 	graph_unlock();
 restore_irqs:
 	raw_local_irq_restore(flags);
-- 
2.20.0.rc2.403.gdbc3b29805-goog

