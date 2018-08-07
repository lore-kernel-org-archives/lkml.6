Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD2C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBA821884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltawNf7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBA821884
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbeHGTKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:10:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41428 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:10:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id w19-v6so5710249ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RBlIuzwh1pQY/4bQtzamE9ubcm8JJb7N3YtSflISkfs=;
        b=ltawNf7DqkxojYxidp1gDaI0m3A5x266a0K2kQyUCZQO4yBOy6IENuAO2C/icvBZEF
         HxzHc8Fe+VqLzbyXVyT7/bsxqif2dj8IlYv2kn3C0psQ+D9PXoj99sFcVn+4Cn6WnOQf
         nsWRSl17SAOrYeUsnQIGraKJ2AlBheVIOiiAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBlIuzwh1pQY/4bQtzamE9ubcm8JJb7N3YtSflISkfs=;
        b=kSxbWkAqWlXpUHLh9q8QxeLtySzcsB/AaXyuytBTB6KkfuiUIsiV94Qg6j9qJlD7Hk
         c+kGjBqk95sBnymL4YBz7rma26BWGgJacvAmHeBaLt8PgJdg3lM3lBx5B0FvfD0cDrkH
         PVk3ARhFogmX93Kl54JPQtxMkQZsOL1u9ccdMZXK4igrlfeDfwnISXMVbfrcLaDg3PnZ
         Uv3ytjur4URAwTNcC0JOTsDmiB80t3g+65yIlCiKX/4t/OZnOORSs3Fj3D5FxQf3lT2H
         NbYpN9+LvFCMuTvMtXYcVeg8RlIzdAmJBBjbcdCSr2d9SfuLJbicfvMEfBQPvSztNyuC
         8n0Q==
X-Gm-Message-State: AOUpUlF+2PgDK4YBCVAiOWxgSDcjAAibbinicW+XAoMA48RvJ/KLDtXE
        tppPNbCj6qsUBg22vyAcHHA/7g==
X-Google-Smtp-Source: AAOMgpcQ4/yCd8P2BDOVxMgWrDi7xdmtR2Qwz+JOYJ06cFT3/Hjf/UjljalOzc3VRG36maydiNGo0Q==
X-Received: by 2002:a17:902:b595:: with SMTP id a21-v6mr18678730pls.23.1533660903360;
        Tue, 07 Aug 2018 09:55:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p19-v6sm4490072pgk.28.2018.08.07.09.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 09:55:02 -0700 (PDT)
Date:   Tue, 7 Aug 2018 09:55:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     bardliao@realtek.com, oder_chiou@realtek.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH] ASoC: rt5677: Remove bogus device id from rt5677_of_match
Message-ID: <20180807165502.GD160295@google.com>
References: <20180807162234.205212-1-mka@chromium.org>
 <CABXOdTcpoGLc+STUZY-tVBqqn5BrBH1vEb6B+bt6MspLHUXeGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXOdTcpoGLc+STUZY-tVBqqn5BrBH1vEb6B+bt6MspLHUXeGQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:39:38AM -0700, Guenter Roeck wrote:
> On Tue, Aug 7, 2018 at 9:22 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The initializer of rt5677_of_match contains a bogus device id
> > (enum type) for the 'type' field (char []). Remove it.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  sound/soc/codecs/rt5677.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> > index 8a0181a2db08..7dab53b35cbf 100644
> > --- a/sound/soc/codecs/rt5677.c
> > +++ b/sound/soc/codecs/rt5677.c
> > @@ -5007,7 +5007,7 @@ static const struct regmap_config rt5677_regmap = {
> >  };
> >
> >  static const struct of_device_id rt5677_of_match[] = {
> > -       { .compatible = "realtek,rt5677", RT5677 },
> > +       { .compatible = "realtek,rt5677", },
> 
> Is that indeed not used, or should it be the following ?
>                         ...  , .data = RT5677 },

You are right, I missed that the driver uses of_device_id->data, will
update.

Thanks!

Matthias
