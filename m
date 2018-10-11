Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44101C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003132087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003132087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJKOZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:25:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43389 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKOZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:25:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id w85so7514678vsa.10;
        Wed, 10 Oct 2018 23:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blu3qBNqed1JoPOHvC9y1QXSXwQvgmiV3+YRfSTvnCs=;
        b=nxM1QFC3AeokFQM/AHYiZixrsb2wYL5yNhgAiNKV2BcIvxhOQZQHR++JrwQ/ysf/rf
         HregPkWoFz1fli3a7ndQr0QhURyNW0l8J0OiTiVGCQ0TQ63JJE8YG0Y2MUnrJHS023C6
         4H+qwSfeFvbZTqJiNuypIICnDfjQ3+A7DMDlVkVZRPm93qxwwcaC83Vg9bMxXXWulsqG
         zwmxVA123ms1Hqq8eYVD370iUE4g+sijovTBWQZQ8jnli0ciR7G8dYuMVdHB0+YfvdYW
         TXX8ng7kQqWHfqDgRBOxsBfHpA/+1JEQvPDO7ZQGI0jtP+ZmJ9FZhoaQUpA9p9zfNdto
         Y7fQ==
X-Gm-Message-State: ABuFfohMzNO1J0Zw888GiL1R2sGn7sYKqTjO6kiYLvUcvdY4AfaA81yN
        Y+1+GjPaQgLB+1xbykL7mPvj82VACYSSrTOGSrI=
X-Google-Smtp-Source: ACcGV638d1xcvbscHnnJQUBM2pZd8HYW6ga8lg/ElAqdaRl3x71MSy/uZMfsuUSw2s8EqCjPYu7kOm/bJCmzZIUgIis=
X-Received: by 2002:a9f:35f1:: with SMTP id u46-v6mr168253uad.20.1539241165892;
 Wed, 10 Oct 2018 23:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134036.8296-4-geert+renesas@glider.be> <1539208063.1944.12.camel@impinj.com>
In-Reply-To: <1539208063.1944.12.camel@impinj.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Oct 2018 08:59:13 +0200
Message-ID: <CAMuHMdVUGW06O9ugzJQh4h5v=Gmf_7byvKPutB=YdQWyWcgN_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to
 optimize DMA
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trent,

On Wed, Oct 10, 2018 at 11:47 PM Trent Piepho <tpiepho@impinj.com> wrote:
> On Wed, 2018-10-10 at 15:40 +0200, Geert Uytterhoeven wrote:
> > Currently EEPROM writes are implemented using a single SPI transfer,
> > which contains all of command, address, and payload data bytes.
> > As some SPI controllers impose limitations on transfers with respect to
> > the use of DMA, they may have to fall back to PIO. E.g. DMA may require
> > the transfer length to be a multiple of 4 bytes.
> >
> > Optimize writes for DMA by splitting writes in two SPI transfers:
> >   - The first transfer contains command and address bytes,
> >   - The second transfer contains the actual payload data, now stored at
> >     the start of the (kmalloc() aligned) buffer, to improve payload
> >     alignment.
>
> Does this always optimize?  A master capable of an of aligned 18 byte
> DMA xfer would now have a 2 byte xfer that would probably be PIO
> followed by a 16 byte DMA.
>
> Or writing 14 bytes to the EEPROM has changed from an aligned 16 byte
> write to a 2 byte and a 14 byte, which is now worse for the 4 byte
> multiple requirement master which can use any DMA anymore.

That's correct. I did consider this case.
However, with the small page sizes used (16, 64, or 256 bytes), I'd expect
EEPROM users to consider them for their data formats, and thus it IMHO
makes sense to optimize for the optimal case, which is currently not the
case.

Note there may be 1, 2, or 3 address bytes, so it can be a total of 2 + len
or 3 + len bytes, too.

> It seems like an enhancement to the DMA code to look more like a
> efficient memcpy() that aligns the address, then xfers efficient
> blocks, then finishes the sub-block tail would be more generally
> applicable.
>
> Or more simply, given an aligned 18 byte xfer, the driver should do an
> aligned 16 byte DMA and then two more bytes.

That's another option, but that probably needs changes in several drivers,
and/or the SPI core (if we want to handle it there).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
