Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeENMxV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:53:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeENMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:53:18 -0400
Date: Mon, 14 May 2018 05:52:20 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-48bda43eabb8d086204f543cf8bbad696b8c6391@git.kernel.org>
Cc: mpe@ellerman.id.au, jejb@parisc-linux.org,
        torvalds@linux-foundation.org, ysato@users.sourceforge.jp,
        fenghua.yu@intel.com, benh@kernel.crashing.org, mingo@kernel.org,
        tony.luck@intel.com, heiko.carstens@de.ibm.com, paulus@samba.org,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        bigeasy@linutronix.de, hpa@zytor.com, dalias@libc.org,
        frederic@kernel.org, deller@gmx.de, tglx@linutronix.de,
        peterz@infradead.org, davem@davemloft.net
Reply-To: benh@kernel.crashing.org, mingo@kernel.org, fenghua.yu@intel.com,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        tony.luck@intel.com, mpe@ellerman.id.au, torvalds@linux-foundation.org,
        jejb@parisc-linux.org, deller@gmx.de, frederic@kernel.org,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        peterz@infradead.org, bigeasy@linutronix.de, hpa@zytor.com
In-Reply-To: <1525786706-22846-12-git-send-email-frederic@kernel.org>
References: <1525786706-22846-12-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/s390: Move default mutators of overwritten
 softirq mask to s390
Git-Commit-ID: 48bda43eabb8d086204f543cf8bbad696b8c6391
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

Commit-ID:  48bda43eabb8d086204f543cf8bbad696b8c6391
Gitweb:     https://git.kernel.org/tip/48bda43eabb8d086204f543cf8bbad696b8c6391
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:28 +0200

softirq/s390: Move default mutators of overwritten softirq mask to s390

s390 is now the last architecture that entirely overwrites
local_softirq_pending() and uses the according default definitions of
set_softirq_pending() and or_softirq_pending().

Just move these to s390 to debloat the generic code complexity.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
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
Link: http://lkml.kernel.org/r/1525786706-22846-12-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/s390/include/asm/hardirq.h | 2 ++
 include/linux/interrupt.h       | 7 -------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index a296c6acfd07..dfbc3c6c0674 100644
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
index 7a11f73c5c3b..eeceac3376fc 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -442,13 +442,6 @@ extern bool force_irqthreads;
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
