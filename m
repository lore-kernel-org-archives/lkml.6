Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69335C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231B3206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="cmrZcf+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231B3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeK2Ksc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:48:32 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:51187 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeK2Krq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=yda+4PuI+jrHvX/4Zgum8ggXDDguKB5SpiquS7RkYR8=; b=cmrZcf+53BfJ
        GLkvWWBZKvunDXvgjLdzaT4OxsAiDeD6RvGpfd+AiFgrWOBCLoVVSh3YE1MZkDwC6TUVpmAQRuGbN
        LnznJLuWsjQHcxgxbpLFStQ/LtFChiWu2wdOyFuh2r82ODaE1bviI5cO1+AqcZHZQ2Sp2m4E+Sei5
        rB6hIz381W2rpXflVk6N81b280txmqj3bUBnyADZPfKKOs+tBrVl14Zgsr9XVy51KzI3rXNKWWNXK
        iXA+DJAG1H1Me58PCkQi3YNZhs/sKWCaPKGMHTYC/1psg+YhkUhjq8fXx/fVs+MP9uOW7CTbavJU0
        B+6vRDSdqDfwoVWq+0dtoQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9VB-000Fm0-8q; Thu, 29 Nov 2018 00:44:17 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 27FCEC11D1;
        Thu, 29 Nov 2018 00:44:15 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 22/27] locking/lockdep: Reuse list entries that are no longer in use
Date:   Wed, 28 Nov 2018 15:43:20 -0800
Message-Id: <20181128234325.110011-23-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5jk0ZXxiQXWDsQUc8Zf8i1p602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aVSlTm0
 9Dhn/ptisobc6pbeq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18nXQzDvPzq7iERC
 6EDedzAjq4PUmDSYkaMWjXOYbjHiv5PtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MXkcWPr5mls3YtQZhf6GbOV5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of abandoning elements of list_entries[] that are no longer in
use, make alloc_list_entry() reuse array elements that have been freed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |  5 +++++
 kernel/locking/lockdep.c | 23 ++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 43327a1dd488..01e55fca7c2c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -183,6 +183,11 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 struct lock_list {
 	/* Entry in locks_after or locks_before. */
 	struct list_head		lock_order_entry;
+	/*
+	 * Entry in all_list_entries when in use and entry in
+	 * free_list_entries when not in use.
+	 */
+	struct list_head		alloc_entry;
 	struct lock_class		*class;
 	struct lock_class		*links_to;
 	struct stack_trace		trace;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 038377d67410..288a2f6fd0ef 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -130,6 +130,8 @@ static inline int debug_locks_off_graph_unlock(void)
 
 unsigned long nr_list_entries;
 static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
+static LIST_HEAD(all_list_entries);
+static LIST_HEAD(free_list_entries);
 
 /*
  * All data structures here are protected by the global debug_lock.
@@ -743,6 +745,9 @@ static void init_lists(void)
 		INIT_LIST_HEAD(&lock_classes[i].locks_after);
 		INIT_LIST_HEAD(&lock_classes[i].locks_before);
 	}
+
+	for (i = 0; i < ARRAY_SIZE(list_entries); i++)
+		list_add_tail(&list_entries[i].alloc_entry, &free_list_entries);
 }
 
 /*
@@ -862,7 +867,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
  */
 static struct lock_list *alloc_list_entry(void)
 {
-	if (nr_list_entries >= MAX_LOCKDEP_ENTRIES) {
+	struct lock_list *e = list_first_entry_or_null(&free_list_entries,
+						       typeof(*e), alloc_entry);
+
+	if (!e) {
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
@@ -870,7 +878,8 @@ static struct lock_list *alloc_list_entry(void)
 		dump_stack();
 		return NULL;
 	}
-	return list_entries + nr_list_entries++;
+	list_move_tail(&e->alloc_entry, &all_list_entries);
+	return e;
 }
 
 /*
@@ -975,7 +984,7 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	lock->parent = parent;
 	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
@@ -985,7 +994,7 @@ static inline unsigned long lock_accessed(struct lock_list *lock)
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
 }
 
@@ -4235,19 +4244,19 @@ static void zap_class(struct list_head *zapped_classes,
 		      struct lock_class *class)
 {
 	struct lock_class *links_to;
-	struct lock_list *entry;
-	int i;
+	struct lock_list *entry, *tmp;
 
 	/*
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+	list_for_each_entry_safe(entry, tmp, &all_list_entries, alloc_entry) {
 		if (entry->class != class && entry->links_to != class)
 			continue;
 		links_to = entry->links_to;
 		WARN_ON_ONCE(entry->class == links_to);
 		list_del_rcu(&entry->lock_order_entry);
+		list_move(&entry->alloc_entry, &free_list_entries);
 		entry->class = NULL;
 		entry->links_to = NULL;
 		check_free_class(zapped_classes, class);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

