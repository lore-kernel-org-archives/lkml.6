Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CACC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433892077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433892077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbeICV4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:56:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeICV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:56:14 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93C33D30;
        Mon,  3 Sep 2018 17:35:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.18 056/123] KVM: x86: ensure all MSRs can always be KVM_GET/SET_MSRd
Date:   Mon,  3 Sep 2018 18:56:40 +0200
Message-Id: <20180903165721.811369783@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 44883f01fe6ae436a8604c47d8435276fef369b0 upstream.

Some of the MSRs returned by GET_MSR_INDEX_LIST currently cannot be sent back
to KVM_GET_MSR and/or KVM_SET_MSR; either they can never be sent back, or you
they are only accepted under special conditions.  This makes the API a pain to
use.

To avoid this pain, this patch makes it so that the result of the get-list
ioctl can always be used for host-initiated get and set.  Since we don't have
a separate way to check for read-only MSRs, this means some Hyper-V MSRs are
ignored when written.  Arguably they should not even be in the result of
GET_MSR_INDEX_LIST, but I am leaving there in case userspace is using the
outcome of GET_MSR_INDEX_LIST to derive the support for the corresponding
Hyper-V feature.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/hyperv.c |   27 ++++++++++++++++++++-------
 arch/x86/kvm/hyperv.h |    2 +-
 arch/x86/kvm/x86.c    |   15 +++++++++------
 3 files changed, 30 insertions(+), 14 deletions(-)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -235,7 +235,7 @@ static int synic_set_msr(struct kvm_vcpu
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
 	int ret;
 
-	if (!synic->active)
+	if (!synic->active && !host)
 		return 1;
 
 	trace_kvm_hv_synic_set_msr(vcpu->vcpu_id, msr, data, host);
@@ -295,11 +295,12 @@ static int synic_set_msr(struct kvm_vcpu
 	return ret;
 }
 
-static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata)
+static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata,
+			 bool host)
 {
 	int ret;
 
-	if (!synic->active)
+	if (!synic->active && !host)
 		return 1;
 
 	ret = 0;
@@ -1014,6 +1015,11 @@ static int kvm_hv_set_msr_pw(struct kvm_
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		hv->hv_tsc_emulation_status = data;
 		break;
+	case HV_X64_MSR_TIME_REF_COUNT:
+		/* read-only, but still ignore it if host-initiated */
+		if (!host)
+			return 1;
+		break;
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
 			    msr, data);
@@ -1101,6 +1107,12 @@ static int kvm_hv_set_msr(struct kvm_vcp
 		return stimer_set_count(vcpu_to_stimer(vcpu, timer_index),
 					data, host);
 	}
+	case HV_X64_MSR_TSC_FREQUENCY:
+	case HV_X64_MSR_APIC_FREQUENCY:
+		/* read-only, but still ignore it if host-initiated */
+		if (!host)
+			return 1;
+		break;
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
 			    msr, data);
@@ -1156,7 +1168,8 @@ static int kvm_hv_get_msr_pw(struct kvm_
 	return 0;
 }
 
-static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
+			  bool host)
 {
 	u64 data = 0;
 	struct kvm_vcpu_hv *hv = &vcpu->arch.hyperv;
@@ -1183,7 +1196,7 @@ static int kvm_hv_get_msr(struct kvm_vcp
 	case HV_X64_MSR_SIMP:
 	case HV_X64_MSR_EOM:
 	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
-		return synic_get_msr(vcpu_to_synic(vcpu), msr, pdata);
+		return synic_get_msr(vcpu_to_synic(vcpu), msr, pdata, host);
 	case HV_X64_MSR_STIMER0_CONFIG:
 	case HV_X64_MSR_STIMER1_CONFIG:
 	case HV_X64_MSR_STIMER2_CONFIG:
@@ -1229,7 +1242,7 @@ int kvm_hv_set_msr_common(struct kvm_vcp
 		return kvm_hv_set_msr(vcpu, msr, data, host);
 }
 
-int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 {
 	if (kvm_hv_msr_partition_wide(msr)) {
 		int r;
@@ -1239,7 +1252,7 @@ int kvm_hv_get_msr_common(struct kvm_vcp
 		mutex_unlock(&vcpu->kvm->arch.hyperv.hv_lock);
 		return r;
 	} else
-		return kvm_hv_get_msr(vcpu, msr, pdata);
+		return kvm_hv_get_msr(vcpu, msr, pdata, host);
 }
 
 static __always_inline int get_sparse_bank_no(u64 valid_bank_mask, int bank_no)
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -48,7 +48,7 @@ static inline struct kvm_vcpu *synic_to_
 }
 
 int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host);
-int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata);
+int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host);
 
 bool kvm_hv_hypercall_enabled(struct kvm *kvm);
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2185,10 +2185,11 @@ static int set_msr_mce(struct kvm_vcpu *
 		vcpu->arch.mcg_status = data;
 		break;
 	case MSR_IA32_MCG_CTL:
-		if (!(mcg_cap & MCG_CTL_P))
+		if (!(mcg_cap & MCG_CTL_P) &&
+		    (data || !msr_info->host_initiated))
 			return 1;
 		if (data != 0 && data != ~(u64)0)
-			return -1;
+			return 1;
 		vcpu->arch.mcg_ctl = data;
 		break;
 	default:
@@ -2576,7 +2577,7 @@ int kvm_get_msr(struct kvm_vcpu *vcpu, s
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr);
 
-static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
+static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 {
 	u64 data;
 	u64 mcg_cap = vcpu->arch.mcg_cap;
@@ -2591,7 +2592,7 @@ static int get_msr_mce(struct kvm_vcpu *
 		data = vcpu->arch.mcg_cap;
 		break;
 	case MSR_IA32_MCG_CTL:
-		if (!(mcg_cap & MCG_CTL_P))
+		if (!(mcg_cap & MCG_CTL_P) && !host)
 			return 1;
 		data = vcpu->arch.mcg_ctl;
 		break;
@@ -2724,7 +2725,8 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_IA32_MCG_CTL:
 	case MSR_IA32_MCG_STATUS:
 	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
-		return get_msr_mce(vcpu, msr_info->index, &msr_info->data);
+		return get_msr_mce(vcpu, msr_info->index, &msr_info->data,
+				   msr_info->host_initiated);
 	case MSR_K7_CLK_CTL:
 		/*
 		 * Provide expected ramp-up count for K7. All other
@@ -2745,7 +2747,8 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case HV_X64_MSR_TSC_EMULATION_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		return kvm_hv_get_msr_common(vcpu,
-					     msr_info->index, &msr_info->data);
+					     msr_info->index, &msr_info->data,
+					     msr_info->host_initiated);
 		break;
 	case MSR_IA32_BBL_CR_CTL3:
 		/* This legacy MSR exists but isn't fully documented in current


