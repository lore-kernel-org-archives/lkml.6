Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2559DECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C825B2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="G7vKnV6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C825B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbeGRPnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:43:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57512 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeGRPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jVxwLGID4pAeqBEPCj0AqBAbXQnEsaVrnD896hWFKIo=; b=G7vKnV6aEYbBvHLdatOfyAm/B
        UG1nzdBS+CqsutwdVIl1jBlyE3WZ11wd+lf7WXS5xbI6PRvetTTJFJISsyl0mnP9LG8aNTm/us2L9
        G9oLqIoTC7D5oNOy7gDoCp5hRkBQeptoj3QiD1fOv2Hq9t53PURFY1x05jTHIVJixRWCY=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffo0a-0003f9-9m; Wed, 18 Jul 2018 15:04:52 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffo0Y-0003zV-Vz; Wed, 18 Jul 2018 16:04:50 +0100
Date:   Wed, 18 Jul 2018 16:04:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: add new SPI_CS_WORD flag
Message-ID: <20180718150450.GO5700@sirena.org.uk>
References: <20180717032052.12273-1-david@lechnology.com>
 <20180717032052.12273-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Content-Disposition: inline
In-Reply-To: <20180717032052.12273-3-david@lechnology.com>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 16, 2018 at 10:20:50PM -0500, David Lechner wrote:
> This adds a new SPI mode flag, SPI_CS_WORD, that is used to indicate
> that a SPI device requires the chip select to be toggled after each
> word that is transferred.

This feels like it should have a soft implementation if it is going to
be truly usable, the vast majority of SPI controllers don't do this and
I can only think of a few that have the hardware feature.  I'd also
expect to see some validation added to the core spi_setup() since at
present a client driver could set the mode option but then have it
ignored by the controller which would presumably break things, we
currently only have checks for specific modes and nothing that'd catch
an unknown flag like this.

Ideally we'd also have some ability to use this as an optimization where
possible with longer sequences (I can see a regmap cache sync being able
to take advantage of this for example) but that might be more trouble
than it's worth.

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPVxIACgkQJNaLcl1U
h9C/awf/b9hscy2AJosmJUBThr9n1LpeKI6knCgJVbsOg9FUBH9JjVxAagPdRe4Z
3fEyFqiDo7kSezNOZmrxbwTKTwiLbi2eLojQfohuMpEaF6HXE7Vo3ypGvlnTwSsQ
Xaw9vlpI8rNbDXqIb98PRd3th49FEkIIdsi2g0LTKlhxZWG3nynTHprK0PyPZuro
uPg4FU4dLUtsIkrsg8awEGCCuBARNysS6TFgPAKeLhSGnMwPfMMx20f2o1KeMdWT
B2QUNwjQnPwnxlYO9ahs2BiYxTY43ap1WlYN0xqoYyUTHN0dL4bD3neCSHb1p+SG
jM2asJiLGGzjHyzrKZhF3VhQuOEp1w==
=l9Kc
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
