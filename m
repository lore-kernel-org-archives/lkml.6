Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757909AbeD0Ji7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:38:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757695AbeD0Ji6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:38:58 -0400
Date: Fri, 27 Apr 2018 02:38:35 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-b247be3fe89b6aba928bf80f4453d1c4ba8d2063@git.kernel.org>
Cc: torvalds@linux-foundation.org, peterz@infradead.org,
        longman@redhat.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: longman@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        will.deacon@arm.com, mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1524738868-31318-5-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-5-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock/x86: Increase _Q_PENDING_LOOPS
 upper bound
Git-Commit-ID: b247be3fe89b6aba928bf80f4453d1c4ba8d2063
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b247be3fe89b6aba928bf80f4453d1c4ba8d2063
Gitweb:     https://git.kernel.org/tip/b247be3fe89b6aba928bf80f4453d1c4ba8d2063
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:18 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:47 +0200

locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound

On x86, atomic_cond_read_relaxed will busy-wait with a cpu_relax() loop,
so it is desirable to increase the number of times we spin on the qspinlock
lockword when it is found to be transitioning from pending to locked.

According to Waiman Long:

 | Ideally, the spinning times should be at least a few times the typical
 | cacheline load time from memory which I think can be down to 100ns or
 | so for each cacheline load with the newest systems or up to several
 | hundreds ns for older systems.

which in his benchmarking corresponded to 512 iterations.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-5-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/qspinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 90b0b0ed8161..da1370ad206d 100644
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
