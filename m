Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932112AbeENMvN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:51:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932099AbeENMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:51:10 -0400
Date: Mon, 14 May 2018 05:50:23 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-03979f8a72e6576248e7b9e3abb72a760312dd7d@git.kernel.org>
Cc: bigeasy@linutronix.de, schwidefsky@de.ibm.com, dalias@libc.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        paulus@samba.org, hpa@zytor.com, tony.luck@intel.com,
        benh@kernel.crashing.org, deller@gmx.de, mpe@ellerman.id.au,
        davem@davemloft.net, peterz@infradead.org, tglx@linutronix.de,
        jejb@parisc-linux.org, heiko.carstens@de.ibm.com, fenghua.yu@intel.com,
        ysato@users.sourceforge.jp, frederic@kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, dalias@libc.org, bigeasy@linutronix.de,
        schwidefsky@de.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        deller@gmx.de, tony.luck@intel.com, davem@davemloft.net,
        torvalds@linux-foundation.org, paulus@samba.org, hpa@zytor.com,
        jejb@parisc-linux.org, heiko.carstens@de.ibm.com, tglx@linutronix.de,
        peterz@infradead.org, fenghua.yu@intel.com, mingo@kernel.org,
        frederic@kernel.org, ysato@users.sourceforge.jp
In-Reply-To: <1525786706-22846-8-git-send-email-frederic@kernel.org>
References: <1525786706-22846-8-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/parisc: Switch to generic
 local_softirq_pending() implementation
Git-Commit-ID: 03979f8a72e6576248e7b9e3abb72a760312dd7d
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

Commit-ID:  03979f8a72e6576248e7b9e3abb72a760312dd7d
Gitweb:     https://git.kernel.org/tip/03979f8a72e6576248e7b9e3abb72a760312dd7d
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:27 +0200

softirq/parisc: Switch to generic local_softirq_pending() implementation

Remove the ad-hoc implementation, the generic code now allows us not to
reinvent the wheel.

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
Link: http://lkml.kernel.org/r/1525786706-22846-8-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/parisc/include/asm/hardirq.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 077815169258..1a1235a9d533 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -34,14 +34,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 #define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
-#define local_softirq_pending()	this_cpu_read(irq_stat.__softirq_pending)
-
-#define __ARCH_SET_SOFTIRQ_PENDING
-
-#define set_softirq_pending(x)	\
-		this_cpu_write(irq_stat.__softirq_pending, (x))
-#define or_softirq_pending(x)	this_cpu_or(irq_stat.__softirq_pending, (x))
-
 #define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
 
 #endif /* _PARISC_HARDIRQ_H */
