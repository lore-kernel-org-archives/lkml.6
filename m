Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeEOGd1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:33:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeEOGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:33:25 -0400
Date: Mon, 14 May 2018 23:32:46 -0700
From: tip-bot for Alan Stern <tipbot@zytor.com>
Message-ID: <tip-8559183ccaec97454b2515ac426f113967256cf9@git.kernel.org>
Cc: mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com,
        dhowells@redhat.com, andrea.parri@amarulasolutions.com,
        torvalds@linux-foundation.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, akiyks@gmail.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, stern@rowland.harvard.edu,
        akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org,
        npiggin@gmail.com, hpa@zytor.com
Reply-To: npiggin@gmail.com, hpa@zytor.com, peterz@infradead.org,
        akpm@linux-foundation.org, tglx@linutronix.de, akiyks@gmail.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, stern@rowland.harvard.edu,
        boqun.feng@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        andrea.parri@amarulasolutions.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, will.deacon@arm.com
In-Reply-To: <1526340837-12222-12-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-12-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Remove duplicated code from
 lock.cat
Git-Commit-ID: 8559183ccaec97454b2515ac426f113967256cf9
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

Commit-ID:  8559183ccaec97454b2515ac426f113967256cf9
Gitweb:     https://git.kernel.org/tip/8559183ccaec97454b2515ac426f113967256cf9
Author:     Alan Stern <stern@rowland.harvard.edu>
AuthorDate: Mon, 14 May 2018 16:33:50 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:17 +0200

tools/memory-model: Remove duplicated code from lock.cat

This patch simplifies the implementation of spin_is_locked in the
LKMM.  It capitalizes on the fact that a failed spin_trylock() and a
spin_is_locked() which returns True have exactly the same semantics
(those of READ_ONCE) and ordering properties (none).  Therefore the
two kinds of events can be combined and handled by the same code,
instead of treated separately as they are currently.

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
Link: http://lkml.kernel.org/r/1526340837-12222-12-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/lock.cat | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 3b1439edc818..1f6d67e79065 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -41,11 +41,15 @@ flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
  *)
 let RL = try RL with emptyset (* defined herd7 >= 7.49 *)
 let RU = try RU with emptyset (* defined herd7 >= 7.49 *)
+
+(* Treat RL as a kind of LF: a read with no ordering properties *)
+let LF = LF | RL
+
 (*
  * Put lock operations in their appropriate classes, but leave UL out of W
  * until after the co relation has been generated.
  *)
-let R = R | LKR | LF | RL | RU
+let R = R | LKR | LF | RU
 let W = W | LKW
 
 let Release = Release | UL
@@ -80,28 +84,8 @@ let all-possible-rfe-lf =
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
-
 let rf-lf = rfe-lf | rfi-lf
 
-(* rf for RL events, ie islocked returning true, similar to LF above *)
-
-(* islocked returning true inside a critical section
- * must read from the opening lock
- *)
-let rfi-rl = ([LKW] ; po-loc ; [RL]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
-
-(* islocked returning true outside critical sections can match any
- * external lock.
- *)
-let all-possible-rfe-rl =
-  let possible-rfe-lf r =
-    let pair-to-relation p = p ++ 0
-    in map pair-to-relation ((LKW * {r}) & loc & ext)
-  in map possible-rfe-lf (RL \ range(rfi-rl))
-
-with rfe-rl from cross(all-possible-rfe-rl)
-let rf-rl = rfe-rl | rfi-rl
-
 (* Read from unlock, ie islocked returning false, slightly different *)
 
 (* islocked returning false can read from the last po-previous unlock *)
@@ -118,7 +102,7 @@ with rfe-ru from cross(all-possible-rfe-ru)
 let rf-ru = rfe-ru | rfi-ru
 
 (* Final rf relation *)
-let rf = rf | rf-lf | rf-rl | rf-ru
+let rf = rf | rf-lf | rf-ru
 
 (* Generate all co relations, including LKW events but not UL *)
 let co0 = co0 | ([IW] ; loc ; [LKW]) |
