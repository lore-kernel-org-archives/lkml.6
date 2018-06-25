Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072D3C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44DD262BC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj9iCsA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44DD262BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeFYXdE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755174AbeFYXdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:33:02 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1F3262BB;
        Mon, 25 Jun 2018 23:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529969581;
        bh=NkeXatR3DqPumCspSYzPOLTnkwagrKv47JBr+OvNDzw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pj9iCsA+gRcAVSeVSpnSVG/o8SwfijSRgeOro1ZyH3YrkP0EcaWCk9dGzpQBLmPk0
         UVP/pbFKRQxIwVCIQkX0lxnVnbWyNMtFmHbxgxB058ngrzxCPS058sHkTwdvCPJ8fH
         0Po8kREWNJjzGa8t0y1Hg+n1O7KT0/p6SylA+2D8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Lechner <david@lechnology.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <3a6d0388-7915-8ea3-6ad6-38dc7ee06377@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180602075256.hrvidsfsmr33mv2f@kili.mountain>
 <3a6d0388-7915-8ea3-6ad6-38dc7ee06377@lechnology.com>
Message-ID: <152996958098.143105.4718477050150092384@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: davinci: cfgchip: testing the wrong variable
Date:   Mon, 25 Jun 2018 16:33:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-06-25 16:17:55)
> On 06/02/2018 02:52 AM, Dan Carpenter wrote:
> > There is a copy and paste bug here.  We should be testing "usb1" instead
> > of "usb0".
> > =

> > Fixes: 58e1e2d2cd89 ("clk: davinci: cfgchip: Add TI DA8XX USB PHY clock=
s")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > =

> > diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/=
da8xx-cfgchip.c
> > index c971111d2601..20a120aa147e 100644
> > --- a/drivers/clk/davinci/da8xx-cfgchip.c
> > +++ b/drivers/clk/davinci/da8xx-cfgchip.c
> > @@ -672,7 +672,7 @@ static int of_da8xx_usb_phy_clk_init(struct device =
*dev, struct regmap *regmap)
> >   =

> >       usb1 =3D da8xx_cfgchip_register_usb1_clk48(dev, regmap);
> >       if (IS_ERR(usb1)) {
> > -             if (PTR_ERR(usb0) =3D=3D -EPROBE_DEFER)
> > +             if (PTR_ERR(usb1) =3D=3D -EPROBE_DEFER)
> >                       return -EPROBE_DEFER;
> >   =

> >               dev_warn(dev, "Failed to register usb1_clk48 (%ld)\n",
> > =

> =

> Applied to https://github.com/dlech/linux/tree/clk-davinci-fixes
> =


Ok. I expect this will be coming in a PR soon? Usually I can pick up
fixes just fine from the list and merge them on up to Linus, unless you
feel the need to pick it into your development tree to base future
development on.

