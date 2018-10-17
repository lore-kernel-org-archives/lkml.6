Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE867C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D8B21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SIweLC/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D8B21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJQOkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:40:43 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:24908 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJQOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:40:42 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w9H6kJwM023303;
        Wed, 17 Oct 2018 15:46:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9H6kJwM023303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539758780;
        bh=L1ip7ws1mlpqaf3W4jOk4dT8WrLZ31ncmusDyWOuTYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SIweLC/HSwnb/ux3Vt9Llk2CaML7U0t38Xt0HFAy3QDMjfIw9pPEO1ziKRsEfTxfS
         IhuZCYNuPVCZIL931xA9zKfJeXL+oid1MTfoTLq3ifnevRAvPPVfHwtszwlJbHXO8M
         RytRuXccQbQ6njKWnnSsTOA3uSUT6Oxu/WG2kCgLgYwTBPCaIo6Z0UqLD/lNf3v/V4
         2yH4zcPxKT2wD8cE+JAdc4tnVkGcAEM+THkfwPj61zwKkxXCrJoqfd/jP9Okfta7HY
         nn+593OWr7rglRO76HNprC/AIFmEQ511VWj/3Pw4Hd0Cb4fnOaaEG2+YtozrM4P5ta
         84P0rNA2NhKFA==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id l65so6084593vki.8;
        Tue, 16 Oct 2018 23:46:20 -0700 (PDT)
X-Gm-Message-State: ABuFfoh/aaN5Tb6iDHh5pQ/5we8YArKXFqHIT7TU7SfyKneG1K499Qx1
        b3/91fFmjPnoppsKJ1fweAxnSUVXxop+P4l+Onw=
X-Google-Smtp-Source: ACcGV60+d3DS0QUtTce10o4CbhSqHjKQm1pPy/1O/bIpoWa+BYLlGFnjz9HbrWyYVEMNXRorLdVUHTPeXnZlMlNyOPo=
X-Received: by 2002:a1f:5503:: with SMTP id j3-v6mr9879581vkb.34.1539758778912;
 Tue, 16 Oct 2018 23:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181016060324.GA10928@ls3530.fritz.box>
In-Reply-To: <20181016060324.GA10928@ls3530.fritz.box>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Oct 2018 15:45:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgmjZ53x240HH7ktOS0oqPiO5drkN2E74zUkdwuBmybg@mail.gmail.com>
Message-ID: <CAK7LNAQgmjZ53x240HH7ktOS0oqPiO5drkN2E74zUkdwuBmybg@mail.gmail.com>
Subject: Re: [PATCH] extract-vmlinux: Check for uncompressed image as fallback
To:     Helge Deller <deller@gmx.de>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        dave.anglin@bell.net, corentincj@iksaif.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,



On Tue, Oct 16, 2018 at 3:06 PM Helge Deller <deller@gmx.de> wrote:
>
> As on x86-64 and other architectures, the boot kernel on parisc (vmlinuz
> and bzImage) contains a full compressed copy of the final kernel
> executable (vmlinux.bin.gz), which one should be able to extract with
> the extract-vmlinux script.
>
> But on parisc extracting the kernel with extract-vmlinux fails.
> Currently the script first checks if the given file is an ELF file
> (which is true on parisc) and if so returns it.  Thus on parisc we
> unexpectedly get back the vmlinuz boot file instead of the uncompressed
> vmlinux image.
>
> This patch fixes this issue by reverting the logic. It now first tries
> to find a compression signature in the given file and if that fails it
> checks the file itself as fallback.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
> index e6239f39abad..85e1f32fb4a0 100755
> --- a/scripts/extract-vmlinux
> +++ b/scripts/extract-vmlinux
> @@ -48,9 +48,6 @@ fi
>  tmp=$(mktemp /tmp/vmlinux-XXX)
>  trap "rm -f $tmp" 0
>
> -# Initial attempt for uncompressed images or objects:
> -check_vmlinux $img
> -

This patch looks good in general,
but, I just wondered why this line is needed.

If I understand this correctly,
when vmlinux itself is passed to this script,
it is returned as-is.
But, we already have what we want in this case.

We can simply drop this code if there is no good reason.

CC'ed the submitter of this script, Corentin Chary
in case he knows something.


>  # That didn't work, so retry after decompression.
>  try_decompress '\037\213\010' xy    gunzip
>  try_decompress '\3757zXZ\000' abcde unxz
> @@ -60,5 +57,8 @@ try_decompress '\211\114\132' xy    'lzop -d'
>  try_decompress '\002!L\030'   xxx   'lz4 -d'
>  try_decompress '(\265/\375'   xxx   unzstd
>
> +# Finally check for uncompressed images or objects:
> +check_vmlinux $img
> +
>  # Bail out:
>  echo "$me: Cannot find vmlinux." >&2




--
Best Regards
Masahiro Yamada
