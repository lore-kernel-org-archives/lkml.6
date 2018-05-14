Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeENXfP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 19:35:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752438AbeENXce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 19:32:34 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 12/19] tools/memory-model: Remove duplicated code from lock.cat
Date: Mon, 14 May 2018 16:33:50 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0024-0000-0000-00000358D64B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811514;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0025-0000-0000-000048037BF3
Message-Id: <1526340837-12222-12-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140230
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch simplifies the implementation of spin_is_locked in the
LKMM.  It capitalizes on the fact that a failed spin_trylock() and a
spin_is_locked() which returns True have exactly the same semantics
(those of READ_ONCE) and ordering properties (none).  Therefore the
two kinds of events can be combined and handled by the same code,
instead of treated separately as they are currently.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Akira Yokosawa <akiyks@gmail.com>
CC: Andrea Parri <andrea.parri@amarulasolutions.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: David Howells <dhowells@redhat.com>
CC: Jade Alglave <j.alglave@ucl.ac.uk>
CC: Luc Maranget <luc.maranget@inria.fr>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Will Deacon <will.deacon@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
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
-- 
2.5.2
