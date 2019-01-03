Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F687C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C5120685
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="trUrQ4d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfACAgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:36:32 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:19857 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfACAgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:36:31 -0500
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x030aPQj019720;
        Thu, 3 Jan 2019 09:36:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x030aPQj019720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546475786;
        bh=mJlYWSiWeqCZq2fJPK7I50b08OCqBiH7PgNOiO8M/9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=trUrQ4d0GJhO3Ji00o7ysJnLg6IbdIjv2lH9K+fNm6Eb/JfGraqu85JH4j6bzHl2m
         03VekhKiMkvrMdhyPGYNohhgmp1GL1btms/aqNntGR8lgQDMl1mXwi38cgt5csr2ZL
         bR+LmhnkzW2aBblu2vFFN47lk1y8k7IkjAnKqWXbbQ02Ii1q7+NA0tL/g1PKSieA0x
         eW8n9yEj7GxC4V5AjKzyOYDnSbuC4YA8EMEsodcLQ9oYAmdVhXhsL1IXMc+a7lfPbQ
         ZTPu6riAnPWyy/IoqC04dxkNapSh5wlaMrZi3M6aTY5B6klUt8TQCiP4N4jOTmi2Mh
         2SB5SHKN4Mjnw==
X-Nifty-SrcIP: [209.85.221.181]
Received: by mail-vk1-f181.google.com with SMTP id 197so6948821vkf.4;
        Wed, 02 Jan 2019 16:36:26 -0800 (PST)
X-Gm-Message-State: AJcUukcqB7dWDGG4eXS6ksvNAXaP1JRzVn1bGrQDp6upF5v/Sw8LiXV+
        a+1nEOjmmUY0Bkdy9yCxKvP0w3uYqX6chpQmvzQ=
X-Google-Smtp-Source: ALg8bN5FKddHcrGWono5UpsMPLqZ5N1NpHGJZCSJ3hQLIGkLGFV1mgyHFxVQz3xse4vncUMh7jRcVM6IwDWcKpScUP8=
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr17035556vkn.0.1546475785253;
 Wed, 02 Jan 2019 16:36:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
In-Reply-To: <CA+icZUU=1S0Xg3+zWNU-60eknfWyL2kjEPm2BNNTK8Eu-tkTEg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Jan 2019 09:35:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWScb7Qt0kmV8RyBdix2GPA24gv=eRNYVWu5dGGePbfQ@mail.gmail.com>
Message-ID: <CAK7LNASWScb7Qt0kmV8RyBdix2GPA24gv=eRNYVWu5dGGePbfQ@mail.gmail.com>
Subject: Re: jump_label: move 'asm goto' support test to Kconfig
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        X86 ML <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 9:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> I was not aware that CONFIG_JUMP_LABEL Kconfig setting depends on the
> support of asm-goto.
>
> Currently, I am doing experiments with clang-7 and a snapshot of
> clang-8 on Linux/x86.
> These compilers have no asm-goto support.
>
> What is your recommendation for Linux >= v4.20?
> I am asking as it is possible to set CONFIG_JUMP_LABEL=y when
> compiling with clang - which has no effect.
> This is confusing.
>
> Thanks, this patch makes things clearer and protects users from
> setting "wrong" in the sense of non-functional settings.
>
> I have tested this against recent Linus tree where kbuild/kconfig Git
> pulls were latest commits.
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> [ x86 with LLVM/Clang
> v7 and v8 (snapshot) ]


Which part was tested?

x86 kernel cannot be compiled with Clang
since it lacks the asm-goto support.


$ make CC=clang
Compiler lacks asm-goto support.
arch/x86/Makefile:293: recipe for target 'checkbin' failed
make: *** [checkbin] Error 1






-- 
Best Regards
Masahiro Yamada
