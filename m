Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeBESuw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:50:52 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18534 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753838AbeBESti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:49:38 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="593308219"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 08/12] KVM/VMX: Use the new host mapping API for mapping nested PML
Date: Mon,  5 Feb 2018 19:47:27 +0100
Message-Id: <1517856451-2932-9-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nested guests the PML page was mapped to the host kernel using
kvm_vcpu_gpa_to_page which assumes that all guest memory is backed by a
"struct page". This breaks guests that have their memory outside the kernel
control.

Switch to the new host mapping API which takes care of this use-case as
well.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 7177176..620b4ff 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11866,7 +11866,7 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	gpa_t gpa;
-	struct page *page = NULL;
+	struct kvm_host_mapping mapping;
 	u64 *pml_address;
 
 	if (is_guest_mode(vcpu)) {
@@ -11888,14 +11888,13 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 
 		gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS) & ~0xFFFull;
 
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->pml_address);
-		if (is_error_page(page))
+		if (!kvm_vcpu_gpa_to_host_mapping(vcpu, vmcs12->pml_address, &mapping, true))
 			return 0;
 
-		pml_address = kmap(page);
+		pml_address = mapping.kaddr;
 		pml_address[vmcs12->guest_pml_index--] = gpa;
-		kunmap(page);
-		kvm_release_page_clean(page);
+
+		kvm_release_host_mapping(&mapping, false);
 	}
 
 	return 0;
-- 
2.7.4
