Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E5EECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF2B21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctuV4vfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF2B21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeJQXhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbeJQXhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:37:35 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D777321529;
        Wed, 17 Oct 2018 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539790879;
        bh=aKACO/jpOvtCZqJ7W2CQxA81agMnEvLFKBv5E82/l84=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ctuV4vfPUEVKrImyNW0/D3+1+qclOnLQdwO9bnuDcI4wOEqs0vdacbtJSROpyHIDE
         EHKhQUyYMBdLUhNIT69N51LfOI9SzBlz7/krgvFp1jw9+WBBYhzPM6MFtc1RXi94V2
         fCsGY2dG2t/gmU4+fSw6b3EHOaWP+wCsJyHj11JE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        bjorn.andersson@linaro.org, ilia.lin@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181014202122.GA13473@centauri.lan>
Cc:     Ricardo Salveti <rsalveti@rsalveti.net>, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, will.deacon@arm.com,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-4-ilia.lin@gmail.com>
 <CAHYQr0rR=mcV-SxZFW+5M4CTUaTv_f_bruyq91HiGP6sqUZ3Yw@mail.gmail.com>
 <153938209728.5275.8811599608746761178@swboyd.mtv.corp.google.com>
 <20181014202122.GA13473@centauri.lan>
Message-ID: <153979087829.5275.6249138489771592939@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 3/8] clk: Use devm_ in the register fixed factor clock
Date:   Wed, 17 Oct 2018 08:41:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2018-10-14 13:21:22)
> On Fri, Oct 12, 2018 at 03:08:17PM -0700, Stephen Boyd wrote:
> > Quoting Ricardo Salveti (2018-09-14 11:53:02)
> > > On Thu, Jun 14, 2018 at 6:55 PM <ilia.lin@gmail.com> wrote:
> > > >
> > > > From: Ilia Lin <ilialin@codeaurora.org>
> > > >
> > > > Use devm_clk_hw_register instead of clk_hw_register
> > > > to simplify the usage of this API. This way drivers that call
> > > > the clk_hw_register_fixed_factor won't need to maintain
> > > > a data structure for further cleanup.
> > > >
> > > > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > > > Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > ---
> > > >  drivers/clk/clk-fixed-factor.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed=
-factor.c
> > > > index a5d402de5584..8e39bda8e596 100644
> > > > --- a/drivers/clk/clk-fixed-factor.c
> > > > +++ b/drivers/clk/clk-fixed-factor.c
> > > > @@ -94,7 +94,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struc=
t device *dev,
> > > >         init.num_parents =3D 1;
> > > >
> > > >         hw =3D &fix->hw;
> > > > -       ret =3D clk_hw_register(dev, hw);
> > > > +       ret =3D devm_clk_hw_register(dev, hw);
> > > =

> > > Not sure what is the current state of this patch-set, but this change
> > > breaks drivers calling clk_hw_register_fixed_factor with a NULL dev
> > > (e.g. imx_clk_fixed_factor), as devm_clk_hw_register needs a valid dev
> > > for devres_add to work.
> > > =

> > =

> > Yep. Probably better to just have a driver register the clk_hw structure
> > itself with the clk framework vs. trying to get it right here in the
> > generic type registration function.
> > =

> =

> Hello Ilia, Stephen,
> =

> As you know this patch series is needed to get DVFS working on msm8996.
> =

> Ilia, are you planning on submitting a new patch set for this, or would
> you prefer if we submitted a new patch version for you?
> =

> Looking at this patch series, this appears to be the only outstanding
> review comment.

Sorry, you were too hopeful :/

> Stephen, do you have any review comments on this series?
> =


Yes, my nitpick should be easy to resolve and then it's just a few open
questions after that. Otherwise things seem fine and the CPU can run
really fast without bumping up the voltages?

