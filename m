Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576E7208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576E7208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756419AbeFOSST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:18:19 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:52410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756390AbeFOSSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:18:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 3365C181D3417;
        Fri, 15 Jun 2018 18:18:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smile96_6507b8c1c283e
X-Filterd-Recvd-Size: 4128
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Jun 2018 18:18:14 +0000 (UTC)
Message-ID: <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Jun 2018 11:18:12 -0700
In-Reply-To: <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
References: <20180615174731.47588-1-mka@chromium.org>
         <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 11:04 -0700, Nick Desaulniers wrote:
> On Fri, Jun 15, 2018 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > 
> > update_permission_bitmask() negates u8 bitmask values and assigns them
> > to variables of type u8. Since the MSB is set in the bitmask values the
> > compiler expands the negated values to int, which then are assigned to
> > u8 variables. Cast the negated values back to u8.
> > 
> > This fixes several warnings like this when building with clang:
> > 
> > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> >   -Wconstant-conversion]
> >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> >        ~~                               ^~
> > 
> > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > doesn't seem to be universally enabled)

Perhaps it's better to turn off the warning.
There are more of these in the kernel too.

At least:
drivers/regulator/max8660.c:	u8 mask = (rdev_get_id(rdev) == MAX8660_V3) ? ~1 : ~4;
drivers/regulator/max8660.c:	u8 mask = (rdev_get_id(rdev) == MAX8660_V6) ? ~2 : ~4;
fs/ext4/resize.c:	__u16 uninit_mask = (flexbg_size > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;


> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/x86/kvm/mmu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index d634f0332c0f..a83817fdbd87 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -4275,11 +4275,11 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
> >                  */
> > 
> >                 /* Faults from writes to non-writable pages */
> > -               u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> > +               u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
> >                 /* Faults from user mode accesses to supervisor pages */
> > -               u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
> > +               u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
> >                 /* Faults from fetches of non-executable pages*/
> > -               u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
> > +               u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
> >                 /* Faults from kernel mode fetches of user pages */
> >                 u8 smepf = 0;
> >                 /* Faults from kernel mode accesses of user pages */
> > --
> > 2.18.0.rc1.244.gcf134e6275-goog
> > 
> 
> This fixes -Woverflow warnings in gcc and -Wconstant-conversion
> warnings in clang, without changing the disassembly.  Further
> modification to mka's test case (to show no change in codegen):
> https://godbolt.org/g/ynAoeJ
> 
> See also: https://wiki.sei.cmu.edu/confluence/display/c/EXP14-C.+Beware+of+integer+promotion+when+performing+bitwise+operations+on+integer+types+smaller+than+int
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> --
> Thanks,
> ~Nick Desaulniers
