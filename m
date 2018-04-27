Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeD0LB7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:01:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeD0LB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:01:58 -0400
Date: Fri, 27 Apr 2018 04:01:31 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-3bea9adc96842b8a7345c7fb202c16ae9c8d5b25@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will.deacon@arm.com, longman@redhat.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
        longman@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180427101619.GB21705@arm.com>
References: <20180427101619.GB21705@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Remove duplicate
 clear_pending() function from PV code
Git-Commit-ID: 3bea9adc96842b8a7345c7fb202c16ae9c8d5b25
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3bea9adc96842b8a7345c7fb202c16ae9c8d5b25
Gitweb:     https://git.kernel.org/tip/3bea9adc96842b8a7345c7fb202c16ae9c8d5b25
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Fri, 27 Apr 2018 10:40:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 12:55:22 +0200

locking/qspinlock: Remove duplicate clear_pending() function from PV code

The native clear_pending() function is identical to the PV version, so the
latter can simply be removed.

This fixes the build for systems with >= 16K CPUs using the PV lock implementation.

Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/20180427101619.GB21705@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock_paravirt.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 25730b2ac022..5a0cf5f9008c 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -130,11 +130,6 @@ static __always_inline void set_pending(struct qspinlock *lock)
 	atomic_or(_Q_PENDING_VAL, &lock->val);
 }
 
-static __always_inline void clear_pending(struct qspinlock *lock)
-{
-	atomic_andnot(_Q_PENDING_VAL, &lock->val);
-}
-
 static __always_inline int trylock_clear_pending(struct qspinlock *lock)
 {
 	int val = atomic_read(&lock->val);
