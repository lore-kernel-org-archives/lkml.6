Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeDKSBK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:01:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52054 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752584AbeDKSBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:01:06 -0400
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        longman@redhat.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 03/13] locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound
Date: Wed, 11 Apr 2018 19:01:10 +0100
Message-Id: <1523469680-17699-4-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86, atomic_cond_read_relaxed will busy-wait with a cpu_relax() loop,
so it is desirable to increase the number of times we spin on the qspinlock
lockword when it is found to be transitioning from pending to locked.

According to Waiman Long:

| Ideally, the spinning times should be at least a few times the typical
| cacheline load time from memory which I think can be down to 100ns or
| so for each cacheline load with the newest systems or up to several
| hundreds ns for older systems.

which in his benchmarking corresponded to 512 iterations.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/qspinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 5e16b5d40d32..2f09915f4aa4 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -7,6 +7,8 @@
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
 
+#define _Q_PENDING_LOOPS	(1 << 9)
+
 #define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
-- 
2.1.4
