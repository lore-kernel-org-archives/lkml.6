Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966659AbeBNDDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:03:31 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46398 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966573AbeBNDDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:03:30 -0500
X-Google-Smtp-Source: AH8x225AraJ+ATznPjVaRjYbC8j7K+w0GZJIxUGA29JqG1tGVhXrMfDzx9o64kcAOAphdx0sxOU+XoFC3TdmDoNFGGY=
MIME-Version: 1.0
In-Reply-To: <d890ee61-19b6-bb38-607b-f9e547b7a35b@redhat.com>
References: <1518483942-14741-1-git-send-email-wanpengli@tencent.com>
 <1518483942-14741-4-git-send-email-wanpengli@tencent.com> <d890ee61-19b6-bb38-607b-f9e547b7a35b@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 14 Feb 2018 11:03:29 +0800
Message-ID: <CANRm+Cz9L9xTe-zGcuqoXD0Q44xvw0Q2Gp_C=NR3t=j6oq-QXQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] KVM: X86: Don't use PV TLB flush with dedicated
 vCPUs and steal time disabled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1E33ZgG009536

2018-02-14 0:12 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 13/02/2018 02:05, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> vCPUs are very unlikely to get preempted when they are the only task
>> running on a CPU.  PV TLB flush is slower that the native flush in that
>> case. In addition, avoid traversing all the cpus for pv tlb flush when
>> steal time is disabled since pv tlb flush depends on the field in steal
>> time for shared data.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kernel/kvm.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index c5566d9..285822f 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -545,7 +545,9 @@ static void __init kvm_guest_init(void)
>>               pv_time_ops.steal_clock = kvm_steal_clock;
>>       }
>>
>> -     if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH))
>> +     if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>> +             !kvm_para_has_feature(KVM_HINTS_DEDICATED) &&
>> +             !kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
>>               pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
>>
>>       if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
>> @@ -638,7 +640,9 @@ static __init int kvm_setup_pv_tlb_flush(void)
>>  {
>>       int cpu;
>>
>> -     if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH)) {
>> +     if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
>> +             !kvm_para_has_feature(KVM_HINTS_DEDICATED) &&
>
> This should have checked the hints word.
>
> In general, I'm going to change in the whole series
> kvm_hint_has_feature with kvm_para_has_hint, and kvm_arch_hint_features
> with kvm_arch_para_hints.  But apart from this small naming issue, the
> series looks good, and I'm applying it to kvm/queue.

Thanks Paolo.

Regards,
Wanpeng Li
