Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeBIOZb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:25:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752171AbeBIOV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:21:58 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/lkmm 09/10] EXP Remove underscore from smp_mb__after_atomic() workings
Date: Fri,  9 Feb 2018 06:20:30 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180209141832.GA17505@linux.vnet.ibm.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020914-0048-0000-0000-00000234EE1E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008504; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987227; UDB=6.00501083; IPR=6.00766586;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019457; XFM=3.00000015;
 UTC=2018-02-09 14:21:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020914-0049-0000-0000-000044124F13
Message-Id: <1518186031-17997-9-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/linux-kernel.bell | 2 +-
 tools/memory-model/linux-kernel.cat  | 2 +-
 tools/memory-model/linux-kernel.def  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 558bbef9e08a..6fca420bc6c4 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -29,7 +29,7 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
 		'before-atomic (*smp_mb__before_atomic*) ||
-		'after_atomic (*smp_mb__after_atomic*) ||
+		'after-atomic (*smp_mb__after_atomic*) ||
 		'after_spinlock (*smp_mb__after_spinlock*)
 instructions F[Barriers]
 
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 31c08a44c088..7b1d9ecc4b67 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -30,7 +30,7 @@ let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
-	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
+	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
 let gp = po ; [Sync-rcu] ; po?
 
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index ff4b756f4a44..46a9eb40323d 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -22,7 +22,7 @@ smp_rmb() { __fence{rmb} ; }
 smp_wmb() { __fence{wmb} ; }
 smp_read_barrier_depends() { __fence{rb_dep}; }
 smp_mb__before_atomic() { __fence{before-atomic} ; }
-smp_mb__after_atomic() { __fence{after_atomic} ; }
+smp_mb__after_atomic() { __fence{after-atomic} ; }
 smp_mb__after_spinlock() { __fence{after_spinlock} ; }
 
 // Exchange
-- 
2.5.2
