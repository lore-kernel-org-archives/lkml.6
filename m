Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E314C2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="CL8mPD7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E314C2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbeKFCxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:53:50 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41067 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbeKFCxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:53:50 -0500
Received: by mail-yb1-f195.google.com with SMTP id t13-v6so4126833ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E/hVEgwTfLoJrQfYVV6HPSiHVifnieHjCHIAFJ90OcM=;
        b=CL8mPD7MVPa3rQwEkfddspa14Sklq1/+Nuv0LsiMVvxpQ6Cuc8xWJwcg0ZTz09RhFh
         rzMvGFGb1wM8xK6PTJg6UPD24D2rqUrrGRWCjIJGV0tSP4AuaJ+Dc8mJAlHug+4TM5WM
         +ElpwN+nKUrNv/kyoXgzHTWxgbWtG5BgbZuf0LulzR8OEjL9tGG0SoyCo8RrTYMnV49z
         QuV8ddl8PDOvU2GYgfYlDtnZPSr7PgpuIvGcyvUQop+Ql320uyDkvl7ZRJ9IZNmsSmjk
         T8uBpgnNgDXJTX/mY+9hvl+J+JGyM/ZOfwf6lvoibhaGMbk0BAKkRLyAr5JoO5oIw9Ot
         7QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/hVEgwTfLoJrQfYVV6HPSiHVifnieHjCHIAFJ90OcM=;
        b=SHoIj+/Pd+16ryXW+EHWEqjPdsru9qHfV/SH9LwHIe6AGMS5v9EnVnq74ZRBm+sqhP
         FQiI/jYZ6RVnIpirMysvyeG1PliPxVDbt11OU1rUDB1jIsX22mHhJtxXWHZlD/OD23ca
         r7Zb3GILVMy8lZHKxxHEWj9hKyIU5b+RuEjef9tJEGq1nDPUET9UcDRFpSLIFayhZn72
         Nq6/+aZ5JV2OnxriF919BWF+S+eSsPGe7tKU4a+qDye9LYwxA++j5VSfLWjtYddNbJrQ
         b2RL2qSa86Fo56BhHWrnXDHeyhP3t7A0r0q4wOJTacJBrwAKCZcoJuqXNqKR86V8ZSAw
         UHUg==
X-Gm-Message-State: AGRZ1gKk7uRbmjNO9QNufb8h/LKSPlT07PFTyBg7BRQOFU4VfjMorF9f
        LsskxSn3Ee33GTvAXGnMsTbkVw==
X-Google-Smtp-Source: AJdET5cGZggZGAelyoTZRtlLsD4+SbZxC/x7dDFk7zJeNBIwPTduDVi1PvmWOXtbrzRFQSpKOYlMGQ==
X-Received: by 2002:a25:32c5:: with SMTP id y188-v6mr22878217yby.392.1541439186717;
        Mon, 05 Nov 2018 09:33:06 -0800 (PST)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id 203-v6sm4289668ywg.29.2018.11.05.09.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 09:33:05 -0800 (PST)
Date:   Mon, 5 Nov 2018 12:33:04 -0500
From:   Sean Paul <sean@poorly.run>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <20181105173304.GJ154160@art_vandelay>
References: <20181102214534.184593-1-mka@chromium.org>
 <20181102214534.184593-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102214534.184593-2-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:45:34PM -0700, Matthias Kaehlcke wrote:
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
>  	void __iomem *phy_cmn_mmio;
>  	void __iomem *mmio;
>  
> +	struct clk *vco_ref_clk;
> +
>  	u64 vco_ref_clk_rate;
>  	u64 vco_current_rate;
>  
> @@ -630,7 +632,8 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
>  	char clk_name[32], parent[32], vco_name[32];
>  	char parent2[32], parent3[32], parent4[32];
>  	struct clk_init_data vco_init = {
> -		.parent_names = (const char *[]){ "xo" },
> +		.parent_names = (const char *[]){
> +			__clk_get_name(pll_10nm->vco_ref_clk) },
>  		.num_parents = 1,

You should check the return of __clk_get_name() since you're setting num_parents
to 1. Also, you should revert the patch that hardcodes 19.2MHz as part of this
set.

>  		.name = vco_name,
>  		.flags = CLK_IGNORE_UNUSED,
> @@ -786,6 +789,12 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
>  	pll_10nm->id = id;
>  	pll_10nm_list[id] = pll_10nm;
>  
> +	pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
> +	if (IS_ERR(pll_10nm->vco_ref_clk)) {
> +		dev_err(&pdev->dev, "couldn't get 'ref' clock\n");

Please print the error message

> +		return (void *)pll_10nm->vco_ref_clk;

Use ERR_CAST here

> +	}
> +
>  	pll_10nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
>  	if (IS_ERR_OR_NULL(pll_10nm->phy_cmn_mmio)) {
>  		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
Sean Paul, Software Engineer, Google / Chromium OS
