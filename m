Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F29C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E9523EA4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E9523EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbeGFQXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:23:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55152 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933442AbeGFQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:23:34 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbTVu-00006u-26; Fri, 06 Jul 2018 18:23:18 +0200
Message-ID: <20180706162049.765314976@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Jul 2018 18:13:13 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: [patch 6/7] x86/kvmclock: Move kvmclock vsyscall param and init to
 kvmclock
References: <20180706161307.733337643@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to have this in the kvm code itself and call it from
there. This can be called from an initcall and the parameter is cleared
when the hypervisor is not KVM.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
---
 arch/x86/include/asm/kvm_guest.h |    7 -----
 arch/x86/kernel/kvm.c            |   13 ----------
 arch/x86/kernel/kvmclock.c       |   49 ++++++++++++++++++++++++---------------
 3 files changed, 31 insertions(+), 38 deletions(-)

--- a/arch/x86/include/asm/kvm_guest.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_KVM_GUEST_H
-#define _ASM_X86_KVM_GUEST_H
-
-int kvm_setup_vsyscall_timeinfo(void);
-
-#endif /* _ASM_X86_KVM_GUEST_H */
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -45,7 +45,6 @@
 #include <asm/apic.h>
 #include <asm/apicdef.h>
 #include <asm/hypervisor.h>
-#include <asm/kvm_guest.h>
 
 static int kvmapf = 1;
 
@@ -66,15 +65,6 @@ static int __init parse_no_stealacc(char
 
 early_param("no-steal-acc", parse_no_stealacc);
 
-static int kvmclock_vsyscall = 1;
-static int __init parse_no_kvmclock_vsyscall(char *arg)
-{
-        kvmclock_vsyscall = 0;
-        return 0;
-}
-
-early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
-
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64);
 static int has_steal_clock = 0;
@@ -560,9 +550,6 @@ static void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		apic_set_eoi_write(kvm_guest_apic_eoi_write);
 
-	if (kvmclock_vsyscall)
-		kvm_setup_vsyscall_timeinfo();
-
 #ifdef CONFIG_SMP
 	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
 	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -27,12 +27,14 @@
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
 
+#include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
 #include <asm/reboot.h>
 #include <asm/kvmclock.h>
 
 static int __initdata kvmclock = 1;
+static int __initdata kvmclock_vsyscall = 1;
 static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
 static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
 static u64 kvm_sched_clock_offset __ro_after_init;
@@ -44,6 +46,13 @@ static int __init parse_no_kvmclock(char
 }
 early_param("no-kvmclock", parse_no_kvmclock);
 
+static int __init parse_no_kvmclock_vsyscall(char *arg)
+{
+	kvmclock_vsyscall = 0;
+	return 0;
+}
+early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
+
 /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
 #define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
 
@@ -227,6 +236,25 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
+static int __init kvm_setup_vsyscall_timeinfo(void)
+{
+#ifdef CONFIG_X86_64
+	u8 flags;
+
+	if (!hv_clock || !kvmclock_vsyscall)
+		return 0;
+
+	flags = pvclock_read_flags(&hv_clock[0].pvti);
+	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
+		return 1;
+
+	pvclock_set_pvti_cpu0_va(hv_clock);
+	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
+#endif
+	return 0;
+}
+early_initcall(kvm_setup_vsyscall_timeinfo);
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
@@ -241,6 +269,9 @@ void __init kvmclock_init(void)
 		return;
 	}
 
+	if (!hypervisor_is_type(X86_HYPER_KVM))
+		kvmclock_vsyscall = 0;
+
 	pr_info("kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
@@ -270,21 +301,3 @@ void __init kvmclock_init(void)
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
 }
-
-int __init kvm_setup_vsyscall_timeinfo(void)
-{
-#ifdef CONFIG_X86_64
-	u8 flags;
-
-	if (!hv_clock)
-		return 0;
-
-	flags = pvclock_read_flags(&hv_clock[0].pvti);
-	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
-		return 1;
-
-	pvclock_set_pvti_cpu0_va(hv_clock);
-	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
-#endif
-	return 0;
-}


