Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F12C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EDC218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="JjhAQsBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfBNXBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:01:49 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:42201 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfBNXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=A9qVKkvs9RCi7UZ33oeUbPa479vpxrfYvdnCF0+oiS4=; b=JjhAQsBt6HCf
        wwjxNHudjj4Y87CSfKo60w360vflrZpKh6eLw4icee2ioMtTkCHGgt6DLPbLOmd7i6DzZXV+Wli+r
        4D7Hzze3sdbi71leN+bFJIclSK8WkyFZOtoBuuknFyoAGgrNMCoVEhfpjuaDXTH63F1kZwtJCMBWW
        KtAHBIIxDx+AWqtMvFh8s4NzJF2/1iaqSAehhT+SysSOjYJAqGdK1fj9kE3D/tTB9cCwsiz1ntVEs
        6sTusF5bUL07OaV0TIw+RfBhIeVLOm3UvU1tRGJ+vxVtGH+WtsakY8R2NWW6cwVlLLEoioQ8eVXvM
        kqoez0pypK0rukgsEOFJEA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0X-000DLb-4T; Fri, 15 Feb 2019 00:01:29 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 78A79C0482;
        Fri, 15 Feb 2019 00:01:26 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 08/23] locking/lockdep: Split lockdep_free_key_range() and lockdep_reset_lock()
Date:   Thu, 14 Feb 2019 15:00:43 -0800
Message-Id: <20190214230058.196511-9-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00491219171721)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vXX3MCdVeRcasSYxSsUJZh602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59xO7WfFJRiO6C5Q5a53OBcFkCAsLDoDtKH0HAWJG1+Vhy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VJ9oPeZuzI4YvGloR1iXZcQ6
 rDn0tTOVcmJwqI8Ju2ne/wwIwzyV/WMPB6zTEWzEncEKJtZE3p7YZqOA3SmjVruGpS+C6BPAIEs8
 PiiVo3Eboi+cbnT5PTDQNVG9E6gOGiUCAW1FDxcZal9mohvTtVuaBo55LoXJ38umBncoBPaTGplH
 cpVCCoX989hgB8R+yBNKgbPqM+gWqiGtLl4stWokc9uykHalFfjbaRfu7LxQjgWlveNnni7FwtfH
 0sq4xXbBteMJzAkMC43e8+sp9ik9r/0RENuxoUHLfdnX97lYWfNCwcrS0aokqY9q7nrY3hEVniih
 uDwEGDcmr6e3OPRLa16pGRvAB1MNCAVzZzPG/W30w/zDcz636yEnTyvlnaXYc5sCGBmhSF08PTuw
 vsoFUZ4OKQBuL/EuEHX3HwZrctgzcDoFd+96Xw4QUNtTnfzp6yaSzf/mBOxmctH1xJW7ZqDnEZyA
 /o9yCJs753i5Anc+dePvuOLndsGRtxRwqudKEy7bP5gIt23U7fpAnNNWb77i3eb3c6Xj53IToZwL
 VabjergYMIEHYgna2Grb/XBEn95eECKi3gxjzXac2CKNL6Ugwa8G8LUBaMaYDRNMLxoq67wPPyTr
 tPptswtkm3vs+M4bivZGPOywGIoCFD0=
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
 kernel/locking/lockdep.c | 72 ++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9967599d7864..7f80d8789978 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4172,6 +4172,24 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
+static void __lockdep_free_key_range(void *start, unsigned long size)
+{
+	struct lock_class *class;
+	struct hlist_head *head;
+	int i;
+
+	/* Unhash all classes that were created by a module. */
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
@@ -4182,30 +4200,14 @@ static inline int within(const void *addr, void *start, unsigned long size)
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
@@ -4247,16 +4249,11 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
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
@@ -4273,19 +4270,22 @@ void lockdep_reset_lock(struct lockdep_map *lock)
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
2.21.0.rc0.258.g878e2cd30e-goog

