Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7F9C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B561B21884
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B561B21884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933167AbeFUR1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:27:14 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36822 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932994AbeFUR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:27:13 -0400
Received: (qmail 4486 invoked by uid 2102); 21 Jun 2018 13:27:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jun 2018 13:27:12 -0400
Date:   Thu, 21 Jun 2018 13:27:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] tools/memory-model: Add write ordering by release-acquire
 and by locks
Message-ID: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More than one kernel developer has expressed the opinion that the LKMM
should enforce ordering of writes by release-acquire chains and by
locking.  In other words, given the following code:

	WRITE_ONCE(x, 1);
	spin_unlock(&s):
	spin_lock(&s);
	WRITE_ONCE(y, 1);

or the following:

	smp_store_release(&x, 1);
	r1 = smp_load_acquire(&x);	// r1 = 1
	WRITE_ONCE(y, 1);

the stores to x and y should be propagated in order to all other CPUs,
even though those other CPUs might not access the lock s or be part of
the release-acquire chain.  In terms of the memory model, this means
that rel-rf-acq-po should be part of the cumul-fence relation.

All the architectures supported by the Linux kernel (including RISC-V)
do behave this way, albeit for varying reasons.  Therefore this patch
changes the model in accordance with the developers' wishes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


[as1871]


 tools/memory-model/Documentation/explanation.txt |   81 +++++++++++++++++++++++
 tools/memory-model/linux-kernel.cat              |    2 
 2 files changed, 82 insertions(+), 1 deletion(-)

Index: usb-4.x/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-4.x.orig/tools/memory-model/linux-kernel.cat
+++ usb-4.x/tools/memory-model/linux-kernel.cat
@@ -66,7 +66,7 @@ let ppo = to-r | to-w | fence
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
+let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | rel-rf-acq-po
 let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
 
 (*
Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-4.x/tools/memory-model/Documentation/explanation.txt
@@ -1897,3 +1897,84 @@ non-deadlocking executions.  For example
 Is it possible to end up with r0 = 36 at the end?  The LKMM will tell
 you it is not, but the model won't mention that this is because P1
 will self-deadlock in the executions where it stores 36 in y.
+
+In the LKMM, locks and release-acquire chains cause stores to
+propagate in order.  For example:
+
+	int x, y, z;
+
+	P0()
+	{
+		WRITE_ONCE(x, 1);
+		smp_store_release(&y, 1);
+	}
+
+	P1()
+	{
+		int r1;
+
+		r1 = smp_load_acquire(&y);
+		WRITE_ONCE(z, 1);
+	}
+
+	P2()
+	{
+		int r2, r3, r4;
+
+		r2 = READ_ONCE(z);
+		smp_rmb();
+		r3 = READ_ONCE(x);
+		r4 = READ_ONCE(y);
+	}
+
+If r1 = 1 and r2 = 1 at the end, then both r3 and r4 must also be 1.
+In other words, the smp_store_release() read by the smp_load_acquire()
+together act as a sort of inter-processor fence, forcing the stores to
+x and y to propagate to P2 before the store to z does, regardless of
+the fact that P2 doesn't execute any release or acquire instructions.
+This conclusion would hold even if P0 and P1 were on the same CPU, so
+long as r1 = 1.
+
+We have mentioned that the LKMM treats locks as acquires and unlocks
+as releases.  Therefore it should not be surprising that something
+analogous to this ordering also holds for locks:
+
+	int x, y;
+	spinlock_t s;
+
+	P0()
+	{
+		spin_lock(&s);
+		WRITE_ONCE(x, 1);
+		spin_unlock(&s);
+	}
+
+	P1()
+	{
+		int r1;
+
+		spin_lock(&s);
+		r1 = READ_ONCE(x):
+		WRITE_ONCE(y, 1);
+		spin_unlock(&s);
+	}
+
+	P2()
+	{
+		int r2, r3;
+
+		r2 = READ_ONCE(y);
+		smp_rmb();
+		r3 = READ_ONCE(x);
+	}
+
+If r1 = 1 at the end (implying that P1's critical section executes
+after P0's) and r2 = 1, then r3 must be 1; the ordering of the
+critical sections forces the store to x to propagate to P2 before the
+store to y does.
+
+In both versions of this scenario, the store-propagation ordering is
+not required by the operational model.  However, it does happen on all
+the architectures supporting the Linux kernel, and kernel developers
+seem to expect it; they have requested that this behavior be included
+in the LKMM.

