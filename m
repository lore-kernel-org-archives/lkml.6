Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDE9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5701E2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh67muk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5701E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeJKOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeJKOp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:45:27 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D08720841;
        Thu, 11 Oct 2018 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539242369;
        bh=bfIoTAeZnIU4SbKiAAJRAQ4ELaMwo9AbHJaFI46F32U=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Uh67muk5ityVGvT8v256PnsIPp1+zQ3fltxO3SQ99MsbslOZV+po1txlFG+J9TWWe
         wZjovQO2OZ+3mOqAqWuSP9Jv+lyOBcJ786uAZxSg87cNqWbapRnR8FS40RKmGfLllw
         EAke/9V1SHHXFlyVSAXROaqhowLxoPHo4WALbOec=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vinod <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181008035144.GD2372@vkoul-mobl>
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
References: <20180921185936.9590-1-vkoul@kernel.org>
 <20180921185936.9590-2-vkoul@kernel.org>
 <153841434099.119890.3912925112860077471@swboyd.mtv.corp.google.com>
 <20181003062103.GN19792@vkoul-mobl>
 <153896630923.119890.17169150168947487135@swboyd.mtv.corp.google.com>
 <20181008035144.GD2372@vkoul-mobl>
Message-ID: <153924236897.5275.4858274509208170603@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add global clock controller driver for QCS404
Date:   Thu, 11 Oct 2018 00:19:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod (2018-10-07 20:51:44)
> On 07-10-18, 19:38, Stephen Boyd wrote:
> > Quoting Vinod (2018-10-02 23:21:03)
> > > Hi Stephen,
> > > =

> > > Thanks for the comments,
> > > =

> > > On 01-10-18, 10:19, Stephen Boyd wrote:
> > > > Quoting Vinod Koul (2018-09-21 11:59:36)
> > > > > From: Shefali Jain <shefjain@codeaurora.org>
> > > > > =

> > > > > Add the clocks supported in global clock controller which clock t=
he
> > > > > peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clo=
cks
> > > > > to the clock framework for the clients to be able to request for =
them.
> > > > > =

> > > > > Signed-off-by: Shefali Jain <shefjain@codeaurora.org>
> > > > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > > > Co-developed-by: Taniya Das <tdas@codeaurora.org>
> > > > > Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> > > > > [rebase and tidyup for upstream]
> > > > =

> > > > Who did the tidying?
> > > =

> > > both of us :)
> > =

> > OK, please add the username of both people per the kernel sign off
> > standards.
> > =

> > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> =

> Sorry not sure I understand, Bjorn and me did cleanup and we signed-off
> per process, did I miss something?

I mean doing something like:

[bjorn.andersson@linaro.org: Clean and tidy]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[vkoul@kernel.org: Clean and tidy even more]
Signed-off-by: Vinod Koul <vkoul@kernel.org>

Would be the kernel standard for maintainer tags.

> =

> > > > > +       [GCC_USB_HS_PHY_CFG_AHB_CLK] =3D &gcc_usb_hs_phy_cfg_ahb_=
clk.clkr,
> > > > > +       [GCC_USB_HS_SYSTEM_CLK] =3D &gcc_usb_hs_system_clk.clkr,
> > > > > +       [GFX3D_CLK_SRC] =3D &gfx3d_clk_src.clkr,
> > > > > +       [GP1_CLK_SRC] =3D &gp1_clk_src.clkr,
> > > > =

> > > > Why are some of these missing GCC_ prefix?
> > > =

> > > will add..
> > =

> > Thanks!
> =

> Btw Taniya also commented on this, do you want this as GCC_ or as per hw
> documentation?
> =


I don't care. Either way is fine with me.

