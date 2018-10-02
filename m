Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975D4C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C9720684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 20:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C9720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeJCDFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJCDFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7386488304;
        Tue,  2 Oct 2018 20:20:42 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCE7C308BDA0;
        Tue,  2 Oct 2018 20:20:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/5] locking/lockdep: Eliminate redundant irqs check in __lock_acquire()
Date:   Tue,  2 Oct 2018 16:19:17 -0400
Message-Id: <1538511560-10090-3-git-send-email-longman@redhat.com>
In-Reply-To: <1538511560-10090-1-git-send-email-longman@redhat.com>
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 02 Oct 2018 20:20:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static __lock_acquire() function has only two callers:

 1) lock_acquire()
 2) reacquire_held_locks()

In lock_acquire(), raw_local_irq_save() is called beforehand. So
IRQs must have been disabled. So the check

	DEBUG_LOCKS_WARN_ON(!irqs_disabled())

is kind of redundant in this case. So move the above check
to reacquire_held_locks() to eliminate redundant code in the
lock_acquire() path.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8f9de7cd11ab..bd59163b0550 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3192,6 +3192,10 @@ static int __lock_is_held(const struct lockdep_map *lock, int read);
 /*
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
+ *
+ * The callers must make sure that IRQs are disabled before calling it,
+ * otherwise we could get an interrupt which would want to take locks,
+ * which would end up in lockdep again.
  */
 static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			  int trylock, int read, int check, int hardirqs_off,
@@ -3209,14 +3213,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (unlikely(!debug_locks))
 		return 0;
 
-	/*
-	 * Lockdep should run with IRQs disabled, otherwise we could
-	 * get an interrupt which would want to take locks, which would
-	 * end up in lockdep and have you got a head-ache already?
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return 0;
-
 	if (!prove_locking || lock->key == &__lockdep_no_validate__)
 		check = 0;
 
@@ -3473,6 +3469,9 @@ static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
 {
 	struct held_lock *hlock;
 
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return 0;
+
 	for (hlock = curr->held_locks + idx; idx < depth; idx++, hlock++) {
 		if (!__lock_acquire(hlock->instance,
 				    hlock_class(hlock)->subclass,
-- 
2.18.0

