Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F80ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6C420833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6C420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbeGTOO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:14:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731848AbeGTOO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:14:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C7487A7E7;
        Fri, 20 Jul 2018 13:26:39 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1FF02026D69;
        Fri, 20 Jul 2018 13:26:37 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 6/7] x86/kvm/nVMX: introduce scache for kvm_init_shadow_ept_mmu
Date:   Fri, 20 Jul 2018 15:26:25 +0200
Message-Id: <20180720132626.5975-7-vkuznets@redhat.com>
In-Reply-To: <20180720132626.5975-1-vkuznets@redhat.com>
References: <20180720132626.5975-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 13:26:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 13:26:39 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU re-initialization is expensive, in particular,
update_permission_bitmask() and update_pkru_bitmask() are.

Cache the data used to setup shadow EPT MMU and avoid full re-init when
it is unchanged.

kvm_mmu_free_roots() can be dropped from nested_ept_init_mmu_context()
as we always do kvm_mmu_reset_context() in nested_vmx_load_cr3().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 15 +++++++++++++
 arch/x86/kvm/mmu.c              | 50 ++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx.c              |  5 +++--
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2c0b493e09f7..fa73cf13c4d0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -325,6 +325,19 @@ struct rsvd_bits_validate {
 	u64 bad_mt_xwr;
 };
 
+/* Source data used to setup MMU */
+struct kvm_mmu_sdata_cache {
+	unsigned int valid:1;
+	unsigned int ept_ad:1;
+	unsigned int execonly:1;
+	unsigned int cr0_wp:1;
+	unsigned int cr4_pae:1;
+	unsigned int cr4_pse:1;
+	unsigned int cr4_pke:1;
+	unsigned int cr4_smap:1;
+	unsigned int cr4_smep:1;
+};
+
 /*
  * x86 supports 4 paging modes (5-level 64-bit, 4-level 64-bit, 3-level 32-bit,
  * and 2-level 32-bit).  The kvm_mmu structure abstracts the details of the
@@ -387,6 +400,8 @@ struct kvm_mmu {
 	bool nx;
 
 	u64 pdptrs[4]; /* pae */
+
+	struct kvm_mmu_sdata_cache scache;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index fb6652643b15..eed1773453cd 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4548,12 +4548,60 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 
+static inline bool shadow_ept_mmu_update_needed(struct kvm_vcpu *vcpu,
+					bool execonly, bool accessed_dirty)
+{
+	struct kvm_mmu *context = vcpu->arch.mmu;
+	bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
+	bool cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
+	bool cr4_pke = kvm_read_cr4_bits(vcpu, X86_CR4_PKE) != 0;
+	bool cr0_wp = is_write_protection(vcpu);
+	bool cr4_pse = is_pse(vcpu);
+	bool res = false;
+
+	if (!context->scache.valid) {
+		res = true;
+		context->scache.valid = 1;
+	}
+	if (context->scache.ept_ad != accessed_dirty) {
+		context->scache.ept_ad = accessed_dirty;
+		res = true;
+	}
+	if (context->scache.execonly != execonly) {
+		res = true;
+		context->scache.execonly = execonly;
+	}
+	if (context->scache.cr4_smap != cr4_smap) {
+		res = true;
+		context->scache.cr4_smap = cr4_smap;
+	}
+	if (context->scache.cr4_smep != cr4_smep) {
+		res = true;
+		context->scache.cr4_smep = cr4_smep;
+	}
+	if (context->scache.cr4_pse != cr4_pse) {
+		res = true;
+		context->scache.cr4_pse = cr4_pse;
+	}
+	if (context->scache.cr4_pke != cr4_pke) {
+		res = true;
+		context->scache.cr4_pke = cr4_pke;
+	}
+	if (context->scache.cr0_wp != cr0_wp) {
+		res = true;
+		context->scache.cr0_wp = cr0_wp;
+	}
+
+	return res;
+}
+
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
 
-	MMU_WARN_ON(VALID_PAGE(context->root_hpa));
+	if (!shadow_ept_mmu_update_needed(vcpu, execonly, accessed_dirty))
+		return;
 
 	context->shadow_root_level = PT64_ROOT_4LEVEL;
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5feb52991065..3467665a75d5 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10577,12 +10577,13 @@ static unsigned long nested_ept_get_cr3(struct kvm_vcpu *vcpu)
 
 static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 {
+	unsigned long cr3 = nested_ept_get_cr3(vcpu);
+
 	WARN_ON(mmu_is_nested(vcpu));
-	if (!valid_ept_address(vcpu, nested_ept_get_cr3(vcpu)))
+	if (!valid_ept_address(vcpu, cr3))
 		return 1;
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
-	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu);
 
 	kvm_init_shadow_ept_mmu(vcpu,
 			to_vmx(vcpu)->nested.msrs.ept_caps &
-- 
2.14.4

