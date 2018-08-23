Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E455DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7702147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGrWC+us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7702147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbeHWMBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:12 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37379 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeHWMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:11 -0400
Received: by mail-yb0-f195.google.com with SMTP id f145-v6so1720131ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bo3OsrIjyR/AXJ5T8kNtJnYGc9pmT7Uk1OoMBkQT1xs=;
        b=CGrWC+usv0+6d+w7VdzO+x8xA791Up7gzDTcfolflNlWUyCD1L+ZMK/E5NZvTyKPmr
         uy5b/FFUiCyN1RLK07L1dK/JHcyJem7p5k6eofiTmOW+BZKja5n8fSftoac/pQErsLws
         ZDG+R9+zpStpebncgA/0+fwkrgiEEbd0eeEiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bo3OsrIjyR/AXJ5T8kNtJnYGc9pmT7Uk1OoMBkQT1xs=;
        b=FSp9AH2W3X31A5HHvMLNEXmXhkBpYcGq7GWHWryVkbEp1JSd2rFXbqwhilNeaQdHh+
         jPpy3R59eJjCXVNja3xDz/SdFb1g6u2myizgF0ocEsv2Gm8hVCaABOkI1K3pvF+CZ6nB
         6M36/S5eZoKkCD+A0V8xyAKnn1n9DWdOxOoeFPvPgnK1Y3Y6zz4xgXY4rK4MfcIuywf0
         PXQbf5XN8PrtU3TIPCP4nGeC8Ciy2aieWEQ1Yxkpnxl8jhdm6moPDAYqS0yAsqihAFPy
         doVj0mfc/qchK042dLtuNbXnQsoiUxoO7WRHfPWvmaCT1wvQjY0BZqz6NiwktxFTqU5l
         nUwA==
X-Gm-Message-State: AOUpUlEN/asRumjhM5999Jdf9LrZq4w06T6gHVESFfP9PzyDAA1oVGki
        xVGbfeYh98K+ngLKpjNDquOsoVqzBx0=
X-Google-Smtp-Source: AA+uWPwS9TX7Sl3+TN3aJUvFfg/fdAIuqjlirs0yT9f5iyOEZX8dTxyRDOeTLsgS/Lzhi9VxTvIY0w==
X-Received: by 2002:a25:e482:: with SMTP id b124-v6mr30759991ybh.127.1535013157290;
        Thu, 23 Aug 2018 01:32:37 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id z125-v6sm4147003ywg.57.2018.08.23.01.32.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 01:32:35 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id j131-v6so1657816ywc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:32:35 -0700 (PDT)
X-Received: by 2002:a81:4418:: with SMTP id r24-v6mr2093958ywa.407.1535013154920;
 Thu, 23 Aug 2018 01:32:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 01:32:34
 -0700 (PDT)
In-Reply-To: <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
References: <20180822233724.110454-1-ndesaulniers@google.com>
 <20180823002508.GA822@nautica> <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Aug 2018 01:32:34 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
Message-ID: <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually exclusive
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 6:02 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Aug 22, 2018 at 5:25 PM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
>>
>> Overall looks good to me, just pointing at the same error I wrote in my
>> other mail here -- I saw that by the time I was done writing this this
>> patch got taken but that alone will probably warrant a follow-up :/
>
> I've fixed that manually, but when I tried to test it I just hit the
>
>   arch/x86/Makefile:179: *** Compiler lacks asm-goto support..  Stop.
>
> error.
>
> Do you have some experimental clang build with asm goto support? What
> version? Or is it just that you're building ARM, not x86?

FWIW, when I do Clang test builds lately[1], I've been using:

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang

(Note this requires a cross-compiled binutils installed in the PATH
with as aarch64-linux-gnu-*, which is where Debian and Ubuntu put
them.)

-Kees

[1] for today's defconfig build to finish, I had to:

./scripts/config -d CONFIG_ARM64_LSE_ATOMICS
(I think my binutils are old)

and comment out the BUILD_BUG_ON() in net/core/filter.c from 2dbb9b9e6df67
(which looks like it needs some attention since gcc has no problem with this)

-- 
Kees Cook
Pixel Security
