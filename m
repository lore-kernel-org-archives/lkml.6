Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeEHNkf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755256AbeEHNi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:38:56 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Rich Felker <dalias@libc.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: [PATCH 05/11] softirq: Consolidate default local_softirq_pending() implementations
Date: Tue,  8 May 2018 15:38:20 +0200
Message-Id: <1525786706-22846-6-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525786706-22846-1-git-send-email-frederic@kernel.org>
References: <1525786706-22846-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate and optimize default softirq mask API implementations.
Per-CPU operations are expected to be faster and a few architectures
already rely on them to implement local_softirq_pending() and related
accessors/mutators. Those will be migrated to the new generic code.

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
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
---
 include/linux/interrupt.h   | 14 ++++++++++++++
 include/linux/irq_cpustat.h |  6 +-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5426627..7a11f73 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -432,11 +432,25 @@ extern bool force_irqthreads;
 #define force_irqthreads	(0)
 #endif
 
+#ifndef local_softirq_pending
+
+#ifndef local_softirq_pending_ref
+#define local_softirq_pending_ref irq_stat.__softirq_pending
+#endif
+
+#define local_softirq_pending()	(__this_cpu_read(local_softirq_pending_ref))
+#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
+#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
+
+#else /* local_softirq_pending */
+
 #ifndef __ARCH_SET_SOFTIRQ_PENDING
 #define set_softirq_pending(x) (local_softirq_pending() = (x))
 #define or_softirq_pending(x)  (local_softirq_pending() |= (x))
 #endif
 
+#endif /* local_softirq_pending */
+
 /* Some architectures might implement lazy enabling/disabling of
  * interrupts. In some cases, such as stop_machine, we might want
  * to ensure that after a local_irq_disable(), interrupts have
diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
index ddea03c..6e8895c 100644
--- a/include/linux/irq_cpustat.h
+++ b/include/linux/irq_cpustat.h
@@ -22,11 +22,7 @@ DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
 #define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat.member, cpu))
 #endif
 
-  /* arch independent irq_stat fields */
-#define local_softirq_pending() \
-	__IRQ_STAT(smp_processor_id(), __softirq_pending)
-
-  /* arch dependent irq_stat fields */
+/* arch dependent irq_stat fields */
 #define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
 
 #endif	/* __irq_cpustat_h */
-- 
2.7.4
