Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11764C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF869218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545177812;
	bh=l9X3UQoXgIeCGAP/aU9OPQ/7WsOloIc3sY+fcmmC0fU=;
	h=References:In-Reply-To:To:Cc:Subject:From:Date:List-ID:From;
	b=Iai3mhwGQAJAJ+Q3dUQLjOqK2IG995Hj5jBH1YshQSuQFn+tBGyjjGgHIdT4UpMgi
	 IWrN3BZKuLbt69c9UAJ/Bb2kXGoo8ABguppNmoymIGAIE5iS0jLIXHfHpUXZH3cnwr
	 ae2DuZ26WypQR3Dkch2tQ7ZpZNPXSAwmD+OU6JRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeLSADb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeLSADb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:03:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A309218AD;
        Wed, 19 Dec 2018 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545177810;
        bh=l9X3UQoXgIeCGAP/aU9OPQ/7WsOloIc3sY+fcmmC0fU=;
        h=References:In-Reply-To:To:Cc:Subject:From:Date:From;
        b=zU0WCnisjRLfQquJ/mvI8tmCfBNSPpUXGRg0ViDwKeRDtgaNkmBX733A3lerUAXCF
         o9FoGX3J+NZ2ukLKM3jS2aSRby+/FugJSGTfGnssuPqgLC1rMw1tAl3HIZZqr8q9fd
         g0nGjXFtUyPolQvS+rSYkzk55Q2d4bB7NQDWev8g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20181204192440.12125-1-miquel.raynal@bootlin.com> <20181204192440.12125-2-miquel.raynal@bootlin.com>
Message-ID: <154517780935.238328.764268020422357561@swboyd.mtv.corp.google.com>
In-Reply-To: <20181204192440.12125-2-miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 1/4] clk: core: clarify the check for runtime PM
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 18 Dec 2018 16:03:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2018-12-04 11:24:37)
> Currently, the core->dev entry is populated only if runtime PM is
> enabled. Doing so prevents accessing the device structure in any
> case.
>=20
> Keep the same logic but instead of using the presence of core->dev as
> the only condition, also check the status of
> pm_runtime_enabled(). Then, we can set the core->dev pointer at any
> time as long as a device structure is available.
>=20
> This change will help supporting device links in the clock subsystem.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/clk.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index af011974d4ec..b799347c5fd6 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -97,7 +97,7 @@ static int clk_pm_runtime_get(struct clk_core *core)
>  {
>         int ret =3D 0;
> =20
> -       if (!core->dev)
> +       if (!core->dev || !pm_runtime_enabled(core->dev))

This looks potentially dangerous. What if runtime PM is disabled for the
clk when this function is called? Shouldn't we just stash a bool away in
the clk_core structure when it's registered? And then we can replace the
check for !core->dev with a check for 'core->rpm_enabled' instead. That
would be a more exact transformation.


