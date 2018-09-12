Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CCC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABD720882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0rAEFHrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABD720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeILR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:58:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62451 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:58:39 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w8CCs0ws031685;
        Wed, 12 Sep 2018 21:54:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w8CCs0ws031685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536756841;
        bh=XbsQWCQzElsxkshqGbbdxeWP7ZqQ0+ritqywkLOfxBI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=0rAEFHrptKN35VTmngB6bwlH0s1cmPDQeLwBFEPJQ++J8fIL+dQ8K32ub0A7TxxED
         QpFQXF4E83jWuQG3VDZWv2WoDNFGiC+t0foLhaZjn8RP4cadnu63TsXcUl7oRQGLwP
         jdkR2mu0/N81jyBQW9/wZtfdFAEy2C15Ik30C+LwEiLldnJiuQ0wa9O5/gd379Pgy3
         cLDqa1Uu9kF/IZLpw3Q18GN3zpHmCneS/FZF6lppZHq75ioKZBU0CGvYlXa1q+vAmR
         cbfvIfX0hZcOxk3HZYLxno6ZbCf/d/dKVpftymyE78FxRWt1CjVMHoq3QzvXoXFLxj
         VCi6w6y3w87cg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id m11-v6so1527121uao.11;
        Wed, 12 Sep 2018 05:54:00 -0700 (PDT)
X-Gm-Message-State: APzg51Ap6RuAD20B1aOQKuyLftfOzUQ35xQV2bPkDCXSCuSixe9dSqmG
        iLnpPwP7B0FtEh6Hds27uHvTJgDHLbYzHXFPmlE=
X-Google-Smtp-Source: ANB0VdbZvLubEup2qRuAKzfWzqBH3Ls2aXNj6m3L2lrqHEHewAHP5aSqmqzknMz+hs5IcUDoQQUyNxpscfvTRg1T55s=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr711599uah.135.1536756839890;
 Wed, 12 Sep 2018 05:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 05:53:19
 -0700 (PDT)
In-Reply-To: <0854f35e92c95e552721dc6a46f4ee2bc4020bc1.camel@synopsys.com>
References: <0854f35e92c95e552721dc6a46f4ee2bc4020bc1.camel@synopsys.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 12 Sep 2018 21:53:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0ghuhDXUqJ=nX0dtbtoOvFff9Eeu-hHWLkTONG09GAQ@mail.gmail.com>
Message-ID: <CAK7LNAR0ghuhDXUqJ=nX0dtbtoOvFff9Eeu-hHWLkTONG09GAQ@mail.gmail.com>
Subject: Re: defconfig fails if CROSS_COMPILE is set while cross-gcc is not avaialble
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey.

2018-09-12 21:08 GMT+09:00 Alexey Brodkin <Alexey.Brodkin@synopsys.com>:
> Hello Masahiro-san,
>
> Starting from kernel v4.17 it is no longer possible to install kernel headers
> for ARC architecture if there's no cross-toolchain in PATH.


Really?

I can do 'make ARCH=arc headers_install'
with the latest Linus' tree.

I see the following warnings, but possible to install kernel headers.

./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found


If ARC compiler is not found in PATH,
those warnings are displayed with v4.16 or older as well.

I do not see much difference in the behavior.


I am trying to fix even those warnings
by eliminating unneeded compiler invocation.  It is WIP.



> Note installation of headers is just one of use-cases when we might not
> have cross-tools available but still want to run "make xxx_defconfig".
> I.e. the problem is "make xxx_defconfig" with no cross-toolchain.
>
> That's what I see:
> ----------------------------->8--------------------------
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> make: arc-linux-gcc: Command not found
> /bin/sh: arc-linux-gcc: command not found
> /bin/sh: arc-linux-gcc: command not found
> *** Default configuration is based on 'nsim_700_defconfig'
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 29: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 26: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: arc-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 29: arc-linux-gcc: command not found
> init/Kconfig:17: syntax error
> init/Kconfig:16: invalid option
> ./scripts/clang-version.sh: line 15: arc-linux-gcc: command not found
> ./scripts/gcc-plugin.sh: line 11: arc-linux-gcc: command not found
> make[1]: *** [scripts/kconfig/Makefile:91: defconfig] Error 1
> make: *** [Makefile:531: defconfig] Error 2
> ----------------------------->8--------------------------
>
> That doesn't happen for ARM and other arches simply because for ARC
> we define CROSS_COMPILE if it is not set by user, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arc/Makefile#n9

I do not think it is a good practice
to forcibly set CROSS_COMPILE that users may not have.

arch/m68k/Makefile uses cc-cross-prefix helper
to set the first found compiler.


> Still if CROSS_COMPILE is set before execution of "make defconfig"
> then the same problem happens for others.
>
> I was able to find a series of commits which cause this problem,
> here they are:
> ----------------------------->8--------------------------
> 59f53855babf - gcc-plugins: test plugin support in Kconfig and clean up Makefile
> 469cb7376c06 - kconfig: add CC_IS_CLANG and CLANG_VERSION
> a4353898980c - kconfig: add CC_IS_GCC and GCC_VERSION
> ----------------------------->8--------------------------
>
> What happen is "$(CC)" is passed as an argument and in its turn CC is
> "$(CROSS_COMPILE)gcc", see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n385
>
>
> So if I substitute "CC" with "HOSTCC" in a couple of places (see below)
> the problem goes away. But I'm not really sure if what I do is correct.
> I.e. when we're interested in CC for target and when only host CC is of
> our interest.

I think the log of commit 316d55d55f49eca44
is a good source to know the background of this change.

Now Kconfig requires the target compiler.
So, it does not make sense to
do defconfig with non-existing compiler.



> Would be interesting to know your opinion here.

I'd recommend to not hard-code CROSS_COMPILE.



Thanks.

-- 
Best Regards
Masahiro Yamada
