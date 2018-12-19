Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D57C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B535320874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PyRH7yQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeLSWWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:22:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLSWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:22:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so10489069pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 14:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bw2ZDnC/IKpdYZMRJtQLezEpanKWYRsvUQ8mNcqY+BA=;
        b=PyRH7yQ6s0OXNfNBSoQL3jF1LcQpS9k9FqvaM1Shb3y7V+vYdRDHB7WGWaXKZoQ13t
         fLDirQmEO0uBI0VZJxsEYV7VbQrekj3WxYLDotGMZ/mJ0qT2OP8cYCovzlGjs00iafjP
         L59G/LXW8j8ydplSHPx3qHI4sflg0QLkMOpCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bw2ZDnC/IKpdYZMRJtQLezEpanKWYRsvUQ8mNcqY+BA=;
        b=GAtyHwudW22w+GvGBBk8UNyq7VP2UIreBE9AT7cKMZal7MI1qyAkFklEAVnlkgU5fX
         Jnp7QexfwQZ8KgT/LhvKL2VKLrE70r9uaKajMCew9TD9Ys+A1HGgD4y5/5YRAEvoXnzc
         +aG0KsRPJUXkhZGsL7oGKhW6AZ0N1ZDE3avRgNt6opCifYrQqFlSrhwxx0AxdRBmRLzM
         lDqh2Y3KdzAasVhvlHiFEoBHt31hS0zaFTzIKrcgrSrbPsUH883qRb41YcbUwWzGz0AA
         RT3FwSLk/v9iNCF1ffBmjqRHCgmHO+j/JSE0e0TQCWJ3Bjv3m8d70a5OT/EZgc6sCfWq
         1UgQ==
X-Gm-Message-State: AA+aEWYaEKHX4om8wFRv0XZgN9suR0wayoWzj7r+L0AFri4HOBqS/Cts
        8WGYUdd7QRB5xQjhIbfu68/e6w==
X-Google-Smtp-Source: AFSGD/UoPH6rqzhCfiD1lwFyJJ2//dlSNBcwkKoQqVyZWHdljbe21ED+N4pUwc7oUetR7fOH6wgpGw==
X-Received: by 2002:a63:20e:: with SMTP id 14mr20881807pgc.161.1545258143585;
        Wed, 19 Dec 2018 14:22:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p6sm24663237pfn.53.2018.12.19.14.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 14:22:22 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:22:22 -0800
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
Subject: Re: [PATCH v4 4/8] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
Message-ID: <20181219222222.GA261387@google.com>
References: <20181204224234.62619-1-mka@chromium.org>
 <20181204224234.62619-5-mka@chromium.org>
 <154445707953.17204.10100324387384439759@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154445707953.17204.10100324387384439759@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:51:19AM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-12-04 14:42:30)
> > diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> > index 71fe60e5f01f1..032bf3e8614bd 100644
> > --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> > +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> > @@ -40,7 +40,6 @@
> >  
> >  #define NUM_PROVIDED_CLKS              2
> >  
> > -#define VCO_REF_CLK_RATE               19200000
> >  #define VCO_MIN_RATE                   1300000000UL
> >  #define VCO_MAX_RATE                   2600000000UL
> >  
> > @@ -139,6 +138,7 @@ struct dsi_pll_14nm {
> >         /* protects REG_DSI_14nm_PHY_CMN_CLK_CFG0 register */
> >         spinlock_t postdiv_lock;
> >  
> > +       struct clk *vco_ref_clk;
> 
> Is there any need to keep it in the struct? Or just get the clk, find
> the rate, and then put the clk and call pll_14nm_postdiv_register()?

I suppose you mean passing the clock name to pll_14nm_register()?

Is putting the clock really needed or preferable, or is it just fine
to auto-put it when the device is deleted?
