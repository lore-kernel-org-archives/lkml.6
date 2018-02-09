Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBIMKa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:10:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750997AbeBIMK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:10:27 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/5] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
Date: Fri,  9 Feb 2018 20:10:05 +0800
Message-Id: <20180209121008.28980-3-bhe@redhat.com>
In-Reply-To: <20180209121008.28980-1-bhe@redhat.com>
References: <20180209121008.28980-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression fix.

Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
calling after disable_IO_APIC(). This introdued a regression. The
root cause is that disable_IO_APIC() not only clears IO_APIC, also
restore boot irq mode by setting LAPIC/APIC/IMCR, lapic_shutdown()
after disable_IO_APIC() will disable LAPIC and ruin the possible
virtual wire mode setting which the code has been trying to do all
along.

The consequence is, in KVM guest kernel always prints warning as below
during kexec/kdump kernel boots up. That happened in setup_local_APIC()
since 'do { xxx } while (queued && max_loops > 0)' loop does not function
well any more if pending irq exists in APIC IRR after LAPIC is disabled.
And people even saw casual kdump kernel hang once in ~30 attempts during
stress testing of kdump on KVM machine.

[    0.001000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1467 setup_local_APIC+0x228/0x330
[    0.001000] Modules linked in:
[    0.001000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc5+ #3
[    0.001000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
[    0.001000] RIP: 0010:setup_local_APIC+0x228/0x330
[    0.001000] RSP: 0000:ffffffffb6e03eb8 EFLAGS: 00010286
[    0.001000] RAX: 0000009edb4c4d84 RBX: 0000000000000000 RCX: 00000000b099d800
[    0.001000] RDX: 0000009e00000000 RSI: 0000000000000000 RDI: 0000000000000810
[    0.001000] RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000001
[    0.001000] R10: ffff98ce6a801c00 R11: 0761076d072f0776 R12: 0000000000000001
[    0.001000] R13: 00000000000000f0 R14: 0000000000004000 R15: ffffffffffffc6ff
[    0.001000] FS:  0000000000000000(0000) GS:ffff98ce6bc00000(0000) knlGS:0000000000000000
[    0.001000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.001000] CR2: 00000000ffffffff CR3: 0000000022209000 CR4: 00000000000406b0
[    0.001000] Call Trace:
[    0.001000]  apic_bsp_setup+0x56/0x74
[    0.001000]  x86_late_time_init+0x11/0x16
[    0.001000]  start_kernel+0x3c9/0x486
[    0.001000]  secondary_startup_64+0xa5/0xb0
[    0.001000] Code: 00 85 c9 74 2d 0f 31 c1 e1 0a 48 c1 e2 20 41 89 cf 4c 03 7c 24 08 48 09 d0 49 29 c7 4c 89 3c 24 48 83 3c 24 00 0f 8f 8f fe ff
ff <0f> ff e9 10 ff ff ff 48 83 2c 24 01 eb e7 48 83 c4 18 5b 5d 41
[    0.001000] ---[ end trace b88e71b9a6ebebdd ]---
[    0.001000] masked ExtINT on CPU#0

To fix this, just break down disable_IO_APIC(), then call
clear_IO_APIC() to stop IO_APIC where disable_IO_APIC() was called,
and call restore_boot_irq_mode() to restore boot irq mode before
reboot or kexec/kdump jump.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/io_apic.h     | 1 +
 arch/x86/kernel/apic/io_apic.c     | 2 +-
 arch/x86/kernel/crash.c            | 3 ++-
 arch/x86/kernel/machine_kexec_32.c | 2 +-
 arch/x86/kernel/machine_kexec_64.c | 2 +-
 arch/x86/kernel/reboot.c           | 3 ++-
 6 files changed, 8 insertions(+), 5 deletions(-)

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
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 10e74d4778a1..1f6680427ff0 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -199,9 +199,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_X86_IO_APIC
 	/* Prevent crash_kexec() from deadlocking on ioapic_lock. */
 	ioapic_zap_locks();
-	disable_IO_APIC();
+	clear_IO_APIC();
 #endif
 	lapic_shutdown();
+	restore_boot_irq_mode();
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index edfede768688..f78bb4432bfb 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -199,7 +199,7 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f790cf9d38f..cb0c2d0a4c99 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -297,7 +297,7 @@ void machine_kexec(struct kimage *image)
 		 * one form or other. kexec jump path also need
 		 * one.
 		 */
-		disable_IO_APIC();
+		restore_boot_irq_mode();
 #endif
 	}
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 2126b9d27c34..725624b6c0c0 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -666,7 +666,7 @@ void native_machine_shutdown(void)
 	 * Even without the erratum, it still makes sense to quiet IO APIC
 	 * before disabling Local APIC.
 	 */
-	disable_IO_APIC();
+	clear_IO_APIC();
 #endif
 
 #ifdef CONFIG_SMP
@@ -680,6 +680,7 @@ void native_machine_shutdown(void)
 #endif
 
 	lapic_shutdown();
+	restore_boot_irq_mode();
 
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
-- 
2.13.6
