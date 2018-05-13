Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeEMIo5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:44:57 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46500 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeEMIoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:44:55 -0400
X-Google-Smtp-Source: AB8JxZrRXZQt4NcTK/Z3dG4NA5w14hrevFs3/VYb/wm/Azlpzk414OdZajDgiZcJcBBhL1rA1N1pGKwTuLAwGkP1Sow=
MIME-Version: 1.0
In-Reply-To: <f0028b5a-101a-4f19-80b8-a00926bc68dd@default>
References: <f0028b5a-101a-4f19-80b8-a00926bc68dd@default>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sun, 13 May 2018 16:44:54 +0800
Message-ID: <CANRm+CzisB6YPW96k_WPMzJDZVLxQKGeHnC0Gr+QOcuN5gM_aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: X86: Fix loss of CR3_PCID_INVD bit when guest
 writes CR3
To: Liran Alon <liran.alon@oracle.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D8j0n4007677

2018-05-13 16:03 GMT+08:00 Liran Alon <liran.alon@oracle.com>:
>
> ----- kernellwp@gmail.com wrote:
>
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> SDM volume 3, section 4.10.4:
>>
>> * MOV to CR3. The behavior of the instruction depends on the value of
>> CR4.PCIDE:
>> — If CR4.PCIDE = 1 and bit 63 of the instruction’s source operand is
>> 1, the
>>   instruction is not required to invalidate any TLB entries or entries
>> in
>>   paging-structure caches.
>>
>> The CR3_PCID_INVD bit should not be removed if CR4.PCIDE = 1 when
>> guest writes
>> CR3, this patch fixes it.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Junaid Shahid <junaids@google.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kvm/x86.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 9a90668..438f140 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -849,11 +849,13 @@ EXPORT_SYMBOL_GPL(kvm_set_cr4);
>>
>>  int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>>  {
>> +     unsigned long cr3_check = cr3;
>> +
>>  #ifdef CONFIG_X86_64
>>       bool pcid_enabled = kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE);
>>
>>       if (pcid_enabled)
>> -             cr3 &= ~CR3_PCID_INVD;
>> +             cr3_check &= ~CR3_PCID_INVD;
>>  #endif
>>
>>       if (cr3 == kvm_read_cr3(vcpu) && !pdptrs_changed(vcpu)) {
>> @@ -863,7 +865,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned
>> long cr3)
>>       }
>>
>>       if (is_long_mode(vcpu) &&
>> -         (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
>> +         (cr3_check & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
>>               return 1;
>>       else if (is_pae(vcpu) && is_paging(vcpu) &&
>>                  !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
>> --
>> 2.7.4
>
> This commit doesn't seem correct to me.
>
> According to Intel SDM "MOV—Move to/from Control Registers":
> "If CR4.PCIDE = 1, bit 63 of the source operand to MOV to CR3 determines whether the instruction
> invalidates entries in the TLBs and the paging-structure caches
> (see Section 4.10.4.1, “Operations that Invalidate TLBs and Paging-Structure Caches,”
> in the Intel® 64 and IA-32 Architectures Software Developer’s Manual, Volume 3A).
> The instruction does not modify bit 63 of CR3, which is reserved and always 0."
>
> However, after this commit kvm_set_cr3() will update vcpu->arch.cr3 to have bit CR3_PCID_INVD set.
> Which is wrong as it should be reserved and always 0.

You are right, thanks Liran.

Regards,
Wanpeng Li
