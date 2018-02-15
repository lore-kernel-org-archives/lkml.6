Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425430AbeBOP7D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:59:03 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46465 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424460AbeBOP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:59:00 -0500
X-Google-Smtp-Source: AH8x225nXw9HNS7avF9aqIB5jtrJCBxHGLP0ZluuPadmYEFINEEnbUMW0jyoQG0YbCb2yprVQhEkrg==
Subject: Trial of conflict resolution of Alan's patch
To: Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Patrick Bellasi <patrick.bellasi@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <Pine.LNX.4.44L0.1802151007210.1883-100000@iolanthe.rowland.org>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <fa35db31-7a73-4865-1505-5378dcb2a0f8@gmail.com>
Date: Fri, 16 Feb 2018 00:58:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1802151007210.1883-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From 81bd6374057f0d89894ead482b870e2f001d2998 Mon Sep 17 00:00:00 2001
From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 16 Feb 2018 00:29:56 +0900
Subject: [PATCH] [TENTATIVE] Trial conflict resolution of Alan's patch

This is a trial of conflict resolution of the patch Alan provided.

Alan's message and original patch:

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

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
[akiyks: Rebased to current master]
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
So, I attempted to rebase the patch to current (somewhat old) master of
https://github.com/aparri/memory-model. Why? Because the lkmm branch
in Paul's -rcu tree doesn't have linux-kernel-hardware.cat.

However, after this change, Z6.0+pooncelock+pooncelock+pombonce still
has the result "Sometimes". I must have done something wrong in the
conflict resolution.

Note: I have almost no idea what this patch is doing. I'm just hoping
to give a starting point of a discussion.

    Thanks, Akira
--
 linux-kernel-hardware.cat | 9 ++++-----
 linux-kernel.cat          | 9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/linux-kernel-hardware.cat b/linux-kernel-hardware.cat
index 7768bf7..6c35655 100644
--- a/linux-kernel-hardware.cat
+++ b/linux-kernel-hardware.cat
@@ -34,7 +34,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -60,14 +60,13 @@ let to-w = rwdep | addrpo | (overwrite & int)
 let rdw = po-loc & (fre ; rfe)
 let detour = po-loc & (coe ; rfe)
 let rrdep = addr | (dep ; rfi) | rdw
-let strong-rrdep = rrdep+ & rb-dep
-let to-r = strong-rrdep | rfi-rel-acq
-let fence = strong-fence | wmb | po-rel | rmb | acq-po
+let to-r = rrdep
+let fence = strong-fence | wmb | po-rel | rmb | acq-po | (rel-rf-acq-po & int)
 let ppo = (rrdep* ; (to-r | to-w | fence)) | rdw | detour
 
 (* Happens Before *)
 let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
+let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | rel-rf-acq-po
 
 let rec prop = (overwrite & ext)? ; cumul-fence ; hb*
     and hb = ppo | rfe | ((hb* ; prop) & int)
diff --git a/linux-kernel.cat b/linux-kernel.cat
index 15b7a5d..c6b0752 100644
--- a/linux-kernel.cat
+++ b/linux-kernel.cat
@@ -39,7 +39,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -62,14 +62,13 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
 let rrdep = addr | (dep ; rfi)
-let strong-rrdep = rrdep+ & rb-dep
-let to-r = strong-rrdep | rfi-rel-acq
-let fence = strong-fence | wmb | po-rel | rmb | acq-po
+let to-r = rrdep
+let fence = strong-fence | wmb | po-rel | rmb | acq-po | (rel-rf-acq-po & int)
 let ppo = rrdep* ; (to-r | to-w | fence)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
+let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | rel-rf-acq-po
 let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
 
 (*
-- 
2.7.4
