Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeECKPS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:15:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:44397 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbeECKPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:15:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38109838"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 08/13] KVM: x86: Add Intel processor trace context for each vcpu
Date: Thu,  3 May 2018 20:08:38 +0800
Message-Id: <1525349323-9938-9-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Add a data structure to save Intel Processor Trace context.
It mainly include the value of Intel PT host/guest MSRs
and guest CPUID information.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 27cf417..9a5c26d 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -597,6 +597,23 @@ static inline int pi_test_sn(struct pi_desc *pi_desc)
 			(unsigned long *)&pi_desc->control);
 }
 
+struct pt_ctx {
+	u64 ctl;
+	u64 status;
+	u64 output_base;
+	u64 output_mask;
+	u64 cr3_match;
+	u64 addrs[MSR_IA32_RTIT_ADDR_COUNT];
+};
+
+struct pt_desc {
+	u64 ctl_bitmask;
+	u32 range_cnt;
+	u32 caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
+	struct pt_ctx host;
+	struct pt_ctx guest;
+};
+
 struct vcpu_vmx {
 	struct kvm_vcpu       vcpu;
 	unsigned long         host_rsp;
@@ -693,6 +710,8 @@ struct vcpu_vmx {
 	 */
 	u64 msr_ia32_feature_control;
 	u64 msr_ia32_feature_control_valid_bits;
+
+	struct pt_desc pt_desc;
 };
 
 enum segment_cache_field {
-- 
1.8.3.1
