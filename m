Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD1BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA7B2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SWhv0OAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA7B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeKPKM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:12:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKPKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vVjFV7tDdfy/Pb/8jAO2slSvX5UUeDfok0dkGuBly4w=; b=SWhv0OAGquntlARJryJKFjYdt
        XHQUT/02qZt1+VXJr9qQWdFhKBdXIekgLWkfkmhQcr8OcVxXdcU3Ks6abtXu5fGs1bb6zkeie1s9A
        0OekhXN49kFC0DZj/cHo6aGgO85z2Skeu7Aa0zj7rRHpSCcAxL4AFk3oG6Dw4HB7VIsjY=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNRaC-0006bc-BC; Fri, 16 Nov 2018 00:02:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 59E11440078; Fri, 16 Nov 2018 00:01:54 +0000 (GMT)
Date:   Thu, 15 Nov 2018 16:01:54 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: Regression in next with spi return from transfer_one()
Message-ID: <20181116000154.GS2089@sirena.org.uk>
References: <20181115211451.GH53235@atomide.com>
 <20181115221241.GQ2089@sirena.org.uk>
 <20181115234359.GJ53235@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sObS8/rhx1YpqEF"
Content-Disposition: inline
In-Reply-To: <20181115234359.GJ53235@atomide.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+sObS8/rhx1YpqEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 03:44:00PM -0800, Tony Lindgren wrote:

> It seems to be caused because of the now missing "if (ret > 0) {"
> line somehow that was there earlier. New code sets ms to 200 it
> seems, then dmesg shows:

Doh, of course :(  Sorry I missed that.

> The old code is not updating ms and it's set to 1.

Right, and not waiting either which should be the issue.  Does the
following work:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 498d3b9bf3ae..430ad637c643 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1114,9 +1114,11 @@ static int spi_transfer_one_message(struct spi_contr=
oller *ctlr,
 				goto out;
 			}
=20
-			ret =3D spi_transfer_wait(ctlr, msg, xfer);
-			if (ret < 0)
-				msg->status =3D ret;
+			if (ret > 0) {
+				ret =3D spi_transfer_wait(ctlr, msg, xfer);
+				if (ret < 0)
+					msg->status =3D ret;
+			}
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,

--+sObS8/rhx1YpqEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvuCO4ACgkQJNaLcl1U
h9ANuwf+IHvPFE5q4uHvxIDsrFdb+JSKUCjFjCUr7uL3Cn9T86CHbD8b+j3xP6U6
bryD7L9gRVH6nnV5UZN7LSlnVWZjGMwRoPkbMWUAtQCunhEP+PDCoBSGPeBRqBw2
1gLGHRmr8mtJ/As4TX9MVr14ybwaIPca7uQOvvtZx7Fx6MxNT4rFE3XOIlrpxXCq
qX/3DqTKmTCpxaughsuIbdg806hBYo4Bot2wR5qITuOOV3kOaDm5mzKefKUBtpH6
7L08S6chbvqST/XAfILHwui7OCw290DTRQyN+Dp76/W2ysSUNdJ4K+FuIbxPgQyM
vTCfyGeuYVGDZ7vPJE5YIeoBS5BM1A==
=KFSj
-----END PGP SIGNATURE-----

--+sObS8/rhx1YpqEF--
