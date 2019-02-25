Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B800C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F242087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxuS+1nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfBYFHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 00:07:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45745 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfBYFHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 00:07:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id h10so5819302lfc.12;
        Sun, 24 Feb 2019 21:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJUgp0Ejp7EUw+wgAsJ5EFIUuvMe7a1oaHXBmHUsaPo=;
        b=DxuS+1nW53402wVgOjaYB1ejf0MmnXOlHWfhNJuqZw1sznuKROwvWp+bdOxTzpFuMb
         4JhiQ43QMXjv3ULsFPjGVkms1UKqw/+r1nt/SecqIUjwX/bez/OjCY+Je0l2qOjrZaY9
         p17h53YZB4vsMCvdp9YYCC5Q9jcCwZG6Mh6gOdvuDUCHNSmj1P8qF4M/QEdFQ8CwnzQ6
         BS0rsYt55v/1BB0Tf84H1Q4a9hNAhBVforlVCjBVqByMsSsw6qtWT/VdRo55cUD/dBGU
         avEok71Gg5YplazqwRlIn+Cv0+wUIU6fs3hwOR1Ilrt3GeIOyzkSNyaRqsbuUvd6Fmcs
         075A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJUgp0Ejp7EUw+wgAsJ5EFIUuvMe7a1oaHXBmHUsaPo=;
        b=LaWWA2Nm+EPv3AjWItYvo1hNkY4WbD2yYstVpQ7vQUA57MCcZRwVZ8r72mWgNdTkds
         FMEV8UFac0l1EoODnCdBQkc3Wl0hYLhAWBaCIQo8SPnu7W3qDZ7l2GpyC6P1QDRJSTNI
         rfENRPFlVBQ5XSfSxTgowErc+Y/OJYDHA7cfOG97nzCQ0xxsx2isfqBIZnPNG6o/I7m+
         Ey9KCfF5ghxEIKulJeQBLjaFTOxYuWfaVwvvZClOC3hFQKPJnmFfanrsekGCYKsxgA5f
         WhZkZ8+hjpLRKgjQAZF2MNV+9i4QWJXdpVFtNx/OG0IoM8Qk3R7INwXeQBqlAj45R39f
         7DNQ==
X-Gm-Message-State: AHQUAub3ldyBM/tqwQlqaraD9FiixmyewTR/mbXMUCTFXJ2r2vvAwtkK
        2zoT+Q9nM6LCC3zZNC2xf/s=
X-Google-Smtp-Source: AHgI3IYA1GiQQNyJ8E/6s62vLpXFBKm0FvgH2PtyDiuVLbiaEuPgyUv3bik3xWGLJiVev9LAjZxyOQ==
X-Received: by 2002:a19:ee11:: with SMTP id g17mr8054359lfb.7.1551071224883;
        Sun, 24 Feb 2019 21:07:04 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id v7sm2134413ljk.7.2019.02.24.21.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 21:07:04 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:07:15 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
Message-ID: <20190225080715.4965810a@dimatab>
In-Reply-To: <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190224153622.8877-1-digetx@gmail.com>
        <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Mon, 25 Feb 2019 02:27:19 +0000
Peter Chen <peter.chen@nxp.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> =20
> >=20
> > Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for
> > Tegra20/30/114/124") =20
>=20
> I suppose you need to apply at stable tree too, right?
>=20

It is enough to have the "Fixes" tag to get patch backported into all
relevant kernel versions.

> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_tegra.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c
> > b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > index 772851bee99b..12025358bb3c 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> > @@ -130,6 +130,7 @@ static int tegra_udc_remove(struct
> > platform_device *pdev) {
> >  	struct tegra_udc *udc =3D platform_get_drvdata(pdev);
> >=20
> > +	ci_hdrc_remove_device(udc->dev);
> >  	usb_phy_set_suspend(udc->phy, 1);
> >  	clk_disable_unprepare(udc->clk);
> >  =20
> =20
> Acked-by: Peter Chen <peter.chen@nxp.com>
>=20
> Hi Greg, would you still accept the bug-fix for this release (v5.0)?
> Or I send you later?

I just want to point out that the bug existed for a very long time and
apparently didn't bother anybody, hence it's not an urgent fix.

