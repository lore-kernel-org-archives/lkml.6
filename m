Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F938218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="KSSYo8i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfBNXB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:01:56 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:53931 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfBNXBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=736BJJI9Id829g11v7ieOoiScctTBqb5x6byc8O8ni0=; b=KSSYo8i0CSSU
        2AaKiflZUTubTEL4E+4gS/DoHwlilF+uqeF0CU4GF3wFzMGbNBKh33xhOIyTb7MLKpz4Cc1xSAiL2
        8Ctr+MO3pGAs1Ro6X5tJ7lIgMUNhUDL3KoFDQ9fFW3klVObQEnFoQV7xUkJzzSlM34EkbnpDhXk8O
        NIo33r5OjZgwbSPeItN+3NhmEMfNLqT/lciZmrWwwfW4+GEo+SKJOSq2so7T1B7B++1yh3DSnidcD
        nYigS68QQ77k7CPxrkvtQaw1DY/FXNGPRikYedBZMoAOoTt9GELYr7KWJPL7lc62JOGN4C73P0lLW
        Ug5y4ZJ0NkCgLbvAFTcTyg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0g-000DOW-1S; Fri, 15 Feb 2019 00:01:38 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 93623C08FC;
        Fri, 15 Feb 2019 00:01:35 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 12/23] locking/lockdep: Reuse list entries that are no longer in use
Date:   Thu, 14 Feb 2019 15:00:47 -0800
Message-Id: <20190214230058.196511-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5mUfYjbL5ty1v/UUngWPnlx602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59oRO7/PBPSDiDxs11bhdKK1kCAsLDoDtKH0HAWJG1+Vhy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0VpXCEqSenvCQusD//B2Ay/sMI2sWxDLHKoH6dsbCFwPr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHSVErAoIU4nUSSDjAwZN9DiweCHJOtc3aoyMrLane
 z28hu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
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
 kernel/locking/lockdep.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6920f406ee91..4308f0b9ecd5 100644
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
@@ -907,7 +909,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
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
 
@@ -915,7 +920,9 @@ static struct lock_list *alloc_list_entry(void)
 		dump_stack();
 		return NULL;
 	}
-	return list_entries + nr_list_entries++;
+	nr_list_entries++;
+	__set_bit(idx, list_entries_in_use);
+	return list_entries + idx;
 }
 
 /*
@@ -1019,7 +1026,7 @@ static inline void mark_lock_accessed(struct lock_list *lock,
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	lock->parent = parent;
 	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
@@ -1029,7 +1036,7 @@ static inline unsigned long lock_accessed(struct lock_list *lock)
 	unsigned long nr;
 
 	nr = lock - list_entries;
-	WARN_ON(nr >= nr_list_entries); /* Out-of-bounds, input fail */
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
 }
 
@@ -4288,13 +4295,13 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+	for_each_set_bit(i, list_entries_in_use, ARRAY_SIZE(list_entries)) {
+		entry = list_entries + i;
 		if (entry->class != class && entry->links_to != class)
 			continue;
+		__clear_bit(i, list_entries_in_use);
+		nr_list_entries--;
 		list_del_rcu(&entry->entry);
-		/* Clear .class and .links_to to avoid double removal. */
-		WRITE_ONCE(entry->class, NULL);
-		WRITE_ONCE(entry->links_to, NULL);
 	}
 	if (list_empty(&class->locks_after) &&
 	    list_empty(&class->locks_before)) {
@@ -4608,6 +4615,7 @@ void __init lockdep_init(void)
 	       (sizeof(lock_classes) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
+		sizeof(list_entries_in_use) +
 		sizeof(chainhash_table) +
 		sizeof(delayed_free)
 #ifdef CONFIG_PROVE_LOCKING
-- 
2.21.0.rc0.258.g878e2cd30e-goog

