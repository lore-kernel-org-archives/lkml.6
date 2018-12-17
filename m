Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72BBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE1D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="tklUPxoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbeLQVcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:32:20 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:38339 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbeLQVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=x2QoQTbMMjcw2sJdj+TX8xNkK8cZ/kdGG7pnt/Zcz2M=; b=tklUPxoS8fT0
        F7mSe2/xQASYz3psVNyd4SHdjzVZ/Fh8EVc0p44lagW97EodagJBp7m4YYRN47+gEQdCPXmW405yz
        C65GJ9FZ8xrlwa0DQPiCt8gb3EIyti6MxS0lh7udWuRhI3zJx9CX74DjXY1y4Iidw5zT5iyPUmTFL
        pWxJJGwad/vGWW04AVSmClxL5xQTYwrbshBdJ22l3kYwUBmvkeylDFgXWxVUIuSTwTMmkiPrWkByz
        M/y/hrj4oJWaoQS+LnTYTRXtj2srDxMDBns/CGgQ0ehDWzg++GNmCe76BCRGsumd/R6nL+q6y/BPK
        8A2YlKS17pz3h4886FU0Cg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gZ0TU-0003D3-Ha; Mon, 17 Dec 2018 22:30:53 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 7742EC00A8;
        Mon, 17 Dec 2018 22:30:45 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v5 05/15] locking/lockdep: Split lockdep_free_key_range() and lockdep_reset_lock()
Date:   Mon, 17 Dec 2018 13:29:52 -0800
Message-Id: <20181217213002.73776-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
In-Reply-To: <20181217213002.73776-1-bvanassche@acm.org>
References: <20181217213002.73776-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00905204939655)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5kbo5srunZFnbzJcX/RWXBJ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORr2DONqFCkX+8/MrMCN
 dMP3SNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/lcBJ
 DmoxYxZqr5EVgTOQJC7GLzA0BvII8U9slRExpJlukSAPHj1Bp/lyUFxOYrucX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2aP/+CKZWvCcGzFtIlCswnZgVTK8XO/HjeTx+t9fXE
 qMPYhBKQrXFod+WvUUP1Uys1SCu8wQmWlqgUhZKbKdwa/OuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change the behavior of these functions but makes the
patch that frees unused lock classes easier to read.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 74 +++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9ab782378b3b..4fcc2a07bfb4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4181,6 +4181,26 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
+static void __lockdep_free_key_range(void *start, unsigned long size)
+{
+	struct lock_class *class;
+	struct hlist_head *head;
+	int i;
+
+	/*
+	 * Unhash all classes that were created by this module:
+	 */
+	for (i = 0; i < CLASSHASH_SIZE; i++) {
+		head = classhash_table + i;
+		hlist_for_each_entry_rcu(class, head, hash_entry) {
+			if (!within(class->key, start, size) &&
+			    !within(class->name, start, size))
+				continue;
+			zap_class(class);
+		}
+	}
+}
+
 /*
  * Used in module.c to remove lock classes from memory that is going to be
  * freed; and possibly re-used by other modules.
@@ -4191,30 +4211,14 @@ static inline int within(const void *addr, void *start, unsigned long size)
  */
 void lockdep_free_key_range(void *start, unsigned long size)
 {
-	struct lock_class *class;
-	struct hlist_head *head;
 	unsigned long flags;
-	int i;
 	int locked;
 
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
-
-	/*
-	 * Unhash all classes that were created by this module:
-	 */
-	for (i = 0; i < CLASSHASH_SIZE; i++) {
-		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			if (within(class->key, start, size))
-				zap_class(class);
-			else if (within(class->name, start, size))
-				zap_class(class);
-		}
-	}
-
+	__lockdep_free_key_range(start, size);
 	if (locked)
 		graph_unlock();
 	raw_local_irq_restore(flags);
@@ -4256,16 +4260,11 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 	return false;
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/* The caller must hold the graph lock. Does not sleep. */
+static void __lockdep_reset_lock(struct lockdep_map *lock)
 {
 	struct lock_class *class;
-	unsigned long flags;
-	int j, locked;
-
-	init_data_structures_once();
-
-	raw_local_irq_save(flags);
-	locked = graph_lock();
+	int j;
 
 	/*
 	 * Remove all classes this lock might have:
@@ -4282,19 +4281,22 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	 * Debug check: in the end all mapped classes should
 	 * be gone.
 	 */
-	if (unlikely(lock_class_cache_is_registered(lock))) {
-		if (debug_locks_off_graph_unlock()) {
-			/*
-			 * We all just reset everything, how did it match?
-			 */
-			WARN_ON(1);
-		}
-		goto out_restore;
-	}
+	if (WARN_ON_ONCE(lock_class_cache_is_registered(lock)))
+		debug_locks_off();
+}
+
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	unsigned long flags;
+	int locked;
+
+	init_data_structures_once();
+
+	raw_local_irq_save(flags);
+	locked = graph_lock();
+	__lockdep_reset_lock(lock);
 	if (locked)
 		graph_unlock();
-
-out_restore:
 	raw_local_irq_restore(flags);
 }
 
-- 
2.20.0.405.gbc1bbc6f85-goog

