Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07185C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFACD23FFA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFACD23FFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933732AbeGFQXa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:23:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933452AbeGFQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:23:28 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbTVr-00006P-Iz; Fri, 06 Jul 2018 18:23:15 +0200
Message-ID: <20180706162049.482199075@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Jul 2018 18:13:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, kvm@vger.kernel.org
Subject: [patch 3/7] x86/kvmclock: Decrapify kvm_register_clock()
References: <20180706161307.733337643@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value is pointless because the wrmsr cannot fail if
KVM_FEATURE_CLOCKSOURCE or KVM_FEATURE_CLOCKSOURCE2 are set.

kvm_register_clock() is only called locally so wants to be static.

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
 arch/x86/include/asm/kvm_para.h |    1 -
 arch/x86/kernel/kvmclock.c      |   35 +++++++++++------------------------
 2 files changed, 11 insertions(+), 25 deletions(-)

--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -7,7 +7,6 @@
 #include <uapi/asm/kvm_para.h>
 
 extern void kvmclock_init(void);
-extern int kvm_register_clock(char *txt);
 
 #ifdef CONFIG_KVM_GUEST
 bool kvm_check_and_clear_guest_paused(void);
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -186,23 +186,18 @@ struct clocksource kvm_clock = {
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
 
-int kvm_register_clock(char *txt)
+static void kvm_register_clock(char *txt)
 {
-	int cpu = smp_processor_id();
-	int low, high, ret;
 	struct pvclock_vcpu_time_info *src;
+	int cpu = smp_processor_id();
+	u64 pa;
 
 	if (!hv_clock)
-		return 0;
-
-	src = &hv_clock[cpu].pvti;
-	low = (int)slow_virt_to_phys(src) | 1;
-	high = ((u64)slow_virt_to_phys(src) >> 32);
-	ret = native_write_msr_safe(msr_kvm_system_time, low, high);
-	printk(KERN_INFO "kvm-clock: cpu %d, msr %x:%x, %s\n",
-	       cpu, high, low, txt);
+		return;
 
-	return ret;
+	pa = slow_virt_to_phys(src) | 0x01ULL;
+	wrmsrl(msr_kvm_system_time, pa);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s\n", cpu, pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -217,11 +212,7 @@ static void kvm_restore_sched_clock_stat
 #ifdef CONFIG_X86_LOCAL_APIC
 static void kvm_setup_secondary_clock(void)
 {
-	/*
-	 * Now that the first cpu already had this clocksource initialized,
-	 * we shouldn't fail.
-	 */
-	WARN_ON(kvm_register_clock("secondary cpu clock"));
+	kvm_register_clock("secondary cpu clock");
 }
 #endif
 
@@ -264,16 +255,12 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
-
-	if (kvm_register_clock("primary cpu clock")) {
-		hv_clock = NULL;
-		return;
-	}
-
 	printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
+	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
+	kvm_register_clock("primary cpu clock");
+
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 


