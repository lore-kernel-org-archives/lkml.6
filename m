Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9BC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D9F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfA3Hfi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:35:38 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39864 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfA3Hfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:35:38 -0500
Received: by mail-vk1-f193.google.com with SMTP id s184so5126662vkd.6;
        Tue, 29 Jan 2019 23:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YTpduAoMXxhUKgTnWFZbLAPz2z/lmnMmtAOe3HKxleY=;
        b=Ghc8vyMeYxNb7epjXKHEw6+s8K7DNa+fSQgoujwgcEvFnBC4lFBRHSbSZKPFiz34kx
         /b6T4bexs5WR8G5Gl1O5qUekL37zis/yanST2g+cQNhHpkkddropcpTC5bmAVVhTYh+4
         sDi9GjgmEaDBpCGrRrGbsSgEDSpDhJygnvDY7Mf4iMzu45tjshj/eO0ZyVCP2D0csA63
         McyatEyl+DeHNx1RaqqD02NPtOoHECiniRKZkXXmqS/4ZPIaSRlag3a3u9GRBFqyYuTo
         FpOFDzSGXBFrCL+T6T+ErRwnX2L0K44pNJB8+J4o2p8ZBI9MSqOl/Gz2ahf/p0itqubw
         WK3w==
X-Gm-Message-State: AJcUukd2SBhCtVadlh+pPpdo2H0v1Btf6W/DgBXANC/7o2JIv2vLSfME
        upS4BOAFaghZ57TlZTbLzCdSjrH8Xkb62qKaB7UN5Ug4
X-Google-Smtp-Source: ALg8bN5LCPHQ6ZnUo1UdCWo+yhEA2ZTgicWEOxx8WCxoRtPYXNRGdAyb1Vfbq68wAi07UWJlNXrsgZi66dVem6oGp7o=
X-Received: by 2002:a1f:a414:: with SMTP id n20mr12090963vke.83.1548833736817;
 Tue, 29 Jan 2019 23:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20190129205502.7741-1-jonas@norrbonn.se> <20190129205502.7741-2-jonas@norrbonn.se>
In-Reply-To: <20190129205502.7741-2-jonas@norrbonn.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Jan 2019 08:35:25 +0100
Message-ID: <CAMuHMdXv6U-VeznbXrTNk9oY1kCkYu-b+_o3KH_R6BMgpVn7YA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Tue, Jan 29, 2019 at 9:55 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> Some devices are slow and cannot keep up with the SPI bus and therefore
> require a short delay between words of the SPI transfer.
>
> The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
> clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
> bytes on the bus fast enough to keep up with the SoC's SPI controller
> even at the lowest bus speed.
>
> This patch introduces the ability to specify a required inter-word
> delay for SPI devices.  It is up to the controller driver to configure
> itself accordingly in order to introduce the requested delay.
>
> Note that, for spi_transfer, there is already a field word_delay that
> provides similar functionality.  This field, however, is specified in
> clock cycles (and worse, SPI controller cycles, not SCK cycles); that
> makes this value dependent on the master clock instead of the device
> clock for which the delay is intended to provide some relief.  This
> patch leaves this old word_delay in place and provides a time-based
> word_delay_us alongside it; the new field fits in the struct padding
> so struct size is constant.  There is only one in-kernel user of the
> word_delay field and presumably that driver could be reworked to use
> the time-based value instead.

Thanks for your patch!

> The time-based delay is limited to 8 bits as these delays are intended
> to be short.  The SAMA5D2 that I've tested this on limits delays to a
> maximum of ~100us, which is already many word-transfer periods even at
> the minimum transfer speed supported by the controller.

Still, the similar delay_usecs uses a u16.

> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h

> @@ -803,6 +808,7 @@ struct spi_transfer {
>  #define        SPI_NBITS_DUAL          0x02 /* 2bits transfer */
>  #define        SPI_NBITS_QUAD          0x04 /* 4bits transfer */
>         u8              bits_per_word;
> +       u8              word_delay_us;

us for µs

>         u16             delay_usecs;

usecs for µs

Can we please try to be consistent?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
