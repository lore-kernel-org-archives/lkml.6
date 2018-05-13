Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeEMJJo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 05:09:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40424 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 05:09:43 -0400
MIME-Version: 1.0
Message-ID: <1712698c-9539-4d62-b92f-53c937b1749b@default>
Date: Sun, 13 May 2018 02:09:16 -0700 (PDT)
From: Liran Alon <liran.alon@oracle.com>
To: <kernellwp@gmail.com>
Cc: <rkrcmar@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <junaids@google.com>
Subject: Re: [PATCH 1/2] KVM: X86: Fix CR3 reserve bits
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8891 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805130095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4D99n3U011142


----- kernellwp@gmail.com wrote:

> 2018-05-13 16:28 GMT+08:00 Liran Alon <liran.alon@oracle.com>:
> >
> > ----- kernellwp@gmail.com wrote:
> >
> >> 2018-05-13 15:53 GMT+08:00 Liran Alon <liran.alon@oracle.com>:
> >> >
> >> > ----- kernellwp@gmail.com wrote:
> >> >
> >> >> From: Wanpeng Li <wanpengli@tencent.com>
> >> >>
> >> >> MSB of CR3 is a reserved bit if the PCIDE bit is not set in
> CR4.
> >> >> It should be checked when PCIDE bit is not set, however commit
> >> >> 'd1cd3ce900441 ("KVM: MMU: check guest CR3 reserved bits based
> on
> >> >> its physical address width")' removes the bit 63 checking
> >> >> unconditionally. This patch fixes it by checking bit 63 of CR3
> >> >> when PCIDE bit is not set in CR4.
> >> >>
> >> >> Fixes: d1cd3ce900441 (KVM: MMU: check guest CR3 reserved bits
> based
> >> on
> >> >> its physical address width)
> >> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> >> Cc: Radim Krčmář <rkrcmar@redhat.com>
> >> >> Cc: Junaid Shahid <junaids@google.com>
> >> >> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> >> >> ---
> >> >>  arch/x86/kvm/emulate.c | 4 +++-
> >> >>  arch/x86/kvm/x86.c     | 2 +-
> >> >>  2 files changed, 4 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> >> >> index b3705ae..b21f427 100644
> >> >> --- a/arch/x86/kvm/emulate.c
> >> >> +++ b/arch/x86/kvm/emulate.c
> >> >> @@ -4189,7 +4189,9 @@ static int check_cr_write(struct
> >> >> x86_emulate_ctxt *ctxt)
> >> >>                               maxphyaddr = eax & 0xff;
> >> >>                       else
> >> >>                               maxphyaddr = 36;
> >> >> -                     rsvd = rsvd_bits(maxphyaddr, 62);
> >> >> +                     if (ctxt->ops->get_cr(ctxt, 4) &
> >> X86_CR4_PCIDE)
> >> >> +                             new_val &= ~CR3_PCID_INVD;
> >> >> +                     rsvd = rsvd_bits(maxphyaddr, 63);
> >> >
> >> > I would prefer instead to do this:
> >> > if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
> >> >     rsvd &= ~CR3_PCID_INVD;
> >> > It makes more sense as opposed to temporary removing the
> >> CR3_PCID_INVD bit from new_val.
> >>
> >> It tries the same way
> >>
> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_virt_kvm_kvm.git_commit_-3Fid-3Dc19986fea873f3c745122bf79013a872a190f212&d=DwIFaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=Jk6Q8nNzkQ6LJ6g42qARkg6ryIDGQr-yKXPNGZbpTx0&m=r52WDgKBorUHwe_B_5Nw2Le_F_E0ne8lqqWW6n-3bSg&s=ufTcXvhhAMkY3XP6gAx-HiKCT8ynPWo2fs2z9DqCzM4&e=
> >> pointed out.
> >>
> >> Regards,
> >> Wanpeng Li
> >
> > Yes but there it makes sense as new CR3 value should not have bit 63
> set in vcpu->arch.cr3.
> 
> When X86_CR4_PCIDE == 0 and CR3 63 bit is set, a #GP is missing in
> your suggestion.
> 
> Regards,
> Wanpeng Li

Why?

I suggest the following change:
- rsvd = rsvd_bits(maxphyaddr, 62);
+ rsvd = rsvd_bits(maxphyaddr, 63);
+ if (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_PCIDE)
+     rsvd &= ~CR3_PCID_INVD;

In this case, if PCIDE=0 then bit 63 is set in rsvd and therefore check_cr_write() will emulate_gp() as needed.
