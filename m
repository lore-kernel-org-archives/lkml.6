Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F9AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DCC21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DCC21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeIZXRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:17:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbeIZXRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:17:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 935983082A2C;
        Wed, 26 Sep 2018 17:03:14 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D330260BE7;
        Wed, 26 Sep 2018 17:03:09 +0000 (UTC)
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
Subject: [PATCH v6 3/7] KVM: x86: hyperv: consistently use 'hv_vcpu' for 'struct kvm_vcpu_hv' variables
Date:   Wed, 26 Sep 2018 19:02:55 +0200
Message-Id: <20180926170259.29796-4-vkuznets@redhat.com>
In-Reply-To: <20180926170259.29796-1-vkuznets@redhat.com>
References: <20180926170259.29796-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 26 Sep 2018 17:03:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'hv' to 'hv_vcpu' in kvm_hv_set_msr/kvm_hv_get_msr(); 'hv' is
'reserved' for 'struct kvm_hv' variables across the file.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index b45ce136be2f..c8764faf783b 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1042,20 +1042,20 @@ static u64 current_task_runtime_100ns(void)
 
 static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 {
-	struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
+	struct kvm_vcpu_hv *hv_vcpu = &vcpu->arch.hyperv;
 
 	switch (msr) {
 	case HV_X64_MSR_VP_INDEX:
 		if (!host || (u32)data >= KVM_MAX_VCPUS)
 			return 1;
-		hv->vp_index = (u32)data;
+		hv_vcpu->vp_index = (u32)data;
 		break;
 	case HV_X64_MSR_VP_ASSIST_PAGE: {
 		u64 gfn;
 		unsigned long addr;
 
 		if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
-			hv->hv_vapic = data;
+			hv_vcpu->hv_vapic = data;
 			if (kvm_lapic_enable_pv_eoi(vcpu, 0))
 				return 1;
 			break;
@@ -1066,7 +1066,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 			return 1;
 		if (__clear_user((void __user *)addr, PAGE_SIZE))
 			return 1;
-		hv->hv_vapic = data;
+		hv_vcpu->hv_vapic = data;
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
 		if (kvm_lapic_enable_pv_eoi(vcpu,
 					    gfn_to_gpa(gfn) | KVM_MSR_ENABLED))
@@ -1082,7 +1082,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 	case HV_X64_MSR_VP_RUNTIME:
 		if (!host)
 			return 1;
-		hv->runtime_offset = data - current_task_runtime_100ns();
+		hv_vcpu->runtime_offset = data - current_task_runtime_100ns();
 		break;
 	case HV_X64_MSR_SCONTROL:
 	case HV_X64_MSR_SVERSION:
@@ -1174,11 +1174,11 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 			  bool host)
 {
 	u64 data = 0;
-	struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
+	struct kvm_vcpu_hv *hv_vcpu = &vcpu->arch.hyperv;
 
 	switch (msr) {
 	case HV_X64_MSR_VP_INDEX:
-		data = hv->vp_index;
+		data = hv_vcpu->vp_index;
 		break;
 	case HV_X64_MSR_EOI:
 		return kvm_hv_vapic_msr_read(vcpu, APIC_EOI, pdata);
@@ -1187,10 +1187,10 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 	case HV_X64_MSR_TPR:
 		return kvm_hv_vapic_msr_read(vcpu, APIC_TASKPRI, pdata);
 	case HV_X64_MSR_VP_ASSIST_PAGE:
-		data = hv->hv_vapic;
+		data = hv_vcpu->hv_vapic;
 		break;
 	case HV_X64_MSR_VP_RUNTIME:
-		data = current_task_runtime_100ns() + hv->runtime_offset;
+		data = current_task_runtime_100ns() + hv_vcpu->runtime_offset;
 		break;
 	case HV_X64_MSR_SCONTROL:
 	case HV_X64_MSR_SVERSION:
-- 
2.17.1

