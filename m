Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C81C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390B327DBF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390B327DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965350AbeF2LQu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:16:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965199AbeF2LQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:16:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A40EB1682;
        Fri, 29 Jun 2018 04:16:45 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CA813F266;
        Fri, 29 Jun 2018 04:16:43 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 12/20] kvm: arm64: Add helper for loading the stage2 setting for a VM
Date:   Fri, 29 Jun 2018 12:15:32 +0100
Message-Id: <1530270944-11351-13-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We load the stage2 context of a guest for different operations,
including running the guest and tlb maintenance on behalf of the
guest. As of now only the vttbr is private to the guest, but this
is about to change with IPA per VM. Add a helper to load the stage2
configuration for a VM, which could do the right thing with the
future changes.

Cc: Christoffer Dall <cdall@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - New patch
---
 arch/arm64/include/asm/kvm_hyp.h | 6 ++++++
 arch/arm64/kvm/hyp/switch.c      | 2 +-
 arch/arm64/kvm/hyp/tlb.c         | 4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 384c343..82f9994 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -155,5 +155,11 @@ void deactivate_traps_vhe_put(void);
 u64 __guest_enter(struct kvm_vcpu *vcpu, struct kvm_cpu_context *host_ctxt);
 void __noreturn __hyp_do_panic(unsigned long, ...);
 
+/* Must be called from hyp code running at EL2 */
+static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
+{
+	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+}
+
 #endif /* __ARM64_KVM_HYP_H__ */
 
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index d496ef5..355fb25 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -195,7 +195,7 @@ void deactivate_traps_vhe_put(void)
 
 static void __hyp_text __activate_vm(struct kvm *kvm)
 {
-	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+	__load_guest_stage2(kvm);
 }
 
 static void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index 131c777..4dbd9c6 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -30,7 +30,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
 	 * bits. Changing E2H is impossible (goodbye TTBR1_EL2), so
 	 * let's flip TGE before executing the TLB operation.
 	 */
-	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+	__load_guest_stage2(kvm);
 	val = read_sysreg(hcr_el2);
 	val &= ~HCR_TGE;
 	write_sysreg(val, hcr_el2);
@@ -39,7 +39,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
 
 static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm)
 {
-	write_sysreg(kvm->arch.vttbr, vttbr_el2);
+	__load_guest_stage2(kvm);
 	isb();
 }
 
-- 
2.7.4

