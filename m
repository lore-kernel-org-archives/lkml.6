Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D0BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BE620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqcpD38Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BE620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934644AbeFRUIy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:08:54 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46410 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755368AbeFRUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:08:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id u5-v6so5347291lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1KmgZ9mnv+nsIee+Ljvl9StSpRoOe5RrOrfteH4umHU=;
        b=aqcpD38YvFvpIUjWEcioRyMPRjDRBEOlQLQ7dt1sEgwF1cfLf0kIc3XrLFI17KwZNP
         qwxrP19ASDCyfnsY6elDpsJ7qzz5dodReV5RCdmc5mRxYecF77vTAWRn/4G5I3xysWjN
         HEKgqwccfKIOqD55cM0M+LS1+kOdndQBSz1Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KmgZ9mnv+nsIee+Ljvl9StSpRoOe5RrOrfteH4umHU=;
        b=Jat69iYeLXhedqnM2htTvmFK4FSSWJTiA0n9rkDakYC38aVnh5muDShKxn0H2+KkAK
         W+THkqXx6shCtVXmShPYt2f75060Ppf+ECNxax9IT2PMMF07BsxDDUxqC6xWamyxZ6Qq
         KWzwp2j2zdo5h74ctKICBN5Ez2szE/laQ5xJl+pivs2EJEKCuuL7zR4PnwmYkFXOhSyg
         +hXu3zpQjH2uM4O4kYBBHiV9lWdtLVMiumKm7Cvz5sv7QQEKmF0ZlH3JAVUJ9gnC7VOT
         mDBS/IKLgGu2VbX+5TcsdwMt5a/vxWxdI7ZktqCSOzJIHn8e5f7Lw+UcHlZWrmdj2BZu
         F7pg==
X-Gm-Message-State: APt69E2lYvAJiYYJFF+QQ4ZI4JuBgJkyHn+liT0kt6ya1XEz5nptpyOA
        mLB4BelAQvAXAgHZEuoUz4YgqQ==
X-Google-Smtp-Source: ADUXVKKGWWj9Z0nsi1oBrkBzfCukZ2tQIISts8cBmGPIcEziJMzgf+4S+e/fleTgkXVEs0kwX+X0Ng==
X-Received: by 2002:a2e:2206:: with SMTP id i6-v6mr8956333lji.119.1529352531480;
        Mon, 18 Jun 2018 13:08:51 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id w1-v6sm2945493lfk.59.2018.06.18.13.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 13:08:51 -0700 (PDT)
Date:   Mon, 18 Jun 2018 22:08:48 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Message-ID: <20180618200848.GA32482@centauri.lan>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org>
 <20180618110642.GA6928@sirena.org.uk>
 <20180618123932.GA28476@centauri.lan>
 <CAL_JsqJQ0GbFtnpP9-YCEcVKHDdHbT5hshZGvNDQw=u5ZANdvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJQ0GbFtnpP9-YCEcVKHDdHbT5hshZGvNDQw=u5ZANdvg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 08:48:32AM -0600, Rob Herring wrote:
> On Mon, Jun 18, 2018 at 6:39 AM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> > On Mon, Jun 18, 2018 at 12:06:42PM +0100, Mark Brown wrote:
> >> On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
> >> > of_platform_device_destroy is only defined when building
> >> > with CONFIG_OF=y. Add a depends on OF.
> >>
> >> Is it sensible that of_platform_device_destroy() is only defined when
> >> building with CONFIG_OF=y?
> >
> > I'm redirecting that question to the device tree maintainers.
> >
> > There are a few of_* functions in include/linux/of_platform.h
> > that are only defined when CONFIG_OF=y:
> >
> > of_platform_device_create()
> > of_platform_device_destroy()
> > of_platform_bus_probe()
> > of_device_alloc()
> >
> > Rob, Frank, do you want me to create static inline dummy versions of these?
> 
> No, because generally you should not be using these functions
> directly. Yes, there are some users, but if you look at the tree,
> there are few or isolated (PowerPC) users. Using
> of_platform_populate/of_platform_depopulate is preferred.

of_platform_device_destroy() is also used by sound/soc/qcom/qdsp6/*
which is why I suggested this patch:
https://marc.info/?l=alsa-devel&m=152932497413567
that adds "depends on OF" for SND_SOC_QDSP6 in sound/soc/qcom/Kconfig.

Or do you think that a better solution would be to modify
sound/soc/qcom/qdsp6/* so that it instead uses
of_platform_populate()/of_platform_depopulate()?
(Or perhaps this isn't even an option,
I'm not at all familiar with the QDSP6 code).

Regards,
Niklas
