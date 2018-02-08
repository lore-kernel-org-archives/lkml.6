Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHWxp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:53:45 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24184 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBHWxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:53:43 -0500
X-IronPort-AV: E=Sophos;i="5.46,480,1511827200";
   d="scan'208";a="331443621"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 3/3] X86/nVMX: Update the MSR_BITMAP field with the L02 MSR BITMAP
Date: Thu,  8 Feb 2018 23:53:30 +0100
Message-Id: <1518130410-6583-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
References: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... otherwise we will just be running with the L1 MSR BITMAP!

It does not seem that we ever update the MSR_BITMAP when the nested guest
is running. The only place where we update the MSR_BITMAP field in VMCS is
for the L1 guest!

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kvm/vmx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 91e3539..f40be10 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10589,6 +10589,9 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
 	vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
 
+	if (cpu_has_vmx_msr_bitmap())
+		vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
+
 	if (from_vmentry &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
-- 
2.7.4
