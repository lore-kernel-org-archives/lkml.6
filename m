Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934106AbeBMP3o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:29:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933789AbeBMP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:29:42 -0500
Date: Tue, 13 Feb 2018 07:28:18 -0800
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-61e02392d3c7ecac1f91c0a90a8043d67e081846@git.kernel.org>
Cc: torvalds@linux-foundation.org, peterz@infradead.org,
        will.deacon@arm.com, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, will.deacon@arm.com, tglx@linutronix.de,
        hpa@zytor.com
In-Reply-To: <1518528619-20049-1-git-send-email-will.deacon@arm.com>
References: <1518528619-20049-1-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/atomic/bitops: Document and clarify
 ordering semantics for failed test_and_{}_bit()
Git-Commit-ID: 61e02392d3c7ecac1f91c0a90a8043d67e081846
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

Commit-ID:  61e02392d3c7ecac1f91c0a90a8043d67e081846
Gitweb:     https://git.kernel.org/tip/61e02392d3c7ecac1f91c0a90a8043d67e081846
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Tue, 13 Feb 2018 13:30:19 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 14:55:53 +0100

locking/atomic/bitops: Document and clarify ordering semantics for failed test_and_{}_bit()

A test_and_{}_bit() operation fails if the value of the bit is such that
the modification does not take place. For example, if test_and_set_bit()
returns 1. In these cases, follow the behaviour of cmpxchg and allow the
operation to be unordered. This also applies to test_and_set_bit_lock()
if the lock is found to be be taken already.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518528619-20049-1-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/atomic_bitops.txt   | 7 ++++++-
 include/asm-generic/bitops/lock.h | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/atomic_bitops.txt b/Documentation/atomic_bitops.txt
index 5550bfdc..be70b32 100644
--- a/Documentation/atomic_bitops.txt
+++ b/Documentation/atomic_bitops.txt
@@ -58,7 +58,12 @@ Like with atomic_t, the rule of thumb is:
 
  - RMW operations that have a return value are fully ordered.
 
-Except for test_and_set_bit_lock() which has ACQUIRE semantics and
+ - RMW operations that are conditional are unordered on FAILURE,
+   otherwise the above rules apply. In the case of test_and_{}_bit() operations,
+   if the bit in memory is unchanged by the operation then it is deemed to have
+   failed.
+
+Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics and
 clear_bit_unlock() which has RELEASE semantics.
 
 Since a platform only has a single means of achieving atomic operations
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
index bc39757..67ab280 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -7,7 +7,8 @@
  * @nr: Bit to set
  * @addr: Address to count from
  *
- * This operation is atomic and provides acquire barrier semantics.
+ * This operation is atomic and provides acquire barrier semantics if
+ * the returned value is 0.
  * It can be used to implement bit locks.
  */
 #define test_and_set_bit_lock(nr, addr)	test_and_set_bit(nr, addr)
