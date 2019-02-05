Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D466AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E1A21852
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549387319;
	bh=d36hRwL1vCQ4M4MMJSJFMbrGERkZyD3OKas7oIXeZWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AVtH/Jmrcq5qyo3g0CpldeIZ7lJjN/EY3dA08pLJqbS2385G55XFUhxg/Hx0/MHSS
	 do0gWpNFvY6SjLUw5V37SLK+QRJEBsrNrV/Z+vnSx3tQlw/Bfo1GyVkzygErBhPnLe
	 /8FETLhlTd0t2GBYaH6AGRMEnG4SXfQPAfL3oLH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfBERV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfBERV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:21:57 -0500
Received: from earth.universe (dyndsl-091-096-002-001.ewe-ip-backbone.de [91.96.2.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F0A20818;
        Tue,  5 Feb 2019 17:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549387317;
        bh=d36hRwL1vCQ4M4MMJSJFMbrGERkZyD3OKas7oIXeZWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrpvPtywJ52S10RzFaBSnye0W5BdoByrCyFVqE5bL9zletbLVMFCeLTiAY/IGIxgI
         TlmytVibUFAOUA1lAzmzq25YivX0UvWGekxrCDGloG784Ey6AFFBski/JrutXn67Bu
         WAD2IDYR4S0A7fT8TuVtwCDoovv6vCH37KCZ0dHU=
Received: by earth.universe (Postfix, from userid 1000)
        id 6D0AE3C08DE; Tue,  5 Feb 2019 18:21:54 +0100 (CET)
Date:   Tue, 5 Feb 2019 18:21:54 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC v1 2/3] max17042_battery: fix potential user-after-free on
 module unload
Message-ID: <20190205172154.j4zhucvnc7enadbc@earth.universe>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <20190204220952.30761-3-TheSven73@googlemail.com>
 <20190205082727.GB118684@dtor-ws>
 <CAGngYiWJhja9bF5vL_4mwTjPMtzOwvsahHEpkntMPgMXdBNg9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2jrdxogdqjb3gzv"
Content-Disposition: inline
In-Reply-To: <CAGngYiWJhja9bF5vL_4mwTjPMtzOwvsahHEpkntMPgMXdBNg9g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d2jrdxogdqjb3gzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 05, 2019 at 09:27:49AM -0500, Sven Van Asbroeck wrote:
> On Tue, Feb 5, 2019 at 3:27 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Are there many more instances of this?
>=20
> Unfortunately I think so.
> A simple grep brings up a couple of candidates, but I'm sure there are mo=
re:
>=20
> drivers/regulator/arizona-micsupp.c
> drivers/nfc/port100.c
> drivers/power/supply/max14656_charger_detector.c
> drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
>=20
> > I am unsure if we need
> > devm_init_work() when we can easily do the same in remove() call.
>=20
> The devm_init_work() suggestion only addresses the problem for those modu=
les
> that use devm_. The others will need fixes in remove(). But this is not as
> elegant and error-proof as using devm_init_work().
>=20
> [...]

I would for sure appreciate a devm_init_work(). There are a lot of
devm_ users in power-supply and this helper would definitely
simplify things.

-- Sebastian

--d2jrdxogdqjb3gzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxZxi8ACgkQ2O7X88g7
+prQuQ/9F542FnFizpWNTCBQFiEGR8h7hB4/iBdHPTqUiKInCVv//JcRxgrBMeDm
G7+V2J1iFdL/sRM/4qLHMh+q2b8nxSzqPBjE+0RPrV3EwFtO3NLXz1PfBzfupzS4
xdUPuE8eF1A2qhk1xjvPXvT8poptJHpMYs7mOfFOUdlDMYcdl6BdHhozitywxQ23
8FEFU4KLIYzeVP/gDvXM10+rkxuS1MVWmUnZ4c8aMJCIvTHw1oC5shjCCA/vxr7f
Yh+7OXaZFy7/2okjkgnPof+MnlEud9hGaI9pV5a2+/p29SeeZT/WolzMjqAo52Dx
IRVazKuBagH2n7xQAjgt/F/T47L/gjr+YRE3lc9hfznS9ZdPPB1OsmaojOO5V4tS
cBALSxm/AVluiwtcZGciWtCqAm6Zvy/biZtkspobZfFfe9+bHz68XtTGX8hfRMVl
wQse7xXA3QejDkLHjeL8Z8yImwo2ILS8Y8/uhpKPvCs51fJ0qRUeBDsF00Anda4R
HlWKrVODG/7oJyN3PGPKZ6brn8eX/ANosAY4jmUJpu3002VsLVitAme5YTcvJxia
Yx2PCd2CQcxxLFL497Sp4wNZibYmqBa21hi4+re/50n1tF5lMNTC5DjXaELuPh8D
FW+2su1x1Eh4RfUiaGfhwiQOzWKJ6jOQXVrzZZFHtClztJKYDdw=
=+Ulx
-----END PGP SIGNATURE-----

--d2jrdxogdqjb3gzv--
