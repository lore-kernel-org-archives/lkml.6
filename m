Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCZMZY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:25:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37902 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:25:22 -0400
X-Google-Smtp-Source: AG47ELsUv6fvUi8q6BCyPR8IH2soJSxe3G72UCT3SpUnUBewmFb4BK28JgLL+TNgYY8JkFxPFsIEN0v+bsidSc2iP/g=
MIME-Version: 1.0
In-Reply-To: <46ef9359-a87c-224c-53e0-c948b79314a8@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com> <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com> <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
 <9bd82cb0-d88f-4891-a111-3704802e1d4e@redhat.com> <CANRm+CwmJQCFZ7oe1_YatqoOXzzEU+SP9Z5qR6zU_ybd_DoGQQ@mail.gmail.com>
 <94bbfac5-2022-ab92-0b9a-1c3cd2275054@citrix.com> <CANRm+CwsFX7rVkPvENRM20D84zotonxFFJMSq98icS4BQm7o2Q@mail.gmail.com>
 <46ef9359-a87c-224c-53e0-c948b79314a8@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 26 Mar 2018 20:25:21 +0800
Message-ID: <CANRm+Czgy0V1E3DsGMd=frSby-6fAEXzvjkVrOE-7kBF4T8dtA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit mode
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-23 23:04 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 23/03/2018 15:27, Wanpeng Li wrote:
>> 2018-03-22 21:53 GMT+08:00 Andrew Cooper <andrew.cooper3@citrix.com>:
>>> On 22/03/18 13:39, Wanpeng Li wrote:
>>>> 2018-03-22 20:38 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>>>> On 22/03/2018 12:04, Andrew Cooper wrote:
>>>>>> We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
>>>>>> magic.  Originally, this was used for PV guests to explicitly request an
>>>>>> emulated CPUID, but I extended it to HVM guests for "emulate the next
>>>>>> instruction", after we had some guest user => guest kernel privilege
>>>>>> escalations because of incorrect emulation.
>>>>> Wanpeng, why don't you add it behind a new kvm module parameter? :)
>>>> Great point! I will have a try. Thanks Paolo and Andrew. :)
>>>
>>> Using the force emulation prefix requires intercepting #UD, which is in
>>> general a BadThing(tm) for security.  Therefore, we have a build time
>>
>> Yeah, however kvm intercepts and emulates #UD by default, should we
>> add a new kvm module parameter to enable it and disable by default?
>
> No, the module parameter should only be about the force-emulation prefix.

How about something like this? (Add EmulateOnUD to cpuid, the testcase
will use it)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index dd88158..80da5c6 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4772,7 +4772,7 @@ static const struct opcode twobyte_table[256] = {
     X16(D(ByteOp | DstMem | SrcNone | ModRM| Mov)),
     /* 0xA0 - 0xA7 */
     I(Stack | Src2FS, em_push_sreg), I(Stack | Src2FS, em_pop_sreg),
-    II(ImplicitOps, em_cpuid, cpuid),
+    II(EmulateOnUD | ImplicitOps, em_cpuid, cpuid),
     F(DstMem | SrcReg | ModRM | BitOp | NoWrite, em_bt),
     F(DstMem | SrcReg | Src2ImmByte | ModRM, em_shld),
     F(DstMem | SrcReg | Src2CL | ModRM, em_shld), N, N,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9bc05f5..1825b45 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -108,6 +108,9 @@ module_param_named(enable_shadow_vmcs,
enable_shadow_vmcs, bool, S_IRUGO);
 static bool __read_mostly nested = 0;
 module_param(nested, bool, S_IRUGO);

+static bool __read_mostly fep = 0;
+module_param(fep, bool, S_IRUGO);
+
 static u64 __read_mostly host_xss;

 static bool __read_mostly enable_pml = 1;
@@ -6215,6 +6218,27 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
     return 1;
 }

+static int handle_ud(struct kvm_vcpu *vcpu)
+{
+    enum emulation_result er;
+
+    if (fep) {
+        char sig[5]; /* ud2; .ascii "kvm" */
+        struct x86_exception e;
+
+        kvm_read_guest_virt(&vcpu->arch.emulate_ctxt,
+                kvm_get_linear_rip(vcpu), sig, sizeof(sig), &e);
+        if (memcmp(sig, "\xf\xbkvm", sizeof(sig)) == 0)
+            kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
+    }
+    er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
+    if (er == EMULATE_USER_EXIT)
+        return 0;
+    if (er != EMULATE_DONE)
+        kvm_queue_exception(vcpu, UD_VECTOR);
+    return 1;
+}
+
 static int handle_exception(struct kvm_vcpu *vcpu)
 {
     struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -6233,14 +6257,8 @@ static int handle_exception(struct kvm_vcpu *vcpu)
     if (is_nmi(intr_info))
         return 1;  /* already handled by vmx_vcpu_run() */

-    if (is_invalid_opcode(intr_info)) {
-        er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
-        if (er == EMULATE_USER_EXIT)
-            return 0;
-        if (er != EMULATE_DONE)
-            kvm_queue_exception(vcpu, UD_VECTOR);
-        return 1;
-    }
+    if (is_invalid_opcode(intr_info))
+        return handle_ud(vcpu);

     error_code = 0;
     if (intr_info & INTR_INFO_DELIVER_CODE_MASK)


The testcase:

#include <stdio.h>
#include <string.h>

#define HYPERVISOR_INFO 0x40000000

#define CPUID(idx, eax, ebx, ecx, edx)\
    asm volatile (\
    "test %1,%1;jz 1f; ud2a; .ascii \"kvm\"; 1: cpuid" \
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
        if (strncmp(string, "KVMKVMKVM\0\0\0",12) == 0) {
                printf("kvm guest\n");
        } else
          printf("bare hardware\n");

}

Regards,
Wanpeng Li
