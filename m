Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeDLPM5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:12:57 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:60365 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeDLPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:12:51 -0400
X-IronPort-AV: E=Sophos;i="5.48,442,1517875200";
   d="scan'208";a="339642646"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 1/2] X86/KVM: Properly restore 'tsc_offset' when running an L2 guest
Date: Thu, 12 Apr 2018 17:12:37 +0200
Message-Id: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the TSC MSR is captured while an L2 guest is running then restored,
the 'tsc_offset' ends up capturing the L02 TSC_OFFSET instead of the L01
TSC_OFFSET. So ensure that this is compensated for when storing the value.

Cc: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 12 +++++++++---
 arch/x86/kvm/x86.c |  1 -
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index cff2f50..2f57571 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2900,6 +2900,8 @@ static u64 guest_read_tsc(struct kvm_vcpu *vcpu)
  */
 static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
+	u64 l1_tsc_offset = 0;
+
 	if (is_guest_mode(vcpu)) {
 		/*
 		 * We're here if L1 chose not to trap WRMSR to TSC. According
@@ -2908,16 +2910,20 @@ static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 		 * to the newly set TSC to get L2's TSC.
 		 */
 		struct vmcs12 *vmcs12;
+
 		/* recalculate vmcs02.TSC_OFFSET: */
 		vmcs12 = get_vmcs12(vcpu);
-		vmcs_write64(TSC_OFFSET, offset +
-			(nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING) ?
-			 vmcs12->tsc_offset : 0));
+
+		l1_tsc_offset = nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING) ?
+					vmcs12->tsc_offset : 0;
+		vmcs_write64(TSC_OFFSET, offset + l1_tsc_offset);
 	} else {
 		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
 					   vmcs_read64(TSC_OFFSET), offset);
 		vmcs_write64(TSC_OFFSET, offset);
 	}
+
+	vcpu->arch.tsc_offset = offset - l1_tsc_offset;
 }
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac42c85..1a2ed92 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1539,7 +1539,6 @@ EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
 static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 	kvm_x86_ops->write_tsc_offset(vcpu, offset);
-	vcpu->arch.tsc_offset = offset;
 }
 
 static inline bool kvm_check_tsc_unstable(void)
-- 
2.7.4
