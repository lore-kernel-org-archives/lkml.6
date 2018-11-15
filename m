Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186D6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6A92145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qZ1paX7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6A92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeKPIWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:22:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=adaYd2r+VIEwjIbpnCt+jN6lLlPJ35oEz0wMXelWLVU=; b=qZ1paX7FFVM+UFm7288NuFZhp
        m6vyYQ5DS96rRlRaAnnKvhYxyI3JspHo719kaBm/4p87ECvXhu8lCDx8TxE8Zn0r91syd5p+R7vKh
        1EK/RoR/pB5EbbYypj08mJfOv1H+gYMnNVZzrpek79+KzodpluOQ/9kyY/9/dlI1bwZx8=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNPsV-0006TB-9f; Thu, 15 Nov 2018 22:12:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3AFAB440078; Thu, 15 Nov 2018 22:12:41 +0000 (GMT)
Date:   Thu, 15 Nov 2018 14:12:41 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: Regression in next with spi return from transfer_one()
Message-ID: <20181115221241.GQ2089@sirena.org.uk>
References: <20181115211451.GH53235@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x9l1eQe8PlYqUxyS"
Content-Disposition: inline
In-Reply-To: <20181115211451.GH53235@atomide.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x9l1eQe8PlYqUxyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 15, 2018 at 01:14:51PM -0800, Tony Lindgren wrote:

> Commit 810923f3bf06 ("spi: Deal with slaves that return from
> transfer_one() unfinished") causes a regression at least on
> droid 4 with SPI PMIC and regulators on the PMIC. During boot
> the device just hangs there waiting for rootfs to appear on
> MMC. Reverting 810923f3bf06 makes things work again.

> Any ideas why this might be?

Wow, that's not obvious...  as far as I can tell the code in the !slave
case is identical so unless the controller is somehow getting mistakenly
flagged as a slave it looks like it should be something to do with it
being pushed into a function.  Could you try logging what the timeout
ends up getting set to?

--x9l1eQe8PlYqUxyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvt71UACgkQJNaLcl1U
h9CJOgf/coh5BBc03VYfTvL6HEMsKXePgtJNRKz+QuDJSY4XAT2ptoh8WfnAMqHt
25SqyCI41HYw6ah7O5Mm3Cky0zIyGCUwfYPj27a//Zw/vtK7mLLzE3ThB86HkPgo
J7xnbwpqJPGOyS9Exkxix/hwlxSADUiOm+Qz1o/XPtDRpCEBzxy3KCuzRhQh9/NN
OvjAkba5DDmlTZsIVzVVfrN/Kv/vkKbkX3/WrXsoTz7NbOBJK0VlpCoxsE4mb6Hi
jyosFs26bVd1rF3BJ6gEeWkt5Hc+TZmJ094tnnn3mupXyfgRzol1eeylA3LZ9Fef
I3QsWhOPoNlYbVNUroNhPFT41aboXA==
=OIp2
-----END PGP SIGNATURE-----

--x9l1eQe8PlYqUxyS--
