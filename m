Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755168AbeCGX5s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:57:48 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41800 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755103AbeCGX5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:57:45 -0500
X-Google-Smtp-Source: AG47ELvRXRdhjz0Ixiey699xkHVzVjMzFANh76vnWx75/0DvO/N5BpjY9or4x5F8LuVJZajjuC1ldw==
Subject: [PATCH v3 4/5] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
Date: Wed,  7 Mar 2018 15:57:30 -0800
Message-Id: <20180307235731.22627-5-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180307235731.22627-1-palmer@sifive.com>
References: <20180307235731.22627-1-palmer@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears arm64 copied arm's GENERIC_IRQ_MULTI_HANDLER code, but made
it unconditional.  I wanted to make this generic so it could be used by
the RISC-V port.  This patch converts the arm64 code to use the new
generic code, which simply consists of deleting the arm64 code and
setting MULTI_IRQ_HANDLER instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
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
-- 
2.16.1
