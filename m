Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FADCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A7D20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vIlgq66v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A7D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbeISUga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:36:30 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:49838 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeISUga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:36:30 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w8JEvlck013213;
        Wed, 19 Sep 2018 23:57:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w8JEvlck013213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537369067;
        bh=dtUG84h5nZgiuksyt6J7DnZ3wXMHYQqz9KcmN1398X0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=vIlgq66vblFzmZDoDSJ3BTMD5q5egMsePfNQzi5luv09BlFpAbMJZ1GsRyCisfUDG
         yFfMbirVSQX6LqUX0rLkTp+dtguCXLyujANhV5NVW4WJov2Y8a0G91m+I5sdAsCxNu
         8AiwoYxQMhcNwMAdTCdV56PCu1S2iyAQ3JbGHzrFUTh099xVO8fXync0/iaxMedzvv
         u3J+LQ+nunNqkwJfjOgIZm2zDhrVxRLPbwfyCltRCMEO2ro5MzgGOUzSlVFONw15kx
         xcFQAnPAEhLLs/nZ2waRkcVWCg/EuXt9J3XpVlBpvbER2cO2MvBwhD0HfgVaZus+za
         uurYsN5kbZDpw==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id s17-v6so1193647vke.10;
        Wed, 19 Sep 2018 07:57:47 -0700 (PDT)
X-Gm-Message-State: APzg51Aefv3sgc3B2AxTP+FJOF428nHsZosSv/vmVJAr2DtvrsfP2UE/
        iVNCfuA0T+vaDgCy4Qe0x5xFTcyGDp94a0d3L9Y=
X-Google-Smtp-Source: ANB0VdYh4PfGo0ZFsnrPfj/6i0A97e2M410DKN9SrSdcz47kklPEALtUJ7jtTp9mqpguE+VW6xAUypCK11x2NVutf6A=
X-Received: by 2002:a1f:328a:: with SMTP id y132-v6mr8973221vky.84.1537369066365;
 Wed, 19 Sep 2018 07:57:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 07:57:05
 -0700 (PDT)
In-Reply-To: <CAKwvOd=CRw+5T6Us-Pw+t02PYWFEh=SM49C+28x7_oH+hcPOzQ@mail.gmail.com>
References: <20180918023157.23951-1-stefan@agner.ch> <CAKwvOd=CRw+5T6Us-Pw+t02PYWFEh=SM49C+28x7_oH+hcPOzQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 19 Sep 2018 23:57:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvCQ-uPYXFv4u4a0kk_yXoBWwHPmA-ggOr_NpQxz7Xrg@mail.gmail.com>
Message-ID: <CAK7LNASvCQ-uPYXFv4u4a0kk_yXoBWwHPmA-ggOr_NpQxz7Xrg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: allow to use GCC toolchain not in Clang search path
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-19 2:16 GMT+09:00 Nick Desaulniers <ndesaulniers@google.com>:
> On Mon, Sep 17, 2018 at 7:32 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> When using a GCC cross toolchain which is not in a compiled in
>> Clang search path, Clang reverts to the system assembler and
>> linker. This leads to assembler or linker errors, depending on
>> which tool is first used for a given architecture.
>>
>> It seems that Clang is not searching $PATH for a matching
>> assembler or linker.
>
> Yes, Clang uses what's called a sysroot, which is meant to be more
> hygenic than $PATH, IIUC.  This is surprising to folks familiar with
> $PATH, but really helps include the correct headers and use the
> correct toolchain when cross compiling, at the cost of freedom to put
> the cross toolchain wherever in the filesystem. (this is my
> understanding of sysroot, I just learned about it yesterday, so take
> this with a grain of salt).
>
>>
>> Make sure that Clang picks up the correct assembler or linker by
>> passing the cross compilers bin directory as search path.
>>
>> This allows to use Clang provided by distributions with GCC
>> toolchains not in /usr/bin.
>
> IIUC, its just utilities in binutils we're using (as, bfd.ld,
> objcopy), not GCC, but maybe that's just being pedantic.
>
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/78
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Nick, I removed your Reviewed-by since I had to change variable
>> assignment slightly...
>
> Yes, thank you, that's the right thing to do.
>
>>
>>  Makefile | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 4d5c883a98e5..d5de2db4b549 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -495,13 +495,15 @@ endif
>>  ifeq ($(cc-name),clang)
>>  ifneq ($(CROSS_COMPILE),)
>>  CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
>> -GCC_TOOLCHAIN  := $(realpath $(dir $(shell which $(LD)))/..)
>> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
>> +CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
>
> Yep: https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-b-dir
>
>> +GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>>  endif
>>  ifneq ($(GCC_TOOLCHAIN),)
>>  CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>>  endif
>> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
>> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
>> +KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>> +KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
>>  KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
>>  endif
>> --
>> 2.19.0
>>
>
> Thanks for this patch Stefan.
> Reviewed-and-tested-by: Nick Desaulniers <ndesaulniers@google.com>
> --
> Thanks,
> ~Nick Desaulniers




Applied to linux-kbuild/fixes. Thanks!

-- 
Best Regards
Masahiro Yamada
