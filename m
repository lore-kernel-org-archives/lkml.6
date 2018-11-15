Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC699C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B20223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1r27Yl+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B20223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbeKOTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:21:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52803 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbeKOTVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:21:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so17999154wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bfX5P11OyBsAQuXqKaR63p+tI0WxZ954PtNdaT6pSjo=;
        b=1r27Yl+pDmtCdxmHFCM4NpHjJp3LzO4KMAeQvrERbP3wpv2jCNdyH2OFtx/h4v+Ry0
         5lXQsWh86kKaV2cYXVTq7M0VGYciPDEr43rFrf0g8OAHydP0N3p5rpi8QDdxvgunV0rj
         V6ozm/kRtI68qUge3FRxL1OBrd+k0w27TIs8MK0W1NPELtDjbK15qHF1lrwbm/9l+xl5
         mZOOshEnw7w1BD0qIDOROLgcuBppgst5unZqhoa6xvCEKZQtGyA1K0UvJrcRwSZMg7Ec
         iIiY3ZdzA58Ml1/NoIWnVFikoIA+jrPz8SXGaFl4uYQuHIv7CoUBolKyuCjBtXlEZlWW
         bFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bfX5P11OyBsAQuXqKaR63p+tI0WxZ954PtNdaT6pSjo=;
        b=pXlZh0nK3U+YLY0Y74CXbdOKTpy0+rojY1kEOg5ws5cjWkfVKaUveIMBh0N+3UGkXf
         CGIPBjjo1VvscvDInVh1Wip2bTjkNG6Ojg4BiEJtgsriZIkZmsg8QxLJL9OA4reIzHTY
         fq7ZAM9T0gdPpCWmY/rlOJidwl9l+YgkdsHtZ0vdRIa6vOpPIFQ6zijirOZ4ZS2pJtZE
         EhDNcCRWUFems/8ZnPGNBDJm5kdWhp9ByKZC3H7uyd6iOThaCJduWF5+Oz8s7nTXis0M
         AUTKH7um33UNKkuMz6fJIM9QuiEOML/kk5CakG9mTRNnBHiPsdVe8b7UCETQ8LgcLJr7
         ZSVQ==
X-Gm-Message-State: AGRZ1gKhvb8NOJBX3AOsjRyZu09z6jdUuXd0nDgK+QBXDf8Eu2fP0HT7
        eSAGZ2hW+6ndkIMDbzNpUz98tw==
X-Google-Smtp-Source: AJdET5eh2RwBtSSJV3c1cTDOydmueJiH2aRX/ChmorPl2Od+TFSzdu+iJFRyIH9AjCpfsfvfRZeEyA==
X-Received: by 2002:a1c:545e:: with SMTP id p30-v6mr4398441wmi.69.1542273256617;
        Thu, 15 Nov 2018 01:14:16 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id g8-v6sm29084603wri.58.2018.11.15.01.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 01:14:15 -0800 (PST)
Message-ID: <b1d223c2d2a9229cfb27275c948a7ff4b3aef93d.camel@baylibre.com>
Subject: Re: [RFC v1 3/7] clk: meson: clk-pll: check if the clock is already
 enabled
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Date:   Thu, 15 Nov 2018 10:14:13 +0100
In-Reply-To: <20181114225725.2821-4-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
         <20181114225725.2821-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") our
> PLLs also support the "enable" bit. Currently meson_clk_pll_enable
> unconditionally resets the PLL, enables it, takes it out of reset and
> waits until it is locked.
> 
> This works fine for our current clock trees. However, there will be a
> problem once we allow modifications to sys_pll on Meson8, Meson8b and
> Meson8m2 (which will be required for CPU frequency scaling):
> the CPU clock is derived from the sys_pll clock. Once clk_enable is
> called on the CPU clock this will be propagated by the common clock
> framework up until the sys_pll clock. If we reset the PLL
> unconditionally in meson_clk_pll_enable the CPU will be stopped (on
> Meson8, Meson8b and Meson8m2).
> To prevent this we simply check if the PLL is already enabled and do
> reset the PLL if it's already enabled and locked.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/clk-pll.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index f5b5b3fabe3c..b46cca953f4f 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -200,11 +200,32 @@ static void meson_clk_pll_init(struct clk_hw *hw)
>  	}
>  }
>  
> +static int meson_clk_pll_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> +
> +	if (meson_parm_read(clk->map, &pll->rst))
> +		return 0;
> +
> +	if (!meson_parm_read(clk->map, &pll->en))
> +		return 0;
> +
> +	if (!meson_parm_read(clk->map, &pll->l))
> +		return 0;

Could you use an OR instead of these 3 seperate checks ?

> +
> +	return 1;
> +}
> +
>  static int meson_clk_pll_enable(struct clk_hw *hw)
>  {
>  	struct clk_regmap *clk = to_clk_regmap(hw);
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  
> +	/* do nothing if the PLL is already enabled */
> +	if (meson_clk_pll_is_enabled(hw))
> +		return 0;
> +
>  	/* Make sure the pll is in reset */
>  	meson_parm_write(clk->map, &pll->rst, 1);
> 
>  

With the small comment above taken care of, it makes perfect sense
and it will be valuable to other PLLs, Thx Martin !

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>


