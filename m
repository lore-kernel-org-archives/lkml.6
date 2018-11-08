Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14E6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F582081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eFtwDMG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F582081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeKHWmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:42:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UvprL5nelySR5nv6RI0/A89mRrdXRo7NZFZVu4WT4bg=; b=eFtwDMG+wIJ/enE7oRCcv9rT3
        FhlYoRL33D6oMXlkRbMHNpj9f73H5oRbbqkzViyezJZ609yQTQGMU5oKCGSL/v2ZANivYqGCCpPKj
        AHH97hXN8JLb1HWsjgjjLTKJxz06Cb+Zoo9Keb1MPWEyS/ElZKP59KxgfOrtQ+bvPJffE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKk1j-0008NE-D8; Thu, 08 Nov 2018 13:07:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D3AB51124D9D; Thu,  8 Nov 2018 13:07:14 +0000 (GMT)
Date:   Thu, 8 Nov 2018 13:07:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 10/11] regulator: core: Use ww_mutex for regulators
 locking
Message-ID: <20181108130714.GE6675@sirena.org.uk>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-11-digetx@gmail.com>
X-Cookie: I'm having a BIG BANG THEORY!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 05, 2018 at 06:36:37PM +0300, Dmitry Osipenko wrote:

> Wait/wound mutex shall be used in order to avoid lockups on locking of
> coupled regulators.

This breaks the build due to a few of the drivers (wm8350 and da9210 at
least) taking rdev locks in their interrupt handlers.  I'd suggest
adding a function for those drivers to use - exposing the ww context
seems like the wrong thing to do there.

Otherwise the series looks good, I've applied everything up to here.
Thanks for taking the time to pick this up, and especially for figuring
out the ww_mutex conversion.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkNQIACgkQJNaLcl1U
h9CBHgf+NUaKw5RG4K/VmM+a/RA5SHTaEUvbBkj0rbZxteC/KbFdAKRHaHyEMfdO
INQon26sjFFX8o8qiiYJHfFkWnJN1tKxODp474RfIL/Sy5U8pNMUfjUPS52qgd56
1onsQCk0cqWlswJAvntF5Ui7XW3MwZXL0xm4/QQsU8yiET9lR2nG8p5Y/Fnn+Enx
9phPizZN1F8+DolLlTjMvuGQXOGXxg8K/UZMHFE3Wtni3aaCGnQsv+eZvge/ga8h
wrxfR9cB7usKdNOFHr0lRwHTrKP0nBus0hgeaGBGGcv5Le3IGLJ4jeVBpolui+jd
1m7N+z7cn27BHlChofvH/ST5ypkq4w==
=oaPc
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
