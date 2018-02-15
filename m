Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033727AbeBOPKE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:10:04 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57364 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1033445AbeBOPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:10:03 -0500
Date: Thu, 15 Feb 2018 10:10:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Akira Yokosawa <akiyks@gmail.com>, <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, <parri.andrea@gmail.com>, <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2] tools/memory-model: Make compat with herd7 7.47 ("-"
 -> "_")
In-Reply-To: <20180214225238.GV3617@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1802151007210.1883-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Paul E. McKenney wrote:

> Let's see, examining the Z6 litmus tests and running on herd7 version 7.48:
> 
> Z6.0+pooncelock+pooncelock+pombonce Sometimes 1 7
> Z6.0+pooncelock+poonceLock+pombonce Never 0 7
> Z6.0+pooncerelease+poacquirerelease+mbonceonce Sometimes 1 7
> 
> But Alan stated that the result of the test would be changed by one of
> the patches in our "pending" list.  I ran with all the patches currently
> applied, so I am guessing that Alan was refering to one of the changes
> that we have discussed but not yet created.
> 
> Alan, enlightenment?

Here's the relevant patch.  It may need some manual adjustment, because 
it was not made against the files currently in the repository.

Alan


diff --git a/linux-kernel-hardware.cat b/linux-kernel-hardware.cat
Index: memory-model/linux-kernel-hardware.cat
===================================================================
--- memory-model.orig/linux-kernel-hardware.cat
+++ memory-model/linux-kernel-hardware.cat
@@ -31,7 +31,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -57,13 +57,13 @@ let to-w = rwdep | addrpo | (overwrite &
 let rdw = po-loc & (fre ; rfe)
 let detour = po-loc & (coe ; rfe)
 let rrdep = addr | (dep ; rfi)
-let to-r = rrdep | rfi-rel-acq
-let fence = strong-fence | wmb | po-rel | rmb | acq-po
+let to-r = rrdep
+let fence = strong-fence | wmb | po-rel | rmb | acq-po | (rel-rf-acq-po & int)
 let ppo = to-r | to-w | fence | rdw | detour
 
 (* Happens Before *)
 let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
+let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | rel-rf-acq-po
 
 let rec prop = (overwrite & ext)? ; cumul-fence ; hb*
     and hb = ppo | rfe | ((hb* ; prop) & int)
Index: memory-model/linux-kernel.cat
===================================================================
--- memory-model.orig/linux-kernel.cat
+++ memory-model/linux-kernel.cat
@@ -31,7 +31,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -54,13 +54,13 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
 let rrdep = addr | (dep ; rfi)
-let to-r = rrdep | rfi-rel-acq
-let fence = strong-fence | wmb | po-rel | rmb | acq-po
+let to-r = rrdep
+let fence = strong-fence | wmb | po-rel | rmb | acq-po | (rel-rf-acq-po & int)
 let ppo = to-r | to-w | fence
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
+let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | rel-rf-acq-po
 let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
 
 (*
