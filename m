Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753528AbeENMuM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:50:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbeENMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:50:11 -0400
Date: Mon, 14 May 2018 05:49:23 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-0fd7d86285290ccebc0dc6eb536b6b043dd6a1e4@git.kernel.org>
Cc: frederic@kernel.org, benh@kernel.crashing.org, deller@gmx.de,
        ysato@users.sourceforge.jp, peterz@infradead.org,
        torvalds@linux-foundation.org, fenghua.yu@intel.com,
        tony.luck@intel.com, mpe@ellerman.id.au, heiko.carstens@de.ibm.com,
        mingo@kernel.org, davem@davemloft.net, jejb@parisc-linux.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, schwidefsky@de.ibm.com,
        paulus@samba.org, dalias@libc.org, tglx@linutronix.de,
        bigeasy@linutronix.de
Reply-To: paulus@samba.org, hpa@zytor.com, schwidefsky@de.ibm.com,
        bigeasy@linutronix.de, dalias@libc.org, tglx@linutronix.de,
        jejb@parisc-linux.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, mpe@ellerman.id.au,
        fenghua.yu@intel.com, mingo@kernel.org, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, deller@gmx.de, benh@kernel.crashing.org,
        frederic@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org
In-Reply-To: <1525786706-22846-6-git-send-email-frederic@kernel.org>
References: <1525786706-22846-6-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/core: Consolidate default
 local_softirq_pending() implementations
Git-Commit-ID: 0fd7d86285290ccebc0dc6eb536b6b043dd6a1e4
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

Commit-ID:  0fd7d86285290ccebc0dc6eb536b6b043dd6a1e4
Gitweb:     https://git.kernel.org/tip/0fd7d86285290ccebc0dc6eb536b6b043dd6a1e4
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:20 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:27 +0200

softirq/core: Consolidate default local_softirq_pending() implementations

Consolidate and optimize default softirq mask API implementations.
Per-CPU operations are expected to be faster and a few architectures
already rely on them to implement local_softirq_pending() and related
accessors/mutators. Those will be migrated to the new generic code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1525786706-22846-6-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/interrupt.h   | 14 ++++++++++++++
 include/linux/irq_cpustat.h |  6 +-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5426627f9c55..7a11f73c5c3b 100644
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
index ddea03c7c39d..6e8895cd4d92 100644
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
