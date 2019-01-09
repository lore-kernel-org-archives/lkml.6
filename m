Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFEBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C142206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="c8AgHTVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfAIVC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:02:57 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:50625 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfAIVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=77H93Ju9C2UL9Y5XjUGrhysvdDIwM067dtbVPLbWND8=; b=c8AgHTVNBU9+
        PNLf1dY0o7dwU7oqELG7e9vFlCdkm9wKQknutP/eBaYjdiaSxuByFZZYDUwY9RpALaNqUKNnmAVyj
        WtdgQuAwmO6A4hX/yFEok9cs8Zi2vRSxIRxZJ7VTEFkVkCjhyLdDFCA0MrElmJEKMkECWbQUdxR8u
        qWCNk/va37O1id+BE9kS4FoXTUDGIWeWFLLPOaj6CGbsbyX1h42IdqOd37cM0cEw9caZXzY6mke8a
        IaN6kYkRVhLO/NnG6/xUFh3Qbr7pMcjd0BXRXPfGxGXT9iEUofWiiWS2846R8D80pJzU0D2gwkgGD
        EYjWxNuQAUQ845Z44WzFjA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzp-0009DF-1n; Wed, 09 Jan 2019 22:02:41 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 34CA6C0687;
        Wed,  9 Jan 2019 22:02:35 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 09/16] locking/lockdep: Reuse list entries that are no longer in use
Date:   Wed,  9 Jan 2019 13:01:57 -0800
Message-Id: <20190109210204.192109-10-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00851265656769)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5lYtMs2XczaslgcG42FLB8x602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoZzN4mkLnxlDck3ivO
 /nssSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/E53d
 gi3vLmcjfrrMypRHn4ReCVVSIHe/oUqzWQIU6rXS6w0smcsfYNgewDQ2vNUGX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2auxsFS8/JZ9ZXq+mjRe93Os/+IQJuLEB5WAN97GIB
 Yo3YhBKQrXFod+WvUUP1Uys1SCu8wQmWlqgUhZKbKdwa/OuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of abandoning elements of list_entries[] that are no longer in
use, make alloc_list_entry() reuse array elements that have been freed.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 48 +++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5b142f699503..5e8a3a17bb94 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -45,6 +45,7 @@
 #include <linux/hash.h>
 #include <linux/ftrace.h>
 #include <linux/stringify.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/gfp.h>
 #include <linux/random.h>
@@ -132,6 +133,7 @@ static inline int debug_locks_off_graph_unlock(void)
 
 unsigned long nr_list_entries;
 static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
+static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
 
 /*
  * All data structures here are protected by the global debug_lock.
@@ -296,6 +298,7 @@ static struct pending_free {
 	struct list_head zapped_classes;
 	struct rcu_head	 rcu_head;
 	bool		 scheduled;
+	DECLARE_BITMAP(list_entries_being_freed, MAX_LOCKDEP_ENTRIES);
 } pending_free[2];
 static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);
 
@@ -756,6 +759,19 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+static bool list_entry_being_freed(int list_entry_idx)
+{
+	struct pending_free *pf;
+	int i;
+
+	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free);
+	     i++, pf++)
+		if (test_bit(list_entry_idx, pf->list_entries_being_freed))
+			return true;
+
+	return false;
+}
+
 /*
  * Initialize the lock_classes[] array elements, the free_lock_classes list
  * and also the pending_free[] array.
@@ -896,7 +912,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
  */
 static struct lock_list *alloc_list_entry(void)
 {
-	if (nr_list_entries >= MAX_LOCKDEP_ENTRIES) {
+	int idx = find_first_zero_bit(list_entries_in_use,
+				      ARRAY_SIZE(list_entries));
+
+	if (idx >= ARRAY_SIZE(list_entries)) {
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
@@ -904,7 +923,9 @@ static struct lock_list *alloc_list_entry(void)
 		dump_stack();
 		return NULL;
 	}
-	return list_entries + nr_list_entries++;
+	nr_list_entries++;
+	__set_bit(idx, list_entries_in_use);
+	return list_entries + idx;
 }
 
 /*
@@ -1008,7 +1029,7 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	lock->parent = parent;
 	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
@@ -1018,7 +1039,7 @@ static inline unsigned long lock_accessed(struct lock_list *lock)
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
 }
 
@@ -4277,13 +4298,15 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
+		entry = list_entries + i;
 		if (entry->class != class && entry->links_to != class)
 			continue;
+		if (list_entry_being_freed(i))
+			continue;
+		set_bit(i, pf->list_entries_being_freed);
+		nr_list_entries--;
 		list_del_rcu(&entry->entry);
-		/* Clear .class and .links_to to avoid double removal. */
-		WRITE_ONCE(entry->class, NULL);
-		WRITE_ONCE(entry->links_to, NULL);
 	}
 	if (list_empty(&class->locks_after) &&
 	    list_empty(&class->locks_before)) {
@@ -4325,8 +4348,9 @@ static bool inside_selftest(void)
 }
 
 /*
- * Free all lock classes that are on the pf->zapped_classes list. May be called
- * from RCU callback context.
+ * Free all lock classes that are on the pf->zapped_classes list and also all
+ * list entries that have been marked as being freed. May be called from RCU
+ * callback context.
  */
 static void free_zapped_classes(struct rcu_head *ch)
 {
@@ -4342,6 +4366,9 @@ static void free_zapped_classes(struct rcu_head *ch)
 		reinit_class(class);
 	}
 	list_splice_init(&pf->zapped_classes, &free_lock_classes);
+	bitmap_andnot(list_entries_in_use, list_entries_in_use,
+		      pf->list_entries_being_freed, ARRAY_SIZE(list_entries));
+	bitmap_clear(pf->list_entries_being_freed, 0, ARRAY_SIZE(list_entries));
 	graph_unlock();
 restore_irqs:
 	raw_local_irq_restore(flags);
@@ -4626,6 +4653,7 @@ void __init lockdep_init(void)
 
 	printk(" memory used by lock dependency info: %zu kB\n",
 	       (sizeof(list_entries) +
+		sizeof(list_entries_in_use) +
 		sizeof(lock_classes) +
 		sizeof(classhash_table) +
 		sizeof(chainhash_table) +
-- 
2.20.1.97.g81188d93c3-goog

