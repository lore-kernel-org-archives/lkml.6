Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3EB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXf8Yzsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3EB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbeLCHHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:07:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLCHHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:07:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so10890997wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 23:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WEOZR9xSFVjqHvE33ySvpJqV9F90/x6lhhmYYgQP3kI=;
        b=BXf8YzsgyUNDYM4OpFzibn74Dr4byLcExFQGkV+Zo42blSxIh/H1jzIsH8rwH1ktS+
         fPnlEX1au1QthM1IjfnlSnwuh9RJTfdRjNsywy5/AHFa49G/zGxjoCAKwNQR+8OUpw9L
         fZ+FbZU2NQuix/tkQzq6gPCtVfH2qzPteeqlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WEOZR9xSFVjqHvE33ySvpJqV9F90/x6lhhmYYgQP3kI=;
        b=UnSEB1GAwPqYcmhIU8ESL1/nk/MnVeKhTKX7sXoLW7Iha3CPStsQ1EmOXFX+6Nw5Uu
         QWytW+5uWLyJP90GnU0l+EKtjxwtJLy0frR9TsBKy139lnJhJGbS3cBJVTcpdkAQ3rPV
         lcw1k9pchupNn0MPJARVV6Gw2J57L0Q9QMV1AzHDsSTXeLKTNOHQyKkv7G/xsB5uF+01
         Nv4kioG7kiKg/3rMwCvailP0KzXrcSrahJK0MdsY7zb8HZPi1U4mybQm97Z0mc08Exfh
         +K6mhNJmSQugnWR2xJWTWkrreF20FDUnXDxFskESFVjEn6t16hV9PUednncw/26DYmWD
         xD/Q==
X-Gm-Message-State: AA+aEWailPe3Ps6ZPK+tdcQd4ENcrychunXTO0ets38wEAIV2iSkDSmF
        1wL+a9sizH2U3rrTcOkkZ3Tjkg==
X-Google-Smtp-Source: AFSGD/WwmRigedoPfb0oSFEr157qOVa2Mz7fDL0wahStvCxk1fAQ2V0oWoDruA11xOLR/wQE/cVtrQ==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr12330886wrx.79.1543820861691;
        Sun, 02 Dec 2018 23:07:41 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id o4sm4970208wmo.29.2018.12.02.23.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 23:07:40 -0800 (PST)
Date:   Mon, 3 Dec 2018 07:07:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        robert.jarzmik@free.fr,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kernel@collabora.com,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        stable@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v3] backlight: pwm_bl: Fix brightness levels for non-DT
 case.
Message-ID: <20181203070739.GK6009@dell>
References: <20181107085507.26126-1-enric.balletbo@collabora.com>
 <CAFqH_53NiYULqcc+2fCgbHETJoTc7tWD8BNxOFhPm6kFZ=e6_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_53NiYULqcc+2fCgbHETJoTc7tWD8BNxOFhPm6kFZ=e6_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Enric Balletbo Serra wrote:

> Hi,
> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
> dia dc., 7 de nov. 2018 a les 9:56:
> >
> > Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye")' allows the possibility to compute a default
> > brightness table when there isn't the brightness-levels property in the
> > DT. Unfortunately the changes made broke the pwm backlight for the
> > non-DT boards.
> >
> > Usually, the non-DT boards don't pass the brightness levels via platform
> > data, instead, it sets the max_brightness in their platform data and the
> > driver calculates the level without a table. The offending patch assumed
> > that when there is no brightness levels table we should create one, but this
> > is clearly wrong for the non-DT case.
> >
> > After this patch the code handles the DT and the non-DT case taking in
> > consideration also if max_brightness is set or not.
> >
> > Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >
> > Changes in v3:
> > - Fixed some typos in commit message.
> > - Removed ' in Fixes tag.
> >
> > Changes in v2:
> > - Rebase on top of mainline
> > - Add Tested-by and Acked-by tags.
> >
> >  drivers/video/backlight/pwm_bl.c | 41 +++++++++++++++++++++++++++-----
> >  1 file changed, 35 insertions(+), 6 deletions(-)

[...]

> A gentle ping on this patch.

Don't do that.

If you think that it's been forgotten, send it again as a [RESEND].

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
