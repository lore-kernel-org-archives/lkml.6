Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9503C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB6C20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Y1thfCxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB6C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504570AbeKXAJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:09:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55682 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390938AbeKXAJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bpnDR76b2ZWMdalr8msjn9gA+Yzx3m0B9/yJrM442Bs=; b=Y1thfCxldSN4HGDr/bMRotnot
        +oy0ZjqYbl0tbdc8T3K3YcWOLGxiW6tH9N/vuylUMFbJzLe9UUW/pt84VuMG09iQlWHV0WCyLCf6F
        Xjb4H37akdCS0+JgY5Hf6mtPqJz+Pzuq5Gjwwpidd8gX9w871/n5l590KCRjVFbp72lc0=;
Received: from [176.12.107.140] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gQBSV-000134-7O; Fri, 23 Nov 2018 13:25:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4247A440078; Fri, 23 Nov 2018 13:25:22 +0000 (GMT)
Date:   Fri, 23 Nov 2018 13:25:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Message-ID: <20181123132522.GE2089@sirena.org.uk>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
 <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z79+P6LHXcBZ81w+"
Content-Disposition: inline
In-Reply-To: <20181123105729.GM16508@imbe.wolfsonmicro.main>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z79+P6LHXcBZ81w+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2018 at 10:57:29AM +0000, Charles Keepax wrote:

> It's fixing something in the case of two regulators using the
> same GPIO. The direction this patch chain takes is that the end
> drivers own the GPIOs not the regulator core (except for the
> legacy case). So both of the end drivers will devm_ request their

The situation with descriptor based GPIOs is a bug - the reason why the
core does the request in the legacy case is precisely the problem Linus
identified.  Once a GPIO is shared all the users of the GPIO need to
coordinate with each other in order to set the value so the refcount by
itself in the GPIO core isn't super useful unless it can also serve to
help the multiple users find each other somehow.  I think what we want
to do here is either push the gpiod requests into the regulator core or
change things so that once the regulator is registered with the
regulator core the regulator core owns and is responsible for freeing
the regulator.

--Z79+P6LHXcBZ81w+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv3/8EACgkQJNaLcl1U
h9CngAf/VsSmqhxP8B88PyMCu9jvoNGZV92/zflmxH90MoJCULb/hYaovGGWRr8i
ywXaT2Z2v60U9nb2gIAsXV0OcuzCSPKz+546I47AKdP9L6Ib168Y90qKLEe+GN0r
HR18HPVfzd30RDPykJfFpLh7CZVPuPQcZOxTOQup2TRzYTFU6iEAwjMBHwd0IckW
bk+DFxAmeF9a+uDeb3BfIWlBN/qRDarUW/H8ihBgj33RSxmtg24WuMO6v1TvH3Do
qom5VoHbPuPtk75wdvbetJQ1/RZAmJ/mNf6HVPGkDPbH9Qel50wk1XYuYCtbDLZN
j7/UA2NddoyPWsVgGxnKEXklYVswMA==
=SGoR
-----END PGP SIGNATURE-----

--Z79+P6LHXcBZ81w+--
