Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DB0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A329F20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfA2TCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:02:51 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45206 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfA2TCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:02:50 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so7205696uam.12;
        Tue, 29 Jan 2019 11:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGbalnbWK1BdJsVh4SfasEI2KSz1Xmm2olQ96cpZjL4=;
        b=p9YabY/uvBO52zZPkzM/ZYIcZBHXbxx98ZI0AoKCI5IQh/4u3c22Ouu82j0iwyL0mJ
         gibxFYqjEv8u2LLd0fPvNzYqqI8ROLXuflezApa+JqibI1FEbTShBCtHsGVF6aPymxuj
         bWyduW1RQbz0PXzCUVhF+S/VTLL8go/NHRY5iKWGzPqRVMaB8hnBaG7MaDdwBwBSGTd0
         znBSaUlcSm0z54q5zy4g5Mvn2PNV5AsrpuIxxTHvC9eotJEpjGuckcNcYpRRuYqD3N60
         0v43Nrb+/2SDqWXp7zSbBiL+oLLhLOivXRzDBbDuRIJ/ycG3lPN2OP/VDRHav083XxBE
         GAFg==
X-Gm-Message-State: AJcUukfD+hw3iknsnqkUlN8z9yVIVl91XpQLVJASBrJzi884eC74W/k1
        OiQE1jMTSQKWv7H1g3gagF++zeXM9rHiz/5XSVk40Oxr
X-Google-Smtp-Source: ALg8bN5FS3RLjkNTwLmFTA7F/tmoskPNe5LD48gPWZdscGmSAlTxrvIZagAeda33RcHwvrapJ/Opo7+7zVU+JiJhfTw=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr11815650uap.0.1548788569395;
 Tue, 29 Jan 2019 11:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20190118140525.29189-1-geert+renesas@glider.be> <20190118230740.44239fcf@bbrezillon>
In-Reply-To: <20190118230740.44239fcf@bbrezillon>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Jan 2019 20:02:37 +0100
Message-ID: <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
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
> Did you consider converting this driver to spimem? Looks like the
> protocol used to communicate with the memory resembles the one used on
> SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.
>
> By doing this conversion you'd allow people to connect an AT25 EEPROM
> to an advanced SPI controller that does not support regular SPI
> transfers and you wouldn't have to forge SPI messages manually.
>
> Here is a patch (only compile tested) doing that. The diffstat is not in
> favor of this conversion, but I find the resulting code cleaner and more
> future proof.

Thanks, seems to work fine, with the 512-byte 25LC040 I have!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I did notice that the first two-byte transfer (command+offset) of each
message is now split in two one-byte transfers, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
