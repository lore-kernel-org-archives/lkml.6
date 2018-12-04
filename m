Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C25C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32DF2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="IbWQm2D5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32DF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeLDA3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:29:40 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:46743 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLDA3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=TLZeq5KH6PCxVjWHalGs7HFGJ/uMCcCOlDOki5RJWdY=; b=IbWQm2D5aF9f
        6XePD4Sjk0lHvteYRsa4M86rjKR6Q5msDgQvAo7wdzFCj3kPDJRThoLNBNJF2qRQlK2CLlViF6vU5
        U6XojIc+i/xCeUm6Beifcxx9wTlYrQpvGVJlGAO4vMtMb2OG1xpIvx8Rzm8NpBwfsl/p5/jqYek43
        PKnugRKfOVvh8sLad9itjZZoiEkx6WsXAA+zrJLliNSyu4prkWVHGvwF+BmbaS0dWRYkgipiijcW9
        fdZ9A/K2LKFCApX1Dounj+hh6nKgcKAZ8NO0SKOwvCU0l6bVT1v6C75EVAvpMFBGPzUU4Wqh7OsyH
        Gqg+q/nwz9Reb0BcEIfYGg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gTyab-0008A1-RW; Tue, 04 Dec 2018 01:29:26 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 664CBC07AC;
        Tue,  4 Dec 2018 01:29:23 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 19/24] locking/lockdep: Check data structure consistency
Date:   Mon,  3 Dec 2018 16:28:28 -0800
Message-Id: <20181204002833.55452-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204002833.55452-1-bvanassche@acm.org>
References: <20181204002833.55452-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.0013579094181)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5kpTeq86FNeJwUmVlnWn/f5602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORpOmgcpebvOVf5k9F7B
 H3cQSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/lcBJ
 DmoxYxZqr5EVgTOQJGrZFp2uygPTeAmvSBJ6qe55YRMY1AYubtD35PmFkZg7X1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2aCp2V4YohJHkF3vhJDWZtE5zkNwf48cxqxZLCJLHq
 Ui/YhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging lockdep data structure inconsistencies is challenging. Add
disabled code that verifies data structure consistency at runtime.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 147 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f343e7612a3a..6d99f3f0757c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -72,6 +72,8 @@ module_param(lock_stat, int, 0644);
 #define lock_stat 0
 #endif
 
+static bool check_data_structure_consistency;
+
 /*
  * lockdep_lock: protects the lockdep graph, the hashes and the
  *               class/list/hash allocators.
@@ -744,6 +746,148 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+/* Check whether element @e occurs in list @h */
+static bool in_list(struct list_head *e, struct list_head *h)
+{
+	struct list_head *f;
+
+	list_for_each(f, h) {
+		if (e == f)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Check whether entry @e occurs in any of the locks_after or locks_before
+ * lists.
+ */
+static bool in_any_class_list(struct list_head *e)
+{
+	struct lock_class *class;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		class = &lock_classes[i];
+		if (in_list(e, &class->locks_after) ||
+		    in_list(e, &class->locks_before))
+			return true;
+	}
+	return false;
+}
+
+static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
+{
+	struct lock_list *e;
+
+	list_for_each_entry(e, h, entry) {
+		if (e->links_to != c) {
+			printk(KERN_INFO "class %s: mismatch for lock entry %ld; class %s <> %s",
+			       c->name ? : "(?)",
+			       (unsigned long)(e - list_entries),
+			       e->links_to && e->links_to->name ?
+			       e->links_to->name : "(?)",
+			       e->class && e->class->name ? e->class->name :
+			       "(?)");
+			return false;
+		}
+	}
+	return true;
+}
+
+static u16 chain_hlocks[];
+
+static bool check_lock_chain_key(struct lock_chain *chain)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	u64 chain_key = 0;
+	int i;
+
+	for (i = chain->base; i < chain->base + chain->depth; i++)
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+	/*
+	 * The 'unsigned long long' casts avoid that a compiler warning
+	 * is reported when building tools/lib/lockdep.
+	 */
+	if (chain->chain_key != chain_key)
+		printk(KERN_INFO "chain %lld: key %#llx <> %#llx\n",
+		       (unsigned long long)(chain - lock_chains),
+		       (unsigned long long)chain->chain_key,
+		       (unsigned long long)chain_key);
+	return chain->chain_key == chain_key;
+#else
+	return true;
+#endif
+}
+
+static bool check_data_structures(void)
+{
+	struct lock_class *class;
+	struct lock_chain *chain;
+	struct hlist_head *head;
+	struct lock_list *e;
+	int i;
+
+	/*
+	 * Check whether all list entries that are in use occur in a class
+	 * lock list.
+	 */
+	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
+		if (test_bit(i, list_entries_being_freed))
+			continue;
+		e = list_entries + i;
+		if (!in_any_class_list(&e->entry)) {
+			printk(KERN_INFO "list entry %d is not in any class list; class %s <> %s\n",
+			       (unsigned int)(e - list_entries),
+			       e->class->name ? : "(?)",
+			       e->links_to->name ? : "(?)");
+			return false;
+		}
+	}
+
+	/*
+	 * Check whether all list entries that are not in use do not occur in
+	 * a class lock list.
+	 */
+	for_each_clear_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
+		e = list_entries + i;
+		if (WARN_ON_ONCE(test_bit(i, list_entries_being_freed)))
+			return false;
+		if (in_any_class_list(&e->entry)) {
+			printk(KERN_INFO "list entry %d occurs in a class list; class %s <> %s\n",
+			       (unsigned int)(e - list_entries),
+			       e->class && e->class->name ? e->class->name :
+			       "(?)",
+			       e->links_to && e->links_to->name ?
+			       e->links_to->name : "(?)");
+			return false;
+		}
+	}
+
+	/* Check whether all classes have valid lock lists. */
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		class = &lock_classes[i];
+		if (!class->locks_before.next)
+			continue;
+		if (!class_lock_list_valid(class, &class->locks_before))
+			return false;
+		if (!class_lock_list_valid(class, &class->locks_after))
+			return false;
+	}
+
+	/* Check the chain_key of all lock chains. */
+	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
+		head = chainhash_table + i;
+		hlist_for_each_entry_rcu(chain, head, entry) {
+			if (!check_lock_chain_key(chain))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 /*
  * Initialize the lock_classes[] array elements and also the free_lock_classes
  * list.
@@ -4308,6 +4452,8 @@ static void free_zapped_classes(struct callback_head *ch)
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 	rcu_callback_scheduled = false;
+	if (check_data_structure_consistency)
+		WARN_ON_ONCE(!check_data_structures());
 	list_for_each_entry(class, &zapped_classes, lock_entry) {
 		reinit_class(class);
 		nr_lock_classes--;
@@ -4319,6 +4465,7 @@ static void free_zapped_classes(struct callback_head *ch)
 	if (locked)
 		graph_unlock();
 	raw_local_irq_restore(flags);
+
 }
 
 /* Must be called with the graph lock held. */
-- 
2.20.0.rc1.387.gf8505762e3-goog

