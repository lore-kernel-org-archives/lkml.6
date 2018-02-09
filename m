Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeBIVNa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:13:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59354 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeBIVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:03 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com
Subject: [PATCH v10 7/7] kvm/x86: remove kvm memblock dependency
Date: Fri,  9 Feb 2018 16:11:43 -0500
Message-Id: <20180209211143.16215-8-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209211143.16215-1-pasha.tatashin@oracle.com>
References: <20180209211143.16215-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM clock is initialized later compared to other hypervisor because it has
dependency on memblock allocator.

This patch removes this dependency by using memory from BSS instead of
allocating it.

The benefits:
- remove ifdef from common code
- earlier availability of TSC.
- remove dependency on memblock, and reduce code

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/kvm.c      |  1 +
 arch/x86/kernel/kvmclock.c | 64 +++++++---------------------------------------
 arch/x86/kernel/setup.c    |  7 +----
 3 files changed, 11 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b40ffbf156c1..5fed337836b0 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -582,6 +582,7 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.name			= "KVM",
 	.detect			= kvm_detect,
 	.type			= X86_HYPER_KVM,
+	.init.init_platform	= kvmclock_init,
 	.init.guest_late_init	= kvm_guest_init,
 	.init.x2apic_available	= kvm_para_available,
 };
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 8b26c9e01cc4..11bae04a19a7 100644
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
@@ -44,6 +44,11 @@ static int parse_no_kvmclock(char *arg)
 }
 early_param("no-kvmclock", parse_no_kvmclock);
 
+/* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
+#define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
+#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
+static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
+static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
 static struct pvclock_wall_clock *wall_clock;
@@ -244,43 +249,12 @@ static void kvm_shutdown(void)
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
 
@@ -290,28 +264,11 @@ void __init kvmclock_init(void)
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
@@ -354,13 +311,10 @@ int __init kvm_setup_vsyscall_timeinfo(void)
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
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1ae67e982af7..9a691306ce8b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -48,7 +48,6 @@
 #include <linux/pci.h>
 #include <asm/pci-direct.h>
 #include <linux/init_ohci1394_dma.h>
-#include <linux/kvm_para.h>
 #include <linux/dma-contiguous.h>
 
 #include <linux/errno.h>
@@ -1007,6 +1006,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	init_hypervisor_platform();
 
+	tsc_early_delay_calibrate();
 	x86_init.resources.probe_roms();
 
 	/* after parse_early_param, so could debug it */
@@ -1192,11 +1192,6 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_find_dma_reserve();
 
-#ifdef CONFIG_KVM_GUEST
-	kvmclock_init();
-#endif
-
-	tsc_early_delay_calibrate();
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();
 
-- 
2.16.1
