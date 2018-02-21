Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938616AbeBURzs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:55:48 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:46048 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933541AbeBURrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:40 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="720905235"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 03/10] X86/nVMX: Update the PML table without mapping and unmapping the page
Date: Wed, 21 Feb 2018 18:47:14 +0100
Message-Id: <1519235241-6500-4-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... which also avoids using kvm_vcpu_gpa_to_page(..) which assumes that
there is a "struct page" for guest memory.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e5653d2..0a98d1a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12111,9 +12111,7 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	gpa_t gpa;
-	struct page *page = NULL;
-	u64 *pml_address;
+	gpa_t gpa, dst;
 
 	if (is_guest_mode(vcpu)) {
 		WARN_ON_ONCE(vmx->nested.pml_full);
@@ -12133,15 +12131,12 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 		}
 
 		gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS) & ~0xFFFull;
+		dst = (gpa_t)(((u64 *)vmcs12->pml_address) + vmcs12->guest_pml_index);
 
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->pml_address);
-		if (is_error_page(page))
+		if (kvm_write_guest(vcpu->kvm, dst, &gpa, sizeof(gpa)))
 			return 0;
 
-		pml_address = kmap(page);
-		pml_address[vmcs12->guest_pml_index--] = gpa;
-		kunmap(page);
-		kvm_release_page_clean(page);
+		vmcs12->guest_pml_index--;
 	}
 
 	return 0;
-- 
2.7.4
