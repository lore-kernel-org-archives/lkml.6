Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4A7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000072152E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000072152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeIZWra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:47:30 -0400
Received: from foss.arm.com ([217.140.101.70]:49986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbeIZWr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:47:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2F95168F;
        Wed, 26 Sep 2018 09:33:43 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C7343F5B3;
        Wed, 26 Sep 2018 09:33:41 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        suzuki.poulose@arm.com, will.deacon@arm.com, dave.martin@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/18] kvm: arm/arm64: Allow arch specific configurations for VM
Date:   Wed, 26 Sep 2018 17:32:42 +0100
Message-Id: <20180926163258.20218-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926163258.20218-1-suzuki.poulose@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the arch backends to perform VM specific initialisation.
This will be later used to handle IPA size configuration and per-VM
VTCR configuration on arm64.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 7 +++++++
 arch/arm64/include/asm/kvm_host.h | 2 ++
 arch/arm64/kvm/reset.c            | 7 +++++++
 virt/kvm/arm/arm.c                | 5 +++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3ad482d2f1eb..72d46418e1ef 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -354,4 +354,11 @@ static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
+static inline int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
+{
+	if (type)
+		return -EINVAL;
+	return 0;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d6d7336f871..b04280ae1be0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -513,4 +513,6 @@ void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu);
 struct kvm *kvm_arch_alloc_vm(void);
 void kvm_arch_free_vm(struct kvm *kvm);
 
+int kvm_arm_config_vm(struct kvm *kvm, unsigned long type);
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index e37c78bbe1ca..b0c07dab5cb3 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -133,3 +133,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset timer */
 	return kvm_timer_vcpu_reset(vcpu);
 }
+
+int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
+{
+	if (type)
+		return -EINVAL;
+	return 0;
+}
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index c92053bc3f96..327d0fd28380 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -120,8 +120,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int ret, cpu;
 
-	if (type)
-		return -EINVAL;
+	ret = kvm_arm_config_vm(kvm, type);
+	if (ret)
+		return ret;
 
 	kvm->arch.last_vcpu_ran = alloc_percpu(typeof(*kvm->arch.last_vcpu_ran));
 	if (!kvm->arch.last_vcpu_ran)
-- 
2.19.0

