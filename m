Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3737C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C3E2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8sbRvAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C3E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeLDRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:35:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37539 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeLDRfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:35:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so8651598plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQWqAKSkbFcoLgFgdbbMkPp5oPBb3CWPSk7Z0zJ87EU=;
        b=O8sbRvABWYknYOld6OU5g2vjz/xxmdgnPCVfwR2f/8PfD47igWofUXh+5MGZSxNuWu
         lUQQXmCg5KqlgLEtVaSWQQvrkS4Xd5XT46X0kqHvsnA1amnWzdokg3E/4B51nN1ANai6
         DUUwUTTroB/qPUa5TThFY1ZAFm2ceQN+oizb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQWqAKSkbFcoLgFgdbbMkPp5oPBb3CWPSk7Z0zJ87EU=;
        b=Wr725Nh9BJ2YNkTP8R9jLwE6F3M5apiXvlqy+L3D8TRtzHlmEX3+DqMPhIQaogOBw5
         mb/6D1IL3q5XYEpDYLHG6LpBMuGeN98dYTnsP5Lby2sdsdlliZYrFiugkWIPyvq+sRqY
         mOvpofqvqEJwbuVA3Ru6V+a6vPothemCOvy456+dVu/I1CC7dxtBZcLvzQ9XJkGvg0eH
         bkg21S/ijzGhlAM6fjOHVkBWfNc43kt/SUfPZdEuZQmzk1YzhXNKpVGCeFbXkctjuJY2
         /MiU/Ha6k1A2zVnQvqgZJ1k6NcTQKXvoihLeeUcDQ75lj1TjxuGaseBJXXJh4qwTzV93
         DiiQ==
X-Gm-Message-State: AA+aEWYZvJUH+XzBQ9eIwxXm+q55EVqJH3WBNhZ3s2Hketor2zWtrIV7
        I5PyS+4z0KhUcLizKUNDhtnfeA==
X-Google-Smtp-Source: AFSGD/Wswy+ymUxqeg9as8PAQ+anwvq9GinVCZXtQyyf5kvaOBoaO7KyZO3vl2a2W/9u9pRXIKIKnw==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr20992849pld.8.1543944950438;
        Tue, 04 Dec 2018 09:35:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id v191sm21066159pgb.77.2018.12.04.09.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:35:49 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:35:49 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from
 the DT
Message-ID: <20181204173549.GB14307@google.com>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-3-mka@chromium.org>
 <154394184065.88331.4558186365546696323@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154394184065.88331.4558186365546696323@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 08:44:00AM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-11-30 16:52:48)
> > Get the ref clock of the PHY from the device tree instead of
> > hardcoding its name and rate. Use default values if the ref
> > clock is not specified.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v3:
> > - use default name and rate if the ref clock is not specified
> >   in the DT
> > - store vco_ref_clk_name instead of vco_ref_clk
> > - fixed check for EPROBE_DEFER
> > - renamed VCO_REF_CLK_RATE to VCO_REF_CLK_DEFAULT_RATE
> > 
> > Changes in v2:
> > - patch added to the series
> > ---
> >  .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 28 +++++++++++++++----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
> > index 49008451085b8..3af678d3317f6 100644
> > --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
> > +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
> > @@ -47,9 +47,9 @@
> >  
> >  #define NUM_PROVIDED_CLKS      2
> >  
> > -#define VCO_REF_CLK_RATE       27000000
> > -#define VCO_MIN_RATE           600000000
> > -#define VCO_MAX_RATE           1200000000
> > +#define VCO_REF_CLK_DEFAULT_RATE       27000000
> > +#define VCO_MIN_RATE                   600000000
> > +#define VCO_MAX_RATE                   1200000000
> >  
> >  #define DSI_BYTE_PLL_CLK       0
> >  #define DSI_PIXEL_PLL_CLK      1
> > @@ -75,6 +75,8 @@ struct dsi_pll_28nm {
> >         struct platform_device *pdev;
> >         void __iomem *mmio;
> >  
> > +       const char *vco_ref_clk_name;
> 
> Can this be passed around during clk registration so we don't have to
> store it away in the structure?

makes sense, will do

> > +
> >         /* custom byte clock divider */
> >         struct clk_bytediv *bytediv;
> >  
> > @@ -125,7 +127,10 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> >         DBG("rate=%lu, parent's=%lu", rate, parent_rate);
> >  
> >         temp = rate / 10;
> > -       val = VCO_REF_CLK_RATE / 10;
> > +       if (parent_rate)
> > +               val = parent_rate / 10;
> > +       else
> > +               val = VCO_REF_CLK_DEFAULT_RATE / 10;
> 
> Is the clk not properly hooked up to a parent sometimes so parent_rate
> is 0? That sounds odd given the fact that it used to be 'pxo' and that
> has always existed on the system as 27 MHz. So I'd remove this and just
> use parent_rate all the time.

I wondered about this, but since I don't have hardware for testing I
kept the previous hardcoded rate. If we know for sure that 'pxo'
always exists it should indeed be fine to use the parent rate.
