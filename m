Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeAaJ5T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:57:19 -0500
Received: from terminus.zytor.com ([65.50.211.136]:50909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeAaJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:57:16 -0500
Date: Wed, 31 Jan 2018 01:54:58 -0800
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-55595980acc3232b018ba30df8ee6e0ac40ad184@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mroos@linux.ee, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mroos@linux.ee, mingo@kernel.org
In-Reply-To: <alpine.DEB.2.20.1801301935410.1797@nanos>
References: <alpine.DEB.2.20.1801301935410.1797@nanos>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Make legacy autoprobing work again
Git-Commit-ID: 55595980acc3232b018ba30df8ee6e0ac40ad184
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

Commit-ID:  55595980acc3232b018ba30df8ee6e0ac40ad184
Gitweb:     https://git.kernel.org/tip/55595980acc3232b018ba30df8ee6e0ac40ad184
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 30 Jan 2018 19:36:32 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 31 Jan 2018 10:52:06 +0100

genirq: Make legacy autoprobing work again

Meelis reported the following warning on a quad P3 HP NetServer museum piece:
 
WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244 __irq_startup+0x80/0x100
EIP: __irq_startup+0x80/0x100
irq_startup+0x7e/0x170
probe_irq_on+0x128/0x2b0
parport_irq_probe.constprop.18+0x8d/0x1af [parport_pc]
parport_pc_probe_port+0xf11/0x1260 [parport_pc]
parport_pc_init+0x78a/0xf10 [parport_pc]
parport_parse_param.constprop.16+0xf0/0xf0 [parport_pc]
do_one_initcall+0x45/0x1e0

This is caused by the rewrite of the irq activation/startup sequence which
missed to convert a callsite in the irq legacy auto probing code.

To fix this irq_activate_and_startup() needs to gain a return value so the
pending logic can work proper.

Fixes: c942cee46bba ("genirq: Separate activation and startup")
Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Meelis Roos <mroos@linux.ee>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801301935410.1797@nanos

---
 kernel/irq/autoprobe.c | 2 +-
 kernel/irq/chip.c      | 4 ++--
 kernel/irq/internals.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index 4e8089b..8c82ea2 100644
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -71,7 +71,7 @@ unsigned long probe_irq_on(void)
 		raw_spin_lock_irq(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			desc->istate |= IRQS_AUTODETECT | IRQS_WAITING;
-			if (irq_startup(desc, IRQ_NORESEND, IRQ_START_FORCE))
+			if (irq_activate_and_startup(desc, IRQ_NORESEND))
 				desc->istate |= IRQS_PENDING;
 		}
 		raw_spin_unlock_irq(&desc->lock);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 043bfc3..f681c0e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -294,11 +294,11 @@ int irq_activate(struct irq_desc *desc)
 	return 0;
 }
 
-void irq_activate_and_startup(struct irq_desc *desc, bool resend)
+int irq_activate_and_startup(struct irq_desc *desc, bool resend)
 {
 	if (WARN_ON(irq_activate(desc)))
 		return;
-	irq_startup(desc, resend, IRQ_START_FORCE);
+	return irq_startup(desc, resend, IRQ_START_FORCE);
 }
 
 static void __irq_disable(struct irq_desc *desc, bool mask);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ab19371..ca6afa2 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -76,7 +76,7 @@ extern void __enable_irq(struct irq_desc *desc);
 #define IRQ_START_COND	false
 
 extern int irq_activate(struct irq_desc *desc);
-extern void irq_activate_and_startup(struct irq_desc *desc, bool resend);
+extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
 extern void irq_shutdown(struct irq_desc *desc);
