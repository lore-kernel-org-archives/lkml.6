Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9059206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="G3ceWvkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9059206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeK2Krv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:51 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:42153 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeK2Kru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=wc3OpeHu5BZObpN0LPN3EmYqY86q8cZb/pOpjiUTBfA=; b=G3ceWvkqB4SR
        QNZdG9CUHwm99l1R8/iyW9Tgfy+Z3CSefXtX9+l63udhVwSUlrLHVisOhj3vTAqINlcpP4ztQRGef
        TWkBic3q1xAp85sNJDGqq9froRmbwKgQrNpOBr9Yv4aSnSHSWhtpZ33/WVSTs3l4YXscmZJYeuABx
        dEuXE5BIuwh5VOyTfFSiS3xjynxrjGBxHwW51MYBCrRnX7W+8D/fOmiPaLTrMFEZSwF8ouCSu40pK
        GV7XOwtp1HyYdw6eZ/iQ2kRRQqk4M3jty6835EbuCWV+mw22gRNmrx7hqwEW28e7uZF86LtSNqi+M
        EzbGs26BFCPTMUqiBm2wdg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9VC-000Fm0-Oi; Thu, 29 Nov 2018 00:44:18 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id A087AC11D1;
        Thu, 29 Nov 2018 00:44:16 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 23/27] locking/lockdep: Check data structure consistency
Date:   Wed, 28 Nov 2018 15:43:21 -0800
Message-Id: <20181128234325.110011-24-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.0011960716015)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jinzgJ1EtFkeyeuV4rfmFd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aX6y7YY
 evlhZhZ4qit068tqq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkBvyMjbyNpr4xR6RL2C9+qlIny++hg9dJLqN5zmWqF/oNe6FVV7drXD
 mtOldfpWzeUCaRHvx+uLGHS3n3Y0pMd0ZyCgxZHINA6A5+7T9o6by6wCf9/ixXi9QE6xc2MJdJIs
 WkULIn/2FBvF31UHbsndehIqUczFWeS6sE8e1b5/UlaX0Ao5X99TlizdjWjXhcukjPvPb2ztUwUU
 F4ekbSpuNzlrea/7iuldgAMiBvdjMS5J8moEi3zrRvDLm1YEEdEHmFDqewO9xyOqCYO8P1aHcsG0
 kWCiESR44kXyAcFBnvq0JaXhRWKyqy0OhbkmMxu2AdrcZPAiQvyjIZ4LQqnqqLEDUnB02oJPHAlf
 IubJYzA0XAoGECHs14pjPDDBgamvNiA5kjk+kUt44s0jst5foe/FOaCTJx4a7HWQH97sguITVg6Q
 TrHGofvmrHam4/RuhWzfuvHd4y0L/HyfN5U858I8R2vIYlYbA7G/CY3eeSCFRiwDn8j3yWGHtM7w
 dRonBy/PpUxgSFRPcWxJF+/beJHmCfSNEcGdfFKs5M18F1x96tlonSt5Ig9mwLw4vXsdf68W0InH
 /+bTMKNm38MHV+diwrlXuxzeO2WnJyd7g8lLLKZgdBo3YHaSgbLEg7M4I+zZPnIX6k9TnzH5sZcr
 MS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging lockdep data structure inconsistencies is challenging. Add
disabled code that verifies data structure consistency at runtime.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 142 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 288a2f6fd0ef..141bb0662ff5 100644
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
@@ -736,6 +738,135 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+/* Check whether element @e occurs in list @h */
+static bool in_list(struct list_head *e, struct list_head *h)
+{
+	struct list_head *f;
+
+	list_for_each(f, h)
+		if (e == f)
+			return true;
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
+	list_for_each_entry(e, h, lock_order_entry) {
+		if (e->links_to != c) {
+			printk(KERN_INFO "class %s: mismatch for lock entry %ld; class %s <> %s",
+			       c->name ? : "(?)", e - list_entries,
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
+	list_for_each_entry(e, &all_list_entries, alloc_entry) {
+		if (!in_any_class_list(&e->lock_order_entry)) {
+			printk(KERN_INFO "list entry %ld is not in any class list; class %s <> %s\n",
+			       e - list_entries,
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
+	list_for_each_entry(e, &free_list_entries, alloc_entry) {
+		if (in_any_class_list(&e->lock_order_entry)) {
+			printk(KERN_INFO "list entry %ld occurs in a class list; class %s <> %s\n",
+			       e - list_entries,
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
+		hlist_for_each_entry_rcu(chain, head, entry)
+			if (!check_lock_chain_key(chain))
+				return false;
+	}
+
+	return true;
+}
+
 static void init_lists(void)
 {
 	int i;
@@ -4294,6 +4425,14 @@ static void free_zapped_classes(struct list_head *zapped_classes)
 	unsigned long flags;
 	int locked;
 
+	raw_local_irq_save(flags);
+	locked = graph_lock();
+	if (check_data_structure_consistency)
+		WARN_ON_ONCE(!check_data_structures());
+	if (locked)
+		graph_unlock();
+	raw_local_irq_restore(flags);
+
 	if (list_empty(zapped_classes))
 		return;
 
@@ -4314,6 +4453,9 @@ static void free_zapped_classes(struct list_head *zapped_classes)
 	if (locked)
 		graph_unlock();
 	raw_local_irq_restore(flags);
+
+	if (check_data_structure_consistency)
+		WARN_ON_ONCE(!check_data_structures());
 }
 
 /*
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

