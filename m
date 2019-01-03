Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8746DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEA520879
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UmCqKHAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfACAbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:31:17 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:64661 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfACAbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:31:17 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x030UmVG024409;
        Thu, 3 Jan 2019 09:30:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x030UmVG024409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546475449;
        bh=wJNJlQ1cK2mWGUFA6G3MmhHeuNvOBH/uigqL79XWvgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UmCqKHAHnfixgC2REEgdauZdM84NVsTVil6kRGMV6W7YJQi6Vpc3TgMhWSbF+ZVaY
         hdQPA98L6xaPp986eF2PEcZS3Cbxjl0/8YWvyUeW+n7vZ7xVqSgNPpO8ZadsXoqsla
         2YhfeDyk55XV0qriy7RzunlXcXpeeXSCFIcmCwEhvoOckGuaXyZ/0iS/k6NeileKF3
         LxCq1ejPtLD+Sf88kc4Zvjg9f9TEjqYBYUgPYcljN/NdI6TzP0aFaf3cP89Tas4QEF
         UkOROdVYxiwmUQjwahfHXwEJbEIGcS+lVrEH8hWzeP57EMFtFN/A+D3iXgujecMwwd
         VQs/L+I6FcpZA==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id y14so6941729vky.9;
        Wed, 02 Jan 2019 16:30:49 -0800 (PST)
X-Gm-Message-State: AJcUukemC/eZ8Kxml5BbQ/7wLeVYA0JEDLvRAURvjcBc7KXztKzgkSoC
        LxE1tWq7FSUvouzhlqMc/CmP+DVTuiifepQS6JA=
X-Google-Smtp-Source: ALg8bN5H3sUJicOP3MkVl66MnFVZMFVO0475RHOVGj0xrEs+aZkoTZchHmAGOfNJY9cqH131f6nqcriUDLqB94N75O4=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr15597424vkd.64.1546475448072;
 Wed, 02 Jan 2019 16:30:48 -0800 (PST)
MIME-Version: 1.0
References: <1546173360-25573-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1546173360-25573-1-git-send-email-minipli@googlemail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Jan 2019 09:30:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNATr9N=e26QQ=ks7ub-YhDPX5tfy7LY41m5oLSXpLLxxLw@mail.gmail.com>
Message-ID: <CAK7LNATr9N=e26QQ=ks7ub-YhDPX5tfy7LY41m5oLSXpLLxxLw@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: lower alignment on ARM
To:     Mathias Krause <minipli@googlemail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 9:37 PM Mathias Krause <minipli@googlemail.com> wrote:
>
> As mentioned in the info pages of gas, the '.align' pseudo op's
> interpretation of the alignment value is architecture specific.
> It might either be a byte value or taken to the power of two.
>
> On ARM it's actually the latter which leads to unnecessary large
> alignments of 16 bytes for 32 bit builds or 256 bytes for 64 bit
> builds.
>
> Fix this by switching to '.balign' instead which is consistent
> across all architectures.
>
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>


Applied to linux-kbuild.
Thanks!


> ---
>  scripts/kallsyms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 109a1af7e444..77cebad0474e 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -334,10 +334,10 @@ static void write_src(void)
>         printf("#include <asm/types.h>\n");
>         printf("#if BITS_PER_LONG == 64\n");
>         printf("#define PTR .quad\n");
> -       printf("#define ALGN .align 8\n");
> +       printf("#define ALGN .balign 8\n");
>         printf("#else\n");
>         printf("#define PTR .long\n");
> -       printf("#define ALGN .align 4\n");
> +       printf("#define ALGN .balign 4\n");
>         printf("#endif\n");
>
>         printf("\t.section .rodata, \"a\"\n");
> --
> 2.19.2
>


-- 
Best Regards
Masahiro Yamada
