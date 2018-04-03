Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755890AbeDCXat (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:30:49 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41963 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755823AbeDCXap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:30:45 -0400
X-Google-Smtp-Source: AIpwx4+oAGbQpwN7ClS6KGSV7juztDdSn69lyw58bhsM/ivEZyEkZ9dtsckpC0En5IKW5MnSfUUjT+XPcOOjYFP36jw=
MIME-Version: 1.0
In-Reply-To: <20180403192407.GA7351@flask>
References: <1522400804-4578-1-git-send-email-wanpengli@tencent.com>
 <1522400804-4578-3-git-send-email-wanpengli@tencent.com> <20180403192407.GA7351@flask>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 4 Apr 2018 07:30:44 +0800
Message-ID: <CANRm+CxuBxdUdD20ozG060_HmT9-LkObx_wY6Vux21czdyWcBA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] KVM: X86: Add Force Emulation Prefix for "emulate
 the next instruction"
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w33NUxOm030377

2018-04-04 3:24 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
> 2018-03-30 02:06-0700, Wanpeng Li:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> There is no easy way to force KVM to run an instruction through the emulator
>> (by design as that will expose the x86 emulator as a significant attack-surface).
>> However, we do wish to expose the x86 emulator in case we are testing it
>> (e.g. via kvm-unit-tests). Therefore, this patch adds a "force emulation prefix"
>> that is designed to raise #UD which KVM will trap and it's #UD exit-handler will
>> match "force emulation prefix" to run instruction after prefix by the x86 emulator.
>> To not expose the x86 emulator by default, we add a module parameter that should
>> be off by default.
>>
>> A simple testcase here:
>>
>> #include <stdio.h>
>> #include <string.h>
>>
>> #define HYPERVISOR_INFO 0x40000000
>>
>> #define CPUID(idx, eax, ebx, ecx, edx) \
>>     asm volatile (\
>>     "ud2a; .ascii \"kvm\"; cpuid" \
>>     :"=b" (*ebx), "=a" (*eax), "=c" (*ecx), "=d" (*edx) \
>>         :"0"(idx) );
>>
>> void main()
>> {
>>       unsigned int eax, ebx, ecx, edx;
>>       char string[13];
>>
>>       CPUID(HYPERVISOR_INFO, &eax, &ebx, &ecx, &edx);
>>       *(unsigned int *)(string + 0) = ebx;
>>       *(unsigned int *)(string + 4) = ecx;
>>       *(unsigned int *)(string + 8) = edx;
>>
>>       string[12] = 0;
>>       if (strncmp(string, "KVMKVMKVM\0\0\0", 12) == 0)
>>               printf("kvm guest\n");
>>       else
>>               printf("bare hardware\n");
>> }
>>
>> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> Reviewed-By: Liran Alon <liran.alon@oracle.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kvm/x86.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 1eb495e..c619564 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -146,6 +146,9 @@ bool __read_mostly enable_vmware_backdoor = false;
>>  module_param(enable_vmware_backdoor, bool, S_IRUGO);
>>  EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
>>
>> +static bool __read_mostly force_emulation_prefix = false;
>> +module_param(force_emulation_prefix, bool, S_IRUGO);
>> +
>>  #define KVM_NR_SHARED_MSRS 16
>>
>>  struct kvm_shared_msrs_global {
>> @@ -4844,6 +4847,18 @@ int handle_ud(struct kvm_vcpu *vcpu)
>>  {
>>       enum emulation_result er;
>>
>> +     if (force_emulation_prefix) {
>> +             char sig[5]; /* ud2; .ascii "kvm" */
>> +             struct x86_exception e;
>> +
>> +             kvm_read_guest_virt(&vcpu->arch.emulate_ctxt,
>> +                             kvm_get_linear_rip(vcpu), sig, sizeof(sig), &e);
>
> Looking at it again, we should skip the following check if the call
> failed (the sig is undefined in that case).

Ok, will fallback to normal emulate_ud when this fail.

>
> With that, or even without as we're talking about a feature that has no
> place in any production system,
>
> Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>

Thanks Radim. :)

Regards,
Wanpeng Li
