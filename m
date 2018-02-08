Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeBHWxn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:53:43 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24184 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHWxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:53:42 -0500
X-IronPort-AV: E=Sophos;i="5.46,480,1511827200";
   d="scan'208";a="331443618"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/3] KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap
Date: Thu,  8 Feb 2018 23:53:29 +0100
Message-Id: <1518130410-6583-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
References: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We either clear the CPU_BASED_USE_MSR_BITMAPS and end up intercepting all
MSR accesses or create a valid L02 MSR bitmap and use that. This decision
has to be made every time we evaluate whether we are going to generate the
L02 MSR bitmap.

Before commit 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
this was probably OK since the decision was always identical. This is no
longer the case now since the MSR bitmap might actually change once we
decide to not intercept SPEC_CTRL and PRED_CMD.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
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
