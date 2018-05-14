Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeENMyR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:54:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbeENMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:54:15 -0400
Date: Mon, 14 May 2018 05:48:21 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-30d723340c30ff9afe200ef5ecbbdc77e6d1f816@git.kernel.org>
Cc: mpe@ellerman.id.au, torvalds@linux-foundation.org,
        benh@kernel.crashing.org, frederic@kernel.org, dalias@libc.org,
        deller@gmx.de, tony.luck@intel.com, paulus@samba.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, fenghua.yu@intel.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        schwidefsky@de.ibm.com, bigeasy@linutronix.de,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        davem@davemloft.net, jejb@parisc-linux.org
Reply-To: fenghua.yu@intel.com, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, bigeasy@linutronix.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net,
        jejb@parisc-linux.org, ysato@users.sourceforge.jp,
        torvalds@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, frederic@kernel.org, dalias@libc.org,
        tony.luck@intel.com, deller@gmx.de, linux-kernel@vger.kernel.org,
        paulus@samba.org
In-Reply-To: <1525786706-22846-4-git-send-email-frederic@kernel.org>
References: <1525786706-22846-4-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/sh: Use nmi_count() on /proc/interrupts
 print out
Git-Commit-ID: 30d723340c30ff9afe200ef5ecbbdc77e6d1f816
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

Commit-ID:  30d723340c30ff9afe200ef5ecbbdc77e6d1f816
Gitweb:     https://git.kernel.org/tip/30d723340c30ff9afe200ef5ecbbdc77e6d1f816
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:18 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:27 +0200

softirq/sh: Use nmi_count() on /proc/interrupts print out

Use nmi_count() instead of accessing directly the irq_stat structure.
Its implementation is going to change to use per-CPU, so defer the guts
to standard API instead.

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
Link: http://lkml.kernel.org/r/1525786706-22846-4-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sh/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 245dbeb20afe..5717c7cbdd97 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stat[j].__nmi_count);
+		seq_printf(p, "%10u ", nmi_count(j));
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
