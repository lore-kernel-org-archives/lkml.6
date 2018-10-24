Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22332082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22332082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeJXQfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:35:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:46033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbeJXQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:35:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="273987503"
Received: from skx-d.bj.intel.com ([10.238.135.53])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2018 01:08:03 -0700
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, joro@8bytes.org,
        songliubraving@fb.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v13 11/12] KVM: x86: Set intercept for Intel PT MSRs read/write
Date:   Wed, 24 Oct 2018 16:05:15 +0800
Message-Id: <1540368316-12998-12-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

To save performance overhead, disable intercept Intel PT MSRs
read/write when Intel PT is enabled in guest.
MSR_IA32_RTIT_CTL is an exception that will always be intercepted.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a568d49..ed247dd 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1333,6 +1333,7 @@ static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -4558,6 +4559,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx_rtit_ctl_check(vcpu, data))
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
+		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
 		vmx->pt_desc.guest.ctl = data;
 		break;
 	case MSR_IA32_RTIT_STATUS:
@@ -6414,6 +6416,27 @@ static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 	vmx->msr_bitmap_mode = mode;
 }
 
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag)
+{
+	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
+	u32 i;
+
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_STATUS,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_BASE,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_MASK,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_CR3_MATCH,
+							MSR_TYPE_RW, flag);
+	for (i = 0; i < vmx->pt_desc.addr_range; i++) {
+		vmx_set_intercept_for_msr(msr_bitmap,
+			MSR_IA32_RTIT_ADDR0_A + i * 2, MSR_TYPE_RW, flag);
+		vmx_set_intercept_for_msr(msr_bitmap,
+			MSR_IA32_RTIT_ADDR0_B + i * 2, MSR_TYPE_RW, flag);
+	}
+}
+
 static bool vmx_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 	return enable_apicv;
-- 
1.8.3.1

