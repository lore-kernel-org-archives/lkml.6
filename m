Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeCaDfj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 23:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752969AbeCaDff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 23:35:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5961C21834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: [PATCH 10/10] softirq/s390: Move default mutators of overwritten softirq mask to s390
Date: Sat, 31 Mar 2018 05:34:53 +0200
Message-Id: <1522467293-7320-11-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522467293-7320-1-git-send-email-frederic@kernel.org>
References: <1522467293-7320-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390 is now the last architecture that entirely overwrites
local_softirq_pending() and uses the according default definitions of
set_softirq_pending() and or_softirq_pending().

Just move these to s390 to debloat the generic code complexity.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/s390/include/asm/hardirq.h | 2 ++
 include/linux/interrupt.h       | 7 -------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index a296c6a..dfbc3c6c0 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -14,6 +14,8 @@
 #include <asm/lowcore.h>
 
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
+#define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
+#define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 01caeca..df35a26 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -444,13 +444,6 @@ extern bool force_irqthreads;
 #define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
 #define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
 
-#else /* local_softirq_pending */
-
-#ifndef __ARCH_SET_SOFTIRQ_PENDING
-#define set_softirq_pending(x) (local_softirq_pending() = (x))
-#define or_softirq_pending(x)  (local_softirq_pending() |= (x))
-#endif
-
 #endif /* local_softirq_pending */
 
 /* Some architectures might implement lazy enabling/disabling of
-- 
2.7.4
