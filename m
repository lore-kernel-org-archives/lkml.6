Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C57C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C27E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="WCK7VmU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfBNXCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:02:00 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:41899 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfBNXBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=aHMu7WDdAsq/Lksex6gWAKvxlrJHlMPxeQS2dRioKXw=; b=WCK7VmU3aLBe
        rOJimX6OJXjlwIcGJJJPdV5MUBwcTFmeC9UbXR9gHK6A8c1DfoLp50luglAWeKRvBxD+hdWlcyzku
        BDmuQdf4tUX3jAxP+Dls3nBN8esPPLIAfk0N7K24lFEVp8zXgVPp0Cu4bp6Qlh0zNUMFZICGy29+m
        D8EIJlfnu3lEjyHNXyXFFFSa00hHYPuQR+1fUtP+jLehVFhL0RO1wArAQ9cPeCK9TDmEpUE5xY5kN
        dnwuZe8plvSQ9zN/NMrUajjXUuwayyPGUspFpf4pHgc52YUk4t15KB11fjv2Pqj5m+QDUHBZJ+RwE
        QmMGE5TMl1lubkeAIzJc6A==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0l-000DVl-Vg; Fri, 15 Feb 2019 00:01:44 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id A3C54C0948;
        Fri, 15 Feb 2019 00:01:41 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 15/23] locking/lockdep: Reuse lock chains that have been freed
Date:   Thu, 14 Feb 2019 15:00:50 -0800
Message-Id: <20190214230058.196511-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5mWCttq6lSpuY8Z1jU+Q2nN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59ItGDQ5ycj+BPd/Cy7aDbB54KqOh03z3Jnl1IbrFC3Wxy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0VpXCEqSenvCQusD//B2Ay8Ak0RaG2jB9NUREmxq+V4Zr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHqV5ZwYAlnPovksfctJtyXeZ5SdxEr3xUMV54hhjU
 VX8hu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
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
 kernel/locking/lockdep.c | 57 ++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e983db2a2032..2ee173820909 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -292,9 +292,12 @@ static LIST_HEAD(free_lock_classes);
 /**
  * struct pending_free - information about data structures about to be freed
  * @zapped: Head of a list with struct lock_class elements.
+ * @lock_chains_being_freed: Bitmap that indicates which lock_chains[] elements
+ *	are about to be freed.
  */
 struct pending_free {
 	struct list_head zapped;
+	DECLARE_BITMAP(lock_chains_being_freed, MAX_LOCKDEP_CHAINS);
 };
 
 /**
@@ -2107,8 +2110,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 	return 0;
 }
 
-static unsigned long nr_lock_chains;
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
+static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 
@@ -2247,12 +2250,25 @@ static int check_no_collision(struct task_struct *curr,
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
@@ -2271,11 +2287,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 	struct lock_chain *chain;
 	int i, j;
 
-	/*
-	 * Allocate a new chain entry from the static array, and add
-	 * it to the hash:
-	 */
-
 	/*
 	 * The caller must hold the graph lock, ensure we've got IRQs
 	 * disabled to make this an IRQ-safe lock.. for recursion reasons
@@ -2284,7 +2295,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return 0;
 
-	if (unlikely(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+	chain = alloc_lock_chain();
+	if (!chain) {
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
@@ -2292,7 +2304,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 		dump_stack();
 		return 0;
 	}
-	chain = lock_chains + nr_lock_chains++;
 	chain->chain_key = chain_key;
 	chain->irq_context = hlock->irq_context;
 	i = get_first_held_lock(curr, hlock);
@@ -4220,7 +4231,8 @@ void lockdep_reset(void)
 }
 
 /* Remove a class from a lock chain. Must be called with the graph lock held. */
-static void remove_class_from_lock_chain(struct lock_chain *chain,
+static void remove_class_from_lock_chain(struct pending_free *pf,
+					 struct lock_chain *chain,
 					 struct lock_class *class)
 {
 #ifdef CONFIG_PROVE_LOCKING
@@ -4258,6 +4270,7 @@ static void remove_class_from_lock_chain(struct lock_chain *chain,
 	 * hlist_for_each_entry_rcu() loop is safe.
 	 */
 	hlist_del_rcu(&chain->entry);
+	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
 	if (chain->depth == 0)
 		return;
 	/*
@@ -4266,22 +4279,19 @@ static void remove_class_from_lock_chain(struct lock_chain *chain,
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
@@ -4290,7 +4300,7 @@ static void remove_class_from_lock_chains(struct lock_class *class)
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
 		hlist_for_each_entry_rcu(chain, head, entry) {
-			remove_class_from_lock_chain(chain, class);
+			remove_class_from_lock_chain(pf, chain, class);
 		}
 	}
 }
@@ -4329,7 +4339,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 			  class->name);
 	}
 
-	remove_class_from_lock_chains(class);
+	remove_class_from_lock_chains(pf, class);
 }
 
 static void reinit_class(struct lock_class *class)
@@ -4395,6 +4405,12 @@ static void __free_zapped_classes(struct pending_free *pf)
 		reinit_class(class);
 
 	list_splice_init(&pf->zapped, &free_lock_classes);
+
+#ifdef CONFIG_PROVE_LOCKING
+	bitmap_andnot(lock_chains_in_use, lock_chains_in_use,
+		      pf->lock_chains_being_freed, ARRAY_SIZE(lock_chains));
+	bitmap_clear(pf->lock_chains_being_freed, 0, ARRAY_SIZE(lock_chains));
+#endif
 }
 
 static void free_zapped_rcu(struct rcu_head *ch)
@@ -4635,6 +4651,7 @@ void __init lockdep_init(void)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
+		+ sizeof(lock_chains_in_use)
 		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
-- 
2.21.0.rc0.258.g878e2cd30e-goog

