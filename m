Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeBESsp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:48:45 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23891 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753908AbeBESsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:03 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="330725258"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 07/12] KVM/VMX: Use the new host mapping API for mapping L12 MSR bitmap
Date: Mon,  5 Feb 2018 19:47:26 +0100
Message-Id: <1517856451-2932-8-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nested guests the L12 MSR bitmap was mapped to the host kernel using
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
index 9544df0..7177176 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10186,7 +10186,7 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 					       struct vmcs12 *vmcs12)
 {
 	int msr;
-	struct page *page;
+	struct kvm_host_mapping mapping;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 	/*
@@ -10209,10 +10209,10 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	    !pred_cmd && !spec_ctrl)
 		return false;
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
-	if (is_error_page(page))
+	if (!kvm_vcpu_gpa_to_host_mapping(vcpu, vmcs12->msr_bitmap, &mapping, true))
 		return false;
-	msr_bitmap_l1 = (unsigned long *)kmap(page);
+
+	msr_bitmap_l1 = (unsigned long *)mapping.kaddr;
 
 	memset(msr_bitmap_l0, 0xff, PAGE_SIZE);
 
@@ -10252,8 +10252,7 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 					MSR_IA32_PRED_CMD,
 					MSR_TYPE_W);
 
-	kunmap(page);
-	kvm_release_page_clean(page);
+	kvm_release_host_mapping(&mapping , false);
 
 	return true;
 }
-- 
2.7.4
