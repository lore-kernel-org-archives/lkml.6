Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5138421470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5138421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeJSRkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:40:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38735 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSRkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:40:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9J9XpBn1183584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Oct 2018 02:33:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9J9Xpvu1183581;
        Fri, 19 Oct 2018 02:33:51 -0700
Date:   Fri, 19 Oct 2018 02:33:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-9506a7425b094d2f1d9c877ed5a78f416669269b@git.kernel.org>
Cc:     longman@redhat.com, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, hpa@zytor.com, will.deacon@arm.com
Reply-To: hpa@zytor.com, will.deacon@arm.com,
          torvalds@linux-foundation.org, akpm@linux-foundation.org,
          mingo@kernel.org, longman@redhat.com, paulmck@linux.vnet.ibm.com,
          tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <1539913518-15598-1-git-send-email-longman@redhat.com>
References: <1539913518-15598-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Fix debug_locks off performance
 problem
Git-Commit-ID: 9506a7425b094d2f1d9c877ed5a78f416669269b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9506a7425b094d2f1d9c877ed5a78f416669269b
Gitweb:     https://git.kernel.org/tip/9506a7425b094d2f1d9c877ed5a78f416669269b
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 18 Oct 2018 21:45:17 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Oct 2018 07:53:17 +0200

locking/lockdep: Fix debug_locks off performance problem

It was found that when debug_locks was turned off because of a problem
found by the lockdep code, the system performance could drop quite
significantly when the lock_stat code was also configured into the
kernel. For instance, parallel kernel build time on a 4-socket x86-64
server nearly doubled.

Further analysis into the cause of the slowdown traced back to the
frequent call to debug_locks_off() from the __lock_acquired() function
probably due to some inconsistent lockdep states with debug_locks
off. The debug_locks_off() function did an unconditional atomic xchg
to write a 0 value into debug_locks which had already been set to 0.
This led to severe cacheline contention in the cacheline that held
debug_locks.  As debug_locks is being referenced in quite a few different
places in the kernel, this greatly slow down the system performance.

To prevent that trashing of debug_locks cacheline, lock_acquired()
and lock_contended() now checks the state of debug_locks before
proceeding. The debug_locks_off() function is also modified to check
debug_locks before calling __debug_locks_off().

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1539913518-15598-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 4 ++--
 lib/debug_locks.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index be76f476c63f..1efada2dd9dd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4066,7 +4066,7 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	if (unlikely(!lock_stat))
+	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
 	if (unlikely(current->lockdep_recursion))
@@ -4086,7 +4086,7 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	if (unlikely(!lock_stat))
+	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
 	if (unlikely(current->lockdep_recursion))
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index 96c4c633d95e..124fdf238b3d 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
  */
 int debug_locks_off(void)
 {
-	if (__debug_locks_off()) {
+	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
 			console_verbose();
 			return 1;
