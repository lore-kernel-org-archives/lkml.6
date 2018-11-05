Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C9ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41E920862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41E920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeKESiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:38:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46093 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeKESiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:38:05 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 67C2E80805; Mon,  5 Nov 2018 10:19:16 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:19:18 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita 
        <jprvita@endlessm.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Message-ID: <20181105091917.GD4439@amd>
References: <20181103065732.12134-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <20181103065732.12134-1-jprvita@endlessm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-02 23:57:32, Jo=E3o Paulo Rechi Vita wrote:
> Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
> "Discharging" on some machines when AC was connected but the battery was
> not charging. But now on these machines the battery status is reported
> as "Not charging" even when the battery is fully charged.
>=20
> This commit takes the battery capacity into consideration when checking
> if "Not charging" should be returned and "Full" is returned when the
> capacity is 100%.
>=20
> Signed-off-by: Jo=E3o Paulo Rechi Vita <jprvita@endlessm.com>

We have people trying to modify this and it caused regressions in
MATE, IIRC.

Plus, I don't think "100% charge" is right test for "battery full". At
least on thinkpads, there's configuration option, and it is common
_not_ to charge batterry above 95% or so (to increase its lifetime).

								Pavel


>  	 * was plugged in and the device thus did not start a new charge cycle.
>  	 */
>  	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
> -	    battery->rate_now =3D=3D 0)
> +	    battery->rate_now =3D=3D 0) {
> +		if (battery->capacity_now && battery->full_charge_capacity &&
> +		    battery->capacity_now / battery->full_charge_capacity =3D=3D 1)
> +			return POWER_SUPPLY_STATUS_FULL;

Division? Really?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvgCxUACgkQMOfwapXb+vJ5/QCgvEm/0gpEFDo8LrQRTWXV1aBz
3mIAoIgXec2F6lOKyyfYdsxU2iiESeBC
=8whT
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
