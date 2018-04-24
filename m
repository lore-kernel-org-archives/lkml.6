Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933625AbeDXOJ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933431AbeDXOJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:09:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D0F217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>
Subject: [PATCH 03/10] softirq: Turn default irq_cpustat_t to standard per-cpu
Date: Tue, 24 Apr 2018 16:09:08 +0200
Message-Id: <1524578955-8903-4-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524578955-8903-1-git-send-email-frederic@kernel.org>
References: <1524578955-8903-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to optimize and consolidate softirq mask accesses, let's
convert the default irq_cpustat_t implementation to per-CPU standard API.

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
---
 include/linux/irq_cpustat.h | 4 ++--
 kernel/softirq.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
index 4954948..ddea03c 100644
--- a/include/linux/irq_cpustat.h
+++ b/include/linux/irq_cpustat.h
@@ -18,8 +18,8 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-extern irq_cpustat_t irq_stat[];		/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
+#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat.member, cpu))
 #endif
 
   /* arch independent irq_stat fields */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 177de36..c5fafd7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -49,8 +49,8 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
-EXPORT_SYMBOL(irq_stat);
+DEFINE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
 #endif
 
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
-- 
2.7.4
