Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeEOGef (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:34:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeEOGee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:34:34 -0400
Date: Mon, 14 May 2018 23:33:49 -0700
From: tip-bot for Alan Stern <tipbot@zytor.com>
Message-ID: <tip-30b795df11a1a9dd7fc50c1ff4677343b67cb379@git.kernel.org>
Cc: luc.maranget@inria.fr, mingo@kernel.org, tglx@linutronix.de,
        stern@rowland.harvard.edu, will.deacon@arm.com, j.alglave@ucl.ac.uk,
        paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        dhowells@redhat.com, peterz@infradead.org, npiggin@gmail.com,
        akiyks@gmail.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: dhowells@redhat.com, akpm@linux-foundation.org, boqun.feng@gmail.com,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        j.alglave@ucl.ac.uk, will.deacon@arm.com, hpa@zytor.com,
        andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org,
        akiyks@gmail.com, npiggin@gmail.com, peterz@infradead.org,
        luc.maranget@inria.fr, tglx@linutronix.de, stern@rowland.harvard.edu,
        mingo@kernel.org
In-Reply-To: <1526340837-12222-14-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-14-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Improve mixed-access
 checking in lock.cat
Git-Commit-ID: 30b795df11a1a9dd7fc50c1ff4677343b67cb379
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

Commit-ID:  30b795df11a1a9dd7fc50c1ff4677343b67cb379
Gitweb:     https://git.kernel.org/tip/30b795df11a1a9dd7fc50c1ff4677343b67cb379
Author:     Alan Stern <stern@rowland.harvard.edu>
AuthorDate: Mon, 14 May 2018 16:33:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:18 +0200

tools/memory-model: Improve mixed-access checking in lock.cat

The code in lock.cat which checks for normal read/write accesses to
spinlock variables doesn't take into account the newly added RL and RU
events.  Add them into the test, and move the resulting code up near
the start of the file, since a violation would indicate a pretty
severe conceptual error in a litmus test.

Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
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
Link: http://lkml.kernel.org/r/1526340837-12222-14-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/lock.cat | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index df74de2148f6..7217cd4941a4 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -32,6 +32,17 @@ include "cross.cat"
  * LKW, LF, RL, and RU have no ordering properties.
  *)
 
+(* Backward compatibility *)
+let RL = try RL with emptyset
+let RU = try RU with emptyset
+
+(* Treat RL as a kind of LF: a read with no ordering properties *)
+let LF = LF | RL
+
+(* There should be no ordinary R or W accesses to spinlocks *)
+let ALL-LOCKS = LKR | LKW | UL | LF | RU
+flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
+
 (* Link Lock-Reads to their RMW-partner Lock-Writes *)
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
 let rmw = rmw | lk-rmw
@@ -49,20 +60,9 @@ flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
 (* This will be allowed if we implement spin_is_locked() *)
 flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
 
-(* There should be no ordinary R or W accesses to spinlocks *)
-let ALL-LOCKS = LKR | LKW | UL | LF
-flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
-
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
 
-(* Backward compatibility *)
-let RL = try RL with emptyset
-let RU = try RU with emptyset
-
-(* Treat RL as a kind of LF: a read with no ordering properties *)
-let LF = LF | RL
-
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
