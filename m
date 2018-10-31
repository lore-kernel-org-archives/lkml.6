Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A292C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E68B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuM12vBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E68B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbeJaV1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbeJaV1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:27:50 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F3B2084A;
        Wed, 31 Oct 2018 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540989000;
        bh=F4XYSwQ87Iv8kE/KuKlIGX5f7xm9Byt+q2ENG7vgeMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CuM12vBzu1k8Z6p1XeTIsL+NpJkmQ+SOJG/I7wMp7FbSGwGoOSPh/CbiHo6RE1Wd2
         DAajBP2NL8Do26aHUrN1NMFruQ8wl6VWRmpqu3o3jPcEFI4o9PAoDvMqwdmnjWWJP1
         uxFfBgxYoHJ5kVblx7P2B7cCdvM7axXjan2xcNr0=
Received: by mail-qt1-f169.google.com with SMTP id z2-v6so17432029qts.1;
        Wed, 31 Oct 2018 05:30:00 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKDSY0NLzzlzHC0rA92YanMyyOENrarEpybyfOy9DGgO1hje2uQ
        F+AgxdkgdhIC9t3/6hGDiedSDDSRCORfD5yYxg==
X-Google-Smtp-Source: AJdET5cJ+7kLxDZut61EBwuN1KLc6XAoy67xFVENfd4XjLBqviGlyDTs4xdJyLr5cP6i8vE8Vtctz1FGfj1h89pCSqI=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr2482903qts.144.1540988999663;
 Wed, 31 Oct 2018 05:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181030230721.28429-1-f.fainelli@gmail.com> <20181030230721.28429-6-f.fainelli@gmail.com>
In-Reply-To: <20181030230721.28429-6-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 31 Oct 2018 07:29:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKynGpg5fgVes2UQprc0Re7-Yp2_jRYfyGxQdse9zro7g@mail.gmail.com>
Message-ID: <CAL_JsqKynGpg5fgVes2UQprc0Re7-Yp2_jRYfyGxQdse9zro7g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] of/fdt: Remove custom __early_init_dt_declare_initrd()
 implementation
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        aryabinin@virtuozzo.com, Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>, ghackmann@android.com,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        chandan.vn@samsung.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        rppt@linux.ibm.com, Russell King <linux@armlinux.org.uk>,
        Greentime Hu <green.hu@gmail.com>, deanbo422@gmail.com,
        gxt@pku.edu.cn, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 6:07 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Now that ARM64 uses phys_initrd_start/phys_initrd_size, we can get rid
> of its custom __early_init_dt_declare_initrd() which causes a fair
> amount of objects rebuild when changing CONFIG_BLK_DEV_INITRD. In order
> to make sure ARM64 does not produce a BUG() when VM debugging is turned
> on though, we must avoid early calls to __va() which is what
> __early_init_dt_declare_initrd() does and wrap this around to avoid
> running that code on ARM64.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/include/asm/memory.h | 8 --------
>  drivers/of/fdt.c                | 9 +++++++--
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..dc3ca21ba240 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -168,14 +168,6 @@
>  #define IOREMAP_MAX_ORDER      (PMD_SHIFT)
>  #endif
>
> -#ifdef CONFIG_BLK_DEV_INITRD
> -#define __early_init_dt_declare_initrd(__start, __end)                 \
> -       do {                                                            \
> -               initrd_start = (__start);                               \
> -               initrd_end = (__end);                                   \
> -       } while (0)
> -#endif
> -
>  #ifndef __ASSEMBLY__
>
>  #include <linux/bitops.h>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index e34cb49231b5..f2b5becae96a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -892,15 +892,20 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
>  }
>
>  #ifdef CONFIG_BLK_DEV_INITRD
> -#ifndef __early_init_dt_declare_initrd
>  static void __early_init_dt_declare_initrd(unsigned long start,
>                                            unsigned long end)
>  {
> +       /* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
> +        * enabled since __va() is called too early. ARM64 does make use
> +        * of phys_initrd_start/phys_initrd_size so we can skip this
> +        * conversion.
> +        */
> +#if (!IS_ENABLED(CONFIG_ARM64))

Use 'if' not '#if'. Use C code rather than preprocessor whenever possible.

>         initrd_start = (unsigned long)__va(start);
>         initrd_end = (unsigned long)__va(end);
>         initrd_below_start_ok = 1;
> -}
>  #endif
> +}
>
>  /**
>   * early_init_dt_check_for_initrd - Decode initrd location from flat tree
> --
> 2.17.1
>
