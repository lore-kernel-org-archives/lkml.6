Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeCIAvw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:51:52 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38740 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeCIAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:51:46 -0500
X-Google-Smtp-Source: AG47ELvs9uSMAhYuKvD+4O6AFJVMD2tmExib1bK0JHQM8vXUZoadzKJ9BNoQTHzpywvNts7i8z34VWsLi1f0AD8Cq4k=
MIME-Version: 1.0
In-Reply-To: <20180308204029.GK12290@flask>
References: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
 <1519897782-8124-2-git-send-email-wanpengli@tencent.com> <20180308204029.GK12290@flask>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 9 Mar 2018 08:51:44 +0800
Message-ID: <CANRm+Cya+QLJV7wX3GzUbKRA+sSPMmDb4sVtk+W6bC70aN8f+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: X86: Provides userspace with a capability to not
 intercept HLT
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w290pvo8006858

2018-03-09 4:40 GMT+08:00 Radim Krčmář <rkrcmar@redhat.com>:
> 2018-03-01 17:49+0800, Wanpeng Li:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> If host CPUs are dedicated to a VM, we can avoid VM exits on HLT.
>> This patch adds the per-VM non-HLT-exiting capability.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index dff3a5d..fcf8339 100644
>> --- a/arch/x86/kvm/svm.c
>> +++ b/arch/x86/kvm/svm.c
>> @@ -1394,6 +1394,9 @@ static void init_vmcb(struct vcpu_svm *svm)
>>               set_intercept(svm, INTERCEPT_MWAIT);
>>       }
>>
>> +     if (!kvm_hlt_in_guest(svm->vcpu.kvm))
>> +             set_intercept(svm, INTERCEPT_HLT);
>
> We unconditionally set INTERCEPT_HLT just above, so that line has to be
> removed.

Agreed.

>
>> +
>>       control->iopm_base_pa = __sme_set(iopm_base);
>>       control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
>>       control->int_ctl = V_INTR_MASKING_MASK;
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> @@ -2525,6 +2525,19 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
>>       return 0;
>>  }
>>
>> +static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
>> +{
>> +     /*
>> +      * Ensure that we clear the HLT state in the VMCS.  We don't need to
>> +      * explicitly skip the instruction because if the HLT state is set,
>> +      * then the instruction is already executing and RIP has already been
>> +      * advanced.
>> +      */
>> +     if (kvm_hlt_in_guest(vcpu->kvm) &&
>> +                     vmcs_read32(GUEST_ACTIVITY_STATE) == GUEST_ACTIVITY_HLT)
>> +             vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
>> +}
>
> The clearing seems to be still missing around SMM -- I think you need to
> call vmx_clear_hlt() from pre_enter_smm().

Will do in v2.

Regards,
Wanpeng Li
