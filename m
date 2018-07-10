Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2255208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2255208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbeGJJa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:30:58 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:52132 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeGJJaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:30:55 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id C9148C0135
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:30:53 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id BB9F4C0EBA; Tue, 10 Jul 2018 11:30:52 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 9CEE2C0E8E;
        Tue, 10 Jul 2018 11:30:46 +0200 (CEST)
Message-ID: <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Jul 2018 11:30:39 +0200
In-Reply-To: <20180710090125.GA28924@arm.com>
References: <20180709200956.31158-1-labbott@redhat.com>
         <20180710090125.GA28924@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> Thanks, Laura.
> 
> I'll take this as a fix, and add a comment to the Makefile to justify
> why we need the linux target.

So this comes down to either breaking fedora/debian toolchains (that
don't support elf emulation mode) or breaking bare-metal toolchains
(that don't support linux emulation mode).

Since Linux is a bare-metal project that does not technically require
the linux target (who said using "Linux" for all things is confusing?),
I think it should aim for the elf target in the long term.

But well, breaking Linux build in common distros isn't good either, so I
guess it makes sense to revert this while distros toolchains are being
fixed. Hopefully, it won't take too long.

What do you think?

Cheers,

Paul

> Will
> 
> On Mon, Jul 09, 2018 at 01:09:56PM -0700, Laura Abbott wrote:
> > This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.
> > 
> > This breaks compilation with Fedora gcc-8 tool chains:
> > 
> >   CHK     include/generated/compile.h
> >   LD [M]  arch/arm64/crypto/sha512-ce.o
> > aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
> > make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
> > make: *** [Makefile:1029: arch/arm64/crypto] Error 2
> > 
> > Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > A bit rushed and I'm still debugging but I wanted to send this out
> > before anyone else gets hit since it is -rc4. Seeing this on both native
> > and cross compiles.
> > ---
> >  arch/arm64/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 7976d2d242fa..f476d52ad8d6 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
> >  KBUILD_CPPFLAGS	+= -mbig-endian
> >  CHECKFLAGS	+= -D__AARCH64EB__
> >  AS		+= -EB
> > -LDFLAGS		+= -EB -maarch64elfb
> > +LDFLAGS		+= -EB -maarch64linuxb
> >  UTS_MACHINE	:= aarch64_be
> >  else
> >  KBUILD_CPPFLAGS	+= -mlittle-endian
> >  CHECKFLAGS	+= -D__AARCH64EL__
> >  AS		+= -EL
> > -LDFLAGS		+= -EL -maarch64elf
> > +LDFLAGS		+= -EL -maarch64linux
> >  UTS_MACHINE	:= aarch64
> >  endif
> >  
> > -- 
> > 2.17.1
> > 
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
