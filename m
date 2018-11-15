Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190A8223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190A8223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbeKPC2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:28:13 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:43732 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729034AbeKPC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:28:13 -0500
Received: (qmail 2955 invoked by uid 2102); 15 Nov 2018 11:19:44 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2018 11:19:44 -0500
Date:   Thu, 15 Nov 2018 11:19:44 -0500 (EST)
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
Subject: [PATCH 1/3] tools/memory-model: Rename some RCU relations
Message-ID: <Pine.LNX.4.44L0.1811151115160.1308-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for SRCU, rename "crit" to
"rcu-rscs", rename "rscs" to "rcu-rscsi", and remove the restriction
to only the outermost level of nesting.

The name change is needed for disambiguating RCU read-side critical
sections from SRCU read-side critical sections.  Adding the "i" at the
end of "rcu-rscsi" emphasizes that the relation is inverted; it links
rcu_read_unlock() events to their corresponding preceding
rcu_read_lock() events.

The restriction to outermost nesting levels was never essential; it
was included mostly to show that it could be done.  Rather than add
equivalent unnecessary code for SRCU lock nesting, it seemed better to
remove the existing code.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.bell |    9 +++------
 tools/memory-model/linux-kernel.cat  |   10 +++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

Index: usb-4.x/tools/memory-model/linux-kernel.bell
===================================================================
--- usb-4.x.orig/tools/memory-model/linux-kernel.bell
+++ usb-4.x/tools/memory-model/linux-kernel.bell
@@ -34,7 +34,7 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
-let matched = let rec
+let rcu-rscs = let rec
 	    unmatched-locks = Rcu-lock \ domain(matched)
 	and unmatched-unlocks = Rcu-unlock \ range(matched)
 	and unmatched = unmatched-locks | unmatched-unlocks
@@ -46,8 +46,5 @@ let matched = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Rcu-lock \ domain(matched) as unbalanced-rcu-locking
-flag ~empty Rcu-unlock \ range(matched) as unbalanced-rcu-locking
-
-(* Outermost level of nesting only *)
-let crit = matched \ (po^-1 ; matched ; po^-1)
+flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
+flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
Index: usb-4.x/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-4.x.orig/tools/memory-model/linux-kernel.cat
+++ usb-4.x/tools/memory-model/linux-kernel.cat
@@ -95,7 +95,7 @@ acyclic pb as propagation
  * onward on the one hand and from the rcu_read_unlock() backwards on the
  * other hand.
  *)
-let rscs = po ; crit^-1 ; po?
+let rcu-rscsi = po ; rcu-rscs^-1 ; po?
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
@@ -109,10 +109,10 @@ let rcu-link = hb* ; pb* ; prop
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
  *)
 let rec rcu-fence = gp |
-	(gp ; rcu-link ; rscs) |
-	(rscs ; rcu-link ; gp) |
-	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
-	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
+	(gp ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; gp) |
+	(gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; gp) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)

