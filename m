Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52431214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52431214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeH1LbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:31:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbeH1LbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:31:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69471AF54;
        Tue, 28 Aug 2018 07:40:37 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 01/15] xen: move pv irq related functions under CONFIG_XEN_PV umbrella
Date:   Tue, 28 Aug 2018 09:40:12 +0200
Message-Id: <20180828074026.820-2-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All functions in arch/x86/xen/irq.c and arch/x86/xen/xen-asm*.S are
specific to PV guests. Include them in the kernel with
CONFIG_XEN_PV only.

Make the PV specific code in arch/x86/entry/entry_*.S dependent on
CONFIG_XEN_PV instead of CONFIG_XEN.

The HVM specific code should depend on CONFIG_XEN_PVHVM.

While at it reformat the Makefile to make it more readable.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |  8 +++++---
 arch/x86/entry/entry_64.S |  8 +++++---
 arch/x86/xen/Makefile     | 41 +++++++++++++++++++++++++++++++----------
 include/xen/events.h      |  2 ++
 4 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2767c625a52c..9cc4c3064ce0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -782,7 +782,7 @@ GLOBAL(__begin_SYSENTER_singlestep_region)
  * will ignore all of the single-step traps generated in this range.
  */
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 /*
  * Xen doesn't set %esp to be precisely what the normal SYSENTER
  * entry point expects, so fix it up before using the normal path.
@@ -1240,7 +1240,7 @@ ENTRY(spurious_interrupt_bug)
 	jmp	common_exception
 END(spurious_interrupt_bug)
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 ENTRY(xen_hypervisor_callback)
 	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
@@ -1321,11 +1321,13 @@ ENTRY(xen_failsafe_callback)
 	_ASM_EXTABLE(3b, 8b)
 	_ASM_EXTABLE(4b, 9b)
 ENDPROC(xen_failsafe_callback)
+#endif /* CONFIG_XEN_PV */
 
+#ifdef CONFIG_XEN_PVHVM
 BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
 		 xen_evtchn_do_upcall)
+#endif
 
-#endif /* CONFIG_XEN */
 
 #if IS_ENABLED(CONFIG_HYPERV)
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..a9ec5d3c6e67 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1050,7 +1050,7 @@ ENTRY(do_softirq_own_stack)
 	ret
 ENDPROC(do_softirq_own_stack)
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
 
 /*
@@ -1130,11 +1130,13 @@ ENTRY(xen_failsafe_callback)
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
+#endif /* CONFIG_XEN_PV */
 
+#ifdef CONFIG_XEN_PVHVM
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	xen_hvm_callback_vector xen_evtchn_do_upcall
+#endif
 
-#endif /* CONFIG_XEN */
 
 #if IS_ENABLED(CONFIG_HYPERV)
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
@@ -1151,7 +1153,7 @@ idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 idtentry xennmi			do_nmi			has_error_code=0
 idtentry xendebug		do_debug		has_error_code=0
 idtentry xenint3		do_int3			has_error_code=0
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index d83cb5478f54..f723b5aa8f74 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -12,25 +12,46 @@ endif
 # Make sure early boot has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_enlighten_pv.o		:= $(nostackp)
-CFLAGS_mmu_pv.o		:= $(nostackp)
+CFLAGS_mmu_pv.o			:= $(nostackp)
 
-obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
-			time.o xen-asm.o xen-asm_$(BITS).o \
-			grant-table.o suspend.o platform-pci-unplug.o
+obj-y				+= enlighten.o
+obj-y				+= multicalls.o
+obj-y				+= mmu.o
+obj-y				+= time.o
+obj-y				+= grant-table.o
+obj-y				+= suspend.o
+obj-y				+= platform-pci-unplug.o
 
-obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
-obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
-						p2m.o enlighten_pv.o mmu_pv.o
-obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
+obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
+obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
+obj-$(CONFIG_XEN_PVHVM)		+= suspend_hvm.o
 
-obj-$(CONFIG_EVENT_TRACING) += trace.o
+obj-$(CONFIG_XEN_PV)		+= setup.o
+obj-$(CONFIG_XEN_PV)		+= apic.o
+obj-$(CONFIG_XEN_PV)		+= pmu.o
+obj-$(CONFIG_XEN_PV)		+= suspend_pv.o
+obj-$(CONFIG_XEN_PV)		+= p2m.o
+obj-$(CONFIG_XEN_PV)		+= enlighten_pv.o
+obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
+obj-$(CONFIG_XEN_PV)		+= irq.o
+obj-$(CONFIG_XEN_PV)		+= xen-asm.o
+obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
+
+obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
+obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
+
+obj-$(CONFIG_EVENT_TRACING)	+= trace.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_XEN_PV_SMP)  	+= smp_pv.o
 obj-$(CONFIG_XEN_PVHVM_SMP)  	+= smp_hvm.o
+
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= spinlock.o
+
 obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
+
 obj-$(CONFIG_XEN_DOM0)		+= vga.o
+
 obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
+
 obj-$(CONFIG_XEN_EFI)		+= efi.o
-obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
diff --git a/include/xen/events.h b/include/xen/events.h
index c3e6bc643a7b..a48897199975 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -89,11 +89,13 @@ unsigned irq_from_evtchn(unsigned int evtchn);
 int irq_from_virq(unsigned int cpu, unsigned int virq);
 unsigned int evtchn_from_irq(unsigned irq);
 
+#ifdef CONFIG_XEN_PVHVM
 /* Xen HVM evtchn vector callback */
 void xen_hvm_callback_vector(void);
 #ifdef CONFIG_TRACING
 #define trace_xen_hvm_callback_vector xen_hvm_callback_vector
 #endif
+#endif
 int xen_set_callback_via(uint64_t via);
 void xen_evtchn_do_upcall(struct pt_regs *regs);
 void xen_hvm_evtchn_do_upcall(void);
-- 
2.16.4

