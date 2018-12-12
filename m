Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A3E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PekGsXjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A3E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLLGOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:14:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40912 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:14:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so4570991wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 22:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4368CCz7ceqRLqtxUqHIJdJ3I12lTjX+NZG4iiXirmU=;
        b=PekGsXjfTuC6ampp23RbY601TffXmVnIgFFJl8L/A3/V3MH9Iu3AuNK/PxnMQOu/78
         uFvPlqBtsV15qgrh7b0ymRKZD6NZ+OudonQw04IGL6iVLkXDdKkf67qdLmuXQ1yBOHQH
         YnNo4YcaxM1diqwqfW32JR0uspxWLLc99xsZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4368CCz7ceqRLqtxUqHIJdJ3I12lTjX+NZG4iiXirmU=;
        b=G+/W3tLGTEeVT5dBHEy5uOwv07RtcAADfjX4/C5qNZg/J3oHKYcTybXuwtabSwTlSu
         9E7SBj05koK3OyZX0fx7GXLeQYVvWX4WV2t08CyORAV/qStORFdjdSHQLOqTHiHi1u5s
         7yjJviIlYGGy0RBjbWtWmtFlp3dLHdgf1uuv+E2nJ4Gz20jjM91LIwy7RMM4vtdDe0W3
         TD7Jw1kKHmTDSCd+Tnz4FIt/BHic69mUnkUxjyGgN5Ax2F4P6XSN2QEJF2vnlN2WkFF3
         p+SHVZtILbJTGLLNNu6AFaPUnLcn8JY3kJ/59G0+0GohjgjpJgKPeRyzF/hr7loSBFBl
         vpNA==
X-Gm-Message-State: AA+aEWYCu+W9KUiFtWWnTPYhWVwDA8YAfQ90vK08V581JqulXTybjLLa
        qjk3uQy6fV6J3/qI9z2yQRI+Xw==
X-Google-Smtp-Source: AFSGD/VRbQi9wBgwSVxpEJAWKeK5BHQ8b6I5WxjqmWcwyP4+Ew27Zt0IU4wXsYzbMXklz5BP8SENvQ==
X-Received: by 2002:a1c:848c:: with SMTP id g134mr4718741wmd.93.1544595248174;
        Tue, 11 Dec 2018 22:14:08 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id x3sm33525591wrd.19.2018.12.11.22.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 22:14:07 -0800 (PST)
Date:   Wed, 12 Dec 2018 06:14:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, robert.jarzmik@free.fr,
        daniel.thompson@linaro.org, kernel@collabora.com, heiko@sntech.de,
        stable@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [RESEND PATCH v3] backlight: pwm_bl: Fix brightness levels for
 non-DT case.
Message-ID: <20181212061404.GK4497@dell>
References: <20181210121437.30170-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210121437.30170-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, Enric Balletbo i Serra wrote:

> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye")' allows the possibility to compute a default
> brightness table when there isn't the brightness-levels property in the
> DT. Unfortunately the changes made broke the pwm backlight for the
> non-DT boards.
> 
> Usually, the non-DT boards don't pass the brightness levels via platform
> data, instead, it sets the max_brightness in their platform data and the
> driver calculates the level without a table. The offending patch assumed
> that when there is no brightness levels table we should create one, but this
> is clearly wrong for the non-DT case.
> 
> After this patch the code handles the DT and the non-DT case taking in
> consideration also if max_brightness is set or not.
> 
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Cc: <stable@vger.kernel.org>
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> 
> Changes in v3:
> - Fixed some typos in commit message.
> - Removed ' in Fixes tag.
> 
> Changes in v2:
> - Rebase on top of mainline
> - Add Tested-by and Acked-by tags.
> 
>  drivers/video/backlight/pwm_bl.c | 41 +++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)

FYI, this patch is now in Mainline.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
