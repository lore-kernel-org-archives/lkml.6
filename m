Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A8E2184F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A8E2184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHUVDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:03:24 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40601 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHUVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:03:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id m13-v6so12335442uaq.7;
        Tue, 21 Aug 2018 10:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOcZ3QdO+X3tB4ERHRS+HDYvmfx3qw/Lj9awlNtuIos=;
        b=g6+VCGkvbxmFmy8msJp9Lgzst4fdJCFhgJsVMxwd0EYf5j5Xgy2wt+db0/lpLPFWIr
         ajxRkqY5MnF0x0ga/rYzN2crF2fkNv7wwuvvm+JUxLtyIEoERBUy/CUKj0/k/Y9vx6xQ
         y3nEQi50sk8WKP23ZynCSEdDpPXzl75t4NmKejWcVW4IDDj00goDwdMX0vFo1jW1Sn85
         xht7rj0aXLWnHm7LT0DBg+jAtQEdrJvI1iVIGUoAiMt4eycoU31sQ2i148u3UbaBBOVK
         69B/FR8kHWuELA2xMFsbpM8KNVNW4YqYlV5VorwKsl7gdvTRjcOFPGO6dog4poCq2G37
         moyw==
X-Gm-Message-State: APzg51CgVL7yY35VDfg1n4ervkWGxcZAnZn5qWTgg7O2JiJ1s3EZ/nzq
        xGhMvlkgZ8afSOSl1EJSC6wvLSsHQ+qVKiYZmoo=
X-Google-Smtp-Source: ANB0Vdau934ds8T8xelu2QYEo9MpHK1qocEku4CvAKjTSQHorlKGSc2UU6bRWoyNN9XoLRhPVDmGGun8qnUbNS2X3ts=
X-Received: by 2002:ab0:51ac:: with SMTP id g41-v6mr2240508uaa.155.1534873336649;
 Tue, 21 Aug 2018 10:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180821095303.27664-1-geert+renesas@glider.be> <20180821134044.GA18693@kroah.com>
In-Reply-To: <20180821134044.GA18693@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Aug 2018 19:42:03 +0200
Message-ID: <CAMuHMdVUomvhM=ag2n4DKf6hwX+J+YL+stA2Z3dQeod2RAwKKQ@mail.gmail.com>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
To:     Greg KH <greg@kroah.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        kirill.kapranov@compulab.co.il,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Aug 21, 2018 at 3:40 PM Greg KH <greg@kroah.com> wrote:
> On Tue, Aug 21, 2018 at 11:53:03AM +0200, Geert Uytterhoeven wrote:
> > If the SPI bus number is provided by a DT alias, idr_alloc() is called
> > twice, leading to:
> >
> >     WARNING: CPU: 1 PID: 1 at drivers/spi/spi.c:2179 spi_register_controller+0x11c/0x5d8
> >     couldn't get idr
> >
> > Fix this by moving the handling of fixed SPI bus numbers up, before the
> > DT handling code fills in ctlr->bus_num.
> >
> > Fixes: 1a4327fbf4554d5b ("spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Seen on e.g. r8a7791/koelsch, breaking both RSPI and MSIOF.
> > ---
> >  drivers/spi/spi.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

I know.

I only CCed stable because the acceptance email for the original patch was
CCed to stable, and I wanted to prevent that one from being backported early.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
