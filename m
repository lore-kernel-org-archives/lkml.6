Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeB0BVU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 20:21:20 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34268 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeB0BVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 20:21:18 -0500
X-Google-Smtp-Source: AG47ELsKMxw5Jnj8IA8UrKlZCMgK7r5jC8URWnz2X+u49TjcZw692I3Z18QDjIuEXxoizAndbr5Xzqi5m3qLQ8eC9Mc=
MIME-Version: 1.0
In-Reply-To: <469812b9-d003-249a-d6d3-de74c24e4146@redhat.com>
References: <1519640239-4428-1-git-send-email-wanpengli@tencent.com> <469812b9-d003-249a-d6d3-de74c24e4146@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 27 Feb 2018 09:21:17 +0800
Message-ID: <CANRm+CyULfiYLkqibxxRwJUETBLruB2=Rrd_g4OSZ2QcmaYVVA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: X86: Allow userspace to define the microcode version
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1R1LOZl007620

2018-02-26 19:42 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 26/02/2018 11:17, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Linux (among the others) has checks to make sure that certain features
>> aren't enabled on a certain family/model/stepping if the microcode version
>> isn't greater than or equal to a known good version.
>>
>> By exposing the real microcode version, we're preventing buggy guests that
>> don't check that they are running virtualized (i.e., they should trust the
>> hypervisor) from disabling features that are effectively not buggy.
>>
>> Suggested-by: Filippo Sironi <sironi@amazon.de>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>> v1 -> v2:
>>  * add MSR_IA32_UCODE_REV to emulated_msrs
>>
>>  arch/x86/include/asm/kvm_host.h | 1 +
>>  arch/x86/kvm/x86.c              | 9 +++++++--
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 938d453..6e13f2f 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -507,6 +507,7 @@ struct kvm_vcpu_arch {
>>       u64 smi_count;
>>       bool tpr_access_reporting;
>>       u64 ia32_xss;
>> +     u32 microcode_version;
>>
>>       /*
>>        * Paging state of the vcpu
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 1a3ed81..4ae9517 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -1047,6 +1047,7 @@ static u32 emulated_msrs[] = {
>>       MSR_SMI_COUNT,
>>       MSR_PLATFORM_INFO,
>>       MSR_MISC_FEATURES_ENABLES,
>> +     MSR_IA32_UCODE_REV,
>>  };
>>
>>  static unsigned num_emulated_msrs;
>> @@ -2247,7 +2248,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>
>>       switch (msr) {
>>       case MSR_AMD64_NB_CFG:
>> -     case MSR_IA32_UCODE_REV:
>>       case MSR_IA32_UCODE_WRITE:
>>       case MSR_VM_HSAVE_PA:
>>       case MSR_AMD64_PATCH_LOADER:
>> @@ -2255,6 +2255,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>       case MSR_AMD64_DC_CFG:
>>               break;
>>
>> +     case MSR_IA32_UCODE_REV:
>> +             if (msr_info->host_initiated)
>> +                     vcpu->arch.microcode_version = data >> 32;
>
> Please remove the shifts, and add the MSR_IA32_UCODE_REV version to the
> "feature MSRs" recently added by Tom Lendacky.

Do it in v3, thanks for the review. :)

Regards,
Wanpeng Li

>
> Thanks,
>
> Paolo
>
>> +             break;
>>       case MSR_EFER:
>>               return set_efer(vcpu, data);
>>       case MSR_K7_HWCR:
>> @@ -2550,7 +2554,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>               msr_info->data = 0;
>>               break;
>>       case MSR_IA32_UCODE_REV:
>> -             msr_info->data = 0x100000000ULL;
>> +             msr_info->data = (u64)vcpu->arch.microcode_version << 32;
>>               break;
>>       case MSR_MTRRcap:
>>       case 0x200 ... 0x2ff:
>> @@ -8232,6 +8236,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>>       vcpu->arch.regs_dirty = ~0;
>>
>>       vcpu->arch.ia32_xss = 0;
>> +     vcpu->arch.microcode_version = 0x1;
>>
>>       kvm_x86_ops->vcpu_reset(vcpu, init_event);
>>  }
>>
>
