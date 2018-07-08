Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D5C6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E995208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 02:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ccv3pakT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E995208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeGHCE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 22:04:58 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:49916 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbeGHCE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 22:04:56 -0400
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com [209.85.217.181]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6824kZb032182;
        Sun, 8 Jul 2018 11:04:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6824kZb032182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531015487;
        bh=gzJgRCWpp+32aLEi/KigrvkVtgWXGZRzXrE1GVoQRuE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ccv3pakTwXF+t6GFCcKQAvaUeAmZAWN8f+2L+RnNOlWCH1JCKqR9I7qZEMUepjf57
         I1N+UOUdg9B7Tx5b7Xwq7yiVqFfq4OikZUYLte3NRXYEqp48w+U6sW3DrHr2Zme3Hn
         j0M+7GVF0etw6cPO81LRT1gSxYyhCkoo/0v248rTotJVtfBHT9EoI+SZhknK5SH56u
         dbWD61qaips6SSjzal3+CYZK5p7PW+QjmSz1ZDKzX1iVEXsOMWaf+eEB2JZ8hQ5HGG
         7/k9gmmHUJF29RIEt/wvUImEX1bRSehKzW9uo99+BTT5usUVD9a2nrIk1DDiYC6d+X
         4aELr0OkbrK7Q==
X-Nifty-SrcIP: [209.85.217.181]
Received: by mail-ua0-f181.google.com with SMTP id j17-v6so9778036uap.7;
        Sat, 07 Jul 2018 19:04:47 -0700 (PDT)
X-Gm-Message-State: APt69E3WhY7vT5qasFk71hHZ9ByEaWcO1PjcZ1xWAO8cRivshOmJsdjF
        ufKHaEWaRnbHfo9daBg6mbVfz7jMmOe5ROqKdUY=
X-Google-Smtp-Source: AAOMgpd6gmcWxrD+28KUmeiGs0iuyPy/ZMYzDZFHZGH4gelRHLG74TQFnaU9PrpLpJELEhjE3a0EW5qySg38HXAZfm8=
X-Received: by 2002:a9f:3d6e:: with SMTP id m46-v6mr9647321uai.17.1531015486078;
 Sat, 07 Jul 2018 19:04:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 19:04:05 -0700 (PDT)
In-Reply-To: <20180707001548.21854-1-kilobyte@angband.pl>
References: <20180707001548.21854-1-kilobyte@angband.pl>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 8 Jul 2018 11:04:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUhSo1WbgK0M1Xxh4ACGqLSh39oq+jDqcTA2byjNJ3cA@mail.gmail.com>
Message-ID: <CAK7LNARUhSo1WbgK0M1Xxh4ACGqLSh39oq+jDqcTA2byjNJ3cA@mail.gmail.com>
Subject: Re: [PATCH resend] scripts: teach extract-vmlinux about LZ4 and ZSTD
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-07 9:15 GMT+09:00 Adam Borowski <kilobyte@angband.pl>:
> Note that the LZ4 signature is different than that of modern LZ4 as we
> use the "legacy" format which suffers from some downsides like inability
> to disable compression.
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> The first time this was sent I managed to screw up both the subject and
> scissors line, so it's likely whatever filter you're using didn't notice
> the patch inside a thread.

Sorry for the delay.
Applied to linux-kbuild.  Thanks!



> ZSTD compression for vmlinux is not yet in, but being able to unpack it
> can't hurt.  LZ4 is in for quite a while.
>
>
>  scripts/extract-vmlinux | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
> index 5061abcc2540..e6239f39abad 100755
> --- a/scripts/extract-vmlinux
> +++ b/scripts/extract-vmlinux
> @@ -57,6 +57,8 @@ try_decompress '\3757zXZ\000' abcde unxz
>  try_decompress 'BZh'          xy    bunzip2
>  try_decompress '\135\0\0\0'   xxx   unlzma
>  try_decompress '\211\114\132' xy    'lzop -d'
> +try_decompress '\002!L\030'   xxx   'lz4 -d'
> +try_decompress '(\265/\375'   xxx   unzstd
>
>  # Bail out:
>  echo "$me: Cannot find vmlinux." >&2
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
