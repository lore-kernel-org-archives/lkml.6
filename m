Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB36C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1DD21536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1DD21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeIZXRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:17:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeIZXRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:17:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AA1C74F17;
        Wed, 26 Sep 2018 17:03:39 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7CA60BE1;
        Wed, 26 Sep 2018 17:03:29 +0000 (UTC)
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
Subject: [PATCH v6 6/7] KVM: x86: hyperv: optimize kvm_hv_flush_tlb() for vp_index == vcpu_idx case
Date:   Wed, 26 Sep 2018 19:02:58 +0200
Message-Id: <20180926170259.29796-7-vkuznets@redhat.com>
In-Reply-To: <20180926170259.29796-1-vkuznets@redhat.com>
References: <20180926170259.29796-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 26 Sep 2018 17:03:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP inedx almost always matches VCPU and when it does it's faster to walk
the sparse set instead of all vcpus.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 96 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index eeb12eacd525..cc0535a078f7 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1277,32 +1277,37 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 		return kvm_hv_get_msr(vcpu, msr, pdata, host);
 }
 
-static __always_inline int get_sparse_bank_no(u64 valid_bank_mask, int bank_no)
+static __always_inline bool hv_vcpu_in_sparse_set(struct kvm_vcpu_hv *hv_vcpu,
+						  u64 sparse_banks[],
+						  u64 valid_bank_mask)
 {
-	int i = 0, j;
+	int bank = hv_vcpu->vp_index / 64, sbank;
 
-	if (!(valid_bank_mask & BIT_ULL(bank_no)))
-		return -1;
+	if (bank >= 64)
+		return false;
 
-	for (j = 0; j < bank_no; j++)
-		if (valid_bank_mask & BIT_ULL(j))
-			i++;
+	if (!(valid_bank_mask & BIT_ULL(bank)))
+		return false;
 
-	return i;
+	/* Sparse bank number equals to the number of set bits before it */
+	sbank = bitmap_weight((unsigned long *)&valid_bank_mask, bank);
+
+	return !!(sparse_banks[sbank] & BIT_ULL(hv_vcpu->vp_index % 64));
 }
 
 static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 			    u16 rep_cnt, bool ex)
 {
 	struct kvm *kvm = current_vcpu->kvm;
-	struct kvm_vcpu_hv *hv_current = &current_vcpu->arch.hyperv;
+	struct kvm_hv *hv = &kvm->arch.hyperv;
+	struct kvm_vcpu_hv *hv_vcpu = &current_vcpu->arch.hyperv;
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
 	struct kvm_vcpu *vcpu;
 	unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)] = {0};
-	u64 valid_bank_mask = 0;
+	u64 valid_bank_mask;
 	u64 sparse_banks[64];
-	int sparse_banks_len, i;
+	int sparse_banks_len, i, bank, sbank;
 	bool all_cpus;
 
 	if (!ex) {
@@ -1312,6 +1317,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 		trace_kvm_hv_flush_tlb(flush.processor_mask,
 				       flush.address_space, flush.flags);
 
+		valid_bank_mask = BIT_ULL(0);
 		sparse_banks[0] = flush.processor_mask;
 		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
 	} else {
@@ -1344,52 +1350,54 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
-	cpumask_clear(&hv_current->tlb_lush);
+	/*
+	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
+	 * analyze it here, flush TLB regardless of the specified address space.
+	 */
+	cpumask_clear(&hv_vcpu->tlb_lush);
 
 	if (all_cpus) {
 		kvm_make_vcpus_request_mask(kvm,
 				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
-				    NULL, &hv_current->tlb_lush);
+				    NULL, &hv_vcpu->tlb_lush);
 		goto ret_success;
 	}
 
-	kvm_for_each_vcpu(i, vcpu, kvm) {
-		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
-		int bank = hv->vp_index / 64, sbank = 0;
-
-		/* Banks >64 can't be represented */
-		if (bank >= 64)
-			continue;
-
-		/* Non-ex hypercalls can only address first 64 vCPUs */
-		if (!ex && bank)
-			continue;
-
-		if (ex) {
-			/*
-			 * Check is the bank of this vCPU is in sparse
-			 * set and get the sparse bank number.
-			 */
-			sbank = get_sparse_bank_no(valid_bank_mask, bank);
-
-			if (sbank < 0)
-				continue;
+	if (atomic_read(&hv->num_mismatched_vp_indexes)) {
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			if (hv_vcpu_in_sparse_set(&vcpu->arch.hyperv,
+						  sparse_banks,
+						  valid_bank_mask))
+				__set_bit(i, vcpu_bitmap);
 		}
+		goto flush_request;
+	}
 
-		if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index % 64)))
-			continue;
-
-		/*
-		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
-		 * can't analyze it here, flush TLB regardless of the specified
-		 * address space.
-		 */
-		__set_bit(i, vcpu_bitmap);
+	/*
+	 * num_mismatched_vp_indexes is zero so every vcpu has
+	 * vp_index == vcpu_idx.
+	 */
+	sbank = 0;
+	for_each_set_bit(bank, (unsigned long *)&valid_bank_mask,
+			 BITS_PER_LONG) {
+		for_each_set_bit(i,
+				 (unsigned long *)&sparse_banks[sbank],
+				 BITS_PER_LONG) {
+			u32 vp_index = bank * 64 + i;
+
+			/* A non-existent vCPU was specified */
+			if (vp_index >= KVM_MAX_VCPUS)
+				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
+			__set_bit(vp_index, vcpu_bitmap);
+		}
+		sbank++;
 	}
 
+flush_request:
 	kvm_make_vcpus_request_mask(kvm,
 				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
-				    vcpu_bitmap, &hv_current->tlb_lush);
+				    vcpu_bitmap, &hv_vcpu->tlb_lush);
 
 ret_success:
 	/* We always do full TLB flush, set rep_done = rep_cnt. */
-- 
2.17.1

