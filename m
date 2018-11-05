Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833952081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd/ci2mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833952081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeKEPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbeKEPzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:55:15 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751302081D;
        Mon,  5 Nov 2018 06:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541399828;
        bh=RcJvTPjfz5ZiC1iA6zz+Ibx23S9XuPQuDLSstDu+yFk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Nd/ci2mFZALdgrd3a2QN/4EtZdbD49B6+2DB9xgHxMVJGjPchl36qfsh6Gq7Vr8Hk
         W5ju7kZGHYH4CnWAVH13acpmt4Lrrpk8CZnfIBpwvJn6QyUYTVzpV9vNaevYzYcHVC
         xy6e4c5pzMRtcc3yB/du0rbUc1Ow0f+eun6wVce0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534141987-29601-5-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
 <1534141987-29601-5-git-send-email-anischal@codeaurora.org>
Message-ID: <154139982787.88331.4428778114927340653@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 4/4] clk: qcom: Add graphics clock controller driver for SDM845
Date:   Sun, 04 Nov 2018 22:37:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-08-12 23:33:07)
> +
> +static int gpu_cc_sdm845_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       unsigned int value, mask;
> +       int ret;
> +
> +       regmap =3D qcom_cc_map(pdev, &gpu_cc_sdm845_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_fabia_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config=
);
> +       clk_fabia_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config=
);
> +
> +       /*
> +        * Configure gpu_cc_cx_gmu_clk with recommended
> +        * wakeup/sleep settings
> +        */
> +       mask =3D CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
> +       mask |=3D CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
> +       value =3D 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEE=
P_SHIFT;
> +       regmap_update_bits(regmap, 0x1098, mask, value);
> +
> +       ret =3D qcom_cc_really_probe(pdev, &gpu_cc_sdm845_desc, regmap);
> +       if (ret)
> +               return ret;
> +
> +       /* Configure clk_dis_wait for gpu_cx_gdsc */
> +       regmap_update_bits(regmap, 0x106c, CLK_DIS_WAIT_MASK,
> +                                               8 << CLK_DIS_WAIT_SHIFT);

Is there a reason this is done after clks are registered? I'd think we
would want to do it before.

> +
> +       /* Set supported range of frequencies for gfx3d clock */
> +       clk_hw_set_rate_range(&gpu_cc_gx_gfx3d_clk_src.clkr.hw, 180000000,
> +                                                               710000000=
);
> +
> +       return 0;
> +}
