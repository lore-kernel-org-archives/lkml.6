Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F2C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED17220827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OZQbAhtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED17220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJ3Veo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:34:44 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:43314 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJ3Veo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:34:44 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9UCf5RL018438;
        Tue, 30 Oct 2018 21:41:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9UCf5RL018438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540903266;
        bh=YairTKVKKa5Ofh3V0oC7nmntUB8w6vB+j3hvWIgrl34=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OZQbAhtA0wZkrwpuuALWS+7IH/UDVnc+/8vIoV3/mpWAIOtMu5Hj7IkhDv+NKfxp/
         nEmAVFbywRBWKuFMLp66sKHLys1lyqhsTYPXElJ5AJ9t9gEWPmfpde+RHnoZqnmYPQ
         fheQ87JkY8odiyttli3jRscTD/HCdCK/8o6DYGaMYJVJkyzYloMWtiC+czQ7eDIkdw
         UduuFBb4xrCfvhtbWiV2P5vAKctX3YqFu0R3MdEp+0HH2X9pYvnYNJXl7miZUbNHm0
         iaCknZszfCqEJBzjt0Vgp9dUCs035ygGwG+Q+bOOFduODsiEBzrYxUAmrWasPzrIgJ
         OwSNNgLS+F1bA==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id u62so265266vkb.3;
        Tue, 30 Oct 2018 05:41:05 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLgMt3e8OxwxH0XnbnNNwVzfSnFiktPql5oAt1MolVtu3jP/Fpx
        kCT/bbkAH9atiB9QnTaEySIOCYiD1y/4UEdjGMU=
X-Google-Smtp-Source: AJdET5eEUF99L4FtC2VlzofrvfFd1ZV/6/+V52Td1Afdq8arw8wITWqX1xauzd2VFT59Ji2hh1utOYimeSPgwecHJyM=
X-Received: by 2002:a1f:c08e:: with SMTP id q136mr7771310vkf.84.1540903264092;
 Tue, 30 Oct 2018 05:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com> <877ehzk3we.fsf@concordia.ellerman.id.au>
In-Reply-To: <877ehzk3we.fsf@concordia.ellerman.id.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 30 Oct 2018 21:40:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
Message-ID: <CAK7LNASrdToqTrffe5XD+_LuK9+0=Bv8L_7ZWeN6iSivYe8Gmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 9:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 17be664..338e827 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)             += $(call cc-option,-mabi=elfv1)
> >  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)   += -mabi=elfv2
> >  endif
> >
> > -ifneq ($(cc-name),clang)
> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
> >    cflags-$(CONFIG_CPU_LITTLE_ENDIAN) += -mno-strict-align
> >  endif
> >
> > @@ -175,7 +175,7 @@ endif
> >  # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
> >  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
> > -ifneq ($(cc-name),clang)
> > +ifneq ($(CONFIG_CC_IS_CLANG),y)
> >  CC_FLAGS_FTRACE      += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
> >  endif
> >  endif
>
> Does this behave like other CONFIG variables, ie. it will not be defined
> when it's false?

Right.


> And if so can't we use ifdef/ifndef? eg:
>
> ifndef CONFIG_CC_IS_CLANG
>   CC_FLAGS_FTRACE       += $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>
> That reads cleaner to me.


OK, will do respin if you prefer ifdef/ifndef style.




> Still this patch is fine as is:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
> cheers



-- 
Best Regards
Masahiro Yamada
