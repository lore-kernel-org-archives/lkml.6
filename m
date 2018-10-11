Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5465C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECB120841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wikghze3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECB120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeJKWLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:11:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53190 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeJKWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hEOMw4Gr5BkGstRKzySUbZCPiJkT3OspbuLHw0kWaaQ=; b=wikghze3l5wk1D6kS3oRdzUgI
        i8SyPV5Egro/ZXCe5NZ+iTObsSQtKnq4age48ofnM49BeF5FLAQokXAUlJuV+EOt/fSj482xXtbGy
        iEHDE1Qn2jusH5eKW52166fTFyatKFSSq1/sOEmLpqMGnFY1tTxZW4UnnL74WHZRjU0Z8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcBX-0001pS-AD; Thu, 11 Oct 2018 14:43:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ECDAF11223ED; Thu, 11 Oct 2018 15:43:30 +0100 (BST)
Date:   Thu, 11 Oct 2018 15:43:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
Message-ID: <20181011144330.GF25351@sirena.org.uk>
References: <20181011143531.7195-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <20181011143531.7195-1-linus.walleij@linaro.org>
X-Cookie: Use at own risk.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 04:35:31PM +0200, Linus Walleij wrote:

> +	/*
> +	 * Some fixed regulators share the enable line between two
> +	 * regulators which makes it necessary to get a handle on the
> +	 * same descriptor for two different consumers. This will get
> +	 * the GPIO descriptor, but only the first call will initialize
> +	 * it so any flags such as inversion or open drain will only
> +	 * be set up by the first caller and assumed identical on the
> +	 * next caller.
> +	 *
> +	 * FIXME: find a better way to deal with this.
> +	 */
> +	gflags |= GPIOD_FLAGS_BIT_NONEXCLUSIVE;
> +

It's not just fixed regulators that do this, often regulators with
register control can do this as well.  Since power up is often a
performance critical path but regulators tend to be controlled via slow
buses like I2C it's common to have register control combined with a GPIO
enable line so you don't need to use the bus to do the enables.  That
should just be a case of adding this flag to all the drivers that have
already been converted to gpiod (including the core code that's in
regulator_ena_gpio_request() which I thought was coping with this
already) unless I'm missing something?

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu/YZIACgkQJNaLcl1U
h9D47Af+LHEm3qHlbkqWm0H1Ku1iFePv0+bsa4Do4nZlGNRSOLXdvuxD2YyTptAu
uB4vzaULjSusPMG+7t9WDuJ1ODl6b2igrAB8v58QWLH91vMh327Pk994BBhDiE5r
ZYK4srJW6X2o3kbUmAFcgzaJtBsMvrhmIYcP7tid40cR5VOhmnTMBtVC6ODguM5Z
kxyBUfJtCs/5/qmiWIJPEM2IqxE/LK34yikRe74gb63Wb3cfgoZ4KwHy+Ci/vKQI
jxHb2bnejiTPYJoT43veSzE0i5GJwezwF14xHgATq3M3yIblpJ30lPhHA2/rJbyp
GO9z3HLVy8zHR1yEhVdFrhrnjETS3w==
=Mcdt
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
