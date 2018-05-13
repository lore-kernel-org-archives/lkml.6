Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeEMJZT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 05:25:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34418 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEMJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 05:25:18 -0400
X-Google-Smtp-Source: AB8JxZrYxZUurLZ3hfTrglkxL4DY5SCU7M41+VRIOPsIcZXZE8lFRokZ/y/4fmJyuRAeHlmFzSBdNw==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Junaid Shahid <junaids@google.com>, Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v2] KVM: X86: Fix CR3 reserve bits
Date: Sun, 13 May 2018 02:24:47 -0700
Message-Id: <1526203487-4967-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

MSB of CR3 is a reserved bit if the PCIDE bit is not set in CR4. 
It should be checked when PCIDE bit is not set, however commit 
'd1cd3ce900441 ("KVM: MMU: check guest CR3 reserved bits based on 
its physical address width")' removes the bit 63 checking 
unconditionally. This patch fixes it by checking bit 63 of CR3 
when PCIDE bit is not set in CR4.

Fixes: d1cd3ce900441 (KVM: MMU: check guest CR3 reserved bits based on its physical address width)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Junaid Shahid <junaids@google.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * remove CR3_PCID_INVD in rsvd when PCIDE is 1 instead of 
   removing CR3_PCID_INVD in new_value

 arch/x86/kvm/emulate.c | 4 +++-
 arch/x86/kvm/x86.c     | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b3705ae..143b7ae 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4189,7 +4189,9 @@ static int check_cr_write(struct x86_emulate_ctxt *ctxt)
 				maxphyaddr = eax & 0xff;
 			else
 				maxphyaddr = 36;
-			rsvd = rsvd_bits(maxphyaddr, 62);
+			rsvd = rsvd_bits(maxphyaddr, 63);
+			if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
+				rsvd &= ~CR3_PCID_INVD;
 		}
 
 		if (new_val & rsvd)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 87e4805..9a90668 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -863,7 +863,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	}
 
 	if (is_long_mode(vcpu) &&
-	    (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 62)))
+	    (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
 		return 1;
 	else if (is_pae(vcpu) && is_paging(vcpu) &&
 		   !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
-- 
2.7.4
