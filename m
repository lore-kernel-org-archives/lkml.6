Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeENMsu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:48:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeENMsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:48:47 -0400
Date: Mon, 14 May 2018 05:47:51 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-49892dbc2cb349f78eccfc1f55eac0ec718f44bb@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        ysato@users.sourceforge.jp, deller@gmx.de, jejb@parisc-linux.org,
        heiko.carstens@de.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, torvalds@linux-foundation.org,
        bigeasy@linutronix.de, dalias@libc.org, peterz@infradead.org,
        hpa@zytor.com, frederic@kernel.org, davem@davemloft.net,
        fenghua.yu@intel.com, paulus@samba.org, tony.luck@intel.com,
        tglx@linutronix.de, schwidefsky@de.ibm.com
Reply-To: deller@gmx.de, jejb@parisc-linux.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, ysato@users.sourceforge.jp, bigeasy@linutronix.de,
        dalias@libc.org, heiko.carstens@de.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, torvalds@linux-foundation.org,
        davem@davemloft.net, hpa@zytor.com, peterz@infradead.org,
        frederic@kernel.org, fenghua.yu@intel.com, paulus@samba.org,
        tony.luck@intel.com, schwidefsky@de.ibm.com, tglx@linutronix.de
In-Reply-To: <1525786706-22846-3-git-send-email-frederic@kernel.org>
References: <1525786706-22846-3-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/sparc: Convert local_softirq_pending() to
 use per-cpu op
Git-Commit-ID: 49892dbc2cb349f78eccfc1f55eac0ec718f44bb
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

Commit-ID:  49892dbc2cb349f78eccfc1f55eac0ec718f44bb
Gitweb:     https://git.kernel.org/tip/49892dbc2cb349f78eccfc1f55eac0ec718f44bb
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:26 +0200

softirq/sparc: Convert local_softirq_pending() to use per-cpu op

In order to consolidate and optimize generic softirq mask accesses, we
first need to convert architectures to use per-cpu operations when
possible.

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
Link: http://lkml.kernel.org/r/1525786706-22846-3-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sparc/include/asm/hardirq_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/hardirq_64.h b/arch/sparc/include/asm/hardirq_64.h
index f56540271993..6aba904819a4 100644
--- a/arch/sparc/include/asm/hardirq_64.h
+++ b/arch/sparc/include/asm/hardirq_64.h
@@ -11,7 +11,7 @@
 
 #define __ARCH_IRQ_STAT
 #define local_softirq_pending() \
-	(local_cpu_data().__softirq_pending)
+	(*this_cpu_ptr(&__cpu_data.__softirq_pending))
 
 void ack_bad_irq(unsigned int irq);
 
