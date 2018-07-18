Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516ECECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015E82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FiH4dq9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015E82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeGRGVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:21:51 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:51281 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeGRGVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:21:51 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w6I5jWRD009185
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:45:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w6I5jWRD009185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531892732;
        bh=CCPx7ULXruYllI3AGhlE49a6V+54D0cm+aCoQsBhgtQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FiH4dq9fTF1CLLZtLf55KbP2NLfWh0LWWlxcrTUefJh7FmQ42YQVlG5IrthTkf6ik
         vZgq3kZ3/MSA0Qnk0+1USCCgYzMbiGFSyH1zFpwzr1sQgOToXjXz8GeFVwNQGjIvte
         hxehUDNcWPGZA2jIk9I5V6xQm4hirT6M4HYnhR1TIvglS56odMXbAU5+rY9MRHnkpy
         sLTYSA0pWwtIuaVx3qYhwBRWhn7osUQv7WeBK8SRGB/hjMaTCteIXoItTqyBKg1OYU
         uqjC21Cwoy4BCjVs4EJWtsscpZuXVk+o0aCJhNnl97966ykAThjFd7t1B3y1P185PQ
         IWecux9jZJA3g==
X-Nifty-SrcIP: [209.85.217.176]
Received: by mail-ua0-f176.google.com with SMTP id i4-v6so2194767uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 22:45:32 -0700 (PDT)
X-Gm-Message-State: AOUpUlHdkUNR2jAgDPi15b5WuXcuiC2ZHVj92byVbPEJ464cAvoIxb8A
        fafuKQheF6r2m9UneFJMkAyIujnHs0p3PY5wZ5g=
X-Google-Smtp-Source: AAOMgpf3gOAD8j9L9bwq8+hY9r6p1pqNx3mDXHtsLnoR7JjVfzm7tyhbeOnQRM5Z+k8fZ+LSWSZ9X6Hh25T1o29YWxg=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr2978483uai.17.1531892731609;
 Tue, 17 Jul 2018 22:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 22:44:51
 -0700 (PDT)
In-Reply-To: <20180715225849.GB30102@gmail.com>
References: <20180715025626.GA48623@beast> <20180715225849.GB30102@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 18 Jul 2018 14:44:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQwEqzbYidax605HD+jQp7Fg45CY72pC2tgKZp3eOf-dA@mail.gmail.com>
Message-ID: <CAK7LNAQwEqzbYidax605HD+jQp7Fg45CY72pC2tgKZp3eOf-dA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Fix if_changed build flip/flop
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Dirk Gouders <dirk@gouders.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-16 7:58 GMT+09:00 Ingo Molnar <mingo@kernel.org>:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> The if_changed kbuild function can only be used once per target. If not
>> it will effectively always trigger, flipping back and forth between the
>> two commands getting recorded. Instead, merge the two commands into a
>> single function to get stable build artifacts (i.e. .vmlinux.cmd).
>>
>> Reported-by: Dirk Gouders <dirk@gouders.net>
>
> What actual symptoms does this bug have?
>
> I.e. it would be nice if the changelog started with such an explanation:
>
>   Dirk Gouders reported that .... <bad stuff happens during kernel build> ...
>   and bisected it back to:
>
>     98f78525371b ("x86/boot: Refuse to build with data relocations")
>
>   The root cause of the bug is that the if_changed kbuild function ...
>
> Or something like that.
>
> Thanks,
>
>         Ingo




Anyway, the code diff looks good to me.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
