Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeENMwP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:52:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeENMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:52:13 -0400
Date: Mon, 14 May 2018 05:51:23 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-424f7d3e3b950c88a4127b7dfa78ea54e287413e@git.kernel.org>
Cc: tony.luck@intel.com, tglx@linutronix.de, dalias@libc.org,
        bigeasy@linutronix.de, mingo@kernel.org, deller@gmx.de, hpa@zytor.com,
        ysato@users.sourceforge.jp, heiko.carstens@de.ibm.com,
        paulus@samba.org, benh@kernel.crashing.org, fenghua.yu@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        jejb@parisc-linux.org, schwidefsky@de.ibm.com, frederic@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        mpe@ellerman.id.au
Reply-To: frederic@kernel.org, mpe@ellerman.id.au, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, jejb@parisc-linux.org, davem@davemloft.net,
        fenghua.yu@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp, hpa@zytor.com,
        deller@gmx.de, mingo@kernel.org, bigeasy@linutronix.de,
        dalias@libc.org, tglx@linutronix.de, tony.luck@intel.com
In-Reply-To: <1525786706-22846-10-git-send-email-frederic@kernel.org>
References: <1525786706-22846-10-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/sparc: Switch to generic
 local_softirq_pending() implementation
Git-Commit-ID: 424f7d3e3b950c88a4127b7dfa78ea54e287413e
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

Commit-ID:  424f7d3e3b950c88a4127b7dfa78ea54e287413e
Gitweb:     https://git.kernel.org/tip/424f7d3e3b950c88a4127b7dfa78ea54e287413e
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:24 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:28 +0200

softirq/sparc: Switch to generic local_softirq_pending() implementation

Benefit from the generic softirq mask implementation that rely on per-CPU
mutators instead of working with raw operators on top of this_cpu_ptr().

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
Link: http://lkml.kernel.org/r/1525786706-22846-10-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sparc/include/asm/hardirq_64.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/hardirq_64.h b/arch/sparc/include/asm/hardirq_64.h
index 6aba904819a4..75b92bfe04b5 100644
--- a/arch/sparc/include/asm/hardirq_64.h
+++ b/arch/sparc/include/asm/hardirq_64.h
@@ -10,8 +10,9 @@
 #include <asm/cpudata.h>
 
 #define __ARCH_IRQ_STAT
-#define local_softirq_pending() \
-	(*this_cpu_ptr(&__cpu_data.__softirq_pending))
+
+#define local_softirq_pending_ref \
+	__cpu_data.__softirq_pending
 
 void ack_bad_irq(unsigned int irq);
 
