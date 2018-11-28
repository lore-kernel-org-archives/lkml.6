Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D210C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2663206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="G8XKnDMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2663206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeK2Kte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:49:34 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:33915 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeK2Kr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=zNXptneemwIaK3CPrWfFtuQxL0UdNCqZ2/9SjDfY9KM=; b=G8XKnDMT3hvb
        MJpBm0O4dDWKzjMtpdhgQF6X5ZnwXDwlVLF74v4thVWhlBT3J+kaldfBb3k2WmQrQMQk3bJgUFiB+
        wGlV8h0FNxRs1zV3FLYnAA6fGAcBqNAsb1FhWTLqTe1Ea8uueksJf6aBrn4HqxEIDXGL4JfufbPFe
        DvmIhf4waNmraEvO9Bc/DTNaES8MjFtrEfxSdm6w3sWJAWHiYcjhgnNIp/R3KWkn/8fFu7KUsH/c4
        CVl/d2+/3XU0cvKdowqtN9R/5jdotlab7hcm7bDjpkT5Dk4UvXlW3PoX2pJJcOQ65N9RPrRAlz2N5
        RjRr8zdo5KK+4+SHoObIRQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Ur-0001zB-Sr; Thu, 29 Nov 2018 00:43:58 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id BE329C1235;
        Thu, 29 Nov 2018 00:43:55 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 10/27] locking/lockdep: Introduce lock_class_cache_is_registered()
Date:   Wed, 28 Nov 2018 15:43:08 -0800
Message-Id: <20181128234325.110011-11-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5tPZPXlTQ85hu2X3a34UIQp602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aUquvkM
 TQObn4MK6QiHj0CNq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi2wFVccsCAZ2dyI5DAR
 qfkZNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18n4mJSlGpCLjjP2
 TVCcvwpqxvcFnH81+zUZvGcwzyDZLZPtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MXxSyBgYVVgHYJw3S85JQTU5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality but makes the
lockdep_reset_lock() function easier to read.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 50 ++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 58205b6ac5ed..8177a8de1e1d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4198,13 +4198,33 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	 */
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/*
+ * Check whether any element of the @lock->class_cache[] array refers to a
+ * registered lock class. The caller must hold either the graph lock or the
+ * RCU read lock.
+ */
+static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
-	unsigned long flags;
 	int i, j;
-	int locked;
+
+	for (i = 0; i < CLASSHASH_SIZE; i++) {
+		head = classhash_table + i;
+		hlist_for_each_entry_rcu(class, head, hash_entry) {
+			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
+				if (lock->class_cache[j] == class)
+					return true;
+		}
+	}
+	return false;
+}
+
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	struct lock_class *class;
+	unsigned long flags;
+	int j, locked;
 
 	raw_local_irq_save(flags);
 
@@ -4224,24 +4244,14 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 	 * be gone.
 	 */
 	locked = graph_lock();
-	for (i = 0; i < CLASSHASH_SIZE; i++) {
-		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			int match = 0;
-
-			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
-				match |= class == lock->class_cache[j];
-
-			if (unlikely(match)) {
-				if (debug_locks_off_graph_unlock()) {
-					/*
-					 * We all just reset everything, how did it match?
-					 */
-					WARN_ON(1);
-				}
-				goto out_restore;
-			}
+	if (unlikely(lock_class_cache_is_registered(lock))) {
+		if (debug_locks_off_graph_unlock()) {
+			/*
+			 * We all just reset everything, how did it match?
+			 */
+			WARN_ON(1);
 		}
+		goto out_restore;
 	}
 	if (locked)
 		graph_unlock();
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

