Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeC0JIQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:08:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36646 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0JH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:07:57 -0400
X-Google-Smtp-Source: AG47ELvBYw1YFmUQ0nlm9i3OXGig/s07ioh/GPoKqtEPBS/mW55oyLa8FI0zyPtHej07fdWcYym9AA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v2 2/2] KVM: X86: Add Force Emulation Prefix for "emulate the next instruction"
Date: Tue, 27 Mar 2018 02:06:56 -0700
Message-Id: <1522141616-9825-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522141616-9825-1-git-send-email-wanpengli@tencent.com>
References: <1522141616-9825-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

There is no easy way to force KVM to run an instruction through the emulator 
(by design as that will expose the x86 emulator as a significant attack-surface).
However, we do wish to expose the x86 emulator in case we are testing it
(e.g. via kvm-unit-tests). Therefore, this patch adds a "force emulation prefix"
that is designed to raise #UD which KVM will trap and it's #UD exit-handler will
match "force emulation prefix" to run instruction after prefix by the x86 emulator.
To not expose the x86 emulator by default, we add a module parameter that should 
be off by default.

A simple testcase here:

#include <stdio.h>
#include <string.h>
   
#define HYPERVISOR_INFO 0x40000000
   
#define CPUID(idx, eax, ebx, ecx, edx) \
    asm volatile (\
    "ud2a; .ascii \"kvm\"; cpuid" \
    :"=b" (*ebx), "=a" (*eax), "=c" (*ecx), "=d" (*edx) \
        :"0"(idx) );  
   
void main()  
{  
	unsigned int eax, ebx, ecx, edx;  
	char string[13];  
   
	CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);  
	*(unsigned int *)(string + 0) = ebx;  
	*(unsigned int *)(string + 4) = ecx;  
	*(unsigned int *)(string + 8) = edx;  
   
	string[12] = 0;  
	if (strncmp(string, "KVMKVMKVM\0\0\0", 12) == 0)
		printf("kvm guest\n");  
	else  
		printf("bare hardware\n");  
}

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e3a60ab..40e2f78 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -146,6 +146,9 @@ bool __read_mostly enable_vmware_backdoor = false;
 module_param(enable_vmware_backdoor, bool, S_IRUGO);
 EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
 
+bool __read_mostly force_emulation_prefix = false;
+module_param(force_emulation_prefix, bool, S_IRUGO);
+
 #define KVM_NR_SHARED_MSRS 16
 
 struct kvm_shared_msrs_global {
@@ -4843,8 +4846,21 @@ EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
 int handle_ud(struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er;
+	int emulation_type = EMULTYPE_TRAP_UD;
+
+	if (force_emulation_prefix) {
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
