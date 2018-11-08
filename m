Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C635EC0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8394720818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SgFVW2TJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8394720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbeKIICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:02:52 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33414 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeKIHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:16 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so12580149vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 14:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Q9Uyh+9BGdUr+1R4mEdgCDqW797mT7Ltt3iL+HGKao=;
        b=SgFVW2TJAl+JYqasGLlAPWHuZEAx3ozjkBLdGHgAIHr55nYVMhTBNOuYJJ8nBIqWKd
         Wh5QSeiWnqmepRCSSPeBEdr+5tu8W42ExY573gx8UNYSkb7ZdBO7MOpVe2Uu4Lt3DBA7
         Owp0OBvkquVwd8fSVPxvBCMdGawMLU40TAbcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Q9Uyh+9BGdUr+1R4mEdgCDqW797mT7Ltt3iL+HGKao=;
        b=Kxhr/Ug8EdN5ssSh1xXFXJ4cVEz4ckeia09ZMPHbNzKurVhLSbSMpC0CSAGDKUvEEd
         acTlaTA5CE64WRSvuXG2qfkCVMENq+IVxqf4CfmNq/fTsao4GVKTiexaHLwltMg12MKq
         /wD4IQgo1hMy6rJpFftivatWzI8O+G3WXL6BKv//h9etTz/5Wu1c8biojH0wA6O35Fbl
         7eTmLPAJs7LY1TDLGg1hz7WwJimaT4VpcBSnuwZMzWyF2h4q9dHzUi2mx4lKdSOZnf+7
         eNnJYv91aM8v9nmczOJ+VL2gk3pMbYre2/PMivpTueyEyuElu5FroH92bduqaiTtKDXB
         KzAQ==
X-Gm-Message-State: AGRZ1gJAN1uxJ9pL7gKh+GP2Lp6TjJVBARNpJcKeRNN16n7ahQ9iBzCO
        TdBMue0/PDs8kF0pNBBnN3hTleZ1/vc=
X-Google-Smtp-Source: AJdET5ec2JEPDUFEK37cM1QAn2LiEmu//lkU2SjvR+P7b1o6dUdUL0jqaZKgBLas39yEE5iFM9NBOg==
X-Received: by 2002:a67:ebc3:: with SMTP id y3mr2823560vso.75.1541714685338;
        Thu, 08 Nov 2018 14:04:45 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id b134sm1344991vke.49.2018.11.08.14.04.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 14:04:44 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id o130so2463583vke.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 14:04:44 -0800 (PST)
X-Received: by 2002:a1f:5a01:: with SMTP id o1mr2874080vkb.4.1541714683754;
 Thu, 08 Nov 2018 14:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20181102214534.184593-1-mka@chromium.org> <20181102214534.184593-2-mka@chromium.org>
In-Reply-To: <20181102214534.184593-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Nov 2018 14:04:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vyv5sRhJNgpP6Gnn3+6zRjGsT8RozCY6xx51Tr_hRoeg@mail.gmail.com>
Message-ID: <CAD=FV=Vyv5sRhJNgpP6Gnn3+6zRjGsT8RozCY6xx51Tr_hRoeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm/dsi: Get PHY ref clock from the DT
To:     Matthias Kaehlcke <mka@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 2, 2018 at 2:45 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Get the PHY ref clock from the device tree instead of hardcoding
> its name and rate.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> index 4c03f0b7343ed..1016eb50df8f5 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> @@ -91,6 +91,8 @@ struct dsi_pll_10nm {
>         void __iomem *phy_cmn_mmio;
>         void __iomem *mmio;
>
> +       struct clk *vco_ref_clk;
> +
>         u64 vco_ref_clk_rate;
>         u64 vco_current_rate;
>
> @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
>         char clk_name[32], parent[32], vco_name[32];
>         char parent2[32], parent3[32], parent4[32];
>         struct clk_init_data vco_init = {
> -               .parent_names = (const char *[]){ "xo" },
> +               .parent_names = (const char *[]){
> +                       __clk_get_name(pll_10nm->vco_ref_clk) },
>                 .num_parents = 1,
>                 .name = vco_name,
>                 .flags = CLK_IGNORE_UNUSED,
> @@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
>         pll_10nm->id = id;
>         pll_10nm_list[id] = pll_10nm;
>
> +       pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> +       if (IS_ERR(pll_10nm->vco_ref_clk)) {
> +               dev_err(&pdev->dev, "couldn't get 'ref' clock\n");
> +               return (void *)pll_10nm->vco_ref_clk;
> +       }

So, ummmm.  Can you follow the same pattern for all the other clocks
in this file too?  All parents should get their name based on
references in the device tree.

It turns out that right now we have a mismatch because
"drivers/clk/qcom/dispcc-sdm845.c" calls "dsi0pllbyte"
"dsi0_phy_pll_out_byteclk" and calls "dsi0pll"
"dsi0_phy_pll_out_dsiclk".  We might want to change the names in
dispcc-sdm845.c, but it wouldn't matter if we simply didn't hardcode
them here.

-Doug
