Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A86C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC1623FF9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC1623FF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933763AbeGFQXb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:23:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55138 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933489AbeGFQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:23:28 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbTVp-000063-Vb; Fri, 06 Jul 2018 18:23:14 +0200
Message-ID: <20180706162049.306418570@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Jul 2018 18:13:08 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: [patch 1/7] x86/kvmclock: Remove memblock dependency
References: <20180706161307.733337643@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>

KVM clock is initialized later compared to other hypervisor clocks because
it has a dependency on the memblock allocator.

Bring it in line with other hypervisors by using memory from the BSS
instead of allocating it.

The benefits:

  - Remove ifdef from common code
  - Earlier availability of the clock
  - Remove dependency on memblock, and reduce code

The downside:

  - Static allocation of the per cpu data structures sized NR_CPUS * 64byte
    Will be addressed in follow up patches.

[ tglx: Split out from larger series ]

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org

---
 arch/x86/kernel/kvm.c      |    1 
 arch/x86/kernel/kvmclock.c |   66 +++++++--------------------------------------
 arch/x86/kernel/setup.c    |    4 --
 3 files changed, 12 insertions(+), 59 deletions(-)

--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -628,6 +628,7 @@ const __initconst struct hypervisor_x86
 	.name			= "KVM",
 	.detect			= kvm_detect,
 	.type			= X86_HYPER_KVM,
+	.init.init_platform	= kvmclock_init,
 	.init.guest_late_init	= kvm_guest_init,
 	.init.x2apic_available	= kvm_para_available,
 };
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -23,9 +23,9 @@
 #include <asm/apic.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
-#include <linux/memblock.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/mm.h>
 
 #include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
@@ -44,6 +44,13 @@ static int parse_no_kvmclock(char *arg)
 }
 early_param("no-kvmclock", parse_no_kvmclock);
 
+/* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
+#define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
+#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
+
+static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
+static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
+
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
 static struct pvclock_wall_clock *wall_clock;
@@ -244,43 +251,12 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
-static phys_addr_t __init kvm_memblock_alloc(phys_addr_t size,
-					     phys_addr_t align)
-{
-	phys_addr_t mem;
-
-	mem = memblock_alloc(size, align);
-	if (!mem)
-		return 0;
-
-	if (sev_active()) {
-		if (early_set_memory_decrypted((unsigned long)__va(mem), size))
-			goto e_free;
-	}
-
-	return mem;
-e_free:
-	memblock_free(mem, size);
-	return 0;
-}
-
-static void __init kvm_memblock_free(phys_addr_t addr, phys_addr_t size)
-{
-	if (sev_active())
-		early_set_memory_encrypted((unsigned long)__va(addr), size);
-
-	memblock_free(addr, size);
-}
-
 void __init kvmclock_init(void)
 {
 	struct pvclock_vcpu_time_info *vcpu_time;
-	unsigned long mem, mem_wall_clock;
-	int size, cpu, wall_clock_size;
+	int cpu;
 	u8 flags;
 
-	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
-
 	if (!kvm_para_available())
 		return;
 
@@ -290,28 +266,11 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	wall_clock_size = PAGE_ALIGN(sizeof(struct pvclock_wall_clock));
-	mem_wall_clock = kvm_memblock_alloc(wall_clock_size, PAGE_SIZE);
-	if (!mem_wall_clock)
-		return;
-
-	wall_clock = __va(mem_wall_clock);
-	memset(wall_clock, 0, wall_clock_size);
-
-	mem = kvm_memblock_alloc(size, PAGE_SIZE);
-	if (!mem) {
-		kvm_memblock_free(mem_wall_clock, wall_clock_size);
-		wall_clock = NULL;
-		return;
-	}
-
-	hv_clock = __va(mem);
-	memset(hv_clock, 0, size);
+	wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
+	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
 
 	if (kvm_register_clock("primary cpu clock")) {
 		hv_clock = NULL;
-		kvm_memblock_free(mem, size);
-		kvm_memblock_free(mem_wall_clock, wall_clock_size);
 		wall_clock = NULL;
 		return;
 	}
@@ -354,13 +313,10 @@ int __init kvm_setup_vsyscall_timeinfo(v
 	int cpu;
 	u8 flags;
 	struct pvclock_vcpu_time_info *vcpu_time;
-	unsigned int size;
 
 	if (!hv_clock)
 		return 0;
 
-	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
-
 	cpu = get_cpu();
 
 	vcpu_time = &hv_clock[cpu].pvti;
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1197,10 +1197,6 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_find_dma_reserve();
 
-#ifdef CONFIG_KVM_GUEST
-	kvmclock_init();
-#endif
-
 	tsc_early_delay_calibrate();
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();


