Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbeENMtv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:49:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeENMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:49:49 -0400
Date: Mon, 14 May 2018 05:48:52 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-0f6f47bacba514f4e9f61de0d85940dfb41498cc@git.kernel.org>
Cc: paulus@samba.org, mpe@ellerman.id.au, tglx@linutronix.de,
        peterz@infradead.org, frederic@kernel.org, dalias@libc.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com, deller@gmx.de,
        schwidefsky@de.ibm.com, benh@kernel.crashing.org, davem@davemloft.net,
        bigeasy@linutronix.de, jejb@parisc-linux.org, mingo@kernel.org,
        torvalds@linux-foundation.org, ysato@users.sourceforge.jp,
        heiko.carstens@de.ibm.com, hpa@zytor.com, tony.luck@intel.com
Reply-To: frederic@kernel.org, dalias@libc.org, peterz@infradead.org,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org, deller@gmx.de,
        schwidefsky@de.ibm.com, davem@davemloft.net, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, tglx@linutronix.de,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        tony.luck@intel.com, hpa@zytor.com, jejb@parisc-linux.org,
        bigeasy@linutronix.de, mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <1525786706-22846-5-git-send-email-frederic@kernel.org>
References: <1525786706-22846-5-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/core: Turn default irq_cpustat_t to standard
 per-cpu
Git-Commit-ID: 0f6f47bacba514f4e9f61de0d85940dfb41498cc
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

Commit-ID:  0f6f47bacba514f4e9f61de0d85940dfb41498cc
Gitweb:     https://git.kernel.org/tip/0f6f47bacba514f4e9f61de0d85940dfb41498cc
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:19 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:27 +0200

softirq/core: Turn default irq_cpustat_t to standard per-cpu

In order to optimize and consolidate softirq mask accesses, let's
convert the default irq_cpustat_t implementation to per-CPU standard API.

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
Link: http://lkml.kernel.org/r/1525786706-22846-5-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/irq_cpustat.h | 4 ++--
 kernel/softirq.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
index 4954948d1973..ddea03c7c39d 100644
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
index 177de3640c78..c5fafd792df1 100644
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
