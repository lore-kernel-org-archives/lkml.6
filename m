Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC691C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E50D20835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E50D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeGIQYC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:24:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754525AbeGIQYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:24:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F21BE4074461;
        Mon,  9 Jul 2018 16:23:59 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC8B62156891;
        Mon,  9 Jul 2018 16:23:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] KVM: x86: mmu: don't re-generate permissions/pkru_mask bitmasks when source is unchanged 1;5004;0c update_permission_bitmask()/update_pkru_bitmask() are rarely called under normal circumstances but nesting changes everything. E.g. for nVMX we call kvm_mmu_reset_context() from nested_vmx_load_cr3() which happens on nested vmexit/vmentry. init_kvm_mmu() in its turn call init_kvm_nested_mmu() or init_kvm_tdp_mmu() (which operate on arch.nested_mmu and arch.mmu respectively) which unconditionally do update_permission_bitmask()/ update_pkru_bitmask().
Date:   Mon,  9 Jul 2018 18:23:57 +0200
Message-Id: <20180709162357.15593-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 16:24:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 16:24:00 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_permission_bitmask()/update_pkru_bitmask() use current environment
(CR0.WP, CR4.SMAP, CR4.SMEP, ...) to fill 'permissions' and 'pkru_mask'
bitmasks. This 'source' data rarely changes but loops to fill these arrays
are relatively expensive. We can remember the source data which was used
to generate the arrays and skip generating them when it is unchanged.

In my testing environment (Hyper-V 2016 on KVM) this dumb patch gives
around 800 CPU cycles on tight CPUID loop test.

This is likely a band-aid and not a proper fix thus RFC. We should probably
avoid full MMU reset when switching between L1 and L2 by e.g. just flip a
pointer between arch.mmu and arch.nested_mmu or something like that. I'd
like to hear ideas on what seems to be the best way to go here.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 25 +++++++++++++++++++++++++
 arch/x86/kvm/mmu.c              | 24 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c13cd28d9d1b..50b393906e39 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -325,6 +325,27 @@ struct rsvd_bits_validate {
 	u64 bad_mt_xwr;
 };
 
+/*
+ * Encoded source data used to generate 'permissions' array; there's no
+ * need to re-generate it if these markers haven't changed. First bit is used
+ * to indicate the array was previously generated (so we don't acidentially skip
+ * generating it when all flags are zeroed).
+ */
+enum permissions_cache_bm {
+	PBM_UPDATE_PM_SET = 0,
+	PBM_EPT,
+	PBM_CR4_SMEP,
+	PBM_CR4_SMAP,
+	PBM_CR0_WP,
+	PBM_NX,
+};
+
+/* Same as permissions_cache_bm but for 'pkru_mask' */
+enum pkru_mask_cache_bm {
+	PKBM_UPDATE_PKRU_SET = 0,
+	PKBM_CR0_WP,
+};
+
 /*
  * x86 supports 4 paging modes (5-level 64-bit, 4-level 64-bit, 3-level 32-bit,
  * and 2-level 32-bit).  The kvm_mmu structure abstracts the details of the
@@ -360,6 +381,8 @@ struct kvm_mmu {
 	 * Bit index: pte permissions in ACC_* format
 	 */
 	u8 permissions[16];
+	/* Cached flags for permissions */
+	u32 permissions_cache_bm;
 
 	/*
 	* The pkru_mask indicates if protection key checks are needed.  It
@@ -368,6 +391,8 @@ struct kvm_mmu {
 	* Each domain has 2 bits which are ANDed with AD and WD from PKRU.
 	*/
 	u32 pkru_mask;
+	/* Cached flags for pkru_mask */
+	u32 pkru_mask_cache_bm;
 
 	u64 *pae_root;
 	u64 *lm_root;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..de0eb3c266f5 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4260,6 +4260,7 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu, bool ept)
 {
 	unsigned byte;
+	u32 permissions_cache_bm;
 
 	const u8 x = BYTE_MASK(ACC_EXEC_MASK);
 	const u8 w = BYTE_MASK(ACC_WRITE_MASK);
@@ -4269,6 +4270,16 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 	bool cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
 	bool cr0_wp = is_write_protection(vcpu);
 
+	permissions_cache_bm = BIT(PBM_UPDATE_PM_SET) |
+		ept ? BIT(PBM_EPT) : 0 |
+		cr4_smep ? BIT(PBM_CR4_SMEP) : 0 |
+		cr4_smap ? BIT(PBM_CR4_SMEP) : 0 |
+		cr0_wp ? BIT(PBM_CR0_WP) : 0 |
+		mmu->nx ? BIT(PBM_NX) : 0;
+
+	if (mmu->permissions_cache_bm == permissions_cache_bm)
+		return;
+
 	for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
 		unsigned pfec = byte << 1;
 
@@ -4326,6 +4337,8 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 
 		mmu->permissions[byte] = ff | uf | wf | smepf | smapf;
 	}
+
+	mmu->permissions_cache_bm = permissions_cache_bm;
 }
 
 /*
@@ -4355,22 +4368,31 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 static void update_pkru_bitmask(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 				bool ept)
 {
+	u32 pkru_mask_cache_bm;
 	unsigned bit;
 	bool wp;
 
 	if (ept) {
 		mmu->pkru_mask = 0;
+		mmu->pkru_mask_cache_bm &= ~PKBM_UPDATE_PKRU_SET;
 		return;
 	}
 
 	/* PKEY is enabled only if CR4.PKE and EFER.LMA are both set. */
 	if (!kvm_read_cr4_bits(vcpu, X86_CR4_PKE) || !is_long_mode(vcpu)) {
 		mmu->pkru_mask = 0;
+		mmu->pkru_mask_cache_bm &= ~PKBM_UPDATE_PKRU_SET;
 		return;
 	}
 
 	wp = is_write_protection(vcpu);
 
+	pkru_mask_cache_bm = BIT(PKBM_UPDATE_PKRU_SET) |
+		wp ? BIT(PKBM_CR0_WP) : 0;
+
+	if (mmu->pkru_mask_cache_bm == pkru_mask_cache_bm)
+		return;
+
 	for (bit = 0; bit < ARRAY_SIZE(mmu->permissions); ++bit) {
 		unsigned pfec, pkey_bits;
 		bool check_pkey, check_write, ff, uf, wf, pte_user;
@@ -4401,6 +4423,8 @@ static void update_pkru_bitmask(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 
 		mmu->pkru_mask |= (pkey_bits & 3) << pfec;
 	}
+
+	mmu->pkru_mask_cache_bm = pkru_mask_cache_bm;
 }
 
 static void update_last_nonleaf_level(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
-- 
2.14.4

