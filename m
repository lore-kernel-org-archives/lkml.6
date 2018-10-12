Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB98C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A8820865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Ws9U/VTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A8820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeJLXuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:50:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58870 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbeJLXug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KtJGRx1cnHU9gZkM0TGmlzCJx6s9zJ2PqICUwTOjoFo=; b=Ws9U/VTFwMLpWnwOCBk9Gk36k
        ug2OlzGI5LqJNLXmLCV52Gf8s8xf2dyb2myr8ZoMzxSnG6j0kN7+maX1e/E3HwPYEJDdiYr2K1LDa
        RBpRBdYbBCrlLC0kqTQeL/99isLApGwfCtZgf+F++XUPX1oqmVJAS9lMtDHGWVezn96L8=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB07d-0006Zp-QF; Fri, 12 Oct 2018 16:17:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 34B95440078; Fri, 12 Oct 2018 18:17:05 +0200 (CEST)
Date:   Fri, 12 Oct 2018 18:17:05 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        jmondi <jacopo@jmondi.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>, philipp.zabel@gmail.com,
        linux-tegra@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Message-ID: <20181012161705.GC2340@sirena.org.uk>
References: <20180906122436.25610-1-linus.walleij@linaro.org>
 <20181011090112eucas1p286d8c1edfc1a2a207d8a11c5ad7eb20e~cglSx9qcr2394623946eucas1p2y@eucas1p2.samsung.com>
 <CACRpkdbTdmQQTg1D9jbcHGcT4kZermwVA+QEnUJGf+VYqoKRkg@mail.gmail.com>
 <c2726f18-f0cd-0d3d-c950-3e7212efd34d@nvidia.com>
 <1539272073.18645.12.camel@toradex.com>
 <CACRpkdYDoFhBJy484Hvf0e+zv51w23hqtBYLFxXsiLmWs63CWw@mail.gmail.com>
 <1539337415.30485.21.camel@toradex.com>
 <c1722bee-230a-d0ad-d2de-790ab1ce9fcf@nvidia.com>
 <20181012104338.GS30658@n2100.armlinux.org.uk>
 <CAHp75VecxqphJBZ2xUTku-WhyjkDRKQPbxvuGFAZ+-1voZRW9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <CAHp75VecxqphJBZ2xUTku-WhyjkDRKQPbxvuGFAZ+-1voZRW9Q@mail.gmail.com>
X-Cookie: He's dead, Jim.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 12, 2018 at 04:58:38PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 12, 2018 at 1:45 PM Russell King - ARM Linux

> > Given that DT describes the hardware, not the software implementation,
> > it must not change just because we move from GPIO numbers to GPIO
> > descriptors.

> > The existing DT description is reasonable, and introducing ficticious
> > regulators in DT to work around the implementation is not reasonable.

> If there is no way to detect shared use of GPIO line for regulators
> (*) from current DT description, DT description should be updated to
> reflect, yes, hardware.

> (*) Not familiar with the guts of DT descriptive language, don't know
> if there are some ways to do a such without additional flags or so.

You can detect this via resolving the GPIOs and seeing if it points back
to something that's already in use for an enable.  This isn't ideal
especially if you want to do it up front but it is doable.  You could
also just assume anything might end up being shared and rather than
doing it up front which is easier and probably about as good.

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvAyQAACgkQJNaLcl1U
h9AxNAf/dagFIggZW486itfhQDBJTefSA7vwmkxbzYKHZwodlcpEpGhwWUGxveyO
8kGuCjpCHU1knlsCL1q+8A9HwWnbCRp/aDYLXHpvSS/vghpCaKTdwo2ZBLg7PSjy
AVd9f/+d4pxoL2eUNgyl6D+EjymXk/v0sgu+uXF6wnHyrAhvD7UAhzAs3EAB00UW
0pkTrYLtpfSJjM+BKurnp+uQ9H3W7GKp86NOE5coFK8rvGQ4J0Mx2VutuMC4VYeR
6RBFMAuXFhnd/bhR/is0giBumfxaHD3vX4QVfxk8vhXhJ5OsO+nzSeMBrG7mS8kO
YXzCtuLAJGuQgrOkXMKYs2UJcZBBZQ==
=7HRA
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
