Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeENMvy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:51:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753416AbeENMvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:51:52 -0400
Date: Mon, 14 May 2018 05:50:53 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-1321a5de1ecb0d2981394ff2111c75c4dcb0c237@git.kernel.org>
Cc: davem@davemloft.net, jejb@parisc-linux.org, ysato@users.sourceforge.jp,
        heiko.carstens@de.ibm.com, paulus@samba.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, deller@gmx.de,
        fenghua.yu@intel.com, tony.luck@intel.com, dalias@libc.org,
        bigeasy@linutronix.de, tglx@linutronix.de, benh@kernel.crashing.org,
        frederic@kernel.org, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, frederic@kernel.org,
        benh@kernel.crashing.org, tglx@linutronix.de, dalias@libc.org,
        bigeasy@linutronix.de, tony.luck@intel.com, deller@gmx.de,
        fenghua.yu@intel.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, schwidefsky@de.ibm.com, hpa@zytor.com,
        mpe@ellerman.id.au, paulus@samba.org, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, jejb@parisc-linux.org, davem@davemloft.net
In-Reply-To: <1525786706-22846-9-git-send-email-frederic@kernel.org>
References: <1525786706-22846-9-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/powerpc: Switch to generic
 local_softirq_pending() implementation
Git-Commit-ID: 1321a5de1ecb0d2981394ff2111c75c4dcb0c237
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

Commit-ID:  1321a5de1ecb0d2981394ff2111c75c4dcb0c237
Gitweb:     https://git.kernel.org/tip/1321a5de1ecb0d2981394ff2111c75c4dcb0c237
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:23 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:28 +0200

softirq/powerpc: Switch to generic local_softirq_pending() implementation

Remove the ad-hoc implementation, the generic code now allows us not to
reinvent the wheel.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1525786706-22846-9-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/include/asm/hardirq.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 5986d473722b..383f628acbf8 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -25,15 +25,8 @@ typedef struct {
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define __ARCH_IRQ_STAT
-
-#define local_softirq_pending()	__this_cpu_read(irq_stat.__softirq_pending)
-
-#define __ARCH_SET_SOFTIRQ_PENDING
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
-#define set_softirq_pending(x) __this_cpu_write(irq_stat.__softirq_pending, (x))
-#define or_softirq_pending(x) __this_cpu_or(irq_stat.__softirq_pending, (x))
-
 static inline void ack_bad_irq(unsigned int irq)
 {
 	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
