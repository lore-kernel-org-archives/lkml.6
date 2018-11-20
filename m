Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D8BC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB07206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1ErwV3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB07206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeKUE0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:26:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40208 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKUE0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:26:22 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so1611367vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1iN3kJ3Yii0NgcyvRUh5/L4P/vz6kGdrAZ+IDzWbW0=;
        b=X1ErwV3nL3Bp6i2WGlEg6BYwJKWcuQ78jc7LzwC8zJ4l1LEuugQAly2UoGvZouvq/m
         MdURa6NlHvW0pAqZD9/eCFXo35BujgB6IWkhRObuQo93PBUfrfSlZkS74zZi3OrnxFBi
         mrBGeFP+FsR5103e4XKsab67Zu3/11wVKy2D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1iN3kJ3Yii0NgcyvRUh5/L4P/vz6kGdrAZ+IDzWbW0=;
        b=QegbH5Gmz/+Ku3/9VgLBZE0gSFKtM4SyLA1zQfaMcRPPhz0slJHRKeZikP6Sh8g3Xu
         8h2RxZ28H2OOE3IMXcUeUzgFIwxezv29gfnOG+81MvPsnwTgnRTgfUul9SilF+cgWDGM
         7HeFaa/e68bUHbYwpSlGcITVLBvgaKFJv1LTkySJwT6C9lCdzc94IapcuwK6W/8O+6Ky
         +MmcLjR7mIlp3z1Apbb2FrhO46uqda2sxbuwvo7ONblsdeBegpOTRR0SvcCuNqdk2NqT
         Bm0EWdK0NOGter8FKGGJZ8tv8VKxG7KQ09qgROhJp3/BEPikMycdb2xWuZNK4Sw2z5wW
         kz4w==
X-Gm-Message-State: AGRZ1gJSVcqmhLWiSIYSV6s+77lXkmsOfhJcD3ZyLgmSs5xbH0lEza9y
        XAF5pftC9o9C7xE8ev4CIjAs1VGD4pM=
X-Google-Smtp-Source: AFSGD/XO5VyuVLnAApIWSkmR8dXySlulQaomv2y/XC3USxFEes7YmfISd/q/+VfU06qbnBXC3svtlA==
X-Received: by 2002:a67:6d42:: with SMTP id i63mr1299730vsc.158.1542736558675;
        Tue, 20 Nov 2018 09:55:58 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id n136sm12125915vka.20.2018.11.20.09.55.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:55:57 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id t17so1603943vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:55:56 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr1162702vsv.20.1542736556340;
 Tue, 20 Nov 2018 09:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-7-dianders@chromium.org>
In-Reply-To: <20181120002654.1891-7-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 09:55:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJ4rKV6N9b82dDf5iWFYO9pFKZXAr0Ud4R-C0+CccyoA@mail.gmail.com>
Message-ID: <CAD=FV=UJ4rKV6N9b82dDf5iWFYO9pFKZXAr0Ud4R-C0+CccyoA@mail.gmail.com>
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in regulator_force_disable()
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 4:27 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> In regulator_force_disable() there was a strange loop that looked like:
>
>   while (rdev->open_count--)
>     regulator_disable(rdev->supply);
>
> I'm not totally sure what the goal was for this loop, but it seems
> wrong to me.  If anything I think maybe we should have been looping
> over our use_count, but even that might be a little strange.  For now
> let's just remove the code and we can add something back in if someone
> can explain what's expected.
>
> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/regulator/core.c | 4 ----
>  1 file changed, 4 deletions(-)

For breadcrumbs: the next version of this patch is now squashed into
("[PATCH v2 2/2] regulator: core: Avoid propagating to supplies when
possible") AKA <http://lkml.kernel.org/r/20181120175255.227783-2-dianders@chromium.org>

-Doug
