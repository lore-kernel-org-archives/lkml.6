Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230DAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E832E20869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeL2W1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:27:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33856 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbeL2W1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:27:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so14270670qke.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 14:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0oBUkqD5p4j+xffeWUiyhsv44vkKiTcEHnXCi5uSdo=;
        b=GJjtEWFWZOIKp4HzgPQzB4+ugDQi0Nk3/9MXvgbcb5h1IBzY78Aea360NMRd4dYSMO
         LE+fKD+45/xSytdaxuhYTu/8F3Th1DX2oIq3NdZj1lMU8ppCFaYcxyrUjAAGamiYaDFn
         W11J4Bcb/foZvMtLpCkbEavml2s9tSb9D/voGhlSKMfKtxRCl7pdaBc2FGLiMBYDEFYs
         +xhBF65G9GuS+munDRvNhEmonY1KlQuyHh/Hcv4Iom2nwmM+KmWBayYaeAFs1xYdPLbK
         dl5XeYQjrqS8boNvfoowQHEGX1nPhujDi39XZNrfEkk8A4eLw02Dn80xp6ozlyvIgiJ1
         BJfQ==
X-Gm-Message-State: AJcUukdZbg81Qf7h+eM27BpWcnbIpiwjGZ37YX+gwwKttG86rKh7sb2+
        jvSf7NKMYIcDeBuAyxBdlng8UFJlL/v3ZdqjxJM=
X-Google-Smtp-Source: ALg8bN6dhuNcs0QnWtoULV5zjryQxDeGrpo3N8kjItS1pnbJjUmy+wHGeE18YJWU6kA2rS73ItoSySk42fhqWqWBPIw=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr29013373qkf.330.1546122463680;
 Sat, 29 Dec 2018 14:27:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au> <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Dec 2018 23:27:27 +0100
Message-ID: <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac functions
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> +
> +static ssize_t m68k_nvram_get_size(void)
> +{
> +       if (MACH_IS_ATARI)
> +               return atari_nvram_get_size();
> +       else if (MACH_IS_MAC)
> +               return mac_pram_get_size();
> +       return -ENODEV;
> +}
> +
> +/* Atari device drivers call .read (to get checksum validation) whereas
> + * Mac and PowerMac device drivers just use .read_byte.
> + */
> +const struct nvram_ops arch_nvram_ops = {
> +#ifdef CONFIG_MAC
> +       .read_byte      = m68k_nvram_read_byte,
> +       .write_byte     = m68k_nvram_write_byte,
> +#endif
> +#ifdef CONFIG_ATARI
> +       .read           = m68k_nvram_read,
> +       .write          = m68k_nvram_write,
> +       .set_checksum   = m68k_nvram_set_checksum,
> +       .initialize     = m68k_nvram_initialize,
> +#endif
> +       .get_size       = m68k_nvram_get_size,
> +};
> +EXPORT_SYMBOL(arch_nvram_ops);

Since the operations are almost entirely distinct, why not have two
separate 'nvram_ops' instances here that each refer to just
the set they actually need?

I was actually expecting one more patch here that would make the
arch_nvram_ops a pointer to one of multiple structures, which would
be easier to do with multiple copies, but I suppose there is no need
for that here (there might be on ppc, I have to look again).

       Arnd
