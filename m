Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeENXeB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 19:34:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752509AbeENXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 19:32:35 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 15/19] tools/memory-model: Remove out-of-date comments and code from lock.cat
Date: Mon, 14 May 2018 16:33:53 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0024-0000-0000-00000358D64C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811514;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0025-0000-0000-000048037BF2
Message-Id: <1526340837-12222-15-git-send-email-paulmck@linux.vnet.ibm.com>
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

lock.cat contains old comments and code referring to the possibility
of LKR events that are not part of an RMW pair.  This is a holdover
from when I though we might end up using LKR events to implement
spin_is_locked().  Reword the comments to remove this assumption and
replace domain(lk-rmw) in the code with LKR.

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
[ paulmck: Pulled "as lock-nest" into previous line as discussed. ]
---
 tools/memory-model/lock.cat | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 7217cd4941a4..cd002a33ca8a 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -47,18 +47,15 @@ flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
 let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
 let rmw = rmw | lk-rmw
 
+(* The litmus test is invalid if an LKR/LKW event is not part of an RMW pair *)
+flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
+flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
+
 (*
- * A paired LKR must always see an unlocked value; spin_lock() calls nested
+ * An LKR must always see an unlocked value; spin_lock() calls nested
  * inside a critical section (for the same lock) always deadlock.
  *)
-empty ([LKW] ; po-loc ; [domain(lk-rmw)]) \ (po-loc ; [UL] ; po-loc)
-	as lock-nest
-
-(* The litmus test is invalid if an LKW event is not part of an RMW pair *)
-flag ~empty LKW \ range(lk-rmw) as unpaired-LKW
-
-(* This will be allowed if we implement spin_is_locked() *)
-flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
+empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
 
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
-- 
2.5.2
