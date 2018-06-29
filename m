Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839ABC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D6227DD1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6227DD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936031AbeF2LRb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:17:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935996AbeF2LRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:17:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1E91168F;
        Fri, 29 Jun 2018 04:17:17 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8ADA13F266;
        Fri, 29 Jun 2018 04:17:15 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [kvmtool test PATCH 24/24] kvmtool: arm: Add support for creating VM with PA size
Date:   Fri, 29 Jun 2018 12:15:44 +0100
Message-Id: <1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the physical size for the VM encoded in the vm type.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/include/arm-common/kvm-arch.h |  6 +++++-
 arm/kvm.c                         | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
index b29b4b1..d77f3ac 100644
--- a/arm/include/arm-common/kvm-arch.h
+++ b/arm/include/arm-common/kvm-arch.h
@@ -44,7 +44,11 @@
 
 #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
 
-#define KVM_VM_TYPE		0
+extern unsigned long		kvm_arm_type;
+extern void kvm__arch_init_hyp(struct kvm *kvm);
+
+#define KVM_VM_TYPE		kvm_arm_type
+#define kvm__arch_init_hyp	kvm__arch_init_hyp
 
 #define VIRTIO_DEFAULT_TRANS(kvm)	\
 	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
diff --git a/arm/kvm.c b/arm/kvm.c
index 5701d41..b1969be 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -11,6 +11,8 @@
 #include <linux/kvm.h>
 #include <linux/sizes.h>
 
+unsigned long kvm_arm_type;
+
 struct kvm_ext kvm_req_ext[] = {
 	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
 	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
@@ -18,6 +20,26 @@ struct kvm_ext kvm_req_ext[] = {
 	{ 0, 0 },
 };
 
+#ifndef KVM_ARM_GET_MAX_VM_PHYS_SHIFT
+#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT		_IO(KVMIO, 0x0b)
+#endif
+
+void kvm__arch_init_hyp(struct kvm *kvm)
+{
+	int max_ipa;
+
+	max_ipa = ioctl(kvm->sys_fd, KVM_ARM_GET_MAX_VM_PHYS_SHIFT);
+	if (max_ipa < 0)
+		max_ipa = 40;
+	if (!kvm->cfg.arch.phys_shift)
+		kvm->cfg.arch.phys_shift = 40;
+	if (kvm->cfg.arch.phys_shift > max_ipa)
+		die("Requested PA size (%u) is not supported by the host (%ubits)\n",
+		    kvm->cfg.arch.phys_shift, max_ipa);
+	if (kvm->cfg.arch.phys_shift != 40)
+		kvm_arm_type = kvm->cfg.arch.phys_shift;
+}
+
 bool kvm__arch_cpu_supports_vm(void)
 {
 	/* The KVM capability check is enough. */
-- 
2.7.4

