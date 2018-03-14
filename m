Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeCNUvH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:51:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCNUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:51:06 -0400
Date: Wed, 14 Mar 2018 13:50:58 -0700
From: tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-d9af5838180359c6be1c07989c91b28eee93d7e7@git.kernel.org>
Cc: palmer@sifive.com, shorne@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, shorne@gmail.com, palmer@sifive.com
In-Reply-To: <20180312184429.20515-1-palmer@sifive.com>
References: <20180312184429.20515-1-palmer@sifive.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
Git-Commit-ID: d9af5838180359c6be1c07989c91b28eee93d7e7
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

Commit-ID:  d9af5838180359c6be1c07989c91b28eee93d7e7
Gitweb:     https://git.kernel.org/tip/d9af5838180359c6be1c07989c91b28eee93d7e7
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Mon, 12 Mar 2018 11:44:29 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 21:46:30 +0100

openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER

It appears that openrisc copied arm64's irq multi handler code (which came
from arm).

Convert it to use the generic version.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se
Cc: stefan.kristiansson@saunalahti.fi
Cc: openrisc@lists.librecores.org
Link: https://lkml.kernel.org/r/20180312184429.20515-1-palmer@sifive.com

---
 arch/openrisc/Kconfig           | 1 +
 arch/openrisc/include/asm/irq.h | 2 --
 arch/openrisc/kernel/irq.c      | 7 -------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 339df7324e9c..dfb6a79ba7ff 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -35,6 +35,7 @@ config OPENRISC
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/openrisc/include/asm/irq.h b/arch/openrisc/include/asm/irq.h
index d9eee0a2b7b4..eb612b1865d2 100644
--- a/arch/openrisc/include/asm/irq.h
+++ b/arch/openrisc/include/asm/irq.h
@@ -24,6 +24,4 @@
 
 #define NO_IRQ		(-1)
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 #endif /* __ASM_OPENRISC_IRQ_H__ */
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index 35e478a93116..5f9445effaf8 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -41,13 +41,6 @@ void __init init_IRQ(void)
 	irqchip_init();
 }
 
-static void (*handle_arch_irq)(struct pt_regs *);
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	handle_arch_irq = handle_irq;
-}
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	handle_arch_irq(regs);
