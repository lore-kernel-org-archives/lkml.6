Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6077C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEBF222DB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391805AbfBOUvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:51:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391321AbfBOUu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:50:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A74F325B0;
        Fri, 15 Feb 2019 20:50:27 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4CF35BBB4;
        Fri, 15 Feb 2019 20:50:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 04/10] locking/rwsem: Micro-optimize rwsem_try_read_lock_unqueued()
Date:   Fri, 15 Feb 2019 15:50:04 -0500
Message-Id: <1550263810-31947-5-git-send-email-longman@redhat.com>
In-Reply-To: <1550263810-31947-1-git-send-email-longman@redhat.com>
References: <1550263810-31947-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Feb 2019 20:50:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic_long_cmpxchg_acquire() in rwsem_try_read_lock_unqueued() is
replaced by atomic_long_try_cmpxchg_acquire() to simpify the code and
generate slightly better assembly code. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index c213869..f6198e1 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -259,21 +259,16 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
  */
 static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
-	long old, count = atomic_long_read(&sem->count);
+	long count = atomic_long_read(&sem->count);
 
-	while (true) {
-		if (!(count == 0 || count == RWSEM_WAITING_BIAS))
-			return false;
-
-		old = atomic_long_cmpxchg_acquire(&sem->count, count,
-				      count + RWSEM_ACTIVE_WRITE_BIAS);
-		if (old == count) {
+	while (!count || count == RWSEM_WAITING_BIAS) {
+		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
+					count + RWSEM_ACTIVE_WRITE_BIAS)) {
 			rwsem_set_owner(sem);
 			return true;
 		}
-
-		count = old;
 	}
+	return false;
 }
 
 static inline bool owner_on_cpu(struct task_struct *owner)
-- 
1.8.3.1

