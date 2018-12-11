Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5C7C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C7D2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="re2bnFl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C7D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeLKWPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:15:15 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:52209 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLKWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=JG+TUun9jK5VBMAZlLmbN3l9YOZbd2l0z9C00IXkjlQ=; b=re2bnFl94Jyg
        eAvVDJgvGT7fDHQqQBRhGDLisAbyG+9s5jvhUMKOIod4V6OEETgE/JEjblGCiVJ7EtZnez/p0/Z8q
        25WLUmzlozecmZhWJs36XciRCH2g6d32WZDsWCdXEl3qjw0u9vsAhOHyI8phDcl8IsVLhLP2+2ynB
        uzwBKp4Vxiu852pCdvqR32GOgUcnFyAKQXMAvU1TBR+SPjFmYLy7Em/MXcnVOP5DzrxwwGNp/qhdX
        NjkvQdL3AsR5s1gQPwWClrGvIDTAZn25QhaNWZdLVJGuq6lxXlo/n31hNucvSS9YLsonwBVOpuC9b
        2DmrFBA7GqoIyK3y76w4cA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWqHu-0006r6-U5; Tue, 11 Dec 2018 23:13:59 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 0382BC0718;
        Tue, 11 Dec 2018 23:13:56 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 11/15] locking/lockdep: Check data structure consistency
Date:   Tue, 11 Dec 2018 14:13:17 -0800
Message-Id: <20181211221321.196536-12-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00229892676491)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5pnGFEP9fiksqhqYWgKLt8B602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORrnTCLUvifkZbpBFvCn
 AY1GSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/E53d
 gi3vLmcjfrrMypRHn/tZblmQ0+ehzpa5Z4MWZxlonTBzk5b/3lbTjB07k4XLX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2adcOAe+99icpOdKU2EXdHMHX1xPXWXZOAzkWT0tkU
 7jXYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
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
 kernel/locking/lockdep.c | 183 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8ba326c68253..f95c1beddc28 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -74,6 +74,8 @@ module_param(lock_stat, int, 0644);
 #define lock_stat 0
 #endif
 
+static bool check_data_structure_consistency;
+
 /*
  * lockdep_lock: protects the lockdep graph, the hashes and the
  *               class/list/hash allocators.
@@ -755,6 +757,185 @@ static bool assign_lock_key(struct lockdep_map *lock)
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
+static bool in_any_zapped_class_list(struct lock_class *class)
+{
+	struct pending_free *pf;
+	int i;
+
+	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free);
+	     i++, pf++)
+		if (in_list(&class->lock_entry, &pf->zapped_classes))
+			return true;
+
+	return false;
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
+	/* Check whether all classes occur in a lock list. */
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		class = &lock_classes[i];
+		if (!in_list(&class->lock_entry, &all_lock_classes) &&
+		    !in_list(&class->lock_entry, &free_lock_classes) &&
+		    !in_any_zapped_class_list(class)) {
+			printk(KERN_INFO "class %px/%s is not in any class list\n",
+			       class, class->name ? : "(?)");
+			return false;
+			return false;
+		}
+	}
+
+	/* Check whether all classes have valid lock lists. */
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		class = &lock_classes[i];
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
+	/*
+	 * Check whether all list entries that are in use occur in a class
+	 * lock list.
+	 */
+	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
+		if (list_entry_being_freed(i))
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
+		if (WARN_ON_ONCE(list_entry_being_freed(i)))
+			return false;
+		e = list_entries + i;
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
+	return true;
+}
+
 /*
  * Initialize the lock_classes[] array elements, the free_lock_classes list
  * and also the pending_free[] array.
@@ -4379,6 +4560,8 @@ static void free_zapped_classes(struct rcu_head *ch)
 	if (!graph_lock())
 		goto restore_irqs;
 	pf->scheduled = false;
+	if (check_data_structure_consistency)
+		WARN_ON_ONCE(!check_data_structures());
 	list_for_each_entry(class, &pf->zapped_classes, lock_entry) {
 		reinit_class(class);
 	}
-- 
2.20.0.rc2.403.gdbc3b29805-goog

