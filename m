Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F1341C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A9120896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A9120896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756131AbeFOIcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:32:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58356 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755964AbeFOIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:31:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 197868050E; Fri, 15 Jun 2018 10:31:58 +0200 (CEST)
Date:   Fri, 15 Jun 2018 10:31:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Charge counter on droid 4
Message-ID: <20180615083156.GA32102@amd>
References: <20180615080014.GA29192@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20180615080014.GA29192@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-15 10:00:14, Pavel Machek wrote:
> Hi!
>=20
> Droid 4 has non-removable battery, yet the charge counter is reset to
> near zero on each boot of linux.
>=20
> Unfortunately, that makes charge counter pretty much useless on d4, as
> the "battery full" and "battery empty" limits will be different during
> each boot.

Hmm, and could we refrain from providing "power" values?

I was thinking great, we have hardware that does proper power
measuerement for us. No.... it is driver providing synthetic
values. As userland has enough information to do that itself, I
believe we should not do this in kernel.

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cp=
cap-battery.c
index 839e365..1610026 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -490,24 +490,6 @@ static int cpcap_battery_get_property(struct power_sup=
ply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		val->intval =3D latest->counter_uah;
 		break;
-	case POWER_SUPPLY_PROP_POWER_NOW:
-		tmp =3D (latest->voltage / 10000) * latest->current_ua;
-		val->intval =3D div64_s64(tmp, 100);
-		break;
-	case POWER_SUPPLY_PROP_POWER_AVG:
-		if (cached) {
-			tmp =3D cpcap_battery_cc_get_avg_current(ddata);
-			tmp *=3D (latest->voltage / 10000);
-			val->intval =3D div64_s64(tmp, 100);
-			break;
-		}
-		sample =3D latest->cc.sample - previous->cc.sample;
-		accumulator =3D latest->cc.accumulator - previous->cc.accumulator;
-		tmp =3D cpcap_battery_cc_to_ua(ddata, sample, accumulator,
-					     latest->cc.offset);
-		tmp *=3D ((latest->voltage + previous->voltage) / 20000);
-		val->intval =3D div64_s64(tmp, 100);
-		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		if (cpcap_battery_full(ddata))
 			val->intval =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAlsjeXwACgkQMOfwapXb+vKlswCggDsZ+YFfzrNvJtdguoJDCIfX
Dk0AlRrUXv0GnMx05KgyILmEEasa/4U=
=wJlv
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
