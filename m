Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C092C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040CF2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="RpbrzNJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040CF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeK2Kru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:50 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:57247 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbeK2Kru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=RcqhROn9FCXw9x7MzRy6T6ZBAp0lGl5e7v26HjUbWCY=; b=RpbrzNJ3U1Zo
        JGv3HEH1A67qjQvlS4PqJjdUxKgIkkymV0oVfRoyK1yPfXgksC4tzTKvr3x0eQEE8mQtoksNgvpmZ
        hPIOQkK21HxPDzJh9Hd7Bgi/ShlYs+l2TE6HdzavIvWemAM+Ea4p4BzQmCCquSBv8tlwBe5RxdzZA
        EckGNGSkPSO5R3XuNoFVc4JqzDUeIdu3d/g1QuIdqdmkLB0Ax4fBRKH0MztbLWPguFYy1n+4vRmX5
        lkysSQeX9GwIAd/xsPx32a+A9DYcfP6DV/b1A+K6PYJzbtmjOYrXlEW+fkrcRAoEi2qg/Nk9RFeop
        FOvxDvObTroAqu0KWy6FpQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9VE-000Fm0-BN; Thu, 29 Nov 2018 00:44:20 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 24ACFC11D1;
        Thu, 29 Nov 2018 00:44:18 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 24/27] locking/lockdep: Introduce __lockdep_free_key_range()
Date:   Wed, 28 Nov 2018 15:43:22 -0800
Message-Id: <20181128234325.110011-25-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5hzyFdjGlx6tEe7vOl5bjXd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aXGF+G3
 7fckuXb2d59fmWYFq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18nXQzDvPzq7iERC
 6EDedzAjmyYYU3CsO603Rr9gA1bVSpPtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MVk3S8cdFMAolK/BUHU4j3f5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change any functionality but makes the next patch
in this series easier to read.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 141bb0662ff5..0e273731d028 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4459,18 +4459,16 @@ static void free_zapped_classes(struct list_head *zapped_classes)
 }
 
 /*
- * Used in module.c to remove lock classes from memory that is going to be
- * freed; and possibly re-used by other modules.
- *
- * We will have had one sync_sched() before getting here, so we're guaranteed
- * nobody will look up these exact classes -- they're properly dead but still
- * allocated.
+ * Remove all lock classes from the class hash table and from the
+ * all_lock_classes list whose key or name is in the address range
+ * [start, start + size). Move these lock classes to the
+ * @zapped_classes list.
  */
-void lockdep_free_key_range(void *start, unsigned long size)
+static void __lockdep_free_key_range(struct list_head *zapped_classes,
+				     void *start, unsigned long size)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
-	LIST_HEAD(zapped_classes);
 	unsigned long flags;
 	int i;
 	int locked;
@@ -4478,9 +4476,8 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	raw_local_irq_save(flags);
 	locked = graph_lock();
 
-	/*
-	 * Unhash all classes that were created by this module:
-	 */
+	INIT_LIST_HEAD(zapped_classes);
+
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
 		hlist_for_each_entry_rcu(class, head, hash_entry) {
@@ -4488,14 +4485,28 @@ void lockdep_free_key_range(void *start, unsigned long size)
 			    (!within(class->key, start, size) &&
 			     !within(class->name, start, size)))
 				continue;
-			zap_class(&zapped_classes, class);
+			zap_class(zapped_classes, class);
 		}
 	}
 
 	if (locked)
 		graph_unlock();
 	raw_local_irq_restore(flags);
+}
+
+/*
+ * Used in module.c to remove lock classes from memory that is going to be
+ * freed; and possibly re-used by other modules.
+ *
+ * We will have had one sync_sched() before getting here, so we're guaranteed
+ * nobody will look up these exact classes -- they're properly dead but still
+ * allocated.
+ */
+void lockdep_free_key_range(void *start, unsigned long size)
+{
+	LIST_HEAD(zapped_classes);
 
+	__lockdep_free_key_range(&zapped_classes, start, size);
 	free_zapped_classes(&zapped_classes);
 }
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

