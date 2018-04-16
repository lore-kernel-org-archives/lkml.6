Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeDPQOW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:14:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753048AbeDPQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 04/17] locking: Document the semantics of spin_is_locked()
Date: Mon, 16 Apr 2018 09:12:32 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0044-0000-0000-00000404B80A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798043;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0045-0000-0000-00000836BB6F
Message-Id: <1523895165-17576-4-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

There appeared to be a certain, recurrent uncertainty concerning the
semantics of spin_is_locked(), likely a consequence of the fact that
this semantics remains undocumented or that it has been historically
linked to the (likewise unclear) semantics of spin_unlock_wait().

A recent auditing [1] of the callers of the primitive confirmed that
none of them are relying on particular ordering guarantees; document
this semantics by adding a docbook header to spin_is_locked(). Also,
describe behaviors specific to certain CONFIG_SMP=n builds.

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
    https://marc.info/?l=linux-kernel&m=152042843808540&w=2
    https://marc.info/?l=linux-kernel&m=152043346110262&w=2

Co-Developed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Co-Developed-by: Alan Stern <stern@rowland.harvard.edu>
Co-Developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/spinlock.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 4894d322d258..1e8a46435838 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -380,6 +380,24 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
 	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
 })
 
+/**
+ * spin_is_locked() - Check whether a spinlock is locked.
+ * @lock: Pointer to the spinlock.
+ *
+ * This function is NOT required to provide any memory ordering
+ * guarantees; it could be used for debugging purposes or, when
+ * additional synchronization is needed, accompanied with other
+ * constructs (memory barriers) enforcing the synchronization.
+ *
+ * Returns: 1 if @lock is locked, 0 otherwise.
+ *
+ * Note that the function only tells you that the spinlock is
+ * seen to be locked, not that it is locked on your CPU.
+ *
+ * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n,
+ * the return value is always 0 (see include/linux/spinlock_up.h).
+ * Therefore you should not rely heavily on the return value.
+ */
 static __always_inline int spin_is_locked(spinlock_t *lock)
 {
 	return raw_spin_is_locked(&lock->rlock);
-- 
2.5.2
