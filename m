Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E77ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8D920661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8D920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbeGTNXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733097AbeGTNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:21 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B99B1CEF;
        Fri, 20 Jul 2018 12:34:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 76/92] KVM: arm/arm64: Do not use kern_hyp_va() with kvm_vgic_global_state
Date:   Fri, 20 Jul 2018 14:14:20 +0200
Message-Id: <20180720121422.096996967@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

Commit 44a497abd621a71c645f06d3d545ae2f46448830 upstream.

kvm_vgic_global_state is part of the read-only section, and is
usually accessed using a PC-relative address generation (adrp + add).

It is thus useless to use kern_hyp_va() on it, and actively problematic
if kern_hyp_va() becomes non-idempotent. On the other hand, there is
no way that the compiler is going to guarantee that such access is
always PC relative.

So let's bite the bullet and provide our own accessor.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_mmu.h   |    7 +++++++
 arch/arm64/include/asm/kvm_mmu.h |   20 ++++++++++++++++++++
 virt/kvm/arm/hyp/vgic-v2-sr.c    |    2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)

--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -28,6 +28,13 @@
  */
 #define kern_hyp_va(kva)	(kva)
 
+/* Contrary to arm64, there is no need to generate a PC-relative address */
+#define hyp_symbol_addr(s)						\
+	({								\
+		typeof(s) *addr = &(s);					\
+		addr;							\
+	})
+
 /*
  * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation levels.
  */
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -131,6 +131,26 @@ static inline unsigned long __kern_hyp_v
 #define kern_hyp_va(v) 	((typeof(v))(__kern_hyp_va((unsigned long)(v))))
 
 /*
+ * Obtain the PC-relative address of a kernel symbol
+ * s: symbol
+ *
+ * The goal of this macro is to return a symbol's address based on a
+ * PC-relative computation, as opposed to a loading the VA from a
+ * constant pool or something similar. This works well for HYP, as an
+ * absolute VA is guaranteed to be wrong. Only use this if trying to
+ * obtain the address of a symbol (i.e. not something you obtained by
+ * following a pointer).
+ */
+#define hyp_symbol_addr(s)						\
+	({								\
+		typeof(s) *addr;					\
+		asm("adrp	%0, %1\n"				\
+		    "add	%0, %0, :lo12:%1\n"			\
+		    : "=r" (addr) : "S" (&s));				\
+		addr;							\
+	})
+
+/*
  * We currently only support a 40bit IPA.
  */
 #define KVM_PHYS_SHIFT	(40)
--- a/virt/kvm/arm/hyp/vgic-v2-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v2-sr.c
@@ -139,7 +139,7 @@ int __hyp_text __vgic_v2_perform_cpuif_a
 		return -1;
 
 	rd = kvm_vcpu_dabt_get_rd(vcpu);
-	addr  = kern_hyp_va((kern_hyp_va(&kvm_vgic_global_state))->vcpu_base_va);
+	addr  = kern_hyp_va(hyp_symbol_addr(kvm_vgic_global_state)->vcpu_base_va);
 	addr += fault_ipa - vgic->vgic_cpu_base;
 
 	if (kvm_vcpu_dabt_iswrite(vcpu)) {


