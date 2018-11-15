Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189F9223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189F9223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbeKPC21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:28:27 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43770 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729034AbeKPC21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:28:27 -0500
Received: (qmail 2969 invoked by uid 2102); 15 Nov 2018 11:19:58 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2018 11:19:58 -0500
Date:   Thu, 15 Nov 2018 11:19:58 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] tools/memory-model: Refactor some RCU relations
Message-ID: <Pine.LNX.4.44L0.1811151116420.1308-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for SRCU, refactor the definitions
of rcu-fence, rcu-rscsi, rcu-link, and rb by moving the po and po?
terms from the first two to the second two.  An rcu-gp relation is
added; it is equivalent to gp with the po and po? terms removed.

This is necessary because for SRCU, we will have to use the loc
relation to check that the terms at the start and end of each disjunct
in the definition of rcu-fence refer to the same srcu_struct
location.  If these terms are hidden behind po and po?, there's no way
to carry out this check.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.cat |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

Index: usb-4.x/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-4.x.orig/tools/memory-model/linux-kernel.cat
+++ usb-4.x/tools/memory-model/linux-kernel.cat
@@ -91,32 +91,37 @@ acyclic pb as propagation
 (*******)
 
 (*
- * Effect of read-side critical section proceeds from the rcu_read_lock()
- * onward on the one hand and from the rcu_read_unlock() backwards on the
+ * Effects of read-side critical sections proceed from the rcu_read_unlock()
+ * backwards on the one hand, and from the rcu_read_lock() forwards on the
  * other hand.
+ *
+ * In the definition of rcu-fence below, the po term at the left-hand side
+ * of each disjunct and the po? term at the right-hand end have been factored
+ * out.  They have been moved into the definitions of rcu-link and rb.
  *)
-let rcu-rscsi = po ; rcu-rscs^-1 ; po?
+let rcu-gp = [Sync-rcu]		(* Compare with gp *)
+let rcu-rscsi = rcu-rscs^-1
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
  * one but two non-rf relations, but only in conjunction with an RCU
  * read-side critical section.
  *)
-let rcu-link = hb* ; pb* ; prop
+let rcu-link = po? ; hb* ; pb* ; prop ; po
 
 (*
  * Any sequence containing at least as many grace periods as RCU read-side
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
  *)
-let rec rcu-fence = gp |
-	(gp ; rcu-link ; rcu-rscsi) |
-	(rcu-rscsi ; rcu-link ; gp) |
-	(gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
-	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; gp) |
+let rec rcu-fence = rcu-gp |
+	(rcu-gp ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-gp) |
+	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
-let rb = prop ; rcu-fence ; hb* ; pb*
+let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
 
 irreflexive rb as rcu
 

