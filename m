Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeC0FJn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:09:43 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37584 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeC0FJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:09:41 -0400
X-Google-Smtp-Source: AG47ELsgoAUqbUszISqfpsS65D/HCEH+0PX2e1aZqgs79J4sXGOiOSzSMj/RXOOnjMY9leK35d5QREP7jp5X+vi7nW4=
MIME-Version: 1.0
In-Reply-To: <20180327044020.GB16974@char.us.oracle.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-3-git-send-email-wanpengli@tencent.com> <20180327044020.GB16974@char.us.oracle.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 27 Mar 2018 13:09:40 +0800
Message-ID: <CANRm+CzxLA1qOVaUCy_hCUMkVJDMxy7yD0ZmNG1Xm77mvg1wgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R59lNQ005784

2018-03-27 12:40 GMT+08:00 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
> On Mon, Mar 26, 2018 at 07:12:15PM -0700, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> This patch introduces a Force Emulation Prefix (ud2a; .ascii "kvm") for
>> "emulate the next instruction", the codes will be executed by emulator
>> instead of processor, for testing purposes.
>
> Can you expand a bit ? Why do you want this in KVM in the first place?
> Should this be controlled by a boolean parameter?
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
>> @@ -108,6 +108,9 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
>>  static bool __read_mostly nested = 0;
>>  module_param(nested, bool, S_IRUGO);
>>
>> +static bool __read_mostly fep = 0;
>> +module_param(fep, bool, S_IRUGO);
>> +
>>  static u64 __read_mostly host_xss;
>>
>>  static bool __read_mostly enable_pml = 1;
>> @@ -6218,8 +6221,21 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
>>  static int handle_ud(struct kvm_vcpu *vcpu)
>>  {
>>       enum emulation_result er;
>> +     int emulation_type = EMULTYPE_TRAP_UD;
>> +
>> +     if (fep) {
>> +             char sig[5]; /* ud2; .ascii "kvm" */
>> +             struct x86_exception e;
>
> Don't you want to do = { };
> to memset it?

sig buffer will be filled by insns which are fetched from guest
memory, so I think not memset is fine.

Regards,
Wanpeng Li
