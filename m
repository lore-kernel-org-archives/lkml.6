Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CCC2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y1jN7+ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CCC2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeGYIJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYII7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:08:59 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3242920852;
        Wed, 25 Jul 2018 06:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532501923;
        bh=kshgAIlZ+9sxKNG54cPoGGzyvE758fC2amOvnvncC2o=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=y1jN7+jaI56cDWQMSvD5aVYUeYBkJ+dV9vzrg9HlDpWCiAakY5IXpHwYohFARhsGG
         jn30aBaqySWlD9GJNLcgWqrab4pnLk6WWicM1ER6PacY7cdMrB1PBs/QT0DIJnCbH3
         rixX0GYqW0vVo1uiMXeAuZ8Jx63PVsIPcqwYfPBY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
 <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
Message-ID: <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date:   Tue, 24 Jul 2018 23:58:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-07-12 05:30:21)
> On 2018-07-09 11:45, Stephen Boyd wrote:
> > Quoting Amit Nischal (2018-06-06 04:41:46)
> >> To turn on the gpu_gx_gdsc, there is a hardware requirement to
> >> turn on the root clock (GFX3D RCG) first which would be the turn
> >> on signal for the gdsc along with the SW_COLLAPSE. As per the
> >> current implementation of clk_rcg2_shared_ops, it clears the
> >> root_enable bit in the enable() and set_rate() clock ops. But due
> >> to the above said requirement for GFX3D shared RCG, root_enable bit
> >> would be already set by gdsc driver and rcg2_shared_ops should not =

> >> clear
> >> the root unless the disable is called.
> >> =

> > =

> > It sounds like the GDSC enable is ANDed with the RCG's root enable
> > bit?
> =

> Here, the root clock (GFX3D RCG) needs to be enabled first before
> writing to SW_COLLAPSE bit of the GDSC. RCG's CLK_ON signal would
> power up the GDSC.
> =

> > Does the RCG need to be clocking for the GDSC to actually turn on?
> > Or is it purely that the enable bit is logically combined that way so
> > that if the RCG is parented to a PLL that's off the GDSC will still =

> > turn
> > on?
> > =

> =

> Yes, the RCG needs to be clocking for the GPU_GX GDSC to actually turn =

> on.

Cool, please add these details to the commit text.

> =

> >> Add support for the same by reusing the existing clk_rcg2_shared_ops
> >> and deriving "clk_rcg2_gfx3d_ops" clk_ops for GFX3D clock to
> >> take care of the root set/clear requirement.
> > =

> > Anyway, this patch will probably significantly change given that the =

> > RCG
> > is a glorified div-2 that muxes between a safe CXO speed and a
> > configurable PLL frequency. A lot of the logic can probably just be
> > hardcoded then.
> > =

> =

> Thanks for the suggestion.
> We are planning to introduce the "clk_rcg2_gfx3d_determine_rate" op =

> which will
> always return the best parent as =E2=80=98GPU_CC_PLL0_OUT_EVEN=E2=80=99 a=
nd best_parent
> rate equal to twice of the requested rate. With this approach frequency =

> table
> for rcg2 structure would not be required as all the supported =

> frequencies would
> be derived from the GPU_CC_PLL0_OUT_EVEN src with a divider of 2.
> =

> Also, we will add support to check the requested rate if falls within =

> allowed
> set_rate range. This will make sure that the source PLL would not go out =

> of
> the supported range. set_rate_range would be set by the GPUCC driver =

> with min/max
> value by calling below API.
> =

> clk_hw_set_rate_range(&gpu_cc_gx_gfx3d_clk_src.clkr.hw, 180000000, =

> 710000000)

Ok. Sounds good! Is the rate range call really needed? It can't be
determined in the PLL code with some table or avoided by making sure GPU
uses OPP table with only approved frequencies?

