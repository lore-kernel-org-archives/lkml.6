Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAD7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF4B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mu2d72Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF4B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeKOHNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:13:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41862 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOHNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:13:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id p16-v6so8353170plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 13:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hhATIM5ddoaIRg5Yx2uWaB9QBa3qEhdoYToowwuZbBQ=;
        b=Mu2d72Bvcdw5uYffN3WnUAZuS6Fdg5tz+fQv2/959rAN9WT2uNi1T1Dg7p+imzNosy
         +XWo4k10dHnHoki2hxVzJBSc5MDjadt9zW5rUB/Yj1ocIYKUZlnOxeABVcZ9oQjTfXdu
         gFseBCfNoJ/yVWaXDLxv7Q7QxRZ/BdQ3Rc34s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hhATIM5ddoaIRg5Yx2uWaB9QBa3qEhdoYToowwuZbBQ=;
        b=Qg4bRb7MqTMm6F4nY1sK5Hfpt81qqIRlV9OQXNrAi3nQb6mcIHorFR57LXNZ+X8iD7
         b3/QTaGmFHUPTrScMn6Gq+txRjx/O980qZrDPWkkq++tWBE104cOD0R5T2yHTf55U3Rs
         +c1V3BVX+FRPX2dXThiIs6tmmj0Ap5V6uWzAvzwi4kelI16w4OakZ9kNOZGdbKkLrril
         563SGWiFPTw5qAHjraDbc7roSftmtzEF7o8PAzuUMK++YivEMl5ROnTEDwrNuK+1HgTM
         xLVc/4CRJdoBpnFs2TmMgv6t/5Hf5kfYUMpTPqhGzxD/Awk6edou/3X7FdWzysAq8yMf
         k1kw==
X-Gm-Message-State: AGRZ1gJPovChhHTCh7e/HKvD9imiFp3C0m+C+g4it/r32s9kuVsRu0yU
        Nn6R0UseegRe/JZZU//Gepeiww==
X-Google-Smtp-Source: AJdET5fsYhv02r+pmTyedA1XasgmKnyU5mbW2/qVMHb/Tp2rRPe40NsLQAQrG+QLTq7kl/OQWOYbMg==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3-v6mr3497412plo.162.1542229738013;
        Wed, 14 Nov 2018 13:08:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a73sm9250299pfa.7.2018.11.14.13.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 13:08:57 -0800 (PST)
Date:   Wed, 14 Nov 2018 13:08:56 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sean Paul <sean@poorly.run>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the
 DT
Message-ID: <20181114210856.GK22824@google.com>
References: <20181102214534.184593-1-mka@chromium.org>
 <20181102214534.184593-2-mka@chromium.org>
 <20181105173304.GJ154160@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105173304.GJ154160@art_vandelay>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:33:04PM -0500, Sean Paul wrote:
> On Fri, Nov 02, 2018 at 02:45:34PM -0700, Matthias Kaehlcke wrote:
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
> >  	void __iomem *phy_cmn_mmio;
> >  	void __iomem *mmio;
> >  
> > +	struct clk *vco_ref_clk;
> > +
> >  	u64 vco_ref_clk_rate;
> >  	u64 vco_current_rate;
> >  
> > @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
> >  	char clk_name[32], parent[32], vco_name[32];
> >  	char parent2[32], parent3[32], parent4[32];
> >  	struct clk_init_data vco_init = {
> > -		.parent_names = (const char *[]){ "xo" },
> > +		.parent_names = (const char *[]){
> > +			__clk_get_name(pll_10nm->vco_ref_clk) },
> >  		.num_parents = 1,
> 
> You should check the return of __clk_get_name() since you're setting num_parents
> to 1.

Is that actually needed? __clk_get_name() only returns NULL if the
passed clock is NULL, and this can't happen here since _init() fails
if the clock can't be obtained, or am I missing something here?

> Also, you should revert the patch that hardcodes 19.2MHz as part of this
> set.

Ooops, this somehow got dropped when moving the patch from my working
tree to the repo I use for upstreaming.

> >  		.name = vco_name,
> >  		.flags = CLK_IGNORE_UNUSED,
> > @@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
> >  	pll_10nm->id = id;
> >  	pll_10nm_list[id] = pll_10nm;
> >  
> > +	pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> > +	if (IS_ERR(pll_10nm->vco_ref_clk)) {
> > +		dev_err(&pdev->dev, "couldn't get 'ref' clock\n");
> 
> Please print the error message

Ok, except for -EPROBE_DEFER as per Stephen's comment.

> > +		return (void *)pll_10nm->vco_ref_clk;
> 
> Use ERR_CAST here

Will do

Cheers

Matthias
