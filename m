Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FB3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0816B20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Va19WB5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0816B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeLEOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:42:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33163 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:42:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so14924129lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/daZjlGPJkP5yUOOonDeceHjcq70T3cl4IR+HFP00I=;
        b=Va19WB5zXFoIzn0B33xxAh62knuZjW7N4GYY27TAkagk2o5Csz+7UQzKw/cYYs7akK
         I+YgTu/0Whyzr6nLnpj7VBvSx8Mygbn6798c1PELCTt8Vs2KP4WLdCzYgLVflyCecyff
         Dg91LX64GqY/Dl7Sxyg8o3+qdTjgyT136tkIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/daZjlGPJkP5yUOOonDeceHjcq70T3cl4IR+HFP00I=;
        b=VY0XEservR3Qurd1CC+89LeTZVk62OBaNKj7fzSIcQSoSL0nzMOCiAdyQQG4e4Dlp7
         1g37f6OsIkgN9nlndq7Pw6vsSvMnjLIXVb6aXpHZ0ubR+YsqK2QT0eUfSAjLgarlPyt9
         zhhB6U7mMmtp1lixEPPQVVEdrP0uTDAoMIbic8vr8qD8MF4MMAnAy1Pxt9ujhw0dVGes
         Vge+hHP8nsmboKYK2YOlKC3MMnDzbElKHNEwip+SF8uteCE8C+rcpk2G97Dp5d91OJPs
         v04KpoO62S2Z/dCLw5F7e7dEbeNfuTiqSpbDUhFSlgt1keR9uC9omtrEPN/ixJVvbUrF
         007w==
X-Gm-Message-State: AA+aEWZjJTSH1JucPnEb55OIiRNAPSbyMo8TaRx7CVX80Nqm9enslUp7
        jI6GfJ8E14uXYrcK7qicwdYvJeJtTyYJP3Wg2oR1kA==
X-Google-Smtp-Source: AFSGD/WlrJTS4nLxXc7n8liIFxdoeuBTLJjhN2CyvNm/C4SatYraWiKatujMabHisnV1sYF/h5QKsVSYXClnsHJyLEY=
X-Received: by 2002:a19:f813:: with SMTP id a19mr13943266lff.67.1544020940246;
 Wed, 05 Dec 2018 06:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20181205124721.26624-1-linus.walleij@linaro.org>
 <20181205124721.26624-7-linus.walleij@linaro.org> <20181205134345.GF16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181205134345.GF16508@imbe.wolfsonmicro.main>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 15:42:06 +0100
Message-ID: <CACRpkdbJsTc2tAyTriz33a75d-1tJdcvdock0fxi7HdJ+EH_Dw@mail.gmail.com>
Subject: Re: [PATCH 06/15 v3] regulator: max8973: Let core handle GPIO descriptor
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 2:43 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Wed, Dec 05, 2018 at 01:47:12PM +0100, Linus Walleij wrote:
> > Use the gpiod_get() rather than the devm_* version so that the
> > regulator core can handle the lifecycle of these descriptors.
> >
> > Fixes: e7d2be696faa ("regulator: max8973: Pass descriptor instead of GPIO number")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v2->v3:
> > - Resending.
> > ChangeLog v1->v2:
> > - Drop the gpiod_put() on the errorpath after devm_regulator_register()
> >   as this will be handled by the regulator core.
> > - Fix the second case of devm_gpiod_get()
> > - Put a comment in the code so maintainers knows not to
> >   use managed resources (devm*)
> > ---
> > @@ -775,10 +779,13 @@ static int max8973_probe(struct i2c_client *client,
> >               /*
> >                * We do not let the core switch this regulator on/off,
> >                * we just leave it on.
> > +              *
> > +              * Do not use devm* here: the regulator core takes over the
> > +              * lifecycle management of the GPIO descriptor.
> >                */
> > -             gpiod = devm_gpiod_get_optional(&client->dev,
> > -                                             "maxim,enable",
> > -                                             GPIOD_OUT_HIGH);
> > +             gpiod = gpiod_get_optional(&client->dev,
> > +                                        "maxim,enable",
> > +                                        GPIOD_OUT_HIGH);
>
> My comment on v2 still stands here, the GPIO is not passed to
> the regulator core on this path.

Patch 01 should take care of that, did you check it?

Yours,
Linus Walleij
