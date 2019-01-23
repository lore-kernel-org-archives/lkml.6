Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDFC21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfAWSLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:11:10 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44641 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWSLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:11:10 -0500
Received: by mail-vs1-f66.google.com with SMTP id u11so1852407vsp.11;
        Wed, 23 Jan 2019 10:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lar/7CirLLuwgN7QjrkipPVg9UnJ8H/ir6GU33xHxvc=;
        b=LJKJYHEdMi/ChlSo8PUD4F6tt57D+lZ5Fm6QiaXuvlC6Mti9i63yKyvYL3hma638yS
         PFwd2YyFCeaCG56ccAtOmIOc95bS+LxOacJd1u5GpLCF7HeCCweeMbqrECpDVglJf8IN
         0Gmzb2dVDV3j+LsjB6K44zBLMGdeVSakEhxUwCzGwqp73nCyRqsw67wwaYs86Oapf3z5
         pndQiELaoHbL7aEkoRDicWVGAcvcJSjJKvQB3Nw3kPh+50hHSYlphvnnk//x8toZb+gz
         PK0af6RbOjfEtBOvwqmRYQeC6bR5vYHUQF3yaUVEiyL+BrREsAe54ArmolvnY10p4lpW
         e/yQ==
X-Gm-Message-State: AJcUukfXUVhy62T6DQcDRNceKGj+ViKiub/R9yW9QTZcaiziW2ABKvCh
        XU1kc3BUXCm8BJB+ORDBfXp6XVSfRKu1JlI0oMJWmw==
X-Google-Smtp-Source: ALg8bN5566f0rXYuWl8e+cbAWmCn2WrWy84SUq0jLilszABY0OIU5GtWW6UAvSB0/TmF3OC/VqRb1bqwrHUqG4Muya4=
X-Received: by 2002:a67:c202:: with SMTP id i2mr1277005vsj.11.1548267069275;
 Wed, 23 Jan 2019 10:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20190118140525.29189-1-geert+renesas@glider.be> <20190118230740.44239fcf@bbrezillon>
In-Reply-To: <20190118230740.44239fcf@bbrezillon>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Jan 2019 19:10:56 +0100
Message-ID: <CAMuHMdUWqcB7cTOenASWt6HXZhGsr9cH9B55Sh-+rmWmAkm4Fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Fri, Jan 18, 2019 at 11:07 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
> On Fri, 18 Jan 2019 15:05:23 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > This patch series contains two improvements for the AT25 SPI EEPROM
> > driver, related to SPI transfers.
> >
> > Changes compared to v1:
> >   - Merge "off" and "offset" into a single variable instead of just
> >     killing the cast, as suggested by Arnd,
> >   - Add Acked-by,
> >   - Dropped "[PATCH 3/3] eeprom: at25: Split writes in two SPI transfers
> >     to optimize DMA", as this is better implemented in the SPI
> >     controller driver (cfr. e.g. "[v2 PATCH 2/2] spi: sh-msiof: Use DMA
> >     if possible",
> >     https://lore.kernel.org/linux-renesas-soc/1547803771-9564-2-git-send-email-na-hoan@jinso.co.jp/)
> >
> > Tested on a Renesas Ebisu development board with R-Car E3 using MSIOF
> > and a 25LC040 EEPROM.
>
> Did you consider converting this driver to spimem? Looks like the
> protocol used to communicate with the memory resembles the one used on
> SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.

No, I hadn't considered doing that ;-)

> By doing this conversion you'd allow people to connect an AT25 EEPROM
> to an advanced SPI controller that does not support regular SPI
> transfers and you wouldn't have to forge SPI messages manually.
>
> Here is a patch (only compile tested) doing that. The diffstat is not in
> favor of this conversion, but I find the resulting code cleaner and more
> future proof.

Thanks, will give it a try, eventually...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
