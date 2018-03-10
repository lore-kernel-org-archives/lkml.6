Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeCJJ2O (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:28:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeCJJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:28:12 -0500
Date: Sat, 10 Mar 2018 01:27:49 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-f28f0868feb1e79b460131bac37230e303a5f6a4@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        hpa@zytor.com, peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
In-Reply-To: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers: De-emphasize
 smp_read_barrier_depends() some more
Git-Commit-ID: f28f0868feb1e79b460131bac37230e303a5f6a4
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

Commit-ID:  f28f0868feb1e79b460131bac37230e303a5f6a4
Gitweb:     https://git.kernel.org/tip/f28f0868feb1e79b460131bac37230e303a5f6a4
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Wed, 7 Mar 2018 09:27:37 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 10 Mar 2018 10:22:22 +0100

locking/memory-barriers: De-emphasize smp_read_barrier_depends() some more

This commit makes further changes to memory-barrier.txt to further
de-emphasize smp_read_barrier_depends(), but leaving some discussion
for historical purposes.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/memory-barriers.txt | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index da6525bdc3f5..6dafc8085acc 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -52,7 +52,7 @@ CONTENTS
 
      - Varieties of memory barrier.
      - What may not be assumed about memory barriers?
-     - Data dependency barriers.
+     - Data dependency barriers (historical).
      - Control dependencies.
      - SMP barrier pairing.
      - Examples of memory barrier sequences.
@@ -554,8 +554,15 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	    Documentation/DMA-API.txt
 
 
-DATA DEPENDENCY BARRIERS
-------------------------
+DATA DEPENDENCY BARRIERS (HISTORICAL)
+-------------------------------------
+
+As of v4.15 of the Linux kernel, an smp_read_barrier_depends() was
+added to READ_ONCE(), which means that about the only people who
+need to pay attention to this section are those working on DEC Alpha
+architecture-specific code and those working on READ_ONCE() itself.
+For those who need it, and for those who are interested in the history,
+here is the story of data-dependency barriers.
 
 The usage requirements of data dependency barriers are a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
@@ -2843,8 +2850,9 @@ as that committed on CPU 1.
 
 
 To intervene, we need to interpolate a data dependency barrier or a read
-barrier between the loads.  This will force the cache to commit its coherency
-queue before processing any further requests:
+barrier between the loads (which as of v4.15 is supplied unconditionally
+by the READ_ONCE() macro).  This will force the cache to commit its
+coherency queue before processing any further requests:
 
 	CPU 1		CPU 2		COMMENT
 	===============	===============	=======================================
@@ -2873,8 +2881,8 @@ Other CPUs may also have split caches, but must coordinate between the various
 cachelets for normal memory accesses.  The semantics of the Alpha removes the
 need for hardware coordination in the absence of memory barriers, which
 permitted Alpha to sport higher CPU clock rates back in the day.  However,
-please note that smp_read_barrier_depends() should not be used except in
-Alpha arch-specific code and within the READ_ONCE() macro.
+please note that (again, as of v4.15) smp_read_barrier_depends() should not
+be used except in Alpha arch-specific code and within the READ_ONCE() macro.
 
 
 CACHE COHERENCY VS DMA
@@ -3039,7 +3047,9 @@ the data dependency barrier really becomes necessary as this synchronises both
 caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 
-The Alpha defines the Linux kernel's memory barrier model.
+The Alpha defines the Linux kernel's memory model, although as of v4.15
+the Linux kernel's addition of smp_read_barrier_depends() to READ_ONCE()
+greatly reduced Alpha's impact on the memory model.
 
 See the subsection on "Cache Coherency" above.
 
