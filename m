Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeBAKAc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:00:32 -0500
Received: from terminus.zytor.com ([65.50.211.136]:49153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeBAKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:00:29 -0500
Date: Thu, 1 Feb 2018 01:58:13 -0800
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9bc43be5151aaf1aa87f832128f1687341f07483@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mroos@linux.ee
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de, mroos@linux.ee,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.20.1801301935410.1797@nanos>
References: <alpine.DEB.2.20.1801301935410.1797@nanos>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Make legacy autoprobing work again
Git-Commit-ID: 9bc43be5151aaf1aa87f832128f1687341f07483
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

Commit-ID:  9bc43be5151aaf1aa87f832128f1687341f07483
Gitweb:     https://git.kernel.org/tip/9bc43be5151aaf1aa87f832128f1687341f07483
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 30 Jan 2018 19:36:32 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Feb 2018 10:54:48 +0100

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
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f681c0e..c69357a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -297,7 +297,7 @@ int irq_activate(struct irq_desc *desc)
 int irq_activate_and_startup(struct irq_desc *desc, bool resend)
 {
 	if (WARN_ON(irq_activate(desc)))
-		return;
+		return 0;
 	return irq_startup(desc, resend, IRQ_START_FORCE);
 }
 
