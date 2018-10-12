Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572EC71123
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D6821470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HECtpkod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D6821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeJMFmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeJMFmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 01:42:47 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8DBB2087D;
        Fri, 12 Oct 2018 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539382098;
        bh=PCloDrn+jrYe8o5w2Acii78A2ZgA24kgY6ZZQirzUfI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=HECtpkod83ADz4NTzqNPrGSxDyg1+y5yLKJaIg0Rj9lenkWcYKGQqiVrofy6ipfXa
         5XbWRWX5xqDlqjeMUcSe5k7rI1bOwhZW/KrFeQZL95GTMslUiKuRbtGhB/TFpema0Y
         Bn2LWYFa867uPff/+oGatcwF8TZKvKDrK1XOgAag=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ricardo Salveti <rsalveti@rsalveti.net>, ilia.lin@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAHYQr0rR=mcV-SxZFW+5M4CTUaTv_f_bruyq91HiGP6sqUZ3Yw@mail.gmail.com>
Cc:     ilialin@codeaurora.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, will.deacon@arm.com,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-4-ilia.lin@gmail.com>
 <CAHYQr0rR=mcV-SxZFW+5M4CTUaTv_f_bruyq91HiGP6sqUZ3Yw@mail.gmail.com>
Message-ID: <153938209728.5275.8811599608746761178@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 3/8] clk: Use devm_ in the register fixed factor clock
Date:   Fri, 12 Oct 2018 15:08:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ricardo Salveti (2018-09-14 11:53:02)
> On Thu, Jun 14, 2018 at 6:55 PM <ilia.lin@gmail.com> wrote:
> >
> > From: Ilia Lin <ilialin@codeaurora.org>
> >
> > Use devm_clk_hw_register instead of clk_hw_register
> > to simplify the usage of this API. This way drivers that call
> > the clk_hw_register_fixed_factor won't need to maintain
> > a data structure for further cleanup.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/clk/clk-fixed-factor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-fac=
tor.c
> > index a5d402de5584..8e39bda8e596 100644
> > --- a/drivers/clk/clk-fixed-factor.c
> > +++ b/drivers/clk/clk-fixed-factor.c
> > @@ -94,7 +94,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct de=
vice *dev,
> >         init.num_parents =3D 1;
> >
> >         hw =3D &fix->hw;
> > -       ret =3D clk_hw_register(dev, hw);
> > +       ret =3D devm_clk_hw_register(dev, hw);
> =

> Not sure what is the current state of this patch-set, but this change
> breaks drivers calling clk_hw_register_fixed_factor with a NULL dev
> (e.g. imx_clk_fixed_factor), as devm_clk_hw_register needs a valid dev
> for devres_add to work.
> =


Yep. Probably better to just have a driver register the clk_hw structure
itself with the clk framework vs. trying to get it right here in the
generic type registration function.

