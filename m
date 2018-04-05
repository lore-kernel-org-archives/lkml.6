Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDEAFA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:05:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42155 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeDEAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:04:58 -0400
X-Google-Smtp-Source: AIpwx49ou9PqxStqpcxHdV3ASG8kvmm82spUO7poaETO0JnspMV+F/+y/w1v2J1hCGwXPRSfLlTBDvNZ9kQJkmn4p0w=
MIME-Version: 1.0
In-Reply-To: <f8da5618-6d80-e209-fb28-0dc11cee5c1d@redhat.com>
References: <1522798129-14588-1-git-send-email-wanpengli@tencent.com>
 <1522798129-14588-3-git-send-email-wanpengli@tencent.com> <48d06146-f508-e883-72cb-881e043f9c72@redhat.com>
 <CANRm+CwMRb9hbV5PjGMoTe1oDa+cEZ0ex7N-1J5NkWiCV62M4A@mail.gmail.com> <f8da5618-6d80-e209-fb28-0dc11cee5c1d@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 5 Apr 2018 08:04:57 +0800
Message-ID: <CANRm+Cz55bkFrd=pHt7ca+7-HP03Ap7hupSVQQSVckTYnX3+HQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] KVM: X86: Add Force Emulation Prefix for "emulate
 the next instruction"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-05 1:09 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 04/04/2018 15:35, Wanpeng Li wrote:
>> 2018-04-04 19:59 GMT+08:00 David Hildenbrand <david@redhat.com>:
>>>
>>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>>> index 1eb495e..a55ecef 100644
>>>> --- a/arch/x86/kvm/x86.c
>>>> +++ b/arch/x86/kvm/x86.c
>>>> @@ -146,6 +146,9 @@ bool __read_mostly enable_vmware_backdoor = false;
>>>>  module_param(enable_vmware_backdoor, bool, S_IRUGO);
>>>>  EXPORT_SYMBOL_GPL(enable_vmware_backdoor);
>>>>
>>>> +static bool __read_mostly force_emulation_prefix = false;
>>>> +module_param(force_emulation_prefix, bool, S_IRUGO);
>>>> +
>>>>  #define KVM_NR_SHARED_MSRS 16
>>>>
>>>>  struct kvm_shared_msrs_global {
>>>> @@ -4844,6 +4847,21 @@ int handle_ud(struct kvm_vcpu *vcpu)
>>>>  {
>>>>       enum emulation_result er;
>>>>
>>>> +     if (force_emulation_prefix) {
>>>> +             char sig[5]; /* ud2; .ascii "kvm" */
>>>> +             struct x86_exception e;
>>>> +
>>>> +             if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt,
>>>> +                             kvm_get_linear_rip(vcpu), sig, sizeof(sig), &e))
>>>> +                     goto emulate_ud;
>>>> +
>>>> +             if (memcmp(sig, "\xf\xbkvm", sizeof(sig)) == 0) {
>>>> +                     kvm_rip_write(vcpu, kvm_rip_read(vcpu) + sizeof(sig));
>>>> +                     return emulate_instruction(vcpu, 0) == EMULATE_DONE;
>>>
>>> What if we would have an invalid instruction here? Shouldn't you handle
>>> the emulate_instruction() like below?
>>> (e.g. keep a variable with the emulation type (0 vs EMULTYPE_TRAP_UD)
>>> and reuse emulate_ud below)
>>
>> emulate_instruction(vcpu, 0) can handle invalid instruction.
>
> But David's observation is still better because your code doesn't handle usermode exits.

My code handles it, return emulate_instruction(vcpu, 0) ==
EMULATE_DONE, it will return 0 since EMULATE_USER_EXIT == EMULATE_DONE
fails.

> I've fixed this up.

Thanks. The codes similar to my v3 but more beauty. :) I change to
this view since Radim's comments to v3
https://www.spinics.net/lists/kvm/msg166999.html

Regards,
Wanpeng Li
