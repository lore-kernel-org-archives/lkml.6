Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeBQLnb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:43:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeBQLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:43:29 -0500
Date: Sat, 17 Feb 2018 03:43:07 -0800
From: tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-51b146c572201e3c368e0baa3e565760aefcf25f@git.kernel.org>
Cc: peterz@infradead.org, ebiederm@xmission.com, tglx@linutronix.de,
        bhe@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, bhe@redhat.com, tglx@linutronix.de,
        ebiederm@xmission.com, peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180214054656.3780-6-bhe@redhat.com>
References: <20180214054656.3780-6-bhe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Rename variables and functions related to
 x86_io_apic_ops
Git-Commit-ID: 51b146c572201e3c368e0baa3e565760aefcf25f
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

Commit-ID:  51b146c572201e3c368e0baa3e565760aefcf25f
Gitweb:     https://git.kernel.org/tip/51b146c572201e3c368e0baa3e565760aefcf25f
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Wed, 14 Feb 2018 13:46:55 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 17 Feb 2018 11:47:45 +0100

x86/apic: Rename variables and functions related to x86_io_apic_ops

The names of x86_io_apic_ops and its two member variables are
misleading:

The ->read() member is to read IO_APIC reg, while ->disable()
which is called by native_disable_io_apic()/irq_remapping_disable_io_apic()
is actually used to restore boot IRQ mode, not to disable the IO-APIC.

So rename x86_io_apic_ops to 'x86_apic_ops' since it doesn't only
handle the IO-APIC, but also the local APIC.

Also rename its member variables and the related callbacks.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: douly.fnst@cn.fujitsu.com
Cc: joro@8bytes.org
Cc: prarit@redhat.com
Cc: uobergfe@redhat.com
Link: http://lkml.kernel.org/r/20180214054656.3780-6-bhe@redhat.com
[ Rewrote the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/io_apic.h  | 6 +++---
 arch/x86/include/asm/x86_init.h | 8 ++++----
 arch/x86/kernel/apic/io_apic.c  | 4 ++--
 arch/x86/kernel/x86_init.c      | 6 +++---
 arch/x86/xen/apic.c             | 2 +-
 drivers/iommu/irq_remapping.c   | 4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 8018fc4..fd20a23 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -183,11 +183,11 @@ extern void disable_ioapic_support(void);
 
 extern void __init io_apic_init_mappings(void);
 extern unsigned int native_io_apic_read(unsigned int apic, unsigned int reg);
-extern void native_disable_io_apic(void);
+extern void native_restore_boot_irq_mode(void);
 
 static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 {
-	return x86_io_apic_ops.read(apic, reg);
+	return x86_apic_ops.io_apic_read(apic, reg);
 }
 
 extern void setup_IO_APIC(void);
@@ -229,7 +229,7 @@ static inline void mp_save_irq(struct mpc_intsrc *m) { }
 static inline void disable_ioapic_support(void) { }
 static inline void io_apic_init_mappings(void) { }
 #define native_io_apic_read		NULL
-#define native_disable_io_apic		NULL
+#define native_restore_boot_irq_mode	NULL
 
 static inline void setup_IO_APIC(void) { }
 static inline void enable_IO_APIC(void) { }
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index fc2f082..8830605 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -274,16 +274,16 @@ struct x86_msi_ops {
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
 
-struct x86_io_apic_ops {
-	unsigned int	(*read)   (unsigned int apic, unsigned int reg);
-	void		(*disable)(void);
+struct x86_apic_ops {
+	unsigned int	(*io_apic_read)   (unsigned int apic, unsigned int reg);
+	void		(*restore)(void);
 };
 
 extern struct x86_init_ops x86_init;
 extern struct x86_cpuinit_ops x86_cpuinit;
 extern struct x86_platform_ops x86_platform;
 extern struct x86_msi_ops x86_msi;
-extern struct x86_io_apic_ops x86_io_apic_ops;
+extern struct x86_apic_ops x86_apic_ops;
 
 extern void x86_early_init_platform_quirks(void);
 extern void x86_init_noop(void);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 9d86b10..68129f1 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1410,7 +1410,7 @@ void __init enable_IO_APIC(void)
 	clear_IO_APIC();
 }
 
-void native_disable_io_apic(void)
+void native_restore_boot_irq_mode(void)
 {
 	/*
 	 * If the i8259 is routed through an IOAPIC
@@ -1443,7 +1443,7 @@ void restore_boot_irq_mode(void)
 	if (!nr_legacy_irqs())
 		return;
 
-	x86_io_apic_ops.disable();
+	x86_apic_ops.restore();
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1151ccd..2bccd03 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -146,7 +146,7 @@ void arch_restore_msi_irqs(struct pci_dev *dev)
 }
 #endif
 
-struct x86_io_apic_ops x86_io_apic_ops __ro_after_init = {
-	.read			= native_io_apic_read,
-	.disable		= native_disable_io_apic,
+struct x86_apic_ops x86_apic_ops __ro_after_init = {
+	.io_apic_read	= native_io_apic_read,
+	.restore	= native_restore_boot_irq_mode,
 };
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index de58533..2163888 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -215,7 +215,7 @@ static void __init xen_apic_check(void)
 }
 void __init xen_init_apic(void)
 {
-	x86_io_apic_ops.read = xen_io_apic_read;
+	x86_apic_ops.io_apic_read = xen_io_apic_read;
 	/* On PV guests the APIC CPUID bit is disabled so none of the
 	 * routines end up executing. */
 	if (!xen_initial_domain())
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 49721b4..496deee 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -27,7 +27,7 @@ int disable_irq_post = 0;
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
-static void irq_remapping_disable_io_apic(void)
+static void irq_remapping_restore_boot_irq_mode(void)
 {
 	/*
 	 * With interrupt-remapping, for now we will use virtual wire A
@@ -42,7 +42,7 @@ static void irq_remapping_disable_io_apic(void)
 
 static void __init irq_remapping_modify_x86_ops(void)
 {
-	x86_io_apic_ops.disable		= irq_remapping_disable_io_apic;
+	x86_apic_ops.restore = irq_remapping_restore_boot_irq_mode;
 }
 
 static __init int setup_nointremap(char *str)
