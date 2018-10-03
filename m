Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630A3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A15720835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kS6f045c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A15720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJCSXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:23:45 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:43076 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:23:45 -0400
X-Greylist: delayed 170058 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2018 14:23:43 EDT
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w93BZVai020388;
        Wed, 3 Oct 2018 20:35:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w93BZVai020388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538566532;
        bh=IeGBb+8CJbG3tQgKNl9Xr3t0jLYUM5mtOLalvsHeidA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kS6f045cNvX9P/U8yrXeuUxp/8fLJuB80mzsLG6AoTX7HeC2ySbO1qCsENvdRAqSh
         BBBvBQwv3w6hLjEgYloS/ejm7A+3gPQG5+cAcNWpcKVf+kNPkDKLO/ryTMEOe28wC6
         NfS2OyGmkiAs9KwQib5eYm49bFIaVvxI3OpdO9gUEHhN0S23EYnB2x1/Nb2kRoIFrT
         blm5QF1A/VUNUO0QBTUefdYMCW6ijTP35/jkXYhkHuDFuX/wDTi02uNh5oZ28tUHfg
         YDlxCIWeChQfMe5lCPYBQnf6o/jcOGQ9KP7tqgLx0OjQzzo4686h9lK0cQ15SZw807
         l4A8EGR7bkvAA==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id i10so2980484vsm.13;
        Wed, 03 Oct 2018 04:35:32 -0700 (PDT)
X-Gm-Message-State: ABuFfogSDGw2p8nS4P3h2GZdLeYYmTbwl7ITiRJPbge7tRuFEU7LbA2P
        tybstIKqhUhYHOwPaKKZn3Sb9t8PeMqfkU1tPAk=
X-Google-Smtp-Source: ACcGV62Drm8oP2I8I9ITS29wTBiG1dPYqX2Vn6dJItk7j/n3PpdFPGLvyJKX+ymClG81VIraw1hDasYJidhlv/MKxg0=
X-Received: by 2002:a67:5f85:: with SMTP id t127-v6mr375192vsb.155.1538566531230;
 Wed, 03 Oct 2018 04:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
 <1538397062-19162-2-git-send-email-yamada.masahiro@socionext.com> <20181002230115.GB812@kunai>
In-Reply-To: <20181002230115.GB812@kunai>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Oct 2018 20:34:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6TxN8rU-=wr1XXjkTJ2n+FK8YHqWCvOqMvXrMFHXoXg@mail.gmail.com>
Message-ID: <CAK7LNAS6TxN8rU-=wr1XXjkTJ2n+FK8YHqWCvOqMvXrMFHXoXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: move MFD variant reset to a platform hook
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,


On Wed, Oct 3, 2018 at 8:02 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> Hi Yamada-san,
>
> On Mon, Oct 01, 2018 at 09:31:01PM +0900, Masahiro Yamada wrote:
> > CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).
> >
> > Add a new hook host->reset for performing a platform-specific reset
> > sequence, and move CTL_RESET_SDIO over there.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I like it in general.
>
> > +static void tmio_mmc_reset(struct tmio_mmc_host *host)
> > +{
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> > +     usleep_range(10000, 11000);
> > +     sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> > +     usleep_range(10000, 11000);
> > +}
> > +
>
> Are you sure resetting SDIO works independently of resetting SD? Maybe
> we should add resetting SD here, too, to keep the pattern...

I am not 100% sure
since I do not have this hardware.


> > --- a/drivers/mmc/host/tmio_mmc_core.c
> > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > @@ -164,14 +164,13 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
> >  {
> >       /* FIXME - should we set stop clock reg here */
> >       sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
> > -     if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
> > -             sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> >       usleep_range(10000, 11000);
> >       sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
> > -     if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
> > -             sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> >       usleep_range(10000, 11000);
>
> ... and have this simplified reset pattern either also in a seperate
> function, or doing...
>
> >
> > +     if (host->reset)
> > +             host->reset(host);
>         else
>                 simplified_reset_pattern
>
> ?
>
> What's your opinion?


OK, I will send v2.



> Regards,
>
>    Wolfram
>


-- 
Best Regards
Masahiro Yamada
