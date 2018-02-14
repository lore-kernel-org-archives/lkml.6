Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeBNFrU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 00:47:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754234AbeBNFrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 00:47:18 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 2/6] x86/apic: Replace disable_IO_APIC for KEXEC_JUMP
Date: Wed, 14 Feb 2018 13:46:52 +0800
Message-Id: <20180214054656.3780-3-bhe@redhat.com>
In-Reply-To: <20180214054656.3780-1-bhe@redhat.com>
References: <20180214054656.3780-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later disable_IO_APIC() will be broken down into clear_IO_APIC()
and restore_boot_irq_mode(). These two functions will be called
separately where they are needed to fix a regression introduced
by commit 522e66464467 ("x86/apic: Disable I/O APIC before
shutdown of the local APIC").

While KEXEC_JUMP code doesn't call lapic_shutdown() before jump
like kexec/kdump, so it's not impacted by commit 522e66464467.

Hence here change clear_IO_APIC() as public, and replace disable_IO_APIC()
with clear_IO_APIC() and restore_boot_irq_mode() to keep KEXEC_JUMP
code unchanged in essence. No functional change.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v4->v5:
  Make this patch to replace disable_IO_APIC() with clear_IO_APIC
  and restore_boot_irq_mode() for KEXEC_JUMP path only. This makes
  patch easier to review according to Eric's suggestion..

 arch/x86/include/asm/io_apic.h     | 1 +
 arch/x86/kernel/apic/io_apic.c     | 2 +-
 arch/x86/kernel/machine_kexec_32.c | 3 ++-
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 558d1a6a13ad..0fa95bfacb39 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -193,6 +193,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
 extern void setup_IO_APIC(void);
 extern void enable_IO_APIC(void);
 extern void disable_IO_APIC(void);
+extern void clear_IO_APIC(void);
 extern void restore_boot_irq_mode(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
 extern void print_IO_APICs(void);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b73b6b9b4b6..2d7cd2db77f5 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -587,7 +587,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 		       mpc_ioapic_id(apic), pin);
 }
 
-static void clear_IO_APIC (void)
+void clear_IO_APIC (void)
 {
 	int apic, pin;
 
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index edfede768688..4cd79d88a4ac 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -199,7 +199,8 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		clear_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f790cf9d38f..2ab14b9c1a89 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -297,7 +297,8 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		clear_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
-- 
2.13.6
