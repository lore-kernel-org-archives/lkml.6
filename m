Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD36C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AB820657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1ljjk1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AB820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJaAKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeJaAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:10:50 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775AE2080A;
        Tue, 30 Oct 2018 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540912616;
        bh=OAW+d5ZkGsIfxN8uBnAEwwVYdU9L9TDQp1wbGIMdkvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t1ljjk1d88FGBjpp9sOfyPcJaKeLXlR535NQVnBVz0unUs8lRi0tJ789OAhVHAwpJ
         w1kU1gJymptSfpnbinGCXaENtAq9wPupTGGJ11x7tm7lmr4PnUjut2V+HoxR1BYNMR
         7Rn2f/k8GL3PpNmffbL2C8gHXsGCvGP3BkiOH7qE=
Received: by mail-qt1-f181.google.com with SMTP id l41-v6so13864679qtl.8;
        Tue, 30 Oct 2018 08:16:56 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLZ8KJBIavMX686ssn7R7JHGe7iiMnRgO3qvjdcjQPuMFcxJoBE
        Jc3YKBs9u3OU35H4DcSpDuD47rRrCq3Vmpw4rQ==
X-Google-Smtp-Source: AJdET5f17LwMCUki0IshTwL00758sknMnd2itiisQYlpvfwjdNF+JAx/lsHJqLu3+tC9ytvGJ27q1s4ypvhrMjT7o7M=
X-Received: by 2002:aed:3ef1:: with SMTP id o46-v6mr690322qtf.26.1540912615689;
 Tue, 30 Oct 2018 08:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181029235206.30060-1-f.fainelli@gmail.com> <20181029235206.30060-5-f.fainelli@gmail.com>
In-Reply-To: <20181029235206.30060-5-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Oct 2018 10:16:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2u_J+F-+b=cL4ACtp70_zgvk_Q-HKOY=iqAD9gzxR-g@mail.gmail.com>
Message-ID: <CAL_Jsq+2u_J+F-+b=cL4ACtp70_zgvk_Q-HKOY=iqAD9gzxR-g@mail.gmail.com>
Subject: Re: [PATCH 4/6] of/fdt: Populate phys_initrd_start/phys_initrd_size
 from FDT
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
        gxt@pku.edu.cn, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 6:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> If the architecture implements ARCH_HAS_PHYS_INITRD, make the FDT
> scanning code populate the physical address of the start of the FDT and
> its size.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/init.c | 2 +-
>  drivers/of/fdt.c   | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 8f364aa24172..517e95cfb5d2 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -237,7 +237,7 @@ static void __init arm_initrd_init(void)
>         phys_addr_t start;
>         unsigned long size;
>
> -       /* FDT scan will populate initrd_start */
> +       /* FDT scan will populate initrd_start and phys_initrd_start */
>         if (initrd_start && !phys_initrd_size) {
>                 phys_initrd_start = __virt_to_phys(initrd_start);
>                 phys_initrd_size = initrd_end - initrd_start;
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 76c83c1ffeda..313cd4f24258 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -899,6 +899,10 @@ static void __early_init_dt_declare_initrd(unsigned long start,
>         initrd_start = (unsigned long)__va(start);
>         initrd_end = (unsigned long)__va(end);

As Ard pointed out, these __va() calls will BUG on arm64 if VM
debugging is enabled. Unless the arm64 folks want to remove that check
(probably not), I'm fine with a 'if (!IS_ENABLED(CONFIG_ARM64)) {'
conditional here.

>         initrd_below_start_ok = 1;
> +#ifdef CONFIG_ARCH_HAS_PHYS_INITRD
> +       phys_initrd_start = start;
> +       phys_initrd_size = end - start;
> +#endif
>  }
>  #endif
>
> --
> 2.17.1
>
