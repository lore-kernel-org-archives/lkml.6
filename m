Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249E4ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9539214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9539214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeIQQKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:10:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbeIQQKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:10:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEC5A1CDD;
        Mon, 17 Sep 2018 03:43:23 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 735A13F5BD;
        Mon, 17 Sep 2018 03:43:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, will.deacon@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, dave.martin@arm.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: [kvmtool PATCH v5 22/18] kvmtool: arm: Add support for creating VM with PA size
Date:   Mon, 17 Sep 2018 11:41:44 +0100
Message-Id: <20180917104144.19188-23-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917104144.19188-1-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the physical size for the VM encoded in the vm type.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/include/arm-common/kvm-arch.h |  6 +++++-
 arm/kvm.c                         | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

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
index eac2ad2..6c19dd0 100644
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
@@ -18,6 +20,31 @@ struct kvm_ext kvm_req_ext[] = {
 	{ 0, 0 },
 };
 
+#ifndef KVM_CAP_ARM_VM_PHYS_SHIFT
+#define KVM_CAP_ARM_VM_PHYS_SHIFT	159
+#endif
+
+void kvm__arch_init_hyp(struct kvm *kvm)
+{
+	int max_ipa;
+
+	if (!kvm->cfg.arch.phys_shift)
+		kvm->cfg.arch.phys_shift = 40;
+	if (kvm->cfg.arch.phys_shift == 40)
+		return;
+	max_ipa = ioctl(kvm->sys_fd,
+			KVM_CHECK_EXTENSION, KVM_CAP_ARM_VM_PHYS_SHIFT);
+	if (!max_ipa)
+		die("Kernel doesn't support IPA size configuration\n");
+	if ((kvm->cfg.arch.phys_shift > max_ipa) ||
+	    (kvm->cfg.arch.phys_shift < 32))
+		die("Requested PA size (%u) is not supported by the host"
+		    " [32 - %u]bit\n",
+		    kvm->cfg.arch.phys_shift, max_ipa);
+	if (kvm->cfg.arch.phys_shift < 32)
+	kvm_arm_type = kvm->cfg.arch.phys_shift;
+}
+
 bool kvm__arch_cpu_supports_vm(void)
 {
 	/* The KVM capability check is enough. */
-- 
2.19.0

