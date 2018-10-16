Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9175C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E492089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E492089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeJQAle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D766308A974;
        Tue, 16 Oct 2018 16:50:17 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 504FA6A039;
        Tue, 16 Oct 2018 16:50:15 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 01/13] KVM: hyperv: define VP assist page helpers
Date:   Tue, 16 Oct 2018 18:49:59 +0200
Message-Id: <20181016165011.6607-2-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 16 Oct 2018 16:50:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ladi Prosek <lprosek@redhat.com>

The state related to the VP assist page is still managed by the LAPIC
code in the pv_eoi field.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
---
 arch/x86/kvm/hyperv.c | 23 +++++++++++++++++++++--
 arch/x86/kvm/hyperv.h |  4 ++++
 arch/x86/kvm/lapic.c  |  4 ++--
 arch/x86/kvm/lapic.h  |  2 +-
 arch/x86/kvm/x86.c    |  2 +-
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index df9ef8f1d2c8..d9b7b4cd4e43 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -693,6 +693,24 @@ void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)
 		stimer_cleanup(&hv_vcpu->stimer[i]);
 }
 
+bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.hyperv.hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE))
+		return false;
+	return vcpu->arch.pv_eoi.msr_val & KVM_MSR_ENABLED;
+}
+EXPORT_SYMBOL_GPL(kvm_hv_assist_page_enabled);
+
+bool kvm_hv_get_assist_page(struct kvm_vcpu *vcpu,
+			    struct hv_vp_assist_page *assist_page)
+{
+	if (!kvm_hv_assist_page_enabled(vcpu))
+		return false;
+	return !kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data,
+				      assist_page, sizeof(*assist_page));
+}
+EXPORT_SYMBOL_GPL(kvm_hv_get_assist_page);
+
 static void stimer_prepare_msg(struct kvm_vcpu_hv_stimer *stimer)
 {
 	struct hv_message *msg = &stimer->msg;
@@ -1078,7 +1096,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 
 		if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
 			hv_vcpu->hv_vapic = data;
-			if (kvm_lapic_enable_pv_eoi(vcpu, 0))
+			if (kvm_lapic_enable_pv_eoi(vcpu, 0, 0))
 				return 1;
 			break;
 		}
@@ -1091,7 +1109,8 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		hv_vcpu->hv_vapic = data;
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
 		if (kvm_lapic_enable_pv_eoi(vcpu,
-					    gfn_to_gpa(gfn) | KVM_MSR_ENABLED))
+					    gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
+					    sizeof(struct hv_vp_assist_page)))
 			return 1;
 		break;
 	}
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index d6aa969e20f1..0e66c12ed2c3 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -62,6 +62,10 @@ void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_hv_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu);
 
+bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu);
+bool kvm_hv_get_assist_page(struct kvm_vcpu *vcpu,
+			    struct hv_vp_assist_page *assist_page);
+
 static inline struct kvm_vcpu_hv_stimer *vcpu_to_stimer(struct kvm_vcpu *vcpu,
 							int timer_index)
 {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 452eed992aea..79358fd6a71c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2644,7 +2644,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 reg, u64 *data)
 	return 0;
 }
 
-int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data)
+int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len)
 {
 	u64 addr = data & ~KVM_MSR_ENABLED;
 	if (!IS_ALIGNED(addr, 4))
@@ -2654,7 +2654,7 @@ int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data)
 	if (!pv_eoi_enabled(vcpu))
 		return 0;
 	return kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.pv_eoi.data,
-					 addr, sizeof(u8));
+					 addr, len);
 }
 
 void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index ed0ed39abd36..ff6ef9c3d760 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -120,7 +120,7 @@ static inline bool kvm_hv_vapic_assist_page_enabled(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hyperv.hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
 }
 
-int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data);
+int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_init(void);
 void kvm_lapic_exit(void);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2750270b7a39..eee871ad4ade 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2477,7 +2477,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		break;
 	case MSR_KVM_PV_EOI_EN:
-		if (kvm_lapic_enable_pv_eoi(vcpu, data))
+		if (kvm_lapic_enable_pv_eoi(vcpu, data, sizeof(u8)))
 			return 1;
 		break;
 
-- 
2.17.1

