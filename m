Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492B2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FCF27DBA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FCF27DBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755263AbeF2LQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:16:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755201AbeF2LQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:16:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12E5A1682;
        Fri, 29 Jun 2018 04:16:35 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B01643F5AF;
        Fri, 29 Jun 2018 04:16:32 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 08/20] kvm: arm/arm64: Abstract stage2 pgd table allocation
Date:   Fri, 29 Jun 2018 12:15:28 +0100
Message-Id: <1530270944-11351-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract the allocation of stage2 entry level tables for
given VM, so that later we can choose to fall back to the
normal page table levels (i.e, avoid entry level table
concatenation) on arm64.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V2:
 - New patch
---
 arch/arm/include/asm/kvm_mmu.h   | 6 ++++++
 arch/arm64/include/asm/kvm_mmu.h | 6 ++++++
 virt/kvm/arm/mmu.c               | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index f36eb20..b2da5a4 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -372,6 +372,12 @@ static inline int hyp_map_aux_data(void)
 	return 0;
 }
 
+static inline void *stage2_alloc_pgd(struct kvm *kvm)
+{
+	return alloc_pages_exact(stage2_pgd_size(kvm),
+				 GFP_KERNEL | __GFP_ZERO);
+}
+
 #define kvm_phys_to_vttbr(addr)		(addr)
 
 #endif	/* !__ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5da8f52..dbaf513 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -501,5 +501,11 @@ static inline int hyp_map_aux_data(void)
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
 
+static inline void *stage2_alloc_pgd(struct kvm *kvm)
+{
+	return alloc_pages_exact(stage2_pgd_size(kvm),
+				 GFP_KERNEL | __GFP_ZERO);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 82dd571..a339e00 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -868,7 +868,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 	}
 
 	/* Allocate the HW PGD, making sure that each page gets its own refcount */
-	pgd = alloc_pages_exact(stage2_pgd_size(kvm), GFP_KERNEL | __GFP_ZERO);
+	pgd = stage2_alloc_pgd(kvm);
 	if (!pgd)
 		return -ENOMEM;
 
-- 
2.7.4

