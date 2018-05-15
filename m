Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752433AbeEOGfG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:35:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeEOGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:35:04 -0400
Date: Mon, 14 May 2018 23:34:19 -0700
From: tip-bot for Alan Stern <tipbot@zytor.com>
Message-ID: <tip-cee0321a404fe6b43d1f4364639c8ffe2f2b37d1@git.kernel.org>
Cc: paulmck@linux.vnet.ibm.com, andrea.parri@amarulasolutions.com,
        boqun.feng@gmail.com, stern@rowland.harvard.edu, j.alglave@ucl.ac.uk,
        hpa@zytor.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com, mingo@kernel.org,
        luc.maranget@inria.fr, tglx@linutronix.de, npiggin@gmail.com,
        peterz@infradead.org, akiyks@gmail.com, will.deacon@arm.com
Reply-To: luc.maranget@inria.fr, tglx@linutronix.de, npiggin@gmail.com,
        peterz@infradead.org, akiyks@gmail.com, will.deacon@arm.com,
        torvalds@linux-foundation.org, dhowells@redhat.com, mingo@kernel.org,
        akpm@linux-foundation.org, hpa@zytor.com, j.alglave@ucl.ac.uk,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        stern@rowland.harvard.edu
In-Reply-To: <1526340837-12222-15-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-15-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Remove out-of-date comments
 and code from lock.cat
Git-Commit-ID: cee0321a404fe6b43d1f4364639c8ffe2f2b37d1
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

Commit-ID:  cee0321a404fe6b43d1f4364639c8ffe2f2b37d1
Gitweb:     https://git.kernel.org/tip/cee0321a404fe6b43d1f4364639c8ffe2f2b37d1
Author:     Alan Stern <stern@rowland.harvard.edu>
AuthorDate: Mon, 14 May 2018 16:33:53 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:18 +0200

tools/memory-model: Remove out-of-date comments and code from lock.cat

lock.cat contains old comments and code referring to the possibility
of LKR events that are not part of an RMW pair.  This is a holdover
from when I though we might end up using LKR events to implement
spin_is_locked().  Reword the comments to remove this assumption and
replace domain(lk-rmw) in the code with LKR.

Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
[ paulmck: Pulled as lock-nest into previous line as discussed. ]
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/1526340837-12222-15-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/lock.cat | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 7217cd4941a4..cd002a33ca8a 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -47,18 +47,15 @@ flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
 let rmw = rmw | lk-rmw
 
+(* The litmus test is invalid if an LKR/LKW event is not part of an RMW pair *)
+flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
+flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
+
 (*
- * A paired LKR must always see an unlocked value; spin_lock() calls nested
+ * An LKR must always see an unlocked value; spin_lock() calls nested
  * inside a critical section (for the same lock) always deadlock.
  *)
-empty ([LKW] ; po-loc ; [domain(lk-rmw)]) \ (po-loc ; [UL] ; po-loc)
-	as lock-nest
-
-(* The litmus test is invalid if an LKW event is not part of an RMW pair *)
-flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
-
-(* This will be allowed if we implement spin_is_locked() *)
-flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
+empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
 
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
