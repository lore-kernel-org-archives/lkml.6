Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeENXAL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 19:00:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752359AbeENXAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 19:00:06 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH memory-model 2/3] arm64: Remove smp_mb() from arch_spin_is_locked()
Date: Mon, 14 May 2018 16:01:28 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514230105.GA6421@linux.vnet.ibm.com>
References: <20180514230105.GA6421@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-0008-0000-0000-000003076B86
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032372; UDB=6.00527777; IPR=6.00811504;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:00:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-0009-0000-0000-0000393FFE43
Message-Id: <1526338889-7003-2-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Commit 38b850a73034f ("arm64: spinlock: order spin_{is_locked,unlock_wait}
against local locks") added an smp_mb() to arch_spin_is_locked(), in order
"to ensure that the lock value is always loaded after any other locks have
been taken by the current CPU", and reported one example (the "insane case"
in ipc/sem.c) relying on such guarantee.

It is however understood that spin_is_locked() is not required to provide
such an ordering guarantee (a guarantee that is currently not provided by
all the implementations/archs), and that callers relying on such ordering
should instead insert suitable memory barriers before acting on the result
of spin_is_locked().

Following a recent auditing [1] of the callers of {,raw_}spin_is_locked(),
revealing that none of them are relying on the ordering guarantee anymore,
this commit removes the leading smp_mb() from the primitive thus reverting
38b850a73034f.

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
    https://marc.info/?l=linux-kernel&m=152042843808540&w=2
    https://marc.info/?l=linux-kernel&m=152043346110262&w=2

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/arm64/include/asm/spinlock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index ebdae15d665d..26c5bd7d88d8 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -122,11 +122,6 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	/*
-	 * Ensure prior spin_lock operations to other locks have completed
-	 * on this CPU before we test whether "lock" is locked.
-	 */
-	smp_mb(); /* ^^^ */
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
-- 
2.5.2
