Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E4EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F99206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="Enogb7nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F99206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeK2Ksx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:48:53 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:51549 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeK2Krg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=qnOH8mtyDsV6uBsBrursnWqFrinIvlyAS0G+wPDhnWg=; b=Enogb7nmzIxl
        +FNQA3zS+VAdf5YDoHYA1TeLFff81oOHJBEw+pxXtN0vkQfyWBezqRKfHCQHlnsbawKiswckVnK41
        TEUrkPvX8W1YQrgxDql5LdsoBieOVw5DA4ClLOn8TeOwY9ZWPR+3CBv5vGoR++gOjng1lnxk4mLj/
        Fcb9kTFU3mSNwxFgqzIaFdwiWzNuWSIZr8Eo0RdKrxbPaGDVkj5IzTTDWdbHrvlb6k3Yw0MDftQJw
        Zj5R2265Lu1mQSPdwv2PP/AVutwUWFLGoD9lyrTA6KRgZPLejEvXIr2wcRhg9UYzibs1IF/HLYiCp
        Yfnt335VpviK7zTWTZH13g==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9V1-000241-QF; Thu, 29 Nov 2018 00:44:07 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id A0FACC11FB;
        Thu, 29 Nov 2018 00:44:05 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 16/27] locking/lockdep: Stop using RCU primitives to access all_lock_classes
Date:   Wed, 28 Nov 2018 15:43:14 -0800
Message-Id: <20181128234325.110011-17-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vxYY358VxPcLwMIIuMjqoF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aUfwSak
 bQKrnum0UZujbSYsq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi2wFVccsCAZ2dyI5DAR
 qfkZNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18n4mJSlGpCLjjP2
 TVCcvwpq3FcGtdhyHYweuIW+h8Cn0ZPtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MWEsV9rLlsboHxOlqxT8p/B5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the previous patch all code that accesses the 'all_lock_classes'
list holds the graph lock. Hence use regular list primitives instead of
their RCU variants to access this list.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ab6abe52e974..96fc8e92c2a6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -626,7 +626,8 @@ static int static_obj(void *obj)
 
 /*
  * To make lock name printouts unique, we calculate a unique
- * class->name_version generation counter:
+ * class->name_version generation counter. The caller must hold the graph
+ * lock.
  */
 static int count_matching_names(struct lock_class *new_class)
 {
@@ -636,7 +637,7 @@ static int count_matching_names(struct lock_class *new_class)
 	if (!new_class->name)
 		return 0;
 
-	list_for_each_entry_rcu(class, &all_lock_classes, lock_entry) {
+	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 		if (new_class->key - new_class->subclass == class->key)
 			return class->name_version;
 		if (class->name && !strcmp(class->name, new_class->name))
@@ -801,7 +802,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	/*
 	 * Add it to the global list of classes:
 	 */
-	list_add_tail_rcu(&class->lock_entry, &all_lock_classes);
+	list_add_tail(&class->lock_entry, &all_lock_classes);
 
 	if (verbose(class)) {
 		graph_unlock();
@@ -4120,6 +4121,9 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
+/*
+ * Remove all references to a lock class. The caller must hold the graph lock.
+ */
 static void zap_class(struct lock_class *class)
 {
 	int i;
@@ -4136,7 +4140,7 @@ static void zap_class(struct lock_class *class)
 	 * Unhash the class and remove it from the all_lock_classes list:
 	 */
 	hlist_del_rcu(&class->hash_entry);
-	list_del_rcu(&class->lock_entry);
+	list_del(&class->lock_entry);
 
 	RCU_INIT_POINTER(class->key, NULL);
 	RCU_INIT_POINTER(class->name, NULL);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

