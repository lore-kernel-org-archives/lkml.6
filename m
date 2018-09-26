Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E30121533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E30121533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeIZWsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:48:12 -0400
Received: from foss.arm.com ([217.140.101.70]:50220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbeIZWsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:48:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A75692379;
        Wed, 26 Sep 2018 09:34:25 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3161A3F5B3;
        Wed, 26 Sep 2018 09:34:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        suzuki.poulose@arm.com, will.deacon@arm.com, dave.martin@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org
Subject: [kvmtool PATCH v6 21/18] kvmtool: arm64: Switch memory layout
Date:   Wed, 26 Sep 2018 17:32:57 +0100
Message-Id: <20180926163258.20218-22-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926163258.20218-1-suzuki.poulose@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the guest wants to use a larger physical address space place
the RAM at upper half of the address space. Otherwise, it uses the
default layout.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/aarch32/include/kvm/kvm-arch.h |  6 ++++--
 arm/aarch64/include/kvm/kvm-arch.h | 15 ++++++++++++---
 arm/include/arm-common/kvm-arch.h  | 11 ++++++-----
 arm/kvm.c                          |  2 +-
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arm/aarch32/include/kvm/kvm-arch.h b/arm/aarch32/include/kvm/kvm-arch.h
index cd31e72..bcd382b 100644
--- a/arm/aarch32/include/kvm/kvm-arch.h
+++ b/arm/aarch32/include/kvm/kvm-arch.h
@@ -3,8 +3,10 @@
 
 #define ARM_KERN_OFFSET(...)	0x8000
 
-#define ARM_MAX_MEMORY(...)	ARM_LOMAP_MAX_MEMORY
-
 #include "arm-common/kvm-arch.h"
 
+#define ARM_MAX_MEMORY(...)	ARM32_MAX_MEMORY
+#define ARM_MEMORY_AREA(...)	ARM32_MEMORY_AREA
+
+
 #endif /* KVM__KVM_ARCH_H */
diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
index 9de623a..bad35b9 100644
--- a/arm/aarch64/include/kvm/kvm-arch.h
+++ b/arm/aarch64/include/kvm/kvm-arch.h
@@ -1,14 +1,23 @@
 #ifndef KVM__KVM_ARCH_H
 #define KVM__KVM_ARCH_H
 
+#include "arm-common/kvm-arch.h"
+
+#define ARM64_MEMORY_AREA(phys_shift)	(1UL << (phys_shift - 1))
+#define ARM64_MAX_MEMORY(phys_shift)	\
+	((1ULL << (phys_shift)) - ARM64_MEMORY_AREA(phys_shift))
+
+#define ARM_MEMORY_AREA(kvm)	((kvm)->cfg.arch.aarch32_guest ?	\
+				 ARM32_MEMORY_AREA		:	\
+				 ARM64_MEMORY_AREA(kvm->cfg.arch.phys_shift))
+
 #define ARM_KERN_OFFSET(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
 				0x8000				:	\
 				0x80000)
 
 #define ARM_MAX_MEMORY(kvm)	((kvm)->cfg.arch.aarch32_guest	?	\
-				ARM_LOMAP_MAX_MEMORY		:	\
-				ARM_HIMAP_MAX_MEMORY)
+				ARM32_MAX_MEMORY		:	\
+				ARM64_MAX_MEMORY(kvm->cfg.arch.phys_shift))
 
-#include "arm-common/kvm-arch.h"
 
 #endif /* KVM__KVM_ARCH_H */
diff --git a/arm/include/arm-common/kvm-arch.h b/arm/include/arm-common/kvm-arch.h
index b9d486d..b29b4b1 100644
--- a/arm/include/arm-common/kvm-arch.h
+++ b/arm/include/arm-common/kvm-arch.h
@@ -6,14 +6,15 @@
 #include <linux/types.h>
 
 #include "arm-common/gic.h"
-
 #define ARM_IOPORT_AREA		_AC(0x0000000000000000, UL)
 #define ARM_MMIO_AREA		_AC(0x0000000000010000, UL)
 #define ARM_AXI_AREA		_AC(0x0000000040000000, UL)
-#define ARM_MEMORY_AREA		_AC(0x0000000080000000, UL)
 
-#define ARM_LOMAP_MAX_MEMORY	((1ULL << 32) - ARM_MEMORY_AREA)
-#define ARM_HIMAP_MAX_MEMORY	((1ULL << 40) - ARM_MEMORY_AREA)
+#define ARM32_MEMORY_AREA	_AC(0x0000000080000000, UL)
+#define ARM32_MAX_MEMORY	((1ULL << 32) - ARM32_MEMORY_AREA)
+
+#define ARM_IOMEM_AREA_END	ARM32_MEMORY_AREA
+
 
 #define ARM_GIC_DIST_BASE	(ARM_AXI_AREA - ARM_GIC_DIST_SIZE)
 #define ARM_GIC_CPUI_BASE	(ARM_GIC_DIST_BASE - ARM_GIC_CPUI_SIZE)
@@ -24,7 +25,7 @@
 #define ARM_IOPORT_SIZE		(ARM_MMIO_AREA - ARM_IOPORT_AREA)
 #define ARM_VIRTIO_MMIO_SIZE	(ARM_AXI_AREA - (ARM_MMIO_AREA + ARM_GIC_SIZE))
 #define ARM_PCI_CFG_SIZE	(1ULL << 24)
-#define ARM_PCI_MMIO_SIZE	(ARM_MEMORY_AREA - \
+#define ARM_PCI_MMIO_SIZE	(ARM_IOMEM_AREA_END - \
 				(ARM_AXI_AREA + ARM_PCI_CFG_SIZE))
 
 #define KVM_IOPORT_AREA		ARM_IOPORT_AREA
diff --git a/arm/kvm.c b/arm/kvm.c
index b824f63..eac2ad2 100644
--- a/arm/kvm.c
+++ b/arm/kvm.c
@@ -30,7 +30,7 @@ void kvm__init_ram(struct kvm *kvm)
 	u64 phys_start, phys_size;
 	void *host_mem;
 
-	phys_start	= ARM_MEMORY_AREA;
+	phys_start	= ARM_MEMORY_AREA(kvm);
 	phys_size	= kvm->ram_size;
 	host_mem	= kvm->ram_start;
 
-- 
2.19.0

