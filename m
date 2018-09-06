Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22415C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3C12075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3C12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIFQgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:36:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:62802 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbeIFQgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:36:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 05:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="71046756"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2018 05:00:53 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com
Subject: [PATCH v2 3/8] KVM/vmx: Pass through the lbr stack to a guest
Date:   Thu,  6 Sep 2018 19:30:51 +0800
Message-Id: <1536233456-12173-4-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass through the LBR stack to the guest when the guest lbr feature is
enabled. This makes the guest have direct accesses to the lbr stack.

Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kvm/vmx.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 1d26f3c..7a62c1c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7847,6 +7847,38 @@ static void vmx_enable_tdp(void)
 	kvm_enable_tdp();
 }
 
+static int vmx_passthrough_lbr_msrs(struct kvm *kvm,
+				     unsigned long *msr_bitmap)
+{
+	int i;
+	struct perf_lbr_stack lbr_stack;
+
+	if (perf_get_lbr_stack(&lbr_stack) < 0) {
+		pr_err("Failed to pass through the lbr stack\n");
+		return -ENOENT;
+	}
+
+	vmx_disable_intercept_for_msr(msr_bitmap, MSR_LBR_SELECT,
+				      MSR_TYPE_RW);
+	vmx_disable_intercept_for_msr(msr_bitmap, lbr_stack.lbr_tos,
+				      MSR_TYPE_RW);
+
+	for (i = 0; i < lbr_stack.lbr_nr; i++) {
+		vmx_disable_intercept_for_msr(msr_bitmap,
+					      lbr_stack.lbr_from + i,
+					      MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap,
+					      lbr_stack.lbr_to + i,
+					      MSR_TYPE_RW);
+		if (lbr_stack.lbr_info)
+			vmx_disable_intercept_for_msr(msr_bitmap,
+						      lbr_stack.lbr_info + i,
+						      MSR_TYPE_RW);
+	}
+
+	return 0;
+}
+
 static __init int hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -10998,6 +11030,12 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
 	vmx->msr_bitmap_mode = 0;
 
+	if (kvm->arch.guest_lbr) {
+		err = vmx_passthrough_lbr_msrs(kvm, msr_bitmap);
+		if (err < 0)
+			goto free_vmcs;
+	}
+
 	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
-- 
2.7.4

