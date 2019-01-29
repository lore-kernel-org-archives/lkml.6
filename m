Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDFFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB5E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ganX7ifr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfA2PMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:12:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53146 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2PMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:12:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so18244259wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vNZ5FJ7cxIMAaxbhIhbHCzmHy341mREO1gfpm3+S9gI=;
        b=ganX7ifrtp5tHj6ni1+LPVWP1E17F8xIGdm7jPsOh7pTgepdccnF2KaBhkLZk0bsEO
         KWM3WIriSYx6AbD3+3QDu0fInI0fAARwj/YG67JXNKsQXT1YU4ea1IWUmKu8f1J2Xb60
         j1vkl34Cro1sm5lCT0LI+i0bbX1fSSeaCyH1Txm6kO12fRVWpId6CtUjApyFniqSdR1T
         I6qO9V48oBkyREa+ezNnhmMABmZUFQdAWNxy09MsCn95ndTOubJbsGD3PdTVsFIjMqJI
         z2QAfgWwQW40O2SFwHt9WMHiHdSMZ31fRoftP6LpgX/BUYRShxF895WPuBArRCheanKS
         OLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vNZ5FJ7cxIMAaxbhIhbHCzmHy341mREO1gfpm3+S9gI=;
        b=lv7Q8CisvPFRi5+sTWaB5NWSwu1bhItYtOXFu4wS0r1W843wk0KoG93dxp7RqTqb4W
         iyfQwn265My6eF1FrAg5APSvxGhifc15ecxBgSQh+kMER5JPoew/1SzRv/v24tKQEc+G
         GHPSLJksFt3ZzPjUI1fotLpO017x9sLpMtlMLi+sIadpU8H78HuVMFQDUKeSnMONw6fp
         x7N5Yk2FivqRPwvzjwIEtWLJmLmsLraHHuzVNZXZUnuiBrYB0Y+vri+6y0VvaJcG/AoY
         EFaJdD4Ienh1M+aUZ9BD7HDPU3hjmKc0MksigHZ9CnJVqje8BNQ59E15ZfT+/Z2R3ZtV
         Gurw==
X-Gm-Message-State: AJcUukfnl4WEE39eh8BDrMSUxfPfN0R/qogfP59ONY/ipt1Of8K8GcnT
        fdUmDEgqp1kZuOEXbbLKPLw1cg==
X-Google-Smtp-Source: ALg8bN6L5HiBonH/xydVY8vwKwxq8H7DS1iyrX1T/hefVcJGQR+A0hsHu4l/9SSJFXhLQwTERu+uTw==
X-Received: by 2002:a1c:2944:: with SMTP id p65mr21261486wmp.20.1548774731567;
        Tue, 29 Jan 2019 07:12:11 -0800 (PST)
Received: from localhost (aputeaux-684-1-12-29.w90-86.abo.wanadoo.fr. [90.86.215.29])
        by smtp.googlemail.com with ESMTPSA id x81sm3069370wmg.17.2019.01.29.07.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 07:12:10 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 2/2] reset: meson: add g12a compatible string
In-Reply-To: <20190128181316.30814-3-jbrunet@baylibre.com>
References: <20190128181316.30814-1-jbrunet@baylibre.com> <20190128181316.30814-3-jbrunet@baylibre.com>
Date:   Tue, 29 Jan 2019 16:12:10 +0100
Message-ID: <7hwomno5v9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add a compatible for the new g12a SoC family.
>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/reset-meson.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 5242e0679df7..a8f6549b3af4 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -134,6 +134,7 @@ static const struct of_device_id meson_reset_dt_ids[] = {
>  	 { .compatible = "amlogic,meson8b-reset" },
>  	 { .compatible = "amlogic,meson-gxbb-reset" },
>  	 { .compatible = "amlogic,meson-axg-reset" },
> +	 { .compatible = "amlogic,meson-g12a-reset" },
>  	 { /* sentinel */ },

Looks like this new compatiable isn't used for anything new in the
driver.  Let's not add a new compatible unless it's needed fo rnew
behavior.

Kevin
