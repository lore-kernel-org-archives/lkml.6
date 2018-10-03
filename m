Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14FAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4F9213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4F9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJCV7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:59:46 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35237 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeJCV7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:59:46 -0400
Received: by mail-vk1-f196.google.com with SMTP id n71-v6so408910vke.2;
        Wed, 03 Oct 2018 08:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+ne1PmWCrm7erGpj0LfBgkY9ySsW4PbAvFGc4rv/pw=;
        b=WWUCNXLmg15LxSx0dNQgQwoP1TOdlGA/wGoAu4VpZS8cKGnzzT3g1chPv0h6TsGzlQ
         oV0+3yYzBD1ZzRxJs+BKv6jo3376SJDUAM7g3+EAJDJrtdLgeDb9HDFUekVPfK7x5YCJ
         D0yZBTY58/b7m24TH8grBxztWhjvvGSJjfO5j9KoD+CYVVC7fouu9DePIGgOZjB+L1+A
         aIWDMpzSFrLIH7dFH2VFuDqF4U4A77MgZV6OzA588keePhE2NMUfNeQjZnJInRrsv0kw
         NSscHPuEPsNRLoPiUWwts0JE/3D/gizwgZkQPdO9+GZku4kT5OlgnZIIBXRXu6ngZjWK
         2J4w==
X-Gm-Message-State: ABuFfoguXsVsXIlG8lz6l+q1HbmeT9CGx2A2+qYgOrDpiXzmOJJgniT8
        OsZAq63Qkrim9RxyOgOofZYuKC0oIWJjv4KS1yCbHg==
X-Google-Smtp-Source: ACcGV62VpiYSVBiX5vqyYA8kYzbR4dHY79kkc1+cx+bm4YiKsBKK0ZC7Otmw8Jy802zxejWjX61ynuG2iktTawpbLoo=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr765761vkg.40.1538579457852;
 Wed, 03 Oct 2018 08:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181003123328.GA29471@embeddedor.com> <CAMuHMdX2YL2PG390ej0WMct7DciAbzO=66z7TJ-VnS8_phjdaQ@mail.gmail.com>
 <20181003150111.GD7132@sirena.org.uk> <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
In-Reply-To: <37edd7c9-c93f-49a1-6621-880d8f88f345@embeddedor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Oct 2018 17:10:45 +0200
Message-ID: <CAMuHMdXyn6MYETdCAueXSKDeZXGxN2JJWX7bsE8QiUZNveeDfg@mail.gmail.com>
Subject: Re: [PATCH] spi: slave: Fix missing break in switch
To:     gustavo@embeddedor.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Wed, Oct 3, 2018 at 5:05 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> On 10/3/18 5:01 PM, Mark Brown wrote:
> > On Wed, Oct 03, 2018 at 04:46:45PM +0200, Geert Uytterhoeven wrote:
> >> On Wed, Oct 3, 2018 at 2:57 PM Gustavo A. R. Silva
> >
> >>>         case CMD_REBOOT:
> >>>                 dev_info(&priv->spi->dev, "Rebooting system...\n");
> >>>                 kernel_restart(NULL);
> >>> +               break;
> >
> >> Alternatively, kernel_restart() and friends could be marked __noreturn.
> >
> > Yes, that seems more sensible though there's no harm in this patch even
> > with that.  It'd definitely avoid other issues in future.
>
> I'll include the __noreturn in addition to the break statement.
> I'll send v2 shortly.

Please note that adding __noreturn is not a trivial task, due to the complex
call chains, and the different implementations on the various architectures
and platforms.  So that will be a big patch series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
