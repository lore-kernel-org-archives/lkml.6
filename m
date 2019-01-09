Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE87DC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80530206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="m9egRaot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfAIVED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:04:03 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:60897 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfAIVCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=PghefKGP1xLj4fm0v32hMCl3oD4uxTLWTkiRCXFqYyY=; b=m9egRaotRHB+
        mugxL09ZWUTFML0Xh/qZ51pQsrj6Xg1IkBmOZWTkD8f24OmPfeApPkKdIq/TAD6XL2pV4SzG17L5F
        Zn3pOdRTUI3bRYsfOXy8LO2zpZdmztqJqrTyPHqyz4r0aFZ1t4amLrtTh1RgtQioZNt40fiQA52eL
        EYhfO1CmS2b5LLYZUDwfT1KJJobAj410B/JsqgMOvpfuECuP3WWVFWBEwYWMJQhiAECTE8ffUoUCu
        bmAhllXmdKFsxgVc6hVj4UMVL3lJ4/9TQBacfeRGGaqZg0wvNGn3qePhtQg4Tbn0cxItDwZTwvxRU
        Vh2zG4KcXzzt1jzuOKMLKA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzt-0009Cr-3i; Wed, 09 Jan 2019 22:02:45 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 34A1AC15F1;
        Wed,  9 Jan 2019 22:02:40 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 11/16] locking/lockdep: Reuse lock chains that have been freed
Date:   Wed,  9 Jan 2019 13:01:59 -0800
Message-Id: <20190109210204.192109-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190109210204.192109-1-bvanassche@acm.org>
References: <20190109210204.192109-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00494465996194)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5uqedaKDPRmr6hTD/1wcFW1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORphPu8jd2ydSlJFjq08
 CAcGSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/E53d
 gi3vLmcjfrrMypRHn7OOqpiCgGRKllFsZ2U4mg8UK6YK/Z3Z4VqycLjuCh+BX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2aQSUN8kFnhD7o+VyQ1oD3roKXmjBL5uwLhkPo1jOY
 3CLYhBKQrXFod+WvUUP1Uys1SCu8wQmWlqgUhZKbKdwa/OuO5TcDeKjrEmYPn2IVWRtfdRHps2br
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
 kernel/locking/lockdep.c | 62 ++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ef3809e21fa9..a8ea03bfc944 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -299,6 +299,7 @@ static struct pending_free {
 	struct rcu_head	 rcu_head;
 	bool		 scheduled;
 	DECLARE_BITMAP(list_entries_being_freed, MAX_LOCKDEP_ENTRIES);
+	DECLARE_BITMAP(lock_chains_being_freed, MAX_LOCKDEP_CHAINS);
 } pending_free[2];
 static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);
 
@@ -2110,8 +2111,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 	return 0;
 }
 
-static unsigned long nr_lock_chains;
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
+static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 
@@ -2250,12 +2251,25 @@ static int check_no_collision(struct task_struct *curr,
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
@@ -2274,20 +2288,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 	struct lock_chain *chain;
 	int i, j;
 
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
+	chain = alloc_lock_chain();
+	if (!chain) {
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
@@ -2295,7 +2297,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 		dump_stack();
 		return 0;
 	}
-	chain = lock_chains + nr_lock_chains++;
 	chain->chain_key = chain_key;
 	chain->irq_context = hlock->irq_context;
 	i = get_first_held_lock(curr, hlock);
@@ -4223,7 +4224,8 @@ void lockdep_reset(void)
 }
 
 /* Remove a class from a lock chain. Must be called with the graph lock held. */
-static void remove_class_from_lock_chain(struct lock_chain *chain,
+static void remove_class_from_lock_chain(struct pending_free *pf,
+					 struct lock_chain *chain,
 					 struct lock_class *class)
 {
 #ifdef CONFIG_PROVE_LOCKING
@@ -4261,6 +4263,7 @@ static void remove_class_from_lock_chain(struct lock_chain *chain,
 	 * hlist_for_each_entry_rcu() loop is safe.
 	 */
 	hlist_del_rcu(&chain->entry);
+	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
 	if (chain->depth == 0)
 		return;
 	/*
@@ -4269,22 +4272,19 @@ static void remove_class_from_lock_chain(struct lock_chain *chain,
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
@@ -4293,7 +4293,7 @@ static void remove_class_from_lock_chains(struct lock_class *class)
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
 		hlist_for_each_entry_rcu(chain, head, entry) {
-			remove_class_from_lock_chain(chain, class);
+			remove_class_from_lock_chain(pf, chain, class);
 		}
 	}
 }
@@ -4334,7 +4334,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 			  class->name);
 	}
 
-	remove_class_from_lock_chains(class);
+	remove_class_from_lock_chains(pf, class);
 }
 
 static void reinit_class(struct lock_class *class)
@@ -4383,6 +4383,11 @@ static void free_zapped_classes(struct rcu_head *ch)
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
@@ -4675,6 +4680,7 @@ void __init lockdep_init(void)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
+		+ sizeof(lock_chains_in_use)
 		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
-- 
2.20.1.97.g81188d93c3-goog

