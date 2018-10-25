Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4EAECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7862083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK3EEpB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7862083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJYV6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeJYV6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:58:02 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49CEA20856;
        Thu, 25 Oct 2018 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540473917;
        bh=ngzx03ftC0NxL2KMCSAgI/D0PWwvtw4PFi3Saml67T0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FK3EEpB8lvnjHoYnz2A1jNtKgocNjcat3kyvc6nHTmIULqzWkN6Mf1Ksz5JLC+LuV
         Vu/JbJnWJE/oDB05FNclReJ2+va1SGmxPCj32RVZqDJ2s9J/KBrsQB8JJ9/wNQfTBY
         gMOG0tnGuJukWpwUsEwxZgYgspUBF3+THNgN21+0=
Received: by mail-qt1-f173.google.com with SMTP id b22-v6so733045qtr.11;
        Thu, 25 Oct 2018 06:25:17 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKHGVtQD9PaKJnzEwH+eAdtVU6IC7Oyo+fUQ969kXuyEpE7O70I
        awIuhfjmG1fliFFakKrkKekO10Q6XJutDdjvAQ==
X-Google-Smtp-Source: AJdET5cEpV2d96zxwhiGOGN2CQbhc3g5cJ1eqe/I+Stj4xtpmf9X0Y5roCnLgEcpmiNPlsWGdGy8cGv0DxBwzOBisVw=
X-Received: by 2002:ad4:4182:: with SMTP id e2mr1531156qvp.106.1540473916446;
 Thu, 25 Oct 2018 06:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181025001742.6510-1-f.fainelli@gmail.com> <20181025001742.6510-2-f.fainelli@gmail.com>
In-Reply-To: <20181025001742.6510-2-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Oct 2018 08:25:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK-bSu520fx-dWMyHsooOU9=24DEf6fZSudQ-QKDkXbGA@mail.gmail.com>
Message-ID: <CAL_JsqK-bSu520fx-dWMyHsooOU9=24DEf6fZSudQ-QKDkXbGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] of/fdt: Absorb ARM64's __early_init_dt_declare_initrd()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        christoffer.dall@arm.com, andreyknvl@google.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 7:17 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> ARM64 is the only architecture that requires a re-definition of
> __early_init_dt_declare_initrd(), absorb its custom implemention in
> drivers/of/fdt.c.
>
> Suggested-by: Rob Herring <robh@kernel.org.

You forgot a shift key. :)

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/of/fdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 800ad252cf9c..7d316f008f22 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -896,9 +896,14 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
>  static void __early_init_dt_declare_initrd(unsigned long start,
>                                            unsigned long end)
>  {
> +#if IS_ENABLED(CONFIG_ARM64)

C code, not preprocessor please.

> +       initrd_start = start;
> +       initrd_end = end;

Thinking some more about this, perhaps it is better to just add the
*_phys variants now along side the VA variants and set them here. Then
the arm64 code can override the initrd_start, initrd_end, and
initrd_below_start_ok values.

> +#else
>         initrd_start = (unsigned long)__va(start);
>         initrd_end = (unsigned long)__va(end);
>         initrd_below_start_ok = 1;
> +#endif
>  }
>  #endif
>
> --
> 2.17.1
>
