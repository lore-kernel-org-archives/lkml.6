Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EAEC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D2920841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssEg3uvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D2920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeJHLBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHLBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 07:01:33 -0400
Received: from localhost (unknown [171.76.86.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4189E20841;
        Mon,  8 Oct 2018 03:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538970715;
        bh=9ADOkQWBAsYwKhFTpDDyiJVX9uXWOciR+OCpl0iJmYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssEg3uvbB5FEs8kofvCm9fpjd/CqYpTVBTFI3XpbAFFY4gIAMYd0URnq1rFmCKdC4
         p0sm32k/w1/VrrxOIGvQjl9obrmrWjX98yhRIG4cD+82P26SyQTx8TUOQC/FgkHeBj
         E50xuJxx0MDpf+oiMRUUtrkaFUlAqa0xklzDArt8=
Date:   Mon, 8 Oct 2018 09:21:44 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Shefali Jain <shefjain@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add global clock controller driver
 for QCS404
Message-ID: <20181008035144.GD2372@vkoul-mobl>
References: <20180921185936.9590-1-vkoul@kernel.org>
 <20180921185936.9590-2-vkoul@kernel.org>
 <153841434099.119890.3912925112860077471@swboyd.mtv.corp.google.com>
 <20181003062103.GN19792@vkoul-mobl>
 <153896630923.119890.17169150168947487135@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153896630923.119890.17169150168947487135@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-10-18, 19:38, Stephen Boyd wrote:
> Quoting Vinod (2018-10-02 23:21:03)
> > Hi Stephen,
> > 
> > Thanks for the comments,
> > 
> > On 01-10-18, 10:19, Stephen Boyd wrote:
> > > Quoting Vinod Koul (2018-09-21 11:59:36)
> > > > From: Shefali Jain <shefjain@codeaurora.org>
> > > > 
> > > > Add the clocks supported in global clock controller which clock the
> > > > peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clocks
> > > > to the clock framework for the clients to be able to request for them.
> > > > 
> > > > Signed-off-by: Shefali Jain <shefjain@codeaurora.org>
> > > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > > Co-developed-by: Taniya Das <tdas@codeaurora.org>
> > > > Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> > > > [rebase and tidyup for upstream]
> > > 
> > > Who did the tidying?
> > 
> > both of us :)
> 
> OK, please add the username of both people per the kernel sign off
> standards.
> 
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>

Sorry not sure I understand, Bjorn and me did cleanup and we signed-off
per process, did I miss something?

> > > > +#include <linux/kernel.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/clk.h>
> > > 
> > > Please don't include this.
> > 
> > OK will check if this is required, any reason for not including this?
> 
> So we can easily split clk consumers and clk providers.

That was my thought, thanks for confirming :)

> > > > +static struct clk_branch gcc_pwm1_xo512_clk = {
> > > > +       .halt_reg = 0x49004,
> > > > +       .halt_check = BRANCH_HALT,
> > > > +       .clkr = {
> > > > +               .enable_reg = 0x49004,
> > > > +               .enable_mask = BIT(0),
> > > > +               .hw.init = &(struct clk_init_data){
> > > > +                       .name = "gcc_pwm1_xo512_clk",
> > > > +                       .ops = &clk_branch2_ops,
> > > 
> > > Do these pwm clks have a parent clk of the XO?
> > 
> > Yes they do
> 
> Cool, we should add them or add a comment explaining why they don't have
> parents listed here.

ok

> > > > +       [GCC_USB_HS_PHY_CFG_AHB_CLK] = &gcc_usb_hs_phy_cfg_ahb_clk.clkr,
> > > > +       [GCC_USB_HS_SYSTEM_CLK] = &gcc_usb_hs_system_clk.clkr,
> > > > +       [GFX3D_CLK_SRC] = &gfx3d_clk_src.clkr,
> > > > +       [GP1_CLK_SRC] = &gp1_clk_src.clkr,
> > > 
> > > Why are some of these missing GCC_ prefix?
> > 
> > will add..
> 
> Thanks!

Btw Taniya also commented on this, do you want this as GCC_ or as per hw
documentation?

> > > > +       clk_prepare_enable(apss_ahb_clk_src.clkr.hw.clk);
> > > > +       clk_prepare_enable(gpll0_ao_out_main.clkr.hw.clk);
> > > 
> > > And these should be marked as critical clocks.
> > 
> > Okay and how do we go about doing that?
> 
> You mark the clk flags with CLK_IS_CRITICAL.

Thanks will do.


-- 
~Vinod
