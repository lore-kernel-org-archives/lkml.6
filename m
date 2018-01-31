Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeAaRNr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753460AbeAaRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:13:46 -0500
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] KVM: nVMX: preserve SECONDARY_EXEC_DESC without UMIP
Date: Wed, 31 Jan 2018 18:12:50 +0100
Message-Id: <20180131171250.29568-1-rkrcmar@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L1 might want to use SECONDARY_EXEC_DESC, so we must not clear the VMCS
bit if UMIP is not being emulated.

We must still set the bit when emulating UMIP as the feature can be
passed to L2 where L0 will do the emulation and because L2 can change
CR4 without a VM exit, we should clear the bit if UMIP is disabled.

Fixes: 0367f205a3b7 ("KVM: vmx: add support for emulating UMIP")
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
---
 I haven't tested emulated UMIP (yet) nor machines with UMIP, but at
 least kvm-unit-tests don't throw an error anymore.

 arch/x86/kvm/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 438802d0b01d..b1e554a74b34 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4379,7 +4379,8 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 		vmcs_set_bits(SECONDARY_VM_EXEC_CONTROL,
 			      SECONDARY_EXEC_DESC);
 		hw_cr4 &= ~X86_CR4_UMIP;
-	} else
+	} else if (!is_guest_mode(vcpu) ||
+	           !nested_cpu_has2(get_vmcs12(vcpu), SECONDARY_EXEC_DESC))
 		vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL,
 				SECONDARY_EXEC_DESC);
 
-- 
2.15.0
