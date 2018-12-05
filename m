Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8664AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FEC2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V4R2ojlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FEC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbeLEPfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:35:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41448 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yFplxfAkz7zY6cqGyIDWiohJhxWO8+45E7iFp+b5/Pc=; b=V4R2ojlVzdD2//iOeAeE6ymWz
        GAlX+3ro60ee9G4V1RYk9jAwfC45aBxNFkNH8i9ECtY53w9l3i7YLhdUk8jdJD1L+jYSGZFMkQlVx
        M/dUXvMhLEbUfkQ/23znjqj/Q+7XVPcv8ayuAqVP1Wp68rq26owqyMj3tmmG6u5iESAoc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUZD4-0005XN-Np; Wed, 05 Dec 2018 15:35:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1398A112533F; Wed,  5 Dec 2018 15:35:34 +0000 (GMT)
Date:   Wed, 5 Dec 2018 15:35:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/1] regmap: irq: handle HW using separate mask bits for
 edges
Message-ID: <20181205153534.GF6205@sirena.org.uk>
References: <20181204181550.29122-1-brgl@bgdev.pl>
 <20181204181550.29122-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <20181204181550.29122-2-brgl@bgdev.pl>
X-Cookie: Real Users never use the Help key.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 07:15:50PM +0100, Bartosz Golaszewski wrote:

> Let's reuse the existing type fields in struct regmap_irq to make
> regmap_irq_chip available to such HW.

I'm not sure this is ideal, it makes the interface less clear for users
especially since there's nothing in the comments in the header that
users will look at which mentions the feature.

> If the type_base and mask_base offsets are the same - assume there
> are separate bits for falling and rising edge interrupts and use
> the value previously written to the type buffer by the set_type()
> callback instead of the entire mask specified for this interrupt
> so that we only enable the requested edge interrupts.

This feels like it's very strongly tied to a specific implementation of
the feature and TBH I'm somewhat unclear on what this ends up concretely
meaning.  It sounds like this hardware represents the two edges as
separate interrupts but you want to combine them into one but I can't
see exactly how the interrupt number gets mapped with your change.

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwH8EUACgkQJNaLcl1U
h9CysAf/T8OMx17dmpEeG9+TJkFq7jreKtDyE30h8Q6yzJo5br3qYq/PUr2nO4a+
pil0dxTuZpl13uE5RKmZkD/YF3PP4QBTQMXE09yd8iMOe/HDHUbQh6yYzGpHmtir
DCQ0Q5VutgY3MqotuG6lUbeKxAHTRcrQeYzoeIecP/xsa68U+WmnOYtWg6sP9Goh
pcdWGSPAw5EOtGtwToGPBgdgv163GavsnFjxYzq7jBgsMWXxkqRfkE83Za015FN0
cMf6nJ7n9kk55KRrLsNXDbFNOxJKdRRCAK8jH+xiKQJ+QLUqUUu/qs3OtvG01JPO
bs9jew7H1mGCj1zmTClLHwg3E8Lbfw==
=UeUq
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
