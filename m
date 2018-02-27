Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeB0C1i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:27:38 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39503 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeB0C1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:27:36 -0500
X-Google-Smtp-Source: AH8x224gp3yJ0Rx59E5E5iCp0xPNf16lVF4p+ZWMpryuhTwQaRXBjg5x2wQjtTAelHAWJnnVRfIQHw==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] KVM: X86: Allow userspace to define the microcode
 version
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CANRm+CwC-Zk4Uq7pYjD9vBW_J9EL0hntFCMtd5sUuYn=ztMRXg@mail.gmail.com>
Date: Mon, 26 Feb 2018 18:27:32 -0800
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Message-Id: <7DB6DFC7-AD62-4AA9-BDCE-141D7A4DDADA@gmail.com>
References: <1519694331-16368-1-git-send-email-wanpengli@tencent.com>
 <F68C9207-03D2-437F-981D-63FE9D5AA61A@gmail.com>
 <CANRm+CwC-Zk4Uq7pYjD9vBW_J9EL0hntFCMtd5sUuYn=ztMRXg@mail.gmail.com>
To: Wanpeng Li <kernellwp@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1R2RiL1030887

Wanpeng Li <kernellwp@gmail.com> wrote:

> 2018-02-27 9:30 GMT+08:00 Nadav Amit <nadav.amit@gmail.com>:
>> Wanpeng Li <kernellwp@gmail.com> wrote:
>> 
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>> 
>>> Linux (among the others) has checks to make sure that certain features
>>> aren't enabled on a certain family/model/stepping if the microcode version
>>> isn't greater than or equal to a known good version.
>>> 
>>> By exposing the real microcode version, we're preventing buggy guests that
>>> don't check that they are running virtualized (i.e., they should trust the
>>> hypervisor) from disabling features that are effectively not buggy.
>>> 
>>> Suggested-by: Filippo Sironi <sironi@amazon.de>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> Cc: Liran Alon <liran.alon@oracle.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> ---
>>> v2 -> v3:
>>> * remove the shifts
>>> * add the MSR_IA32_UCODE_REV version to the "feature MSRs"
>>> v1 -> v2:
>>> * add MSR_IA32_UCODE_REV to emulated_msrs
>>> 
>>> arch/x86/include/asm/kvm_host.h |  1 +
>>> arch/x86/kvm/x86.c              | 19 +++++++++++++++----
>>> 2 files changed, 16 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>> index 938d453..6e13f2f 100644
>>> --- a/arch/x86/include/asm/kvm_host.h
>>> +++ b/arch/x86/include/asm/kvm_host.h
>>> @@ -507,6 +507,7 @@ struct kvm_vcpu_arch {
>>>      u64 smi_count;
>>>      bool tpr_access_reporting;
>>>      u64 ia32_xss;
>>> +     u32 microcode_version;
>>> 
>>>      /*
>>>       * Paging state of the vcpu
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index d4985a9..00af28e 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -1058,6 +1058,7 @@ static unsigned num_emulated_msrs;
>>> static u32 msr_based_features[] = {
>>>      MSR_IA32_ARCH_CAPABILITIES,
>>>      MSR_F10H_DECFG,
>>> +     MSR_IA32_UCODE_REV,
>>> };
>>> 
>>> static unsigned int num_msr_based_features;
>>> @@ -1067,8 +1068,14 @@ static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
>>>      struct kvm_msr_entry msr;
>>> 
>>>      msr.index = index;
>>> -     if (kvm_x86_ops->get_msr_feature(&msr))
>>> -             return 1;
>>> +     switch (msr.index) {
>>> +     case MSR_IA32_UCODE_REV:
>>> +             rdmsrl(msr.index, msr.data);
>>> +             break;
>>> +     default:
>>> +             if (kvm_x86_ops->get_msr_feature(&msr))
>>> +                     return 1;
>>> +     }
>>> 
>>>      *data = msr.data;
>>> 
>>> @@ -2248,7 +2255,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>> 
>>>      switch (msr) {
>>>      case MSR_AMD64_NB_CFG:
>>> -     case MSR_IA32_UCODE_REV:
>>>      case MSR_IA32_UCODE_WRITE:
>>>      case MSR_VM_HSAVE_PA:
>>>      case MSR_AMD64_PATCH_LOADER:
>>> @@ -2256,6 +2262,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>      case MSR_AMD64_DC_CFG:
>>>              break;
>>> 
>>> +     case MSR_IA32_UCODE_REV:
>>> +             if (msr_info->host_initiated)
>>> +                     vcpu->arch.microcode_version = data;
>>> +             break;
>>>      case MSR_EFER:
>>>              return set_efer(vcpu, data);
>>>      case MSR_K7_HWCR:
>>> @@ -2551,7 +2561,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>              msr_info->data = 0;
>>>              break;
>>>      case MSR_IA32_UCODE_REV:
>>> -             msr_info->data = 0x100000000ULL;
>>> +             msr_info->data = (u64)vcpu->arch.microcode_version;
>> 
>> I think that the shifts are missing here (the version should be on the high
>> bits according to intel_get_microcode_revision() ).
> 
> You are right, it seems that we all miss it before.

Nah. I’m not that smart. It was ok on v2 ;-)
