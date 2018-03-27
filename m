Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeC0JKS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:10:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39196 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeC0JKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:10:01 -0400
X-Google-Smtp-Source: AG47ELu52q0h4TGSnPU3MoGm5nn0MAVpeQK4iIYnZa+3zNhyZcj9nkODDCuA3GFiMpylCBUGt1stycKXe5WOcrz3pKg=
MIME-Version: 1.0
In-Reply-To: <76d08635-59da-4399-bc35-f99a00236725@default>
References: <76d08635-59da-4399-bc35-f99a00236725@default>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 27 Mar 2018 17:09:59 +0800
Message-ID: <CANRm+CwLU0rHoAEfoGbWPb2xPF7RLQgytFoSr4WVRopRjR_SOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
To: Liran Alon <liran.alon@oracle.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R9Adpl027564

2018-03-27 15:52 GMT+08:00 Liran Alon <liran.alon@oracle.com>:
>
> ----- kernellwp@gmail.com wrote:
>
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> This patch introduces a Force Emulation Prefix (ud2a; .ascii "kvm")
>> for
>> "emulate the next instruction", the codes will be executed by emulator
>>
>> instead of processor, for testing purposes.
>
> I think this should be better explained in commit message.
> We should explain that there is no easy way to force KVM to run an
> instruction through the emulator (by design as that will expose the
> x86 emulator as a significant attack-surface).
> However, we do wish to expose the x86 emulator in case we are testing it
> (e.g. via kvm-unit-tests). Therefore, this patch adds a "force emulation prefix"
> that is designed to raise #UD which KVM will trap and it's #UD exit-handler will
> match "force emulation prefix" to run instruction after prefix by the x86 emulator.
> To not expose the x86 emulator by default, we add a module parameter that should be
> off by default.

This commit message looks good, I'm too lazy to write a new one, will
reference. :)

Regards,
Wanpeng Li

>
>>
>> A testcase here:
>>
>> #include <stdio.h>
>> #include <string.h>
>>
>> #define HYPERVISOR_INFO 0x40000000
>>
>> #define CPUID(idx, eax, ebx, ecx, edx)\
>>     asm volatile (\
>>     "ud2a; .ascii \"kvm\"; 1: cpuid" \
>>     :"=b" (*ebx), "=a" (*eax),"=c" (*ecx), "=d" (*edx)\
>>         :"0"(idx) );
>>
>> void main()
>> {
>>       unsigned int eax,ebx,ecx,edx;
>>       char string[13];
>>
>>       CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);
>>       *(unsigned int *)(string+0) = ebx;
>>       *(unsigned int *)(string+4) = ecx;
>>       *(unsigned int *)(string+8) = edx;
>>
>>       string[12] = 0;
>>       if (strncmp(string, "KVMKVMKVM\0\0\0",12) == 0)
>>               printf("kvm guest\n");
>>       else
>>               printf("bare hardware\n");
>> }
>>
>> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kvm/vmx.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 0f99833..90abed8 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -108,6 +108,9 @@ module_param_named(enable_shadow_vmcs,
>> enable_shadow_vmcs, bool, S_IRUGO);
>>  static bool __read_mostly nested = 0;
>>  module_param(nested, bool, S_IRUGO);
>>
>> +static bool __read_mostly fep = 0;
>> +module_param(fep, bool, S_IRUGO);
>
> I think this module parameter should have a better name...
> Why not "emulation_prefix" or "enable_emulation_prefix"?
> This short names just confuse the average user.
> It makes him think it is some kind of Intel VT-x technology
> that he isn't aware of :P
>
> In addition, I think this module parameter should be in kvm module
> (not kvm_intel) and you should add similar logic to kvm_amd module (SVM)
>
>> +
>>  static u64 __read_mostly host_xss;
>>
>>  static bool __read_mostly enable_pml = 1;
>> @@ -6218,8 +6221,21 @@ static int handle_machine_check(struct kvm_vcpu
>> *vcpu)
>>  static int handle_ud(struct kvm_vcpu *vcpu)
>>  {
>>       enum emulation_result er;
>> +     int emulation_type = EMULTYPE_TRAP_UD;
>> +
>> +     if (fep) {
>> +             char sig[5]; /* ud2; .ascii "kvm" */
>> +             struct x86_exception e;
>> +
>> +             kvm_read_guest_virt(&vcpu->arch.emulate_ctxt,
>> +                             kvm_get_linear_rip(vcpu), sig, sizeof(sig), &e);
>> +             if (memcmp(sig, "\xf\xbkvm", sizeof(sig)) == 0) {
>> +                     emulation_type = 0;
>> +                     kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
>> +             }
>> +     }
>>
>> -     er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
>> +     er = emulate_instruction(vcpu, emulation_type);
>>       if (er == EMULATE_USER_EXIT)
>>               return 0;
>>       if (er != EMULATE_DONE)
>> --
>> 2.7.4
