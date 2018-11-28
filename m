Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30347C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02B4206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="duG9g2XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02B4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeK2Krq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:46 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:49831 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeK2Krp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=O8YRw11OO1xndBDY0jx2mUYdnSD8n82Tu9g3TPCfdE0=; b=duG9g2XQaiGK
        yeUVc2GyWAorbRjVj+hhobu9QLaRtMbxOO9wW416KDjNVv+MM2CKWnrpMCk/o4ayRnCiDLPkHKQIj
        Stk3Dk89B6ahL0lcLP5OkBj7L75UV/uCDS5FB+iEAtm2lfcYB2OqXBAb0oydxzZwLx+XqO6CuepOU
        Q/eCnT+bp5/fJUAQQU+9kw7eqfmehAUKEpgkrHdtSZs6xaHpAq2A6lJBQrozX1QBTJjEoZStknb5p
        eCcvf7BVWgpRItjAqVPUw7Rz12sO6LCiR6mAwUIoMjLMOAN++N3QMXuYUVvANSFZewNGZgeyvfFK2
        L1aR/00NgLwfiftJU7wbrA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9V9-000Fm0-PJ; Thu, 29 Nov 2018 00:44:15 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id A39F8C11FB;
        Thu, 29 Nov 2018 00:44:13 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 21/27] locking/lockdep: Rename lock_list.entry into lock_list.lock_order_entry
Date:   Wed, 28 Nov 2018 15:43:19 -0800
Message-Id: <20181128234325.110011-22-bvanassche@acm.org>
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
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ujWEtVC8wSzZsY5R+gNm4V602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aUak/9u
 JggiTsLboF0x3VdPq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18nXQzDvPzq7iERC
 6EDedzAjVRetEV9DijRLuMIN9Jt/i5PtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MXbvsDfgZylBdXK6axO6AFi5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch in this series will add a new list entry member to
struct lock_list. Rename the existing "entry" member to keep the
lockdep source code readable.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h       | 3 ++-
 kernel/locking/lockdep.c      | 9 +++++----
 kernel/locking/lockdep_proc.c | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 02a1469c46e1..43327a1dd488 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -181,7 +181,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
  * We only grow the list, never remove from it:
  */
 struct lock_list {
-	struct list_head		entry;
+	/* Entry in locks_after or locks_before. */
+	struct list_head		lock_order_entry;
 	struct lock_class		*class;
 	struct lock_class		*links_to;
 	struct stack_trace		trace;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 53d8daa8d0dc..038377d67410 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -900,7 +900,7 @@ static int add_lock_to_list(struct lock_class *this,
 	 * iteration is under RCU-sched; see look_up_lock_class() and
 	 * lockdep_free_key_range().
 	 */
-	list_add_tail_rcu(&entry->entry, head);
+	list_add_tail_rcu(&entry->lock_order_entry, head);
 
 	return 1;
 }
@@ -1051,7 +1051,7 @@ static int __bfs(struct lock_list *source_entry,
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
-		list_for_each_entry_rcu(entry, head, entry) {
+		list_for_each_entry_rcu(entry, head, lock_order_entry) {
 			if (!lock_accessed(entry)) {
 				unsigned int cq_depth;
 				mark_lock_accessed(entry, lock);
@@ -1916,7 +1916,8 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 *  chains - the second one will be new, but L1 already has
 	 *  L2 added to its dependency list, due to the first chain.)
 	 */
-	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
+	list_for_each_entry(entry, &hlock_class(prev)->locks_after,
+			    lock_order_entry) {
 		if (entry->class == hlock_class(next)) {
 			if (distance == 1)
 				entry->distance = 1;
@@ -4246,7 +4247,7 @@ static void zap_class(struct list_head *zapped_classes,
 			continue;
 		links_to = entry->links_to;
 		WARN_ON_ONCE(entry->class == links_to);
-		list_del_rcu(&entry->entry);
+		list_del_rcu(&entry->lock_order_entry);
 		entry->class = NULL;
 		entry->links_to = NULL;
 		check_free_class(zapped_classes, class);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3d31f9b0059e..17460b412927 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -82,7 +82,7 @@ static int l_show(struct seq_file *m, void *v)
 	print_name(m, class);
 	seq_puts(m, "\n");
 
-	list_for_each_entry(entry, &class->locks_after, entry) {
+	list_for_each_entry(entry, &class->locks_after, lock_order_entry) {
 		if (entry->distance == 1) {
 			seq_printf(m, " -> [%p] ", entry->class->key);
 			print_name(m, entry->class);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

