Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8FA2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lquDG3xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8FA2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGJDst (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:48:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:30991 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeGJDsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:48:42 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w6A3mVSc023794;
        Tue, 10 Jul 2018 12:48:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w6A3mVSc023794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531194511;
        bh=iHHlyH7TsD8dZvCRpwNdq0+NZ48GC8u1aqhq5kW7td4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lquDG3xGyxv46fk6UStmSbjujrYK9oPdU/eV7rjPLyqT/bcU2A+kasj6da9tYhYzR
         ZGzJat4wTIVt+YFaehldpQbnKmpv4YejfTIxXGqYUKsWYNmanbWmG5JjgFSIi70cre
         Cfg5De+uWbIGmg5IgiMWirvfyVctl8+fjmuQrZk2NpaavLBc/9K+H046XbMZc1UJD/
         pI+J/AuAIaB5r8Ds+uZtJuUZdGW/KzHZNiERELJWA/d6DeFLajBiVq7jtvJKRIE8Cl
         92JIo4p/hrBMia3b79VWQ2tCa+OavkkWu94UWhdRCTUsT4UC79flrlRrZLlqzAEB+w
         B+q/XmX6C3Xcw==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id y8-v6so13096895uan.3;
        Mon, 09 Jul 2018 20:48:31 -0700 (PDT)
X-Gm-Message-State: APt69E2wwCRbkjSjFvO2iThaCuqFC7MrwAfYflgI3TapdzyzGA0v5L1w
        75xHHy+IapL+hD+CGxlSt6U2fK0mgsgr7gZsHoA=
X-Google-Smtp-Source: AAOMgpfGlb7A/Arjo8FUQFsR0i2XH+kH1t08+X/pnJuIFnmPiKLu8hxDuBwwzrWP1z7PH6HWLDV7WBF0nl+co+2jxSQ=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr14442889uai.17.1531194510341;
 Mon, 09 Jul 2018 20:48:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 20:47:49 -0700 (PDT)
In-Reply-To: <20180710022904.e3oql2ts4qz43bzo@treble>
References: <1531186516-15764-1-git-send-email-yamada.masahiro@socionext.com> <20180710022904.e3oql2ts4qz43bzo@treble>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 10 Jul 2018 12:47:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASM+81JkGu5-z8GRZ9+sRyd55gO0G0M5c54zRhE5JhE3g@mail.gmail.com>
Message-ID: <CAK7LNASM+81JkGu5-z8GRZ9+sRyd55gO0G0M5c54zRhE5JhE3g@mail.gmail.com>
Subject: Re: [PATCH v2] objtool: move libelf detection to Kconfig from Makefile
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-07-10 11:29 GMT+09:00 Josh Poimboeuf <jpoimboe@redhat.com>:
> On Tue, Jul 10, 2018 at 10:35:16AM +0900, Masahiro Yamada wrote:
>> Currently, users are allowed to enable STACK_VALIDATION regardless
>> of the compiler capability.  The top-level Makefile warns or breaks
>> the build if it turns out that the host compiler cannot link libelf.
>>
>> Move the libelf test to Kconfig so that users can enable the feature
>> only when the host compiler can build the objtool.  The ugly check
>> in the Makefile will go away.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
>
> Actually, looking at this again, I want to rescind my ack.
>
> This patches changes the behavior in a subtle (but important) way.
>
> Before, if I did "make defconfig", it would *always* choose the ORC
> unwinder.  Then, if I didn't have libelf-devel, the build would fail and
> it would tell me what I need to install.
>
> But now with this patch, if I do "make defconfig", the generated config
> actually changes based on what I happen to have installed on my build
> system.  If I don't have libelf-devel, then it silently chooses the
> non-default unwinder (frame pointer).
>
> This is a subtle difference, but IMO it's dangerous, because it will
> silently enable the frame pointer unwinder for the majority of new
> systems, even though it's not the default.
>
> I strongly prefer the original behavior, because we really want to
> encourage people to use the ORC unwinder, even if that means they have
> to install a package to build it.
>
> Also -- in general -- I suspect that silently changing the defaults like
> this will create a lot of bad surprises.  The output of "make defconfig"
> should be predictable and not dependent on what RPMs I happen to have
> installed.



Actually, we had similar discussion for stack protector.


First, Kees liked to let the build fail
instead of disabling the stack protector silently:

https://lkml.org/lkml/2018/2/9/697



Linus said:
But yes, I also reacted to your earlier " It can't silently rewrite it
to _REGULAR because the compiler support for _STRONG regressed."
Because it damn well can. If the compiler doesn't support
-fstack-protector-strong, we can just fall back on -fstack-protector.
Silently. No extra crazy complex logic for that either.

(https://lkml.org/lkml/2018/2/10/281)



I hope this is the same pattern.



-- 
Best Regards
Masahiro Yamada
