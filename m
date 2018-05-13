Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeEMIyW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:54:22 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39632 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeEMIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:54:21 -0400
X-Google-Smtp-Source: AB8JxZpEyq3jYApjq8Tbl+WrRvZskduMmI7EwBPwSAHj6HcAFvXlK52rHOvsHCBxH+6QJRKqDIqD5ccl9nqTkbiGIo0=
MIME-Version: 1.0
In-Reply-To: <6c3c9a5b-ccf3-4702-8832-b44a98822966@default>
References: <6c3c9a5b-ccf3-4702-8832-b44a98822966@default>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sun, 13 May 2018 16:54:20 +0800
Message-ID: <CANRm+Cy59KBxNLFHTm1Ff2+uTOPZgEG_fyFJ-+zW6oEbSnUJEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: X86: Fix CR3 reserve bits
To: Liran Alon <liran.alon@oracle.com>
Cc: Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Junaid Shahid <junaids@google.com>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D8sUia011094

2018-05-13 16:28 GMT+08:00 Liran Alon <liran.alon@oracle.com>:
>
> ----- kernellwp@gmail.com wrote:
>
>> 2018-05-13 15:53 GMT+08:00 Liran Alon <liran.alon@oracle.com>:
>> >
>> > ----- kernellwp@gmail.com wrote:
>> >
>> >> From: Wanpeng Li <wanpengli@tencent.com>
>> >>
>> >> MSB of CR3 is a reserved bit if the PCIDE bit is not set in CR4.
>> >> It should be checked when PCIDE bit is not set, however commit
>> >> 'd1cd3ce900441 ("KVM: MMU: check guest CR3 reserved bits based on
>> >> its physical address width")' removes the bit 63 checking
>> >> unconditionally. This patch fixes it by checking bit 63 of CR3
>> >> when PCIDE bit is not set in CR4.
>> >>
>> >> Fixes: d1cd3ce900441 (KVM: MMU: check guest CR3 reserved bits based
>> on
>> >> its physical address width)
>> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> >> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> >> Cc: Junaid Shahid <junaids@google.com>
>> >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> >> ---
>> >>  arch/x86/kvm/emulate.c | 4 +++-
>> >>  arch/x86/kvm/x86.c     | 2 +-
>> >>  2 files changed, 4 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> >> index b3705ae..b21f427 100644
>> >> --- a/arch/x86/kvm/emulate.c
>> >> +++ b/arch/x86/kvm/emulate.c
>> >> @@ -4189,7 +4189,9 @@ static int check_cr_write(struct
>> >> x86_emulate_ctxt *ctxt)
>> >>                               maxphyaddr = eax & 0xff;
>> >>                       else
>> >>                               maxphyaddr = 36;
>> >> -                     rsvd = rsvd_bits(maxphyaddr, 62);
>> >> +                     if (ctxt->ops->get_cr(ctxt, 4) &
>> X86_CR4_PCIDE)
>> >> +                             new_val &= ~CR3_PCID_INVD;
>> >> +                     rsvd = rsvd_bits(maxphyaddr, 63);
>> >
>> > I would prefer instead to do this:
>> > if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
>> >     rsvd &= ~CR3_PCID_INVD;
>> > It makes more sense as opposed to temporary removing the
>> CR3_PCID_INVD bit from new_val.
>>
>> It tries the same way
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_virt_kvm_kvm.git_commit_-3Fid-3Dc19986fea873f3c745122bf79013a872a190f212&d=DwIFaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=Jk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=r52WDgKBorUHwe_B_5Nw2Le_F_E0ne8lqqWW6n-3bSg&s=ufTcXvhhAMkY3XP6gAx-HiKCT8ynPWo2fs2z9DqCzM4&e=
>> pointed out.
>>
>> Regards,
>> Wanpeng Li
>
> Yes but there it makes sense as new CR3 value should not have bit 63 set in vcpu->arch.cr3.

When X86_CR4_PCIDE == 0 and CR3 63 bit is set, a #GP is missing in
your suggestion.

Regards,
Wanpeng Li
