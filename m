Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C24C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79C4208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zWy1oTzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79C4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeISMPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbeISMPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:15:44 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677C5208A3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537339157;
        bh=wbSQYLEpKpdHxr4L1FJjqYwtI6pS5pYQ6bWf5FVsOkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zWy1oTzntiF73+kRu5HV0M5Czp4FCjw7f03kfuBIk+10DN07qRzpkgehNFSI7vP8h
         DnFYohk4qTTQG6HJPozDfdPurpR3IlsBKVvO0ggLnHvsKBaJPdyVG9eHUXgvO6FrnN
         drTNauW4aK1wfUThy94xZXoyq7i+o+au2abySnjU=
Received: by mail-wr1-f44.google.com with SMTP id v16-v6so4471597wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:39:17 -0700 (PDT)
X-Gm-Message-State: APzg51AG78OtlFjjt/s4OYQD12TF0iisMvlWcKsuwAPa1OjCyRAV1AnO
        3nXbMdd1Fp9KFsfBEO3GK+rPtDUaKgLi5s7SLOM=
X-Google-Smtp-Source: ANB0VdaiD59sZX9O4qO2El7qQIyTRtsWlymuf+Q8rerOHSw020D8LBphzzDbNFKn0R6acW8ARUjQCQ5Y/gXStUkJqLw=
X-Received: by 2002:adf:a299:: with SMTP id s25-v6mr2612134wra.100.1537339155837;
 Tue, 18 Sep 2018 23:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180918230756.26035-1-joel@jms.id.au>
In-Reply-To: <20180918230756.26035-1-joel@jms.id.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 19 Sep 2018 08:39:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd4dCyuXKxAz-V=ujtiuKcumHzAx28y5J+6m+L7ZRLsZQ@mail.gmail.com>
Message-ID: <CAJKOXPd4dCyuXKxAz-V=ujtiuKcumHzAx28y5J+6m+L7ZRLsZQ@mail.gmail.com>
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To:     joel@jms.id.au
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, oohall@gmail.com,
        linuxppc-dev@lists.ozlabs.org,
        Christophe LEROY <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 at 01:08, Joel Stanley <joel@jms.id.au> wrote:
>
> This partially reverts faa16bc404d72a5 ("lib: Use existing define with
> polynomial").
>
> The cleanup added a dependency on include/linux, which broke the PowerPC
> boot wrapper/decompresser when KERNEL_XZ is enabled:
>
>   BOOTCC  arch/powerpc/boot/decompress.o
>  In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>                  from arch/powerpc/boot/decompress.c:42:
>  arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>  linux/crc32poly.h: No such file or directory
>   #include <linux/crc32poly.h>
>            ^~~~~~~~~~~~~~~~~~~
>
> The powerpc decompressor is a hairy corner of the kernel. Even while building
> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> files from include/linux.

I fixed the build error here:
https://lkml.org/lkml/2018/8/29/179

If you choose to remove any includes from /linux, then go ahead but
please use original reported-by :)

Best regards,
Krzysztof

>
> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> We need to clean up the powerpc boot decompresser but that work will be
> more involved than we would include in a late -rc. Please consider
> merging this fix for 4.19. Thanks!
>
>  lib/xz/xz_crc32.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
> index 25a5d87e2e4c..34532d14fd4c 100644
> --- a/lib/xz/xz_crc32.c
> +++ b/lib/xz/xz_crc32.c
> @@ -15,7 +15,6 @@
>   * but they are bigger and use more memory for the lookup table.
>   */
>
> -#include <linux/crc32poly.h>
>  #include "xz_private.h"
>
>  /*
> @@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
>
>  XZ_EXTERN void xz_crc32_init(void)
>  {
> -       const uint32_t poly = CRC32_POLY_LE;
> +       const uint32_t poly = 0xEDB88320;
>
>         uint32_t i;
>         uint32_t j;
> --
> 2.17.1
>
