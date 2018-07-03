Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27444C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE54822464
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE54822464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932353AbeGCNmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:42:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932238AbeGCNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40041405A011;
        Tue,  3 Jul 2018 13:42:20 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5612A1117629;
        Tue,  3 Jul 2018 13:42:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] KVM: x86: hyperv: use get_vcpu_by_vpidx() in kvm_hv_flush_tlb()
Date:   Tue,  3 Jul 2018 15:42:04 +0200
Message-Id: <20180703134206.27240-4-vkuznets@redhat.com>
In-Reply-To: <20180703134206.27240-1-vkuznets@redhat.com>
References: <20180703134206.27240-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 03 Jul 2018 13:42:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 03 Jul 2018 13:42:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP_INDEX almost always matches VCPU id and get_vcpu_by_vpidx() is fast,
use it instead of traversing full vCPU list every time.

To support the change split off get_vcpu_idx_by_vpidx() from
get_vcpu_by_vpidx().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 78 ++++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index c5b921c0a467..8db20c9d4529 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -127,20 +127,31 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 	return 0;
 }
 
-static struct kvm_vcpu *get_vcpu_by_vpidx(struct kvm *kvm, u32 vpidx)
+static u32 get_vcpu_idx_by_vpidx(struct kvm *kvm, u32 vpidx)
 {
 	struct kvm_vcpu *vcpu = NULL;
 	int i;
 
 	if (vpidx >= KVM_MAX_VCPUS)
-		return NULL;
+		return U32_MAX;
 
 	vcpu = kvm_get_vcpu(kvm, vpidx);
 	if (vcpu && vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
-		return vcpu;
+		return vpidx;
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		if (vcpu_to_hv_vcpu(vcpu)->vp_index == vpidx)
-			return vcpu;
+			return i;
+	return U32_MAX;
+}
+
+static __always_inline struct kvm_vcpu *get_vcpu_by_vpidx(struct kvm *kvm,
+							  u32 vpidx)
+{
+	u32 vcpu_idx = get_vcpu_idx_by_vpidx(kvm, vpidx);
+
+	if (vcpu_idx < KVM_MAX_VCPUS)
+		return kvm_get_vcpu(kvm, vcpu_idx);
+
 	return NULL;
 }
 
@@ -1244,20 +1255,6 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 		return kvm_hv_get_msr(vcpu, msr, pdata);
 }
 
-static __always_inline int get_sparse_bank_no(u64 valid_bank_mask, int bank_no)
-{
-	int i = 0, j;
-
-	if (!(valid_bank_mask & BIT_ULL(bank_no)))
-		return -1;
-
-	for (j = 0; j < bank_no; j++)
-		if (valid_bank_mask & BIT_ULL(j))
-			i++;
-
-	return i;
-}
-
 static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 			    u16 rep_cnt, bool ex)
 {
@@ -1265,11 +1262,10 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
-	struct kvm_vcpu *vcpu;
 	unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)] = {0};
-	unsigned long valid_bank_mask = 0;
+	unsigned long valid_bank_mask;
 	u64 sparse_banks[64];
-	int sparse_banks_len, i;
+	int sparse_banks_len, bank, i;
 	bool all_cpus;
 
 	if (!ex) {
@@ -1279,6 +1275,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 		trace_kvm_hv_flush_tlb(flush.processor_mask,
 				       flush.address_space, flush.flags);
 
+		valid_bank_mask = BIT_ULL(0);
 		sparse_banks[0] = flush.processor_mask;
 		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
 	} else {
@@ -1319,38 +1316,25 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 		goto ret_success;
 	}
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
-		int bank = hv->vp_index / 64, sbank = 0;
+	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
+			 BITS_PER_LONG) {
 
-		/* Banks >64 can't be represented */
-		if (bank >= 64)
-			continue;
+		for_each_set_bit(i, (unsigned long *)&sparse_banks[bank],
+				 BITS_PER_LONG) {
+			u32 vp_index = bank * 64 + i;
+			u32 vcpu_idx = get_vcpu_idx_by_vpidx(kvm, vp_index);
 
-		/* Non-ex hypercalls can only address first 64 vCPUs */
-		if (!ex && bank)
-			continue;
+			/* A non-existent vCPU was specified */
+			if (vcpu_idx >= KVM_MAX_VCPUS)
+				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-		if (ex) {
 			/*
-			 * Check is the bank of this vCPU is in sparse
-			 * set and get the sparse bank number.
+			 * vcpu->arch.cr3 may not be up-to-date for running
+			 * vCPUs so we can't analyze it here, flush TLB
+			 * regardless of the specified address space.
 			 */
-			sbank = get_sparse_bank_no(valid_bank_mask, bank);
-
-			if (sbank < 0)
-				continue;
+			__set_bit(vcpu_idx, vcpu_bitmap);
 		}
-
-		if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index % 64)))
-			continue;
-
-		/*
-		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
-		 * can't analyze it here, flush TLB regardless of the specified
-		 * address space.
-		 */
-		__set_bit(i, vcpu_bitmap);
 	}
 
 	kvm_make_vcpus_request_mask(kvm,
-- 
2.14.4

