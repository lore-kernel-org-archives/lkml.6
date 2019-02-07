Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8860DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F60F218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBGTKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:10:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfBGTK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:10:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03F0B37E85;
        Thu,  7 Feb 2019 19:10:26 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB62662FA3;
        Thu,  7 Feb 2019 19:10:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 22/22] locking/rwsem: Ensure an RT task will not spin on reader
Date:   Thu,  7 Feb 2019 14:07:26 -0500
Message-Id: <1549566446-27967-23-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 07 Feb 2019 19:10:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An RT task can do optimistic spinning only if the lock holder is
actually running. If the state of the lock holder isn't known, there
is a possibility that high priority of the RT task may block forward
progress of the lock holder if they happen to reside on the same CPU.
This will lead to deadlock. So we have to make sure that an RT task
will not spin on a reader-owned rwsem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 3cf2e84..ac1f6c4 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -349,12 +349,14 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 /*
  * Return the folowing three values depending on the lock owner state.
+ *   2	when owner is currently NULL
  *   1	when owner changes and no reader is detected yet.
  *   0	when owner changes and the new owner may be a reader.
  *  -1	when optimistic spinning has to stop because either the owner stops
  *	running, is unknown, or its timeslice has been used up.
  */
 enum owner_state {
+	OWNER_NULL = 2,
 	OWNER_SPINNABLE = 1,
 	OWNER_READER = 0,
 	OWNER_NONSPINNABLE = -1,
@@ -405,7 +407,8 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
 	owner = rwsem_get_owner(sem);
 	if (!is_rwsem_owner_spinnable(owner))
 		return OWNER_NONSPINNABLE;
-	return is_rwsem_owner_reader(owner) ? OWNER_READER : OWNER_SPINNABLE;
+	return !owner ? OWNER_NULL :
+	       is_rwsem_owner_reader(owner) ? OWNER_READER : OWNER_SPINNABLE;
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
@@ -442,12 +445,13 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 			break;
 
 		/*
-		 * When there's no owner, we might have preempted between the
-		 * owner acquiring the lock and setting the owner field. If
-		 * we're an RT task that will live-lock because we won't let
-		 * the owner complete.
+		 * An RT task cannot do optimistic spinning if it cannot
+		 * be sure the lock holder is running. When there's no owner
+		 * or is reader-owned, an RT task has to stop spinning or
+		 * live-lock may happen if the current task and the lock
+		 * holder happen to run in the same CPU.
 		 */
-		if (!rwsem_get_owner(sem) &&
+		if ((owner_state != OWNER_SPINNABLE) &&
 		   (need_resched() || rt_task(current)))
 			break;
 
-- 
1.8.3.1

