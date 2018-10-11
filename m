Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFED2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="O1MU0rO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFED2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJKWgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:36:51 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:42651 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJKWgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:36:51 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9BF8ics004603;
        Fri, 12 Oct 2018 00:08:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9BF8ics004603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539270524;
        bh=wbGlAsK+I2CVFkVwpxy3SfOoq+ve0v4GRtHGhevBRDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O1MU0rO5/5G5j3xTG1wmOrbIQj7/9b3dCajlnbWU/WytgZwxYZm5ADPvuTurMr0/t
         RyCEqhENJsuQwZ2jGBNu7atFrBK1o9AmfN0NOWquu7Rfi0Bi9alQ/H6CIelAuxWRHZ
         MQHvKIyicvmToJC6ZltovXo8zrB7Bb7pO3A5NZBTDaQmMZiVCCljzKQappVBLLhFgl
         +/AKhaiKLcOlyX0HPemYerp5iN5pzPacSXJZ6TLWkKtGdtn2MHuIagHcFNrSwUYzN6
         pNdZQYmLEf38Ixa5Pz5OJhIf/1yUMGhN/7p0F+CA550MX3o27zi1DPg3lw1yW6Jc2O
         uKdWaNdOccghw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id w85so8839217vsa.10;
        Thu, 11 Oct 2018 08:08:44 -0700 (PDT)
X-Gm-Message-State: ABuFfojgy6XxTjBOtOCU+drIg9Qw95VLf8oHUmr1Jsn7O047SO+Gg+xh
        litWWiWNFc5LjYnMOEjALoGdPRV5aRt78RQyOE0=
X-Google-Smtp-Source: ACcGV62uf9DPp90ay3k4X6inOE/IdTMTc+ddCwnwADvLBf0U6+RU4qA6YFuH8+CcQZZia9Wl1XV7K9Omr9lP+mmnWtQ=
X-Received: by 2002:a67:f1d2:: with SMTP id v18mr783341vsm.181.1539270523401;
 Thu, 11 Oct 2018 08:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181010222333.17794-1-bp@alien8.de> <CAK7LNAT2KpYkn=hj=h1XmbMJRdtgCQ__xP0X+Rpwm3e_Xs1brQ@mail.gmail.com>
 <20181011085234.GA25435@zn.tnic>
In-Reply-To: <20181011085234.GA25435@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Oct 2018 00:08:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=Kr1W6SfwojEVdwpKy7Au9NRh-wd2Qfo5+aVQVDe9ZQ@mail.gmail.com>
Message-ID: <CAK7LNAS=Kr1W6SfwojEVdwpKy7Au9NRh-wd2Qfo5+aVQVDe9ZQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fail the build early when no lz4 present
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 5:54 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Oct 11, 2018 at 01:26:23PM +0900, Masahiro Yamada wrote:
> > So, the cause of the failure is clear enough
> > from the build log.
>
> Sure but it wasts unnecessary build cycles and appears only after all
> the compilation units have been produced.


Not a waste of time.

Install lz4c, and run 'make' again.
Almost all objects have been built there,
so you will finish it soon.

If you are building up a compile-test machine,
you will probably need to install various tools anyway.

I do not want to add ugly checks in random places.


> > It is weird to check only lz4c.
> > If CONFIG_KERNEL_LZO is enabled, but lzop is not installed,
> > I see this log
> >
> >   LZO     arch/x86/boot/compressed/vmlinux.bin.lzo
> > /bin/sh: 1: lzop: not found
> >
> > It is still clear what to do, though.
>
> Right, we should test for that too. Unless distros start installing it
> by default. It is not installed by default on a debian guest here, at
> least.
>
> SLES15 either:
>
> $ lzop
> If 'lzop' is not a typo you can use command-not-found to lookup the package that contains it, like this:
>     cnf lzop
>
> > Is it necessary to check this earlier?
>
> Yes, see above.
>
> > If you get this error, you just need to install the tool.
> > Then, you can re-run the incremental build.
>
> Actually, I'd prefer the build to fail early so that machine can
> continue with the next build.
>
> > BTW, this patch has a drawback.
> >
> > [1] Enable CONFIG_KERNEL_LZ4 on the system
> >     without lz4c installed
> >
> > [2] Run 'make' and you will get the error
> >     "lz4 tool not found on this system but CONFIG_KERNEL_LZ4 enabled"
> >
> > [3] Run 'make menuconfig' and
> >     switch from CONFIG_KERNEL_LZ4 to CONFIG_KERNEL_GZIP
> >
> > [4] Run 'make' and you will still get the same error
> >     even after you have chosen to use GZIP instead of LZ4.
>
> Well, there's code in Makefile to refresh include/config/auto.conf but
> for whatever reason that make in step 4 doesn't run it.
>
> And *that* looks like a bug - if a user runs "make menuconfig" and
> .config gets updated, then include/config/auto.conf better get updated
> too. Right?

Not a bug.
include/config/auto.conf gets updates.

But the top Makefile is parsed twice
with a stale auto.conf, and with a fresh auto.conf

It is wrong to add $(error ...)
in the plain context in the top Makefile.



> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada
