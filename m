Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbeDPQOU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:14:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753050AbeDPQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:11:48 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH tools/memory-model 06/17] locking: Clean up comment and #ifndef for {,queued_}spin_is_locked()
Date: Mon, 16 Apr 2018 09:12:34 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041616-0036-0000-0000-000002E2DC9A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008863; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01018801; UDB=6.00519703; IPR=6.00798043;
 MB=3.00020599; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-16 16:11:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0037-0000-0000-000044010207
Message-Id: <1523895165-17576-6-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Removes "#ifndef queued_spin_is_locked" from the generic code: this is
unused and it's reasonable to conclude that it will continue to be unused.

Also removes the comment about spin_is_locked() from mutex_is_locked():
the comment remains valid but not particularly useful.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/asm-generic/qspinlock.h | 2 --
 include/linux/mutex.h           | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index b37b4ad7eb94..dc4e4ac4937e 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -26,7 +26,6 @@
  * @lock: Pointer to queued spinlock structure
  * Return: 1 if it is locked, 0 otherwise
  */
-#ifndef queued_spin_is_locked
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 {
 	/*
@@ -35,7 +34,6 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 	 */
 	return atomic_read(&lock->val);
 }
-#endif
 
 /**
  * queued_spin_value_unlocked - is the spinlock structure unlocked?
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 14bc0d5d0ee5..3093dd162424 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -146,9 +146,6 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  */
 static inline bool mutex_is_locked(struct mutex *lock)
 {
-	/*
-	 * XXX think about spin_is_locked
-	 */
 	return __mutex_owner(lock) != NULL;
 }
 
-- 
2.5.2
