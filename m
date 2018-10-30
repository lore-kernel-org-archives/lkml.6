Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92FEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E932204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C62qNvxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E932204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJaAFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeJaAFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:05:05 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D169E208A3;
        Tue, 30 Oct 2018 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540912273;
        bh=j55T4BEsJzj3tXD1UP5KA33jRJgXefZZn+fGyA8xjg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C62qNvxYZQXtRCdhG0QnCW1N7Nr9Ui/ZHAs8B6oCE60FaF+sTWPp88ZSJyqz3R0yt
         wZwE8LQSej/WePwqM+P+LeQutk5yGH3UGGOM+rTz9PneLvTIOaSfU2xEjbhZbBO9qe
         +3ckNo+yeJ50++yRQd5g8DtzE9NqvMAwKEo2vnCw=
Received: by mail-qk1-f171.google.com with SMTP id p3-v6so7457447qkb.5;
        Tue, 30 Oct 2018 08:11:12 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLTizJdwbdihqGbv0cZqO4u2H78O71CcZ+VsmqHvcaf750dS0d+
        lOMd2WpPm1a/+2LTVHrMvDB6LB5qG4bpU3vsLg==
X-Google-Smtp-Source: AJdET5dfew/O2cSjnjEFdI14pEjXvr+Q1enSTEjNC6+bvQ/Tqc9t8rEDW/bzvjzfPY3MgHoZTrWyotkQ5a+m6X2XpI8=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr16541988qkg.147.1540912271915;
 Tue, 30 Oct 2018 08:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181029235206.30060-1-f.fainelli@gmail.com> <20181029235206.30060-3-f.fainelli@gmail.com>
In-Reply-To: <20181029235206.30060-3-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 30 Oct 2018 10:10:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKrrmMOQrV62L0QXAPiLGceMbvA7HZ=1U3PW0_MpqtC=w@mail.gmail.com>
Message-ID: <CAL_JsqKrrmMOQrV62L0QXAPiLGceMbvA7HZ=1U3PW0_MpqtC=w@mail.gmail.com>
Subject: Re: [PATCH 2/6] arch: Make phys_initrd_start and phys_initrd_size
 global variables
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
> Make phys_initrd_start and phys_initrd_size global variables that will
> later be referenced by generic code under drivers/of/fdt.c.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mm/init.c       | 4 ++--
>  arch/unicore32/mm/init.c | 4 ++--
>  include/linux/initrd.h   | 3 +++
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 0cc8e04295a4..8f364aa24172 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -51,8 +51,8 @@ unsigned long __init __clear_cr(unsigned long mask)
>  }
>  #endif
>
> -static phys_addr_t phys_initrd_start __initdata = 0;
> -static unsigned long phys_initrd_size __initdata = 0;
> +phys_addr_t phys_initrd_start __initdata = 0;
> +unsigned long phys_initrd_size __initdata = 0;

I would declare these in common initrd code instead. Then you don't
need a kconfig symbol.

>  static int __init early_initrd(char *p)
>  {
> diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
> index 8f8699e62bd5..4dd26d6f02e5 100644
> --- a/arch/unicore32/mm/init.c
> +++ b/arch/unicore32/mm/init.c
> @@ -31,8 +31,8 @@
>
>  #include "mm.h"
>
> -static unsigned long phys_initrd_start __initdata = 0x01000000;
> -static unsigned long phys_initrd_size __initdata = SZ_8M;
> +phys_addr_t phys_initrd_start __initdata = 0x01000000;
> +unsigned long phys_initrd_size __initdata = SZ_8M;

You'll have to set these at runtime though. However, I seem to
remember that an exact size was needed for decompressing an initrd
which would make these defaults pointless. Maybe that was only certain
compression formats.

Rob
