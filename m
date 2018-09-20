Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB4ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBB82087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RdQ4AA1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBB82087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbeITWD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:03:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34994 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeITWD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MphQ0lIyTvDl/Jou746DXEsAZKb85BMJ86NnTswrA/A=; b=RdQ4AA1xkJz4siYlv0Z2a5H7g
        TC113zOlJHKK1m5AongXpB5ahj8z7J2djqPrjPiCKOn9vPebJwPwdtdBoo8OmMrGk2NWlXYJMCDLC
        KF+7mOpXBw+aDMem6SiHhz0wOaGQxbG0qrIShDfvaKsyvoqNSWFVJE39VhJDT64bXB2Zo=;
Received: from [209.82.80.116] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g31fa-000769-LF; Thu, 20 Sep 2018 16:19:10 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1209C440078; Thu, 20 Sep 2018 17:19:06 +0100 (BST)
Date:   Thu, 20 Sep 2018 09:19:05 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org
Subject: Re: [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Message-ID: <20180920161905.GM2471@sirena.org.uk>
References: <20180912121955.33048-1-cychiang@chromium.org>
 <20180912121955.33048-2-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSJGZE3ajDCqFLUt"
Content-Disposition: inline
In-Reply-To: <20180912121955.33048-2-cychiang@chromium.org>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VSJGZE3ajDCqFLUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2018 at 08:19:55PM +0800, Cheng-Yi Chiang wrote:

> +	/*
> +	 * Release reset GPIO because we are not going to use it.
> +	 */
> +	devm_gpiod_put(dev, max98927->reset_gpio);

There is no need to do this, it's still potentially useful information
for userspace and it's also going to surprise anyone who tries to modify
the code to use this function at some other time (eg, when coming out of
suspend sometimes it's useful to reset the device).

> @@ -934,6 +1010,8 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>  	if (ret < 0)
>  		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
> =20
> +	list_add(&max98927->list, &reset_list);
> +

I'm not seeing any locking of this list.  This also feels like something
that shouldn't be in this driver but should be pushed up a level - it's
only going to do the right thing if the reset line is only shared with
other devices using this driver, if someone does something like put the
CODEC and an external speaker amp on the same reset pin then it won't
work.  I'm not sure where the best place to do that is; drivers/reset
isn't really for this use case but feels right perhaps?

Can you perhaps split the basic reset handling out from this list
handling as a separate patch?

--VSJGZE3ajDCqFLUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlujyHkACgkQJNaLcl1U
h9BuFQf/Q5y6HzLzXxcbLIk/wGLLN6BWn65TTUXkpZyWSPWDu5ZTISi6mKO3ahpT
xlqQXIWuY9T8DPL1tKUch40051dJExbQbd3y6JWUbQN0y0nqpKaCBhiqEYfG0Svj
CT90BvsEfhHsBvx+gWw6DXWuRLjik9AKjgPBqkNtU3wSB06xWZoDXQpJC/5nCdns
CmN/Y7UpGa5e5JAYGyYSeDu9Hna1Opb2nG+pDLqbgbmHpiTTo5Slc5etpavVl4rJ
+ivSqktKhd882USl//O6LCP3A32VW+b8eG9LbCAe0PwQxfMaUIwVMm985PzvV5ld
qtwLIvOYlMpZAZ2VBU4xrTxij2ab2Q==
=80Zv
-----END PGP SIGNATURE-----

--VSJGZE3ajDCqFLUt--
