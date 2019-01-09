Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9AFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91D5206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfAIVIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:08:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbfAIVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:07:59 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Kn2P3044863
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:07:58 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwpxh4pn4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:07:57 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:56 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:07:51 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09L7o8e18743458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:07:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D6EB206B;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 198E0B2065;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E28B116C63E4; Wed,  9 Jan 2019 13:07:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, willy@infradead.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 3/7] tools/memory-model: Add SRCU support
Date:   Wed,  9 Jan 2019 13:07:44 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0072-0000-0000-000003E73BCC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144138; UDB=6.00595704; IPR=6.00924400;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:07:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0073-0000-0000-00004ABF5EE1
Message-Id: <20190109210748.29074-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Add support for SRCU.  Herd creates srcu events and linux-kernel.def
associates them with three possible annotations (srcu-lock,
srcu-unlock, and sync-srcu) corresponding to the API routines
srcu_read_lock(), srcu_read_unlock(), and synchronize_srcu().

The linux-kernel.bell file now declares the annotations
and determines matching lock/unlock pairs delimiting SRCU read-side
critical sections, and it also checks for synchronize_srcu() calls
inside an RCU critical section (which would generate a "sleeping in
atomic context" error in real kernel code).  The linux-kernel.cat file
now adds SRCU-induced ordering, analogous to the existing RCU-induced
ordering, to the gp and rcu-fence relations.

Curiously enough, these small changes to the model's .cat code are all
that is needed to describe SRCU.

Portions of this patch (linux-kernel.def and the first hunk in
linux-kernel.bell) were written by Luc Maranget.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Luc Maranget <luc.maranget@inria.fr>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.bell | 25 +++++++++++++++++++++++++
 tools/memory-model/linux-kernel.cat  | 18 ++++++++++++++----
 tools/memory-model/linux-kernel.def  |  5 +++++
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 353c8d68e030..9c42cd9ddcb4 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -33,6 +33,12 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'after-unlock-lock (*smp_mb__after_unlock_lock*)
 instructions F[Barriers]
 
+(* SRCU *)
+enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
+instructions SRCU[SRCU]
+(* All srcu events *)
+let Srcu = Srcu-lock | Srcu-unlock | Sync-srcu
+
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
 let rcu-rscs = let rec
 	    unmatched-locks = Rcu-lock \ domain(matched)
@@ -48,3 +54,22 @@ let rcu-rscs = let rec
 (* Validate nesting *)
 flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
 flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
+
+(* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
+let srcu-rscs = let rec
+	    unmatched-locks = Srcu-lock \ domain(matched)
+	and unmatched-unlocks = Srcu-unlock \ range(matched)
+	and unmatched = unmatched-locks | unmatched-unlocks
+	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
+	and unmatched-locks-to-unlocks =
+		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
+	and matched = matched | (unmatched-locks-to-unlocks \
+		(unmatched-po ; unmatched-po))
+	in matched
+
+(* Validate nesting *)
+flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
+flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
+
+(* Check for use of synchronize_srcu() inside an RCU critical section *)
+flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index b8e6197f05af..8dcb37835b61 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -33,7 +33,7 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
 		fencerel(After-unlock-lock) ; [M])
-let gp = po ; [Sync-rcu] ; po?
+let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 
 let strong-fence = mb | gp
 
@@ -92,15 +92,18 @@ acyclic pb as propagation
 
 (*
  * Effects of read-side critical sections proceed from the rcu_read_unlock()
- * backwards on the one hand, and from the rcu_read_lock() forwards on the
- * other hand.
+ * or srcu_read_unlock() backwards on the one hand, and from the
+ * rcu_read_lock() or srcu_read_lock() forwards on the other hand.
  *
  * In the definition of rcu-fence below, the po term at the left-hand side
  * of each disjunct and the po? term at the right-hand end have been factored
  * out.  They have been moved into the definitions of rcu-link and rb.
+ * This was necessary in order to apply the "& loc" tests correctly.
  *)
 let rcu-gp = [Sync-rcu]		(* Compare with gp *)
+let srcu-gp = [Sync-srcu]
 let rcu-rscsi = rcu-rscs^-1
+let srcu-rscsi = srcu-rscs^-1
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
@@ -112,12 +115,19 @@ let rcu-link = po? ; hb* ; pb* ; prop ; po
 (*
  * Any sequence containing at least as many grace periods as RCU read-side
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
+ * Likewise for SRCU grace periods and read-side critical sections, provided
+ * the synchronize_srcu() and srcu_read_[un]lock() calls refer to the same
+ * struct srcu_struct location.
  *)
-let rec rcu-fence = rcu-gp |
+let rec rcu-fence = rcu-gp | srcu-gp |
 	(rcu-gp ; rcu-link ; rcu-rscsi) |
+	((srcu-gp ; rcu-link ; srcu-rscsi) & loc) |
 	(rcu-rscsi ; rcu-link ; rcu-gp) |
+	((srcu-rscsi ; rcu-link ; srcu-gp) & loc) |
 	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	((srcu-gp ; rcu-link ; rcu-fence ; rcu-link ; srcu-rscsi) & loc) |
 	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
+	((srcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; srcu-gp) & loc) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index b27911cc087d..1d6a120cde14 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -47,6 +47,11 @@ rcu_read_unlock() { __fence{rcu-unlock}; }
 synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
+// SRCU
+srcu_read_lock(X)  __srcu{srcu-lock}(X)
+srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
+synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
+
 // Atomic
 atomic_read(X) READ_ONCE(*X)
 atomic_set(X,V) { WRITE_ONCE(*X,V); }
-- 
2.17.1

