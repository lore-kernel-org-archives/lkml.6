Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2EC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E962082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHRMyBwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E962082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeKCGBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbeKCGBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:01:20 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4326A2082E;
        Fri,  2 Nov 2018 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541191961;
        bh=vJRDmfrp0jtDatYmo3aRaTmkmqRI/Xv0Ugemt64LReY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bHRMyBwMQfuEcZMAOsrXP9A88ZbyQnDUAH8K6XojqHQ2n37vqa8xPMhbDPO3NHD60
         fMeuXs2YplK8sttWkllAq4DzWjtWD2bbh0SgqSmGbMeS2B3a+rOPcXFIYzlR2QWbRs
         3zAcwkBYA0A94HvaPQJafgYnfABpBUy+P0yr9Yc0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534141987-29601-3-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
 <1534141987-29601-3-git-send-email-anischal@codeaurora.org>
Message-ID: <154119196058.88331.1952304286743529280@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date:   Fri, 02 Nov 2018 13:52:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-08-12 23:33:05)
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 52208d4..a57ce00 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -866,7 +866,7 @@ static int clk_rcg2_shared_set_rate_and_parent(struct=
 clk_hw *hw,
>         return clk_rcg2_shared_set_rate(hw, rate, parent_rate);
>  }
> =

> -static int clk_rcg2_shared_enable(struct clk_hw *hw)
> +static int __clk_rcg2_shared_enable(struct clk_hw *hw)

Name this clk_rcg2_force_enable() please. Also add a comment above like:

/* Set RCG force enable bit and flush out any configuration settings */

>  {
>         struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
>         int ret;
> @@ -879,7 +879,14 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
>         if (ret)
>                 return ret;
> =

> -       ret =3D update_config(rcg);
> +       return update_config(rcg);
> +}
> +
> +static int clk_rcg2_shared_enable(struct clk_hw *hw)
> +{
> +       int ret;
> +
> +       ret =3D __clk_rcg2_shared_enable(hw);
>         if (ret)
>                 return ret;
> =

> @@ -929,3 +936,78 @@ static void clk_rcg2_shared_disable(struct clk_hw *h=
w)
>         .set_rate_and_parent =3D clk_rcg2_shared_set_rate_and_parent,
>  };
>  EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
> +
> +static int clk_rcg2_gfx3d_enable(struct clk_hw *hw)
> +{
> +       return __clk_rcg2_shared_enable(hw);
> +}

And then drop this wrapper and just use clk_rcg2_force_enable() in the
clk_ops structure.

> +
> +static int clk_rcg2_gfx3d_determine_rate(struct clk_hw *hw,
> +                                       struct clk_rate_request *req)
> +{
> +       struct clk_rate_request parent_req =3D { };
> +       struct clk_hw *p;
> +       unsigned long rate =3D req->rate;
> +       int ret;
> +
> +       rate =3D clamp(rate, req->min_rate, req->max_rate);

Doesn't the core already clamp the rate for you? Seems wasteful to do it
again.

> +
> +       /* Get fixed parent - GPU_CC_PLL0_OUT_EVEN */

I hope this doesn't change in the future! Any way to make this
detectable by storing the parent index somewhere so this op can work
with any future index selection instead of hardcoding '1' here?

> +       p =3D clk_hw_get_parent_by_index(hw, 1);
> +
> +       /* Parent should always run at twice of the requested rate */
> +       parent_req.rate =3D 2 * rate;
> +
> +       ret =3D __clk_determine_rate(req->best_parent_hw, &parent_req);
> +       if (ret)
> +               return ret;
> +
> +       req->best_parent_hw =3D p;
> +       req->best_parent_rate =3D parent_req.rate;
> +       req->rate =3D parent_req.rate / 2;
> +
> +       return 0;
> +}
> +
> +static int clk_rcg2_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                   unsigned long parent_rate)
> +{
> +       struct clk_rcg2 *rcg =3D to_clk_rcg2(hw);
> +       int ret;
> +       u32 cfg;
> +
> +       /* Configure fixed SRC and DIV */
> +       cfg =3D rcg->parent_map[1].cfg << CFG_SRC_SEL_SHIFT;

This would need to be dynamic too instead of hardcoding '1'.

> +       cfg |=3D 0x3 << CFG_SRC_DIV_SHIFT;
> +
> +       ret =3D regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, c=
fg);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * In case clock is disabled, update the SRC and DIV only
> +        * and return without configuration update.

Add:

 When the clk is enabled, we'll configure the rate to be what we
 requested here. This allows other users of this clk (i.e. GPU)
 to change the rate when this clk is disabled from our perspective.

> +        */
> +       if (!__clk_is_enabled(hw->clk))
> +               return 0;
> +
> +       return update_config(rcg);
> +}
