Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeBHHfe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:35:34 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:39752 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeBHHfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:35:33 -0500
X-Google-Smtp-Source: AH8x2251DMhzgM75O9KXrqOHNb2VNrPefn2xlEaKOAUrFzG1PT991ayLL+7MfiLoG6xjIG1p2k/FgBd3KquFei4mJd4=
MIME-Version: 1.0
In-Reply-To: <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com> <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 8 Feb 2018 15:35:32 +0800
Message-ID: <CANRm+Czz5_Tuys1J7c_Mq5Spb+1Y0vbzaXuZ3suijzmxDR-tUg@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-07 22:16 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 07/02/2018 07:25, Wanpeng Li wrote:
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 786cd00..445e702 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -7458,6 +7458,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>               goto out;
>>       }
>>
>> +     if (unlikely(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN)) {
>> +             r = -EINVAL;
>> +             goto out;
>> +     }
>> +
>>       if (vcpu->run->kvm_dirty_regs) {
>>               r = sync_regs(vcpu);
>>               if (r != 0)
>>
>
> This most likely breaks triple faults in the usual case where they
> should result in resetting the system; the KVM API doesn't say that you
> should clear vcpu->run->exit_reason before entering.
>
> What exactly causes the EPT misconfig to reach the WARN?  That is, how
> does kvm_mmu_page_fault end up returning a negative errno value?  If I
> read the code correctly only tdp_page_fault can do so, so my guess would
> be kvm_handle_bad_page:
>
>         if (pfn == KVM_PFN_ERR_RO_FAULT)
>                 return RET_PF_EMULATE;
>
>         if (pfn == KVM_PFN_ERR_HWPOISON) {
>                 kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn),
> current);
>                 return RET_PF_RETRY;
>         }
>
>         /* KVM_PFN_ERR_FAULT */
>         return -EFAULT;
>
> Maybe it should return RET_PF_EMULATE, which would cause an emulation
> failure and then an exit with KVM_EXIT_INTERNAL_ERROR.

Agreed, just do it in v2. In addition, I didn't remove the
RET_PFN_ERR_PO_FAULT check since I think otherwise we will miss the
comments above it.

Regards,
Wanpeng Li
