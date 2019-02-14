Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D81C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BA2222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438006AbfBNJnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:43:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:32226 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395247AbfBNJnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:43:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 01:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="124411831"
Received: from devel-ww.sh.intel.com ([10.239.48.128])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2019 01:43:10 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com, jmattson@google.com
Subject: [PATCH v5 12/12] KVM/VMX/vPMU: support to report GLOBAL_STATUS_LBRS_FROZEN
Date:   Thu, 14 Feb 2019 17:06:14 +0800
Message-Id: <1550135174-5423-13-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arch v4 supports streamlined Freeze_LBR_on_PMI, so we set the
GLOBAL_STATUS_LBRS_FROZEN bit when the guest reads the global
status msr with freezing lbr in use.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index bf40941..80d3fcf 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -420,6 +420,25 @@ static bool intel_pmu_access_lbr_msr(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
+static void intel_pmu_get_global_status(struct kvm_pmu *pmu,
+					struct msr_data *msr_info)
+{
+	u64 guest_debugctl, freeze_lbr_bits = DEBUGCTLMSR_FREEZE_LBRS_ON_PMI |
+					      DEBUGCTLMSR_LBR;
+
+	if (!pmu->global_status) {
+		msr_info->data = 0;
+		return;
+	}
+
+	msr_info->data = pmu->global_status;
+	if (pmu->version >= 4) {
+		guest_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		if ((guest_debugctl & freeze_lbr_bits) == freeze_lbr_bits)
+			msr_info->data |= GLOBAL_STATUS_LBRS_FROZEN;
+	}
+}
+
 static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -431,7 +450,7 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = pmu->fixed_ctr_ctrl;
 		return 0;
 	case MSR_CORE_PERF_GLOBAL_STATUS:
-		msr_info->data = pmu->global_status;
+		intel_pmu_get_global_status(pmu, msr_info);
 		return 0;
 	case MSR_CORE_PERF_GLOBAL_CTRL:
 		msr_info->data = pmu->global_ctrl;
-- 
2.7.4

