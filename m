Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeBNFre (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 00:47:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754350AbeBNFrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 00:47:31 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 4/6] x86/apic: Remove useless disable_IO_APIC
Date: Wed, 14 Feb 2018 13:46:54 +0800
Message-Id: <20180214054656.3780-5-bhe@redhat.com>
In-Reply-To: <20180214054656.3780-1-bhe@redhat.com>
References: <20180214054656.3780-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one uses it anymore.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/io_apic.h     |  1 -
 arch/x86/kernel/apic/io_apic.c     | 13 -------------
 arch/x86/kernel/machine_kexec_32.c |  5 ++---
 arch/x86/kernel/machine_kexec_64.c |  5 ++---
 4 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 0fa95bfacb39..5e389145d808 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -192,7 +192,6 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 
 extern void setup_IO_APIC(void);
 extern void enable_IO_APIC(void);
-extern void disable_IO_APIC(void);
 extern void clear_IO_APIC(void);
 extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 2d7cd2db77f5..9d86b10c2121 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1438,19 +1438,6 @@ void native_disable_io_apic(void)
 		disconnect_bsp_APIC(ioapic_i8259.pin != -1);
 }
 
-/*
- * Not an __init, needed by the reboot code
- */
-void disable_IO_APIC(void)
-{
-	/*
-	 * Clear the IO-APIC before rebooting:
-	 */
-	clear_IO_APIC();
-
-	restore_boot_irq_mode();
-}
-
 void restore_boot_irq_mode(void)
 {
 	if (!nr_legacy_irqs())
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 4cd79d88a4ac..60cdec6628b0 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -195,9 +195,8 @@ void machine_kexec(struct kimage *image)
 		/*
 		 * We need to put APICs in legacy mode so that we can
 		 * get timer interrupts in second kernel. kexec/kdump
-		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
+		 * paths already have calls to restore_boot_irq_mode()
+		 * in one form or other. kexec jump path also need one.
 		 */
 		clear_IO_APIC();
 		restore_boot_irq_mode();
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 2ab14b9c1a89..5ffbc55ea80f 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -293,9 +293,8 @@ void machine_kexec(struct kimage *image)
 		/*
 		 * We need to put APICs in legacy mode so that we can
 		 * get timer interrupts in second kernel. kexec/kdump
-		 * paths already have calls to disable_IO_APIC() in
-		 * one form or other. kexec jump path also need
-		 * one.
+		 * paths already have calls to restore_boot_irq_mode()
+		 * in one form or other. kexec jump path also need one.
 		 */
 		clear_IO_APIC();
 		restore_boot_irq_mode();
-- 
2.13.6
