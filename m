Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D5CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A4C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfBSJZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:25:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfBSJZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:25:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D773CEBD;
        Tue, 19 Feb 2019 01:25:24 -0800 (PST)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D1123F740;
        Tue, 19 Feb 2019 01:25:20 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [kvmtool PATCH v6 6/6] arm/kvm: arm64: Add a vcpu feature for pointer authentication
Date:   Tue, 19 Feb 2019 14:54:31 +0530
Message-Id: <1550568271-5319-7-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a runtime capabality for KVM tool to enable Armv8.3 Pointer
Authentication in guest kernel. A command line option --ptrauth is
required for this.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 arm/aarch32/include/kvm/kvm-cpu-arch.h    | 1 +
 arm/aarch64/include/asm/kvm.h             | 1 +
 arm/aarch64/include/kvm/kvm-config-arch.h | 4 +++-
 arm/aarch64/include/kvm/kvm-cpu-arch.h    | 1 +
 arm/include/arm-common/kvm-config-arch.h  | 1 +
 arm/kvm-cpu.c                             | 6 ++++++
 include/linux/kvm.h                       | 1 +
 7 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
index d28ea67..520ea76 100644
--- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
@@ -13,4 +13,5 @@
 #define ARM_CPU_ID		0, 0, 0
 #define ARM_CPU_ID_MPIDR	5
 
+#define ARM_VCPU_PTRAUTH_FEATURE	0
 #endif /* KVM__KVM_CPU_ARCH_H */
diff --git a/arm/aarch64/include/asm/kvm.h b/arm/aarch64/include/asm/kvm.h
index 97c3478..1068fd1 100644
--- a/arm/aarch64/include/asm/kvm.h
+++ b/arm/aarch64/include/asm/kvm.h
@@ -102,6 +102,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
+#define KVM_ARM_VCPU_PTRAUTH		4 /* CPU uses pointer authentication */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
index 04be43d..2074684 100644
--- a/arm/aarch64/include/kvm/kvm-config-arch.h
+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
@@ -8,7 +8,9 @@
 			"Create PMUv3 device"),				\
 	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
 			"Specify random seed for Kernel Address Space "	\
-			"Layout Randomization (KASLR)"),
+			"Layout Randomization (KASLR)"),		\
+	OPT_BOOLEAN('\0', "ptrauth", &(cfg)->has_ptrauth,		\
+			"Enable address authentication"),
 
 #include "arm-common/kvm-config-arch.h"
 
diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
index a9d8563..496ece8 100644
--- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
+++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
@@ -17,4 +17,5 @@
 #define ARM_CPU_CTRL		3, 0, 1, 0
 #define ARM_CPU_CTRL_SCTLR_EL1	0
 
+#define ARM_VCPU_PTRAUTH_FEATURE	(1UL << KVM_ARM_VCPU_PTRAUTH)
 #endif /* KVM__KVM_CPU_ARCH_H */
diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
index 5734c46..5badcbd 100644
--- a/arm/include/arm-common/kvm-config-arch.h
+++ b/arm/include/arm-common/kvm-config-arch.h
@@ -10,6 +10,7 @@ struct kvm_config_arch {
 	bool		aarch32_guest;
 	bool		has_pmuv3;
 	u64		kaslr_seed;
+	bool		has_ptrauth;
 	enum irqchip_type irqchip;
 	u64		fw_addr;
 };
diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
index 7780251..4ac80f8 100644
--- a/arm/kvm-cpu.c
+++ b/arm/kvm-cpu.c
@@ -68,6 +68,12 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
 		vcpu_init.features[0] |= (1UL << KVM_ARM_VCPU_PSCI_0_2);
 	}
 
+	/* Set KVM_ARM_VCPU_PTRAUTH if available */
+	if (kvm__supports_extension(kvm, KVM_CAP_ARM_PTRAUTH)) {
+		if (kvm->cfg.arch.has_ptrauth)
+			vcpu_init.features[0] |= ARM_VCPU_PTRAUTH_FEATURE;
+	}
+
 	/*
 	 * If the preferred target ioctl is successful then
 	 * use preferred target else try each and every target type
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 6d4ea4b..a553477 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -988,6 +988,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
 #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_ARM_PTRAUTH 168
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4

