Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCNUum (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:50:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCNUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:50:40 -0400
Date: Wed, 14 Mar 2018 13:50:29 -0700
From: tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-ec38432a7e84bb614401788ec03c6f05e7915832@git.kernel.org>
Cc: tglx@linutronix.de, palmer@sifive.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, will.deacon@arm.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hch@lst.de, will.deacon@arm.com,
        hpa@zytor.com, tglx@linutronix.de, palmer@sifive.com, mingo@kernel.org
In-Reply-To: <20180307235731.22627-5-palmer@sifive.com>
References: <20180307235731.22627-5-palmer@sifive.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
Git-Commit-ID: ec38432a7e84bb614401788ec03c6f05e7915832
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

Commit-ID:  ec38432a7e84bb614401788ec03c6f05e7915832
Gitweb:     https://git.kernel.org/tip/ec38432a7e84bb614401788ec03c6f05e7915832
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Wed, 7 Mar 2018 15:57:30 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 21:46:30 +0100

arm64: Use the new GENERIC_IRQ_MULTI_HANDLER

It appears arm64 copied arm's GENERIC_IRQ_MULTI_HANDLER code, but made
it unconditional.

Convert the arm64 code to use the new generic code, which simply consists
of deleting the arm64 code and setting GENERIC_MULTI_IRQ_HANDLER instead.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: jonas@southpole.se
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux@armlinux.org.uk
Cc: stefan.kristiansson@saunalahti.fi
Cc: openrisc@lists.librecores.org
Cc: shorne@gmail.com
Cc: linux-riscv@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/20180307235731.22627-5-palmer@sifive.com

---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/irq.h |  2 --
 arch/arm64/kernel/irq.c      | 10 ----------
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb7ef8e..cb03e93f03cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
+	select GENERIC_IRQ_MULTI_HANDLER
 	select NO_BOOTMEM
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index a0fee6985e6a..b2b0c6405eb0 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -8,8 +8,6 @@
 
 struct pt_regs;
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 static inline int nr_legacy_irqs(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 60e5fc661f74..780a12f59a8f 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -42,16 +42,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-void (*handle_arch_irq)(struct pt_regs *) = NULL;
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	if (handle_arch_irq)
-		return;
-
-	handle_arch_irq = handle_irq;
-}
-
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
