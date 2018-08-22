Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5106C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6062148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6062148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeHVNm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:42:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728643AbeHVNm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:42:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15AFB4023476;
        Wed, 22 Aug 2018 10:18:39 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF3FA9E57;
        Wed, 22 Aug 2018 10:18:37 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 RESEND 2/5] KVM: x86: hyperv: optimize 'all cpus' case in kvm_hv_flush_tlb()
Date:   Wed, 22 Aug 2018 12:18:29 +0200
Message-Id: <20180822101832.31763-3-vkuznets@redhat.com>
In-Reply-To: <20180822101832.31763-1-vkuznets@redhat.com>
References: <20180822101832.31763-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 22 Aug 2018 10:18:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 22 Aug 2018 10:18:39 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use 'NULL' to represent 'all cpus' case in
kvm_make_vcpus_request_mask() and avoid building vCPU mask with
all vCPUs.

Suggested-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
---
 arch/x86/kvm/hyperv.c | 42 +++++++++++++++++++++++-------------------
 virt/kvm/kvm_main.c   |  6 ++----
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0cd597b0f754..b45ce136be2f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1325,35 +1325,39 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 
 	cpumask_clear(&hv_current->tlb_lush);
 
+	if (all_cpus) {
+		kvm_make_vcpus_request_mask(kvm,
+				    KVM_REQ_TLB_FLUSH | KVM_REQUEST_NO_WAKEUP,
+				    NULL, &hv_current->tlb_lush);
+		goto ret_success;
+	}
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
 		int bank = hv->vp_index / 64, sbank = 0;
 
-		if (!all_cpus) {
-			/* Banks >64 can't be represented */
-			if (bank >= 64)
-				continue;
-
-			/* Non-ex hypercalls can only address first 64 vCPUs */
-			if (!ex && bank)
-				continue;
+		/* Banks >64 can't be represented */
+		if (bank >= 64)
+			continue;
 
-			if (ex) {
-				/*
-				 * Check is the bank of this vCPU is in sparse
-				 * set and get the sparse bank number.
-				 */
-				sbank = get_sparse_bank_no(valid_bank_mask,
-							   bank);
+		/* Non-ex hypercalls can only address first 64 vCPUs */
+		if (!ex && bank)
+			continue;
 
-				if (sbank < 0)
-					continue;
-			}
+		if (ex) {
+			/*
+			 * Check is the bank of this vCPU is in sparse
+			 * set and get the sparse bank number.
+			 */
+			sbank = get_sparse_bank_no(valid_bank_mask, bank);
 
-			if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index % 64)))
+			if (sbank < 0)
 				continue;
 		}
 
+		if (!(sparse_banks[sbank] & BIT_ULL(hv->vp_index % 64)))
+			continue;
+
 		/*
 		 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we
 		 * can't analyze it here, flush TLB regardless of the specified
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f83239ac8be1..3340f8128dc8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -218,7 +218,7 @@ bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
 	me = get_cpu();
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		if (!test_bit(i, vcpu_bitmap))
+		if (vcpu_bitmap && !test_bit(i, vcpu_bitmap))
 			continue;
 
 		kvm_make_request(req, vcpu);
@@ -242,12 +242,10 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 {
 	cpumask_var_t cpus;
 	bool called;
-	static unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)]
-		= {[0 ... BITS_TO_LONGS(KVM_MAX_VCPUS)-1] = ULONG_MAX};
 
 	zalloc_cpumask_var(&cpus, GFP_ATOMIC);
 
-	called = kvm_make_vcpus_request_mask(kvm, req, vcpu_bitmap, cpus);
+	called = kvm_make_vcpus_request_mask(kvm, req, NULL, cpus);
 
 	free_cpumask_var(cpus);
 	return called;
-- 
2.14.4

