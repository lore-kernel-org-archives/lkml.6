Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC5FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7E420893
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU+sqIj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7E420893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeIJTaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbeIJTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:30:05 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568942089C;
        Mon, 10 Sep 2018 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536590142;
        bh=VwD4VB4mc463qlRBNmS4+JtAy54cv2VmaVAhFmBiNm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aU+sqIj6voqeU/ldmscAB/w6c0sWp1jhCtw49nmHA10GUpQKSfBJX2IIgz8hK9wzZ
         vGGlY31+nUPkVrEjqc9J+qm2i9oUCWGtkkq15J91my+29eyISMVNlG0tYLC73WY8CD
         z8ulXWkztozM5rCFoaqwVjyq4cNajJAHB9GHG+8o=
Received: by mail-qt0-f179.google.com with SMTP id o15-v6so24344673qtk.6;
        Mon, 10 Sep 2018 07:35:42 -0700 (PDT)
X-Gm-Message-State: APzg51B4q0EDKthAN9m0v7/Quvtx1k1n3zNqOTxESxJIGCVT8/CYqS/f
        +iDmL/QOFz4abWkjgntS8DZD74wFhNYnInRwGQ==
X-Google-Smtp-Source: ANB0VdbtTO6ttnsb68A9Shh3FsJ20XorjkY40MHKBJzxvL5wuZEmvYvrH2k4z/tXtR4sV0+I2AcpnemaXLMcKJi/SIo=
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr16113770qto.188.1536590141286;
 Mon, 10 Sep 2018 07:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180905235327.5996-1-robh@kernel.org> <20180905235327.5996-7-robh@kernel.org>
 <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
In-Reply-To: <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Sep 2018 09:35:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKS+h0B5AuUh=vk0m1_7KSj4h2zZUo22rdt1w7oee=QwA@mail.gmail.com>
Message-ID: <CAL_JsqKS+h0B5AuUh=vk0m1_7KSj4h2zZUo22rdt1w7oee=QwA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 6:28 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> 2018-09-06 8:53 GMT+09:00 Rob Herring <robh@kernel.org>:
> > There is nothing arch specific about building dtb files other than their
> > location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> > The dependencies and supported targets are all slightly different.
> > Also, a cross-compiler for each arch is needed, but really the host
> > compiler preprocessor is perfectly fine for building dtbs. Move the
> > build rules to a common location and remove the arch specific ones. This
> > is done in a single step to avoid warnings about overriding rules.
> >
> > The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> > These pull in several dependencies some of which need a target compiler
> > (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> > All that is really needed is dtc, so adjust the dependencies to only be
> > dtc.
> >
> > This change enables support 'dtbs_install' on some arches which were
> > missing the target.
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Michal Marek <michal.lkml@markovi.net>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux-snps-arc@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: uclinux-h8-devel@lists.sourceforge.jp
> > Cc: linux-mips@linux-mips.org
> > Cc: nios2-dev@lists.rocketboards.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-xtensa@linux-xtensa.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Please ack so I can take the whole series via the DT tree.
> >
> > v2:
> >  - Fix $arch/boot/dts path check for out of tree builds
> >  - Fix dtc dependency for building built-in dtbs
> >  - Fix microblaze built-in dtb building
> >
> >  Makefile                          | 32 +++++++++++++++++++++++++++++++
> >  arch/arc/Makefile                 |  6 ------
> >  arch/arm/Makefile                 | 20 +------------------
> >  arch/arm64/Makefile               | 17 +---------------
> >  arch/c6x/Makefile                 |  2 --
> >  arch/h8300/Makefile               | 11 +----------
> >  arch/microblaze/Makefile          |  4 +---
> >  arch/microblaze/boot/dts/Makefile |  2 ++
> >  arch/mips/Makefile                | 15 +--------------
> >  arch/nds32/Makefile               |  2 +-
> >  arch/nios2/Makefile               |  7 -------
> >  arch/nios2/boot/Makefile          |  4 ----
> >  arch/powerpc/Makefile             |  3 ---
> >  arch/xtensa/Makefile              | 12 +-----------
> >  scripts/Makefile.lib              |  2 +-
> >  15 files changed, 42 insertions(+), 97 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 2b458801ba74..bc18dbbc16c5 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1212,6 +1212,32 @@ kselftest-merge:
> >                 $(srctree)/tools/testing/selftests/*/config
> >         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >
> > +# ---------------------------------------------------------------------------
> > +# Devicetree files
> > +
> > +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> > +dtstree := arch/$(SRCARCH)/boot/dts
> > +endif
> > +
> > +ifdef CONFIG_OF_EARLY_FLATTREE
> > +
> > +%.dtb %.dtb.S %.dtb.o: | dtc
> > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
>
> Hmm, I was worried about '%.dtb.o: | dtc'
> but seems working.
>
> Compiling %.S -> %.o requires objtool for x86,
> but x86 does not support DT.

Well, x86 does support DT to some extent. There's 2 platforms and the
DT unittests build and run on x86.

Actually, we can remove "%.dtb.S %.dtb.o" because we don't need those
as top-level build targets. Must have been a copy-n-paste relic from
before having common rules.

>
> If CONFIG_MODVERSIONS=y, scripts/genksyms/genksyms is required,
> %.dtb.S does not contain EXPORT_SYMBOL.

Okay, but that shouldn't affect any of this. We only build *.dtb.S
when doing built-in dtbs.

> BTW, 'dtc' should be a PHONY target.

Right, I found that too.

Rob
