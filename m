Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D15BC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD57208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZQ+0yDjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD57208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGHWNZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 18:13:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:46319 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754369AbeGHWNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 18:13:24 -0400
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com [209.85.213.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w68MDI9g006852;
        Mon, 9 Jul 2018 07:13:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w68MDI9g006852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531087999;
        bh=e3vn/4oqRCK5+lBsvp5zOY53TuZCOL9bzTR133NKMRM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZQ+0yDjMvp5GnxlRaLaImL0P63Lz5l+aSCtBOKRDrvglLqI+7Cr9BhNxUmaT2oOFy
         +qfEbr9pp6Gn1yHLKr7QQBUsRyuzLfdAHRcA7wPb8OsTt2rAx4ICfGJCWZ+642MccG
         OrmmBuShT8rsJDZiKS2tvmCbhdWw4/ycimRuXnqJGEtoF31onwgoZ4Lvc+reF+77hg
         pqRupjbK5jREpk6oW25CcuIR4R3oWGqe66A4XlqnKd+sBEZfsgEenKO0XxjUByhlNT
         R8qNVBJA1gsVfd1pZAOdub6RjjPJ42edjAJoGFv25W1vA1uH/nJQxLL2Vi+Zy906kh
         9TVgmv/MyJnNw==
X-Nifty-SrcIP: [209.85.213.48]
Received: by mail-vk0-f48.google.com with SMTP id l143-v6so2096734vke.1;
        Sun, 08 Jul 2018 15:13:18 -0700 (PDT)
X-Gm-Message-State: APt69E2ANQGfWnHlRIIWkORnPRw+GwC0dvdawAwHsHCgNM9AQTqVy65C
        9ykbYxogutnKWW9hI1+N19ATkdfOEq1uNTDDEyU=
X-Google-Smtp-Source: AAOMgpcX0Bm+JmuOfAukgxfJF4SfNVyVG07tv6N52t6goJh8wnX8NOfOsxK709zNFvAX9hK91w/+uN4I1gwRuKd65+o=
X-Received: by 2002:a1f:9807:: with SMTP id a7-v6mr10208821vke.65.1531087997685;
 Sun, 08 Jul 2018 15:13:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 15:12:37 -0700 (PDT)
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 9 Jul 2018 07:12:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASo7pnL32dFqdxmKqCLkBsJwGOaTHXX=rVjpi2-Y=t0Aw@mail.gmail.com>
Message-ID: <CAK7LNASo7pnL32dFqdxmKqCLkBsJwGOaTHXX=rVjpi2-Y=t0Aw@mail.gmail.com>
Subject: Re: [PATCHv6 0/4] Salted build ids via ELF notes
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Wielaard <mjw@fedoraproject.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Cary Coutant <ccoutant@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-06 9:49 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> Hi,
>
> This is v6 of the series to allow unique build ids. v6 is mostly minor
> fixups and Acks for this to go through the kbuild tree.


Applied to linux-kbuild. Thanks!


> Thanks,
> Laura
>
> Laura Abbott (4):
>   kbuild: Add build salt to the kernel and modules
>   x86: Add build salt to the vDSO
>   powerpc: Add build salt to the vDSO
>   arm64: Add build salt to the vDSO
>
>  arch/arm64/kernel/vdso/note.S     |  3 +++
>  arch/powerpc/kernel/vdso32/note.S |  3 +++
>  arch/x86/entry/vdso/vdso-note.S   |  3 +++
>  arch/x86/entry/vdso/vdso32/note.S |  3 +++
>  include/linux/build-salt.h        | 20 ++++++++++++++++++++
>  init/Kconfig                      |  9 +++++++++
>  init/version.c                    |  3 +++
>  scripts/mod/modpost.c             |  3 +++
>  8 files changed, 47 insertions(+)
>  create mode 100644 include/linux/build-salt.h
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
