Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8033C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE2420652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE2420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeJWF1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:27:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52188 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeJWF1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:27:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1C5BE80794; Mon, 22 Oct 2018 23:07:07 +0200 (CEST)
Date:   Mon, 22 Oct 2018 23:07:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Message-ID: <20181022210707.GA3764@amd>
References: <20180927004810.124185-1-mka@chromium.org>
 <20180927004810.124185-2-mka@chromium.org>
 <b28c34475e447cc29a139f9121b3c1d9@codeaurora.org>
 <e6752d4b-b22a-d951-e9db-1ae7445dc403@codeaurora.org>
 <20180927171305.GG22824@google.com>
 <20181004173338.GL22824@google.com>
 <9B742DB5-F584-4A47-A04B-4F72EB17519C@holtmann.org>
 <20181015185128.GT22824@google.com>
 <8D254888-52A9-4201-882C-EDE71EE4CF5C@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <8D254888-52A9-4201-882C-EDE71EE4CF5C@holtmann.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> explain to me again why this is useful?
> >=20
> > The official binding for providing the BD_ADDR through the device tree
> > is the property 'local-bd-address'. device_get_bd_address() provides a
> > common API to retrieve the BD_ADDR instead of requiring BT drivers to
> > use the lower level fwnode_property_read_u8_array(). It also avoids
> > repeating the check for an all zeroes BD_ADDR in multiple drivers.
> >=20
> >> I am failing to see the benefit if this is not part of the property.h =
API.
> >=20
> > My understanding is that the intention of property.h it to provide an
> > API for common property types used by drivers from different
> > subsystems, hence the implementation 'lives' in drivers/base.
> > Obtaining the BD_ADDR is clearly limited to the Bluetooth subsystem,
> > and drivers/base doesn't seem to be the right place for it. It's true,
> > device_get_mac_address() lives in the common property code, but that
> > doesn't necessarily mean it really should be there and we should do
> > the same. I agree with Sakari that the the approach taken by V4L2
> > (drivers/media/v4l2-core/v4l2-fwnode.c) seems more appropriate.
> >=20
> > That said I wouldn't raise opposition if the maintainers of
> > drivers/base agreed to add device_get_mac_address() there, however so
> > far several recent authors of property.[ch] have raised objections.
>=20
> so if this is not in drivers/base/ then what is the point in making each =
driver do this? If it is a common property, then it can be well handled in =
the Bluetooth core when setting up the hardware.
>=20
> This whole BD_ADDR via DT is stupid anyway. Just so that is clear
> up-front. It has been a total hack and fully relies on boot
> loaders doing too much magic and then using DT to hide this magic.

Can you wrap lines at around 72 characters in the emails?

We do ethernet addresses via DT. I don't know if doing that in
bootloader is a hack or not, but if bootloader is already doing that
for ethernet, bluettoth address in DT kind of makes sense.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvOO/sACgkQMOfwapXb+vI0SACeMFEuegAfXWfn0BZGqrd79383
HSEAoL9NWTgrEohV3zpouDp4JLlibUub
=JmqK
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
