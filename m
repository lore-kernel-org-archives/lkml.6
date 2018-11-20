Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A887BC5ACBA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B02421479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oWmPWDJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B02421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeKUJMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:12:49 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39572 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKUJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:12:48 -0500
Received: by mail-vk1-f195.google.com with SMTP id q80so801694vka.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVKwFw+/QT8NXXSuuH7kx54OQEHdc3bkJ9kbi+uCh3Y=;
        b=oWmPWDJYxjZGbwztviUoGebXDUyWoaQa4irwkIGc4baiK2YM8Jcw/XolUQmZAmK03H
         44vlp1HIR9Pc90KrssjwO1i2unbh64YDv2x/x1Bov5X2wpNiEgQvquC6MbQK41uNvLVF
         3dzPqlzRC1V5Al4YMQLQL7VdK8uQAJv/nPaC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVKwFw+/QT8NXXSuuH7kx54OQEHdc3bkJ9kbi+uCh3Y=;
        b=RVsaJqn3zNLQNP454BE/Yjd5UVTb4lEJEVYo5fhuI2ZMpAfco84Cwl1lcX+7Rj+jJB
         u0ub01ydTmzNceNCqEeNzTpZoiMQIi9BhZrza3DfJHvvrsSX+jbA3gSUbwH1D+MN7VfN
         LA6U79KYMPRwPywYGJ10UDQoph7+eQOH1sZ1qEabHdEBIwswAqJO6LL302trMp+aDE/y
         aDC5ZU14DkaL769bw4O//WpWm8wnLfU6SSNfIyckfvrQeYCx2ggIFBC1/aOMTctrfvoE
         nCi3pfziyAFob0U6zzw4I1AleuP1y6GAbVn9PMPATttfQDARtIEC63YNOcRCpa8AVD8u
         72gQ==
X-Gm-Message-State: AA+aEWb8QiSDWyqNuB++N8qbJnVP3AaUplFFGdX1D/bM5DA+0WILB1Cg
        cjHc5WSnDdjHaHVpMlXaF5hPCxgnqR4=
X-Google-Smtp-Source: AFSGD/XwXSLIzukkY4nwZn900DG4st6f3YOc7kg+Rk/iwn5JvkdISnGi2gy2fD/B1kDsBa89oNzy+Q==
X-Received: by 2002:a1f:bd2:: with SMTP id 201mr1717692vkl.42.1542753677943;
        Tue, 20 Nov 2018 14:41:17 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id l13sm19422351vka.16.2018.11.20.14.41.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 14:41:16 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id d2so1268041ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:41:15 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr1693875uaj.126.1542753674870;
 Tue, 20 Nov 2018 14:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20181102214534.184593-1-mka@chromium.org> <20181102214534.184593-2-mka@chromium.org>
 <CAD=FV=Vyv5sRhJNgpP6Gnn3+6zRjGsT8RozCY6xx51Tr_hRoeg@mail.gmail.com> <20181114235630.GO22824@google.com>
In-Reply-To: <20181114235630.GO22824@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 14:41:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XD7g8gZsTNTLGCN3ZC7zOuFX1LxMWVnE+=1k68tuQVpg@mail.gmail.com>
Message-ID: <CAD=FV=XD7g8gZsTNTLGCN3ZC7zOuFX1LxMWVnE+=1k68tuQVpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the DT
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 14, 2018 at 3:56 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Nov 08, 2018 at 02:04:31PM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Nov 2, 2018 at 2:45 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > Get the PHY ref clock from the device tree instead of hardcoding
> > > its name and rate.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > > index 4c03f0b7343ed..1016eb50df8f5 100644
> > > --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > > +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> > > @@ -91,6 +91,8 @@ struct dsi_pll_10nm {
> > >         void __iomem *phy_cmn_mmio;
> > >         void __iomem *mmio;
> > >
> > > +       struct clk *vco_ref_clk;
> > > +
> > >         u64 vco_ref_clk_rate;
> > >         u64 vco_current_rate;
> > >
> > > @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
> > >         char clk_name[32], parent[32], vco_name[32];
> > >         char parent2[32], parent3[32], parent4[32];
> > >         struct clk_init_data vco_init = {
> > > -               .parent_names = (const char *[]){ "xo" },
> > > +               .parent_names = (const char *[]){
> > > +                       __clk_get_name(pll_10nm->vco_ref_clk) },
> > >                 .num_parents = 1,
> > >                 .name = vco_name,
> > >                 .flags = CLK_IGNORE_UNUSED,
> > > @@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
> > >         pll_10nm->id = id;
> > >         pll_10nm_list[id] = pll_10nm;
> > >
> > > +       pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> > > +       if (IS_ERR(pll_10nm->vco_ref_clk)) {
> > > +               dev_err(&pdev->dev, "couldn't get 'ref' clock\n");
> > > +               return (void *)pll_10nm->vco_ref_clk;
> > > +       }
> >
> > So, ummmm.  Can you follow the same pattern for all the other clocks
> > in this file too?  All parents should get their name based on
> > references in the device tree.
> >
> > It turns out that right now we have a mismatch because
> > "drivers/clk/qcom/dispcc-sdm845.c" calls "dsi0pllbyte"
> > "dsi0_phy_pll_out_byteclk" and calls "dsi0pll"
> > "dsi0_phy_pll_out_dsiclk".  We might want to change the names in
> > dispcc-sdm845.c, but it wouldn't matter if we simply didn't hardcode
> > them here.
>
> Hm, I understand the problem, but not quite what you mean with 'follow
> the same pattern'. The VCO ref clock is an 'external'/existing clock,
> hence it can be specificed in the DT and obtained with
> _clk_get(). However the clocks you mention above are 'created' by the
> PHY driver, so we could only specify their names in the DT, not sure
> if that's what you are suggesting. I guess 'clock-output-names' could
> be used, though it isn't really useful to describe the names in a
> clock tree. If you still think this should be done please share how
> you envision the DT entries to look.

Ah.  Right.  This is me being dumb.  As you said the
"dsi0_phy_pll_out_byteclk" and "dsi0_phy_pll_out_dsiclk" clocks are
backwards of the one you're dealing with here.  No no change needed in
your patch for this.

In theory we could do a follow-up patch where the dispcc-sdm845
bindings take phandle references to the PHY clock for the clocks it
consumes.  That would future proof the bindings but I believe it
wouldn't really be possible to use them right now in code since the
clock framework doesn't really handle cases where two drivers mutually
produce / consume clocks from each other.


-Doug
