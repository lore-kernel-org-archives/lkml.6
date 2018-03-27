Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeC0CNZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:13:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33679 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeC0CNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:13:11 -0400
X-Google-Smtp-Source: AG47ELs03jy/9W94MOvQvUFUUdkUesFOwpt1ox9xFzjutzkGVapIMF2uD3a2SlkwNKE/UuWWXUpgGg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the next instruction"
Date: Mon, 26 Mar 2018 19:12:15 -0700
Message-Id: <1522116735-4861-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

This patch introduces a Force Emulation Prefix (ud2a; .ascii "kvm") for 
"emulate the next instruction", the codes will be executed by emulator 
instead of processor, for testing purposes.

A testcase here:

#include <stdio.h>
#include <string.h>
   
#define HYPERVISOR_INFO 0x40000000
   
#define CPUID(idx, eax, ebx, ecx, edx)\
    asm volatile (\
    "ud2a; .ascii \"kvm\"; 1: cpuid" \
    :"=b" (*ebx), "=a" (*eax),"=c" (*ecx), "=d" (*edx)\
        :"0"(idx) );  
   
void main()  
{  
	unsigned int eax,ebx,ecx,edx;  
	char string[13];  
   
	CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);  
	*(unsigned int *)(string+0) = ebx;  
	*(unsigned int *)(string+4) = ecx;  
	*(unsigned int *)(string+8) = edx;  
   
	string[12] = 0;  
	if (strncmp(string, "KVMKVMKVM\0\0\0",12) == 0)
		printf("kvm guest\n");  
	else  
		printf("bare hardware\n");  
}

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 0f99833..90abed8 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -108,6 +108,9 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
 static bool __read_mostly nested = 0;
 module_param(nested, bool, S_IRUGO);
 
+static bool __read_mostly fep = 0;
+module_param(fep, bool, S_IRUGO);
+
 static u64 __read_mostly host_xss;
 
 static bool __read_mostly enable_pml = 1;
@@ -6218,8 +6221,21 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
 static int handle_ud(struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er;
+	int emulation_type = EMULTYPE_TRAP_UD;
+
+	if (fep) {
+		char sig[5]; /* ud2; .ascii "kvm" */
+		struct x86_exception e;
+
+		kvm_read_guest_virt(&vcpu->arch.emulate_ctxt,
+				kvm_get_linear_rip(vcpu), sig, sizeof(sig), &e);
+		if (memcmp(sig, "\xf\xbkvm", sizeof(sig)) == 0) {
+			emulation_type = 0;
+			kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
+		}
+	}
 
-	er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
+	er = emulate_instruction(vcpu, emulation_type);
 	if (er == EMULATE_USER_EXIT)
 		return 0;
 	if (er != EMULATE_DONE)
-- 
2.7.4
