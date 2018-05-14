Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeENMwn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:52:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753445AbeENMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:52:42 -0400
Date: Mon, 14 May 2018 05:51:51 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-1a8bc8f8d6a7980a999975edbd29578fbce09359@git.kernel.org>
Cc: schwidefsky@de.ibm.com, fenghua.yu@intel.com, mingo@kernel.org,
        heiko.carstens@de.ibm.com, tglx@linutronix.de, tony.luck@intel.com,
        paulus@samba.org, jejb@parisc-linux.org, bigeasy@linutronix.de,
        deller@gmx.de, dalias@libc.org, mpe@ellerman.id.au,
        torvalds@linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org, hpa@zytor.com,
        peterz@infradead.org, frederic@kernel.org, ysato@users.sourceforge.jp
Reply-To: fenghua.yu@intel.com, schwidefsky@de.ibm.com, dalias@libc.org,
        deller@gmx.de, bigeasy@linutronix.de, jejb@parisc-linux.org,
        paulus@samba.org, tony.luck@intel.com, tglx@linutronix.de,
        mingo@kernel.org, heiko.carstens@de.ibm.com,
        torvalds@linux-foundation.org, davem@davemloft.net, mpe@ellerman.id.au,
        frederic@kernel.org, ysato@users.sourceforge.jp, peterz@infradead.org,
        hpa@zytor.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <1525786706-22846-11-git-send-email-frederic@kernel.org>
References: <1525786706-22846-11-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/x86: Switch to generic
 local_softirq_pending() implementation
Git-Commit-ID: 1a8bc8f8d6a7980a999975edbd29578fbce09359
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

Commit-ID:  1a8bc8f8d6a7980a999975edbd29578fbce09359
Gitweb:     https://git.kernel.org/tip/1a8bc8f8d6a7980a999975edbd29578fbce09359
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:25 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:28 +0200

softirq/x86: Switch to generic local_softirq_pending() implementation

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
Link: http://lkml.kernel.org/r/1525786706-22846-11-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/hardirq.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 5ea2afd4c871..740a428acf1e 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -50,14 +50,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 
-#define local_softirq_pending()	this_cpu_read(irq_stat.__softirq_pending)
-
-#define __ARCH_SET_SOFTIRQ_PENDING
-
-#define set_softirq_pending(x)	\
-		this_cpu_write(irq_stat.__softirq_pending, (x))
-#define or_softirq_pending(x)	this_cpu_or(irq_stat.__softirq_pending, (x))
-
 extern void ack_bad_irq(unsigned int irq);
 
 extern u64 arch_irq_stat_cpu(unsigned int cpu);
