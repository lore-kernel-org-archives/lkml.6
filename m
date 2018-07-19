Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247FAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DF120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DF120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGSXKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:10:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeGSXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:10:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMOdSn2438751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:24:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMOdKH2438748;
        Thu, 19 Jul 2018 15:24:39 -0700
Date:   Thu, 19 Jul 2018 15:24:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e499a9b6dc488aff7f284bee51936f510ab7ad15@git.kernel.org>
Cc:     tglx@linutronix.de, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        pasha.tatashin@oracle.com
Reply-To: pasha.tatashin@oracle.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, pbonzini@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20180719205545.16512-7-pasha.tatashin@oracle.com>
References: <20180719205545.16512-7-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/kvmclock: Move kvmclock vsyscall param and
 init to kvmclock
Git-Commit-ID: e499a9b6dc488aff7f284bee51936f510ab7ad15
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e499a9b6dc488aff7f284bee51936f510ab7ad15
Gitweb:     https://git.kernel.org/tip/e499a9b6dc488aff7f284bee51936f510ab7ad15
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 19 Jul 2018 16:55:25 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:37 +0200

x86/kvmclock: Move kvmclock vsyscall param and init to kvmclock

There is no point to have this in the kvm code itself and call it from
there. This can be called from an initcall and the parameter is cleared
when the hypervisor is not KVM.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Link: https://lkml.kernel.org/r/20180719205545.16512-7-pasha.tatashin@oracle.com

---
 arch/x86/include/asm/kvm_guest.h |  7 -------
 arch/x86/kernel/kvm.c            | 13 ------------
 arch/x86/kernel/kvmclock.c       | 44 ++++++++++++++++++++++++----------------
 3 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/kvm_guest.h b/arch/x86/include/asm/kvm_guest.h
deleted file mode 100644
index 46185263d9c2..000000000000
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
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c65c232d3ddd..a560750cc76f 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -45,7 +45,6 @@
 #include <asm/apic.h>
 #include <asm/apicdef.h>
 #include <asm/hypervisor.h>
-#include <asm/kvm_guest.h>
 
 static int kvmapf = 1;
 
@@ -66,15 +65,6 @@ static int __init parse_no_stealacc(char *arg)
 
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
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 78aec160f5e0..7d690d2238f8 100644
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
 
 static int kvmclock __initdata = 1;
+static int kvmclock_vsyscall __initdata = 1;
 static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
 static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
 static u64 kvm_sched_clock_offset __ro_after_init;
@@ -44,6 +46,13 @@ static int __init parse_no_kvmclock(char *arg)
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
 
@@ -228,6 +237,24 @@ static void kvm_shutdown(void)
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
+	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
+#endif
+	return 0;
+}
+early_initcall(kvm_setup_vsyscall_timeinfo);
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
@@ -272,20 +299,3 @@ void __init kvmclock_init(void)
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
-	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
-#endif
-	return 0;
-}
