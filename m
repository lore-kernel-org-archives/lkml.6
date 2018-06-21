Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA83C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B7E21870
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B7E21870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeFUR0v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:26:51 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36776 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932508AbeFUR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:26:50 -0400
Received: (qmail 4461 invoked by uid 2102); 21 Jun 2018 13:26:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jun 2018 13:26:49 -0400
Date:   Thu, 21 Jun 2018 13:26:49 -0400 (EDT)
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
Subject: [PATCH 1/2] tools/memory-model: Change rel-rfi-acq ordering to
 (rel-rf-acq-po & int)
Message-ID: <Pine.LNX.4.44L0.1806211315550.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the LKMM rule which says that an acquire which
reads from an earlier release must be executed after that release (in
other words, the release cannot be forwarded to the acquire).  This is
not true on PowerPC, for example.

What is true instead is that any instruction following the acquire
must be executed after the release.  On some architectures this is
because a write-release cannot be forwarded to a read-acquire; on
others (including PowerPC) it is because the implementation of
smp_load_acquire() places a memory barrier immediately after the
load.

This change to the model does not cause any change to the model's
predictions.  This is because any link starting from a load must be an
instance of either po or fr.  In the po case, the new rule will still
provide ordering.  In the fr case, we also have ordering because there
must be a co link to the same destination starting from the
write-release.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


[as1870]


 tools/memory-model/Documentation/explanation.txt |   35 ++++++++++++-----------
 tools/memory-model/linux-kernel.cat              |    6 +--
 2 files changed, 22 insertions(+), 19 deletions(-)

Index: usb-4.x/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-4.x.orig/tools/memory-model/linux-kernel.cat
+++ usb-4.x/tools/memory-model/linux-kernel.cat
@@ -38,7 +38,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -60,9 +60,9 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi) | rfi-rel-acq
+let to-r = addr | (dep ; rfi)
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
-let ppo = to-r | to-w | fence
+let ppo = to-r | to-w | fence | (rel-rf-acq-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-4.x/tools/memory-model/Documentation/explanation.txt
@@ -1067,27 +1067,30 @@ allowing out-of-order writes like this t
 violating the write-write coherence rule by requiring the CPU not to
 send the W write to the memory subsystem at all!)
 
-There is one last example of preserved program order in the LKMM: when
-a load-acquire reads from an earlier store-release.  For example:
+There is one last example of preserved program order in the LKMM; it
+applies to instructions po-after a load-acquire which reads from an
+earlier store-release.  For example:
 
 	smp_store_release(&x, 123);
 	r1 = smp_load_acquire(&x);
+	WRITE_ONCE(&y, 246);
 
 If the smp_load_acquire() ends up obtaining the 123 value that was
-stored by the smp_store_release(), the LKMM says that the load must be
-executed after the store; the store cannot be forwarded to the load.
-This requirement does not arise from the operational model, but it
-yields correct predictions on all architectures supported by the Linux
-kernel, although for differing reasons.
-
-On some architectures, including x86 and ARMv8, it is true that the
-store cannot be forwarded to the load.  On others, including PowerPC
-and ARMv7, smp_store_release() generates object code that starts with
-a fence and smp_load_acquire() generates object code that ends with a
-fence.  The upshot is that even though the store may be forwarded to
-the load, it is still true that any instruction preceding the store
-will be executed before the load or any following instructions, and
-the store will be executed before any instruction following the load.
+written by the smp_store_release(), the LKMM says that the store to y
+must be executed after the store to x.  In fact, the only way this
+could fail would be if the store-release was forwarded to the
+load-acquire; the LKMM says it holds even in that case.  This
+requirement does not arise from the operational model, but it yields
+correct predictions on all architectures supported by the Linux
+kernel, although for differing reasons:
+
+On some architectures, including x86 and ARMv8, a store-release cannot
+be forwarded to a load-acquire.  On others, including PowerPC and
+ARMv7, smp_load_acquire() generates object code that ends with a
+fence.  The result is that even though the store-release may be
+forwarded to the load-acquire, it is still true that the store-release
+(and all preceding instructions) will be executed before any
+instruction following the load-acquire.
 
 
 AND THEN THERE WAS ALPHA

