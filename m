Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDDN2b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:28:31 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42162 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeDDN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:28:29 -0400
X-Google-Smtp-Source: AIpwx48d1OggI6ZRS68jSR63lHO7jOR+AYEKyvDCFq3ueysaO/cVK86o8wtFHbFn0cHOdxXU/lRUaxl/psX2MB3VAh4=
MIME-Version: 1.0
In-Reply-To: <9d68b1b4-04e6-46d6-70b4-6ebcb0a0c4aa@redhat.com>
References: <1522798129-14588-1-git-send-email-wanpengli@tencent.com>
 <1522798129-14588-2-git-send-email-wanpengli@tencent.com> <9d68b1b4-04e6-46d6-70b4-6ebcb0a0c4aa@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 4 Apr 2018 21:28:28 +0800
Message-ID: <CANRm+Cxc9uVqS9J98qLTCg3WHDef1G6-AZT0TOgT_FQ3DsWFAQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: X86: Introduce handle_ud()
To: David Hildenbrand <david@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34DSb8e017808

2018-04-04 19:54 GMT+08:00 David Hildenbrand <david@redhat.com>:
> On 04.04.2018 01:28, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Introduce handle_ud() to handle invalid opcode, this function will be
>> used by later patches.
>>
>> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Reviewed-by: Liran Alon <liran.alon@oracle.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kvm/svm.c |  9 +--------
>>  arch/x86/kvm/vmx.c | 10 ++--------
>>  arch/x86/kvm/x86.c | 13 +++++++++++++
>>  arch/x86/kvm/x86.h |  2 ++
>>  4 files changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
>> index f66fc2e..e0a3f56 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -2676,14 +2676,7 @@ static int bp_interception(struct vcpu_svm *svm)
>>
>>  static int ud_interception(struct vcpu_svm *svm)
>>  {
>> -     int er;
>> -
>> -     er = emulate_instruction(&svm->vcpu, EMULTYPE_TRAP_UD);
>> -     if (er == EMULATE_USER_EXIT)
>> -             return 0;
>> -     if (er != EMULATE_DONE)
>> -             kvm_queue_exception(&svm->vcpu, UD_VECTOR);
>> -     return 1;
>> +     return handle_ud(&svm->vcpu);
>>  }
>>
>>  static int ac_interception(struct vcpu_svm *svm)
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index b2f8a70..0f11243 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -6436,14 +6436,8 @@ static int handle_exception(struct kvm_vcpu *vcpu)
>>       if (is_nmi(intr_info))
>>               return 1;  /* already handled by vmx_vcpu_run() */
>>
>> -     if (is_invalid_opcode(intr_info)) {
>> -             er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
>> -             if (er == EMULATE_USER_EXIT)
>> -                     return 0;
>> -             if (er != EMULATE_DONE)
>> -                     kvm_queue_exception(vcpu, UD_VECTOR);
>> -             return 1;
>> -     }
>> +     if (is_invalid_opcode(intr_info))
>> +             return handle_ud(vcpu);
>
> (maybe different on this branch) isn't "er" now unused?

Hmm, It is used in other place of the function handle_exception.

>
>>
>>       error_code = 0;
>>       if (intr_info & INTR_INFO_DELIVER_CODE_MASK)
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 7d9a444..1eb495e 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -4840,6 +4840,19 @@ int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
>>  }
>>  EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
>>
>> +int handle_ud(struct kvm_vcpu *vcpu)
>> +{
>> +     enum emulation_result er;
>> +
>> +     er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
>> +     if (er == EMULATE_USER_EXIT)
>> +             return 0;
>> +     if (er != EMULATE_DONE)
>> +             kvm_queue_exception(vcpu, UD_VECTOR);
>> +     return 1;
>
> I would now actually prefer
>
> if (er == EMULATE_DONE)
>         return 1 ...

Keep the original one I think.

Regards,
Wanpeng Li
