Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A80BC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EBD2156F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZKu+v+BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EBD2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeHONtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:49:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHONtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3aocv68c+y5A60g9AD4qIGeTr7mmnuLwxVAiuPNfa0k=; b=ZKu+v+BBuv7UUrAY3qdGR6JFA
        mnvc5pWWs1uSyNykV8ScMVlWEa7L/3/f/Gl6kbiHYTV1mR+9/xqdO3Ie+sjjNonQ/lfV4RsI+peft
        0DkHEKGoh8FOmk68l64bM4eya72TWBSJJWYsKIrmqlUEgKCGaET84z4Ku2HTKRP4weTvM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fptUY-0001ax-4z; Wed, 15 Aug 2018 10:57:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 53BD0440078; Wed, 15 Aug 2018 11:57:29 +0100 (BST)
Date:   Wed, 15 Aug 2018 11:57:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: core: If consumers don't call
 regulator_set_load() assume max
Message-ID: <20180815105728.GW2414@sirena.org.uk>
References: <20180814170617.100087-1-dianders@chromium.org>
 <20180814170617.100087-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dIV3CY5swYZsO92m"
Content-Disposition: inline
In-Reply-To: <20180814170617.100087-2-dianders@chromium.org>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dIV3CY5swYZsO92m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2018 at 10:06:14AM -0700, Douglas Anderson wrote:
> Not all regulator consumers call regulator_set_load().  On some
> regulators (like on RPMh-regulator) this could be bad since the
> regulator framework will treat this as if consumer needs no load.
> It's much better to assume that a dumb client needs the maximum
> possible load so we get correctness first.

If you take this to its logical conclusion we should never have runtime
mode setting - there may be passive components in the system which don't
appear in DT but do affect the load.  It's why we require the machines
to explicitlly enable any changes that the framework does, if we don't
do this then things aren't safe.  You may also have a situation where
some of the drivers that are registered are included in a fixed load
specified by the machine integration.

Dynamic mode setting is just a very hard feature to use usefully,
there's a reason why few systems do it.

--dIV3CY5swYZsO92m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt0BxgACgkQJNaLcl1U
h9ASxwf+Nckyt05E1tPXv5gm3yuIus/OGZ5dZhjf6tdS7aoNL+HUG4iEr8TDBgA/
qUMOJioFdR5YjXZwCla3KlN/TZUKOUr8qajwhvwuh+Y3LiNzUKnb/hp8GrsqK3LU
FbsXqxzqPJXgcsacYGtVA4A7/67+c+R6ScvNorUfXGzy6BRygyvxHHeGdMnhcjOt
ejB71/wH7yoAhtMHSKUYkzfwY95Mh+eS37WAgI69zr+KZ28e8DD+Rv2yphcxfrz2
fHcegYeqlbXbdS7/WEAMQpZ8rmeOJ/Sg4OuA3lR0xkC+oB2NPR2VCYP0JZ7XJKrS
x1p6qRhpznCoqbSwKk9UatVvKhHRKQ==
=nEZj
-----END PGP SIGNATURE-----

--dIV3CY5swYZsO92m--
