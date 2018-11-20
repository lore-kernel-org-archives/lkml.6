Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FBC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52573206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="c4dQR0ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52573206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeKUCYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:24:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60048 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUCYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xouPxh5SVwTqwmjQe+DL3V9behUHfvmY3jFFG5w5p+A=; b=c4dQR0ff/RoN/Bq9ogg+rFgGM
        0TDE0dXzXhRyVl5GZ5jqfwFusd8cRuIgLKhKdM1tJi/G2mdUHaE3rVOgtWoLdeJgT60stJR1lVK9i
        zhvkGQ9f1zFc9u7yh8txCnGIX5OU3yImtSEdO/k7Sh3S4GQP3USbPZ05yAysE+dr2AMQc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8Md-0001js-FE; Tue, 20 Nov 2018 15:54:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EDD8D1124DC2; Tue, 20 Nov 2018 15:54:58 +0000 (GMT)
Date:   Tue, 20 Nov 2018 15:54:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] regulator: core: Remove loop disabling supplies in
 regulator_force_disable()
Message-ID: <20181120155458.GG3894@sirena.org.uk>
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-7-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Content-Disposition: inline
In-Reply-To: <20181120002654.1891-7-dianders@chromium.org>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 04:26:54PM -0800, Douglas Anderson wrote:
> In regulator_force_disable() there was a strange loop that looked like:
>=20
>   while (rdev->open_count--)
>     regulator_disable(rdev->supply);
>=20
> I'm not totally sure what the goal was for this loop, but it seems
> wrong to me.  If anything I think maybe we should have been looping
> over our use_count, but even that might be a little strange.  For now
> let's just remove the code and we can add something back in if someone
> can explain what's expected.

This should be using use_count, what that loop is doing is dropping all
the enables that the regulator being force disabled had propagated up
all the enables it passed up the chain of supplies.

--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0LlIACgkQJNaLcl1U
h9BZFAf7B3sKN+Q6R7pWEpITXi4nd+st9MYfsvGgcqtgyys3MnAvGjZ/yfsjwXUD
qS27/N1JBttBLJg1AN+QBVnf9b2pPAEZy0WBr7sR2nJmyvCDP8KRSYZtSBEqjosp
sNSCkYDjfnrXw111dDQiixjHxmREdmLw1lD8JyfzPsEl0ekI70qtWLYY8wL/iBzS
Y2ORR4VdgG4N+JFhASonLe9QGKuxbL9hLpZVMaWcCBar/J9A0Ql/kk3Izwx+vZai
WbChEeX+qOK6bwFpWrOeRbeBPfuim3g3cSSWt3p2Rm4wYn/5ZCRf6isjgukoox5M
JYjl6BpCcLCY/m0d8TXjgWgxreGwAg==
=R/+2
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--
