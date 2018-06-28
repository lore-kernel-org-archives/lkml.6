Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90735C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526E024664
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526E024664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966441AbeF1NyK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:54:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966365AbeF1NxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 247B15BCB6;
        Thu, 28 Jun 2018 13:53:23 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D49620180F4;
        Thu, 28 Jun 2018 13:53:21 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: [PATCH v2 3/5] KVM: x86: hyperv: use vp_idx_to_vcpu_idx() in kvm_hv_flush_tlb()
Date:   Thu, 28 Jun 2018 15:53:11 +0200
Message-Id: <20180628135313.17468-4-vkuznets@redhat.com>
In-Reply-To: <20180628135313.17468-1-vkuznets@redhat.com>
References: <20180628135313.17468-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 13:53:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 13:53:23 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we now have a fast way to get vCPU index from VP number we can
avoid walking through all vCPUs in kvm_hv_flush_tlb().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 59 ++++++++++++++-------------------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d676335a5448..9983304d6664 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1395,20 +1395,6 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
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
@@ -1416,11 +1402,10 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
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
@@ -1430,6 +1415,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 		trace_kvm_hv_flush_tlb(flush.processor_mask,
 				       flush.address_space, flush.flags);
 
+		valid_bank_mask = BIT_ULL(0);
 		sparse_banks[0] = flush.processor_mask;
 		all_cpus = flush.flags & HV_FLUSH_ALL_PROCESSORS;
 	} else {
@@ -1470,38 +1456,25 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
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
+			u32 vcpu_idx = vp_idx_to_vcpu_idx(kvm, vp_index);
 
-		/* Non-ex hypercalls can only address first 64 vCPUs */
-		if (!ex && bank)
-			continue;
+			/* A non-existent vCPU was specified */
+			if (vcpu_idx >= atomic_read(&kvm->online_vcpus))
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

