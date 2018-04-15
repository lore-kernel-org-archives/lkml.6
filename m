Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDOVzA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:55:00 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:59935 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDOVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:54:54 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="339837512"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 03/12] X86/nVMX: Update the PML table without mapping and unmapping the page
Date: Sun, 15 Apr 2018 23:53:09 +0200
Message-Id: <1523829198-13236-4-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the PML table without mapping and unmapping the page. This also
avoids using kvm_vcpu_gpa_to_page(..) which assumes that there is a "struct
page" for guest memory.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Use kvm_write_guest_page instead of kvm_write_guest (pbonzini)
- Do not use pointer arithmetic for pml_address (pbonzini)
---
 arch/x86/kvm/vmx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 810ba7a..179061d 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12294,9 +12294,7 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	gpa_t gpa;
-	struct page *page = NULL;
-	u64 *pml_address;
+	gpa_t gpa, dst;
 
 	if (is_guest_mode(vcpu)) {
 		WARN_ON_ONCE(vmx->nested.pml_full);
@@ -12316,15 +12314,13 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
 		}
 
 		gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS) & ~0xFFFull;
+		dst = vmcs12->pml_address + sizeof(u64) * vmcs12->guest_pml_index;
 
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->pml_address);
-		if (is_error_page(page))
+		if (kvm_write_guest_page(vcpu->kvm, gpa_to_gfn(dst), &gpa,
+					 offset_in_page(dst), sizeof(gpa)))
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
