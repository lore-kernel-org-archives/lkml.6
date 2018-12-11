Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE8C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D7620851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="Yl/DdfDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D7620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLKWQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:16:01 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:35927 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeLKWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=o7tXSJlOfScEy/51es8gD9E5byJW55frhbO4qMvIuaQ=; b=Yl/DdfDI+dVB
        b7fOYVrrK9pGaxoGhy+01rn63GLqeXZMXYRI2IBMxai0d31t2n0rIpoT28tPPB4dY8Wl/llCE8zw6
        oPYnUaWADjygSZAKL77Fdw81SY5jIfYwSEvByTzD5NOkMFbyVXgnwm+sVBscPn+FdhxmZWXD/hDwl
        ctENPAr16MqlvKEtBermA7MW1KvPYO8ZwFEng9MBy+hpz2JqitdB3J/vg4MA/UAgkY9gm2qMSoZDp
        8rhMV+7JwZ+e+XD70JLCG5zYtB+2VQRRp5mSZEwrEVkd7C/HdDb69PFLNgi5n65oSC18FDbXnxvKj
        oOu+EZXHAQswBq3Rr8ctQA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWqHp-0005NF-HB; Tue, 11 Dec 2018 23:13:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id A9472C09DB;
        Tue, 11 Dec 2018 23:13:51 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 08/15] locking/lockdep: Reuse list entries that are no longer in use
Date:   Tue, 11 Dec 2018 14:13:14 -0800
Message-Id: <20181211221321.196536-9-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5hyzKBUC78Yl+qfLkYux10t602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORpNi5kHhTOtgfj/V5da
 35caSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8FNKZFrpMP+RrTJ6+mm5EZIJGM
 wI7EsU9X7t6jyXWnUCFeETgDl3PwKvXCHlDl/OyqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxzXti4dc8mSdWWWnq5+T0OlQCXHAnYN7KgY5ZOOQJ3pEpIAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
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
 kernel/locking/lockdep.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 82dd7d2851eb..2da45621f741 100644
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
 
@@ -891,7 +894,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
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
 
@@ -899,7 +905,9 @@ static struct lock_list *alloc_list_entry(void)
 		dump_stack();
 		return NULL;
 	}
-	return list_entries + nr_list_entries++;
+	nr_list_entries++;
+	__set_bit(idx, list_entries_in_use);
+	return list_entries + idx;
 }
 
 /*
@@ -1003,7 +1011,7 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	lock->parent = parent;
 	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
@@ -1013,7 +1021,7 @@ static inline unsigned long lock_accessed(struct lock_list *lock)
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
 }
 
@@ -4281,13 +4289,14 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
+		entry = list_entries + i;
 		if (entry->class != class && entry->links_to != class)
 			continue;
+		if (__test_and_set_bit(i, pf->list_entries_being_freed))
+			continue;
+		nr_list_entries--;
 		list_del_rcu(&entry->entry);
-		/* Clear .class and .links_to to avoid double removal. */
-		WRITE_ONCE(entry->class, NULL);
-		WRITE_ONCE(entry->links_to, NULL);
 	}
 	if (list_empty(&class->locks_after) &&
 	    list_empty(&class->locks_before)) {
@@ -4329,8 +4338,9 @@ static bool inside_selftest(void)
 }
 
 /*
- * Free all lock classes that are on the pf->zapped_classes list. May be called
- * from RCU callback context.
+ * Free all lock classes that are on the pf->zapped_classes list and also all
+ * list entries that have been marked as being freed. Called as an RCU
+ * callback function. May be called from RCU callback context.
  */
 static void free_zapped_classes(struct rcu_head *ch)
 {
@@ -4346,6 +4356,9 @@ static void free_zapped_classes(struct rcu_head *ch)
 		reinit_class(class);
 	}
 	list_splice_init(&pf->zapped_classes, &free_lock_classes);
+	bitmap_andnot(list_entries_in_use, list_entries_in_use,
+		      pf->list_entries_being_freed, ARRAY_SIZE(list_entries));
+	bitmap_clear(pf->list_entries_being_freed, 0, ARRAY_SIZE(list_entries));
 	graph_unlock();
 restore_irqs:
 	raw_local_irq_restore(flags);
-- 
2.20.0.rc2.403.gdbc3b29805-goog

