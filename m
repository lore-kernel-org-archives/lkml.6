Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD0E222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfBLSZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:25:59 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39879 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBLSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:25:59 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 3EF42C0008;
        Tue, 12 Feb 2019 18:25:55 +0000 (UTC)
Date:   Tue, 12 Feb 2019 19:25:55 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Paul Hardwick <p.hardwick@option.com>
Subject: Re: [PATCH] tty/nozomi: use pci_iomap instead of ioremap_nocache
Message-ID: <20190212182555.GD2261@behemoth.owl.eu.com.local>
References: <20190210171212.GA22758@behemoth.owl.eu.com.local>
 <20190210214500.GB22758@behemoth.owl.eu.com.local>
 <20190212092625.GC27450@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20190212092625.GC27450@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(cc-ing Paul Hardwick, mentioned as maintainer of the driver)

Hi,

> > there's still something unclear to me about dc->card_type being used as
> > size argument to ioremap_nocache().
> >=20
> > dc->base_addr is the sum of all six io region lengths, not the size of
> > region 0 which we are trying to map here. Why not using the size of reg=
ion
> > 0 instead ?
>=20
> No idea, that might just be how the card is layed out.
>=20
> > If the goal is to map all six regions "at once", I'm not sure how this =
is
> > supposed to work. Is there any kind of guarantee that all six regions w=
ill
> > be adjacent?
>=20
> For some reason, it must happen that way, otherwise the driver would not
> work very well :)
>=20
> > If this is a bug then this patch "somehow" already adresses it since
> > pci_iomap calls pci_resource_len itself. Otherwise this patch is broken.
>=20
> Let's apply it and see if anyone screams...

Hum, it looks very much like the intention here was to map all bars at
once.

The offsets corresponding to the downlink, uplink, etc. regions are
retrieved as part of the config table by nozomi_read_config_table().

Unfortunately I don't own test devices, so I will not be able to verify it
myself. This is easy to test, though: if I am right, this patch breaks the
driver.

I guess the right way to map all bars in a single buffer would look like
what the hifn_795x driver does[0].

I will provide a patch if somebody is available to test it.

regards,
 Hugo

[0] https://elixir.bootlin.com/linux/latest/source/drivers/crypto/hifn_795x=
=2Ec#L2504

--=20
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxjD6sACgkQZYVUZx9w
0DRjZAf/Yv0K+GMkYtaJQy1MdlcyUHyZl2DyfD5yo6P1IdWuH/J4MDukkrCsAoWp
adhT4jWoUZS8VT2NT/FPvTQsC6BhLFK9hCpjeb2ISDSwyWjTKigliPgwF5xn/4nB
ygHlrBw0AgXlS9HRHD4ODcKfhKwKgG5qk1ZccWR0qe/Rxh6UM02GE8oyiOzK5LRD
qvcDp9ItPtrSHAKG9wO6fDxDzU34kGMX8ztC1epJUSuOeXbHP5tFaILD3N+IHDlO
Ton0VUVMKRGDOlwQ/Dh6Kl2tcimtuk74S8ptVjeWcaEgcg1yrjweT4Eg9TPau/zT
C6Jr/9vtbt0S1Obdb5w869PP/CedHw==
=iCGf
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
