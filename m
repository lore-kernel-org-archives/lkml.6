Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B6BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2562227BCD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2562227BCD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933758AbeF2IPo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:15:44 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44070 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbeF2IPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:15:38 -0400
Received: by mail-vk0-f65.google.com with SMTP id x4-v6so4849611vkx.11;
        Fri, 29 Jun 2018 01:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ksb85eCHgRCsZIzOuTOtRCOIsJgDt7FmFZQUHs+Ml/Y=;
        b=q3MdW6ZjAJbKpVzdjFgahsf/Mh+a8GTUVms4gldDOEi6bzUPfTZk3RZj8w/UyQ+oDn
         WPNWQrTaV7e7zvsfx4H4JmSlPvG46yNFKngMR5kHtPyXXrfQSp91vflXPtnIMDr+arXC
         w50hwEb09OrMqssRHD/BQQPpXGXqxjLLGU6oEHx/i2rwfOrxw14Llc9R3DSuaFc3CCKG
         s5eSv0QfKnivS4fTxJej2Nnu+9knIk3FqYeTPjeirDcOhT639BjKiKDlf8iiGy/nSFJe
         KXvz29PhXdzAuviSdtHpP+6S7IwshmjmoxcGOi6BxKfNQ7dRPgZO3YXbS7e9xf9Slirc
         aP9A==
X-Gm-Message-State: APt69E3s7tvipv6xTxiqvUPaYib6A6tRpYrt8X9xRouBDh3+os7K07mO
        YkU/eM+Ysq6Ve0CPIXbqspcNp/aYAz+zNmlPkes=
X-Google-Smtp-Source: AAOMgpcPap3XKMkAxc7FbH836LbJS+fvkTZ/39auL/Jo3MPidoK1co1Or2F8UcxBu2GDRRtPHFwt1UYRsLD7fg98QQo=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr8065292vks.106.1530260137552;
 Fri, 29 Jun 2018 01:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180627035642.8561-1-nicolas.pitre@linaro.org> <20180627035642.8561-3-nicolas.pitre@linaro.org>
In-Reply-To: <20180627035642.8561-3-nicolas.pitre@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Jun 2018 10:15:26 +0200
Message-ID: <CAMuHMdUmC+uiKTEMotB83A86E1wEYrNF2qPf3kDACaW27D_NbA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vt: introduce unicode mode for /dev/vcs
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Dave@mielke.cc,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, Jun 27, 2018 at 7:03 AM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Now that the core vt code knows how to preserve unicode values for each
> displayed character, it is then possible to let user space access it via
> /dev/vcs*.
>
> Unicode characters are presented as 32 bit values in native endianity
> via the /dev/vcsu* devices, mimicking the simple /dev/vcs* devices.
> Unicode with attributes (similarly to /dev/vcsa*) is not supported at
> the moment.
>
> Data is available only as long as the console is in UTF-8 mode. ENODATA
> is returned otherwise.
>
> This was tested with the latest development version (to become
> version 5.7) of BRLTTY. Amongst other things, this allows ⠋⠕⠗ ⠞⠓⠊⠎
> ⠃⠗⠁⠊⠇⠇⠑⠀⠞⠑⠭⠞⠀to appear directly on braille displays regardless of the
> console font being used.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Thanks for your patch (which is now in tty-next).

> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c

> @@ -51,6 +57,26 @@
>
>  #define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
>
> +/*
> + * Our minor space:
> + *
> + *   0 ... 63  glyph mode without attributes
> + *  64 ... 127 unicode mode without attributes
> + * 128 ... 191 glyph mode with attributes
> + * 192 ... 255 unused (reserved for unicode with attributes)
> + *
> + * This relies on MAX_NR_CONSOLES being  <= 63, meaning 63 actual consoles
> + * with minors 0, 64, 128 and 192 being proxies for the foreground console.
> + */
> +#if MAX_NR_CONSOLES > 63
> +#warning "/dev/vcs* devices may not accommodate more than 63 consoles"
> +#endif

MAX_NR_CONSOLES is part of UAPI, so it cannot change.
It doesn't hurt to have an explicit check here, though.

However, looking into that I noticed include/uapi/linux/vt.h says:

    #define MAX_NR_CONSOLES 63      /* serial lines start at 64 */

But that seems to apply to /dev/tty* (major 4), not /dev/vcs* (major 7),
so you're safe.

> +
> +#define console(inode)         (iminor(inode) & 63)
> +#define use_unicode(inode)     (iminor(inode) & 64)
> +#define use_attributes(inode)  (iminor(inode) & 128)

I guess you need to update Documentation/admin-guide/devices.txt, and
add /dev/vcsu*?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
