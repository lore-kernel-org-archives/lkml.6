Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519E0C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1507F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qRk5umjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1507F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJMAbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:31:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42894 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJMAbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OHWTPopatYi34Hs7pu+opMboTJ2doM5AHnaVAk2BxhY=; b=qRk5umjFqzPJKAzmWJd+fFmC1
        0WAwVhLhoFING2p92rhHcJUMaNuinXqw/hgR7/JJXOeq+EcFeBCEGcf38tuNuy0DylSvqzuOYx1QB
        FNqqV/ZYRwmx9rw/qyOkUbcN7B8FWSQm4d4KImyEcrL4zH3fK570g9uXPT/QIFxkHMv3Q=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0l6-0006d4-Nd; Fri, 12 Oct 2018 16:57:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D0A76440078; Fri, 12 Oct 2018 18:57:51 +0200 (CEST)
Date:   Fri, 12 Oct 2018 18:57:51 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jacopo@jmondi.org" <jacopo@jmondi.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shc_work@mail.ru" <shc_work@mail.ru>,
        "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "zonque@gmail.com" <zonque@gmail.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "jmkrzyszt@gmail.com" <jmkrzyszt@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Message-ID: <20181012165751.GI2340@sirena.org.uk>
References: <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
 <1539272073.18645.12.camel@toradex.com>
 <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
 <1539337415.30485.21.camel@toradex.com>
 <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
 <20181012104338.GS30658@n2100.armlinux.org.uk>
 <1539344591.30485.28.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <1539344591.30485.28.camel@toradex.com>
X-Cookie: He's dead, Jim.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 12, 2018 at 11:43:13AM +0000, Marcel Ziswiler wrote:
> On Fri, 2018-10-12 at 11:43 +0100, Russell King - ARM Linux wrote:

> > The existing DT description is reasonable, and introducing ficticious
> > regulators in DT to work around the implementation is not reasonable.

> I don't think it is that fictitious as it makes it crystal clear that
> there is something shared with all its pros and cons. E.g. what happens
> if one of them regulators wants to turn off while the other one still
> needs power? The regular regulator dependency tree would nicely make
> this all clear.

We already have code to handle that via refcounting on the GPIO once we
identify that it's the same GPIO.  If we make a shared virtual parent
regulator that'll break other things where we're tracking what the
actual physical parent for voltage reasons like adjusting parent
voltages up and down to improve efficiency or handling things that are
just dumb power switches rather than actual regulators.

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvA0o8ACgkQJNaLcl1U
h9CyGgf/fTeudX6kIfqmUFuZBMh3F6KuHTcd+G1ns+loJwMPBYjbPLCRYYizA4HK
mm2cNaF2xXV+/HAck9SXH/4X6D46hIJtbdecYPiMUfU8Crm6GhsWR2fg0JCDxvWF
gTpbE367Yn34YqxIC9zDltWMj4r1+/NkbyGHFkrUtz7P69ImGRf/2l9YIJUsoBUT
kEW3YkOHfMERDQeaXcp7NU8mHMtHFlJdQjnfX5yH3ZLkfrf0dRnJl6SJyFyyTwrc
eNM9FHJij8CuR82MX+lENcWHU+Rswez0aezN7edWvL1y+Ajmw64qYlRmWBJZAMp/
UYcKfCcYR8+qXxFF7kj97/ZLYKhWYQ==
=2TbA
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--
