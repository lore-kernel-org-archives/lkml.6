Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeBJXj5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 18:39:57 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:21160 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752988AbeBJXjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 18:39:54 -0500
X-IronPort-AV: E=Sophos;i="5.46,492,1511827200";
   d="scan'208";a="331584187"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: [PATCH v2 5/6] KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap
Date: Sat, 10 Feb 2018 23:39:26 +0000
Message-Id: <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KarimAllah Ahmed <karahmed@amazon.de>

We either clear the CPU_BASED_USE_MSR_BITMAPS and end up intercepting all
MSR accesses or create a valid L02 MSR bitmap and use that. This decision
has to be made every time we evaluate whether we are going to generate the
L02 MSR bitmap.

Before commit 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
this was probably OK since the decision was always identical. This is no
longer the case now since the MSR bitmap might actually change once we
decide to not intercept SPEC_CTRL and PRED_CMD.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 599179b..91e3539 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10130,7 +10130,8 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 	if (cpu_has_vmx_msr_bitmap() &&
 	    nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS) &&
 	    nested_vmx_merge_msr_bitmap(vcpu, vmcs12))
-		;
+		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
+			      CPU_BASED_USE_MSR_BITMAPS);
 	else
 		vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
 				CPU_BASED_USE_MSR_BITMAPS);
-- 
2.7.4
