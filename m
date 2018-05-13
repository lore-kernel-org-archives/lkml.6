Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeEMI0B (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:26:01 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43875 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeEMIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:25:59 -0400
X-Google-Smtp-Source: AB8JxZqmJ0JuOpgrfcP0WKiqL/QFe+Xsk6ncF6cDtKXJoyl4QZpEx3SOUf0B3/f0j7DtbN+Np8XvllJ6eRf93FRtb8w=
MIME-Version: 1.0
In-Reply-To: <dface5bf-04f4-439a-86d1-df301eec1974@default>
References: <dface5bf-04f4-439a-86d1-df301eec1974@default>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sun, 13 May 2018 16:25:58 +0800
Message-ID: <CANRm+CxbK+9isOPOa3DLVG2TCnUaPJtNDj6BGy1Zfp0ik7Pk9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: X86: Fix CR3 reserve bits
To: Liran Alon <liran.alon@oracle.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D8Q8vg007611

2018-05-13 15:53 GMT+08:00 Liran Alon <liran.alon@oracle.com>:
>
> ----- kernellwp@gmail.com wrote:
>
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> MSB of CR3 is a reserved bit if the PCIDE bit is not set in CR4.
>> It should be checked when PCIDE bit is not set, however commit
>> 'd1cd3ce900441 ("KVM: MMU: check guest CR3 reserved bits based on
>> its physical address width")' removes the bit 63 checking
>> unconditionally. This patch fixes it by checking bit 63 of CR3
>> when PCIDE bit is not set in CR4.
>>
>> Fixes: d1cd3ce900441 (KVM: MMU: check guest CR3 reserved bits based on
>> its physical address width)
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Junaid Shahid <junaids@google.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>>  arch/x86/kvm/emulate.c | 4 +++-
>>  arch/x86/kvm/x86.c     | 2 +-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> index b3705ae..b21f427 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
>> @@ -4189,7 +4189,9 @@ static int check_cr_write(struct
>> x86_emulate_ctxt *ctxt)
>>                               maxphyaddr = eax & 0xff;
>>                       else
>>                               maxphyaddr = 36;
>> -                     rsvd = rsvd_bits(maxphyaddr, 62);
>> +                     if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
>> +                             new_val &= ~CR3_PCID_INVD;
>> +                     rsvd = rsvd_bits(maxphyaddr, 63);
>
> I would prefer instead to do this:
> if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
>     rsvd &= ~CR3_PCID_INVD;
> It makes more sense as opposed to temporary removing the CR3_PCID_INVD bit from new_val.

It tries the same way
https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=c19986fea873f3c745122bf79013a872a190f212
pointed out.

Regards,
Wanpeng Li

>
>>               }
>>
>>               if (new_val & rsvd)
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 87e4805..9a90668 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -863,7 +863,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned
>> long cr3)
>>       }
>>
>>       if (is_long_mode(vcpu) &&
>> -         (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 62)))
>> +         (cr3 & rsvd_bits(cpuid_maxphyaddr(vcpu), 63)))
>>               return 1;
>>       else if (is_pae(vcpu) && is_paging(vcpu) &&
>>                  !load_pdptrs(vcpu, vcpu->arch.walk_mmu, cr3))
>> --
>> 2.7.4
