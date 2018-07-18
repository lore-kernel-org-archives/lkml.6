Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D48ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zS9vN5LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645C92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbeGRDA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:00:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45084 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731893AbeGRC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2Jtr8001052;
        Wed, 18 Jul 2018 02:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=HrI13El2AtYGFL9hjq2GqC4989/C5RtLOAFVm8r8nOY=;
 b=zS9vN5LBz62xGmbTscYLBJHMgVize0LCLOxNxBbTF4WEG0kcbYuvTbf4UdkHghMu7pae
 gO4em74tgPsJeG7/80rtyotw1/qyhtP9d35yNg9e5rTEWgz9t9P2Vbgc72CVzPyDwuCW
 jLUZd/Ec5UQNoaeqcuxPeNP475jT4KRJbrjSC1wzd4ofclPLE2hjK8g/JMtms5/AUizQ
 JbOkxi+eGHAtGjaYkEVMUAbofT3BP41fEYY3VlLNujJXNv1FuDBEAAelKY2Wv+azHZFe
 +G470FTqlSsh1xsXkmTJmWTddlXTCoWy+kE9CEqTLrlUZPHkVkKSaT9R56J9aKFSCbAi Mg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MZjt027614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:35 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I2MYNc013474;
        Wed, 18 Jul 2018 02:22:34 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:22:33 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: [PATCH v14 06/25] x86/kvmclock: Move kvmclock vsyscall param and init to kvmclock
Date:   Tue, 17 Jul 2018 22:21:52 -0400
Message-Id: <20180718022211.6259-7-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There is no point to have this in the kvm code itself and call it from
there. This can be called from an initcall and the parameter is cleared
when the hypervisor is not KVM.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_guest.h |  7 -----
 arch/x86/kernel/kvm.c            | 13 ---------
 arch/x86/kernel/kvmclock.c       | 46 +++++++++++++++++++-------------
 3 files changed, 28 insertions(+), 38 deletions(-)
 delete mode 100644 arch/x86/include/asm/kvm_guest.h

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
index f312d7f6de57..08e7726a5e62 100644
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
@@ -270,21 +298,3 @@ void __init kvmclock_init(void)
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
-- 
2.18.0

