Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682E02087E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8neoLnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682E02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeKOKCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:02:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43663 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeKOKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:02:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so8098806pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYwvw4CCvWN7nmt5+MPowfiTeIWOXdMhQ6m2Rk92D90=;
        b=Z8neoLnMuSH26cCOu1dQQwUzJd4YtjyuZHuxdvqVoJ8+70lB6UmT7EbWp3mJcueiTs
         01cjLgIglbE81S0ATxFVtExtvpYNRh+JfCIGFitm8snqkLlWbpjf0u6ZXzHt0UQhRjW1
         tsRf5iqnbceAeuhZmvALln3XWtssvlQJyYqqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYwvw4CCvWN7nmt5+MPowfiTeIWOXdMhQ6m2Rk92D90=;
        b=t4uxjkNa1PWjR4tHT7jgfU1iwgMvYmrn0GqmFJBmAVf4G/FReY8ZbN1bCGfAeAax//
         8CEBSceeHoiQ9n7fmTpC5608BpomXEoyLP+nUNVwfOddEK/GAhH8wGtcV2KIJyDASPcx
         b4ZTeVpKIdFGrW8w+9QtowOnsBE5mGV1wRzzJODPJZurumM6fQVw6yuCIAGhQa2Ra1lS
         SCztT/7bCLwVVHyY5mtC+zAVGQr+qvvBH+miA4AoEGKrew1496U1jzpj12rPlqleZABs
         vBizazRQpCXVjQ+h4+dp81xPMCbSRJCoITcD8yWs+1T6lHaPl9BafPZMoT4t9BVvEkyB
         HK8g==
X-Gm-Message-State: AGRZ1gIJo/UJ4ShnsexzxheGkeKKel3+9k9fW8zt17DVZNwbkslhDXGP
        wEaUGto9130QP8/TzxiJJdxIkQ==
X-Google-Smtp-Source: AJdET5eeMJmXOGlO9I1LanjuCBgZUyj+6zXyTvQz0i3XRMv6vyXLZw+wlBrgS7HJKLAou2qvAtuB3w==
X-Received: by 2002:a63:104d:: with SMTP id 13mr3658821pgq.303.1542239791942;
        Wed, 14 Nov 2018 15:56:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 71-v6sm5884910pfs.108.2018.11.14.15.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 15:56:31 -0800 (PST)
Date:   Wed, 14 Nov 2018 15:56:30 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>, ryadav@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the DT
Message-ID: <20181114235630.GO22824@google.com>
References: <20181102214534.184593-1-mka@chromium.org>
 <20181102214534.184593-2-mka@chromium.org>
 <CAD=FV=Vyv5sRhJNgpP6Gnn3+6zRjGsT8RozCY6xx51Tr_hRoeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vyv5sRhJNgpP6Gnn3+6zRjGsT8RozCY6xx51Tr_hRoeg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 02:04:31PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Nov 2, 2018 at 2:45 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Get the PHY ref clock from the device tree instead of hardcoding
> > its name and rate.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > index 4c03f0b7343ed..1016eb50df8f5 100644
> > --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > @@ -91,6 +91,8 @@ struct dsi_pll_10nm {
> >         void __iomem *phy_cmn_mmio;
> >         void __iomem *mmio;
> >
> > +       struct clk *vco_ref_clk;
> > +
> >         u64 vco_ref_clk_rate;
> >         u64 vco_current_rate;
> >
> > @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
> >         char clk_name[32], parent[32], vco_name[32];
> >         char parent2[32], parent3[32], parent4[32];
> >         struct clk_init_data vco_init = {
> > -               .parent_names = (const char *[]){ "xo" },
> > +               .parent_names = (const char *[]){
> > +                       __clk_get_name(pll_10nm->vco_ref_clk) },
> >                 .num_parents = 1,
> >                 .name = vco_name,
> >                 .flags = CLK_IGNORE_UNUSED,
> > @@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
> >         pll_10nm->id = id;
> >         pll_10nm_list[id] = pll_10nm;
> >
> > +       pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> > +       if (IS_ERR(pll_10nm->vco_ref_clk)) {
> > +               dev_err(&pdev->dev, "couldn't get 'ref' clock\n");
> > +               return (void *)pll_10nm->vco_ref_clk;
> > +       }
> 
> So, ummmm.  Can you follow the same pattern for all the other clocks
> in this file too?  All parents should get their name based on
> references in the device tree.
> 
> It turns out that right now we have a mismatch because
> "drivers/clk/qcom/dispcc-sdm845.c" calls "dsi0pllbyte"
> "dsi0_phy_pll_out_byteclk" and calls "dsi0pll"
> "dsi0_phy_pll_out_dsiclk".  We might want to change the names in
> dispcc-sdm845.c, but it wouldn't matter if we simply didn't hardcode
> them here.

Hm, I understand the problem, but not quite what you mean with 'follow
the same pattern'. The VCO ref clock is an 'external'/existing clock,
hence it can be specificed in the DT and obtained with
_clk_get(). However the clocks you mention above are 'created' by the
PHY driver, so we could only specify their names in the DT, not sure
if that's what you are suggesting. I guess 'clock-output-names' could
be used, though it isn't really useful to describe the names in a
clock tree. If you still think this should be done please share how
you envision the DT entries to look.

Cheers

Matthias
