Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA8AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640DD208E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640DD208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756588AbeFOSka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:40:30 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:33237 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756538AbeFOSk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:40:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 349DA180F2652;
        Fri, 15 Jun 2018 18:40:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dust47_3d78ab06fb33
X-Filterd-Recvd-Size: 3443
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Jun 2018 18:40:26 +0000 (UTC)
Message-ID: <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
From:   Joe Perches <joe@perches.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Jun 2018 11:40:25 -0700
In-Reply-To: <20180615182945.GN88063@google.com>
References: <20180615174731.47588-1-mka@chromium.org>
         <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
         <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
         <20180615182945.GN88063@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 11:29 -0700, Matthias Kaehlcke wrote:
> On Fri, Jun 15, 2018 at 11:18:12AM -0700, Joe Perches wrote:
> > On Fri, 2018-06-15 at 11:04 -0700, Nick Desaulniers wrote:
> > > On Fri, Jun 15, 2018 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > 
> > > > update_permission_bitmask() negates u8 bitmask values and assigns them
> > > > to variables of type u8. Since the MSB is set in the bitmask values the
> > > > compiler expands the negated values to int, which then are assigned to
> > > > u8 variables. Cast the negated values back to u8.
> > > > 
> > > > This fixes several warnings like this when building with clang:
> > > > 
> > > > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> > > >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> > > >   -Wconstant-conversion]
> > > >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> > > >        ~~                               ^~
> > > > 
> > > > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > > > doesn't seem to be universally enabled)
> > 
> > Perhaps it's better to turn off the warning.
> > There are more of these in the kernel too.
> > 
> > At least:
> > drivers/regulator/max8660.c:	u8 mask = (rdev_get_id(rdev) == MAX8660_V3) ? ~1 : ~4;
> > drivers/regulator/max8660.c:	u8 mask = (rdev_get_id(rdev) == MAX8660_V6) ? ~2 : ~4;
> > fs/ext4/resize.c:	__u16 uninit_mask = (flexbg_size > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;
> 
> In my experience neither clang nor gcc should promote these values to
> int, since the MSB/sign bit is not set.

Well, that is what the c90 standard requires.

6.5.3.3 Unary arithmetic operators
Constraints
4 The result of the ~ operator is the bitwise complement of its (promoted) operand (that is,
each bit in the result is set if and only if the corresponding bit in the converted operand is
not set). The integer promotions are performed on the operand, and the result has the
promoted type. If the promoted type is an unsigned type, the expression ~E is equivalent
to the maximum value representable in that type minus E.

> In any case I think it it preferable to fix the code over disabling
> the warning, unless the warning is bogus or there are just too many
> occurrences.

Maybe.

