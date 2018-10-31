Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141D9ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D027D2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqV2sVlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D027D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeKAIIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbeKAIIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F2E20664;
        Wed, 31 Oct 2018 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027278;
        bh=bRKgJ+xBYUCEpjXEyHI+O3QUHYNbv1I4xyLFczcsd4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqV2sVlUvuxbd6FVksxhyTlUQlnPFTumaZf1RlZgqCoAzq/L7NdtvNFV1cDB1Ha1g
         mjcgZaafyGr338U/lFRJlTUKqfJcbRgcA7oKakPpohonUw4Bhj1g5lEaY8lSHcrgOZ
         zWOhUz9qlb5xar0Tn+pMlQTgJmRn+49JxZy/OiKo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 003/126] locking/lockdep: Fix debug_locks off performance problem
Date:   Wed, 31 Oct 2018 19:05:51 -0400
Message-Id: <20181031230754.29029-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

[ Upstream commit 9506a7425b094d2f1d9c877ed5a78f416669269b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep.c | 4 ++--
 lib/debug_locks.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..aa6ebb799f16 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4148,7 +4148,7 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	if (unlikely(!lock_stat))
+	if (unlikely(!lock_stat || !debug_locks))
 		return;
 
 	if (unlikely(current->lockdep_recursion))
@@ -4168,7 +4168,7 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
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
-- 
2.17.1

