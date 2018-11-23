Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C4EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36355206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RULTzOUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36355206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440011AbeKXBKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:10:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44494 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731438AbeKXBKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/JJwB45EoaxunINPe3KOwMlCsvvM4My6si5MoeNOYZg=; b=RULTzOUcJ13LVj5MD0hKQnkq8
        EeaZ4mtd1+I6RabB+lwcG6+gNgonV1MyjdfdgLlyst9ADm7CA9zzUyCIHrOLpu/5T0hEwLzkoMNIs
        pni42DEzVDgJKAWz9EuLvkuiFFTLuNLCu5w35FdQ6Vt5s23r2ESDMxmxPEPHjFo7qR6cw=;
Received: from [176.12.107.140] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gQCOw-0001B9-VE; Fri, 23 Nov 2018 14:25:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 93D22440078; Fri, 23 Nov 2018 14:25:44 +0000 (GMT)
Date:   Fri, 23 Nov 2018 14:25:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/3] regulator: Only free GPIOs if the core requested them
Message-ID: <20181123142544.GI2089@sirena.org.uk>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17Nf1kE0PuD3oAGS"
Content-Disposition: inline
In-Reply-To: <20181122173015.23905-2-ckeepax@opensource.cirrus.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17Nf1kE0PuD3oAGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2018 at 05:30:14PM +0000, Charles Keepax wrote:
> Currently, the regulator core will take ownership of any GPIO passed
> into it. Makes end driver code fairly error prone as the normal devm_
> patterns of allocation don't work. Update the regulator core to only
> free the GPIO if it requested it, this allows the drivers to manage the
> GPIO lifetime as they normally would.

I think this is fine in conjunction with patch 3 in that adding that
patch sorts out the double free problems with shared regulators but
without that pushing the GPIO management into the individual regulator
drivers is going to create trouble as something needs to coordinate to
make sure that we only free when the last user is gone.

However even with patch 3 I think it'd be better to base this off the
rest of Linus' series for converting to descriptors (which is currently
sitting waiting for some more testing) since that will convert
everything to descriptors and so remove the code that's doing requests
in the core entirely.

--17Nf1kE0PuD3oAGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv4DecACgkQJNaLcl1U
h9Cmqgf/esCjGRhqFLJVPAdbeVYlbTV0n6/iiEzwFXn5UfVle7ljW3KJ24tOTDqA
sYK6H++Qs3JyXOwexI8/mxkjIqUfCOOCIsqSJcp//3BBgTKp0PcyuXmKvQ8qmaRp
twohfzOskKGaQmITcCJ3RtRsN1FlgVnd/5um1KrIC9f6EZDu9Jdj7JaBEdZjp40a
0gRDzhx70m9TA8h1zdsZJ9VJKKngTumogT/BAd5b3RQJCZ8B2JrCgSx+TGBcWbHw
TKcxr1K6kBrAA/+/NvEcHTDA8sn1TsEbS2Dfbk2YQEX7/AQ7PWpk83TvhAxFTcTr
RtNRQ6UkajgYQe6rQEUxg9/cSN35yQ==
=pxdb
-----END PGP SIGNATURE-----

--17Nf1kE0PuD3oAGS--
