Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeEMDYo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 23:24:44 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36631 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeEMDYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 23:24:42 -0400
X-Google-Smtp-Source: AB8JxZqpu1tiCOmFHQuAoi9N7mY6f3/41hHoGD3k+1WKt1Sxa+YYtRiHbRiLxmmfZAA30pfnnDQA3A==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Junaid Shahid <junaids@google.com>
Subject: [PATCH 2/2] KVM: X86: Fix loss of CR3_PCID_INVD bit when guest writes CR3
Date: Sat, 12 May 2018 20:24:14 -0700
Message-Id: <1526181854-3631-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

SDM volume 3, section 4.10.4:

* MOV to CR3. The behavior of the instruction depends on the value of CR4.PCIDE:
— If CR4.PCIDE = 1 and bit 63 of the instruction’s source operand is 1, the 
  instruction is not required to invalidate any TLB entries or entries in 
  paging-structure caches.

The CR3_PCID_INVD bit should not be removed if CR4.PCIDE = 1 when guest writes 
CR3, this patch fixes it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Junaid Shahid <junaids@google.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9a90668..438f140 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -849,11 +849,13 @@ EXPORT_SYMBOL_GPL(kvm_set_cr4);
 
 int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
+	unsigned long cr3_check = cr3;
+
 #ifdef CONFIG_X86_64
 	bool pcid_enabled = kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE);
 
 	if (pcid_enabled)
-		cr3 &= ~CR3_PCID_INVD;
+		cr3_check &= ~CR3_PCID_INVD;
 #endif
 
 	if (cr3 == kvm_read_cr3(vcpu) && !pdptrs_changed(vcpu)) {
@@ -863,7 +865,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	}
 
 	if (is_long_mode(vcpu) &&
-	    (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
+	    (cr3_check & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
 		return 1;
 	else if (is_pae(vcpu) && is_paging(vcpu) &&
 		   !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
-- 
2.7.4
