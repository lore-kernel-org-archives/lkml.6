Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23E1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A6D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="onLbbVqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfAKDIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:08:52 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:40059 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfAKDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:08:51 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x0B38e4v022464
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:08:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x0B38e4v022464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547176121;
        bh=gaxhBMrxiaTkXMhUzpaE+DTNWXXVNmnaKXsC40qFtKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=onLbbVqDsewx+dJ9dhcavantSpXLMJsvJxb0mOWAgUq9ELRXYYisaqrwiF0OwDzfi
         a4mkzcs2exr0+Ez6iy3eVleFl2vM5+OMiWXhhITSIqff34lb1o8hbhyRX/BY0WkGmO
         GF/pOW+Z6s4/logd0N9nWtztU7RjAiWTIU1XpIBnN464dj4Eac7ll8JC/d9kNYDCx0
         fZkIi8I5neipFaXsC4bG4xqA/V9ljUE/aur8K0eJ/frHfs+/Jby+FTl3ai/w5Re62f
         UMFMo/L4w9VDGcl/SGIdJ2xvPeprnmX82dnIa3ZsC8LGauoJogrPhtR69uRvQ49zIR
         GO+QLh6Aup+gg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id p9so4306733uaa.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 19:08:41 -0800 (PST)
X-Gm-Message-State: AJcUukfaP1WkAtoG2Z/V448USYPeRWM6aHEolxXunb1F8NtCzScuHlDx
        Tbb9yYoo3oKiN0BQPJI1gUVQsU/YouURHWY4PuE=
X-Google-Smtp-Source: ALg8bN5yNn7rtF3SmBrlBZKIYWH2L1cvvx8ESnDLVMX8f/PO9aEHv6ZgcrN1KSGSwBWHN0xOkI9BiiMhlb7+a6enrVQ=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr4854577uap.6.1547176120170;
 Thu, 10 Jan 2019 19:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20190110054216.74248-1-aik@ozlabs.ru>
In-Reply-To: <20190110054216.74248-1-aik@ozlabs.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 11 Jan 2019 12:08:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
Message-ID: <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
Subject: Re: [RFC PATCH kernel] powerpc/stack_protector: Fix external modules building
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 2:44 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> c3ff2a519 "powerpc/32: add stack protector support" addes stack protector
> support so now powerpc's "prepare" target depends on prepare0 (via
> stack_protector_prepare target).
>
> It works fine until we try build an external module where it fails with:
> Run: 'make -j128 SYSSRC=/home/aik/p/kernel SYSOUT=/home/aik/pbuild/kernel-le-pseries/ ARCH=powerpc'
> make[1]: Entering directory '/home/aik/p/kernel'
> make[2]: Entering directory '/home/aik/pbuild/kernel-le-pseries'
> make[2]: *** No rule to make target 'prepare0', needed by 'stack_protector_prepare'.  Stop.
>
> The reason for that is that the main Linux Makefile defines "prepare0"
> only if KBUILD_EXTMOD=="".
>
> This hacks powerpc's Makefile to make external modules build again.
>
> Fixes: c3ff2a519 "powerpc/32: add stack protector support"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
>
> It has been suggested that there is a better way of fixing this hence RFC.
>
>
> ---
>  arch/powerpc/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 488c9ed..0492f62 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -419,7 +419,11 @@ archheaders:
>  ifdef CONFIG_STACKPROTECTOR
>  prepare: stack_protector_prepare
>
> +ifeq ($(KBUILD_EXTMOD),)
>  stack_protector_prepare: prepare0
> +else
> +stack_protector_prepare:
> +endif


Honestly, I think this is ugly.

Do you want me to send an alternative solution?




>  ifdef CONFIG_PPC64
>         $(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
>  else
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
