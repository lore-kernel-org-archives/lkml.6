Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2592CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DF12156E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DF12156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965505AbeF0U6i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:58:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40315 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965026AbeF0U6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:58:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 40DA48057B; Wed, 27 Jun 2018 22:58:35 +0200 (CEST)
Date:   Wed, 27 Jun 2018 22:58:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: v4.18-rc1 on droid 4: very bad CPU performance
Message-ID: <20180627205834.GB29478@amd>
References: <20180621121542.GA4836@amd>
 <20180622072005.GF112168@atomide.com>
 <20180622074936.GG112168@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <20180622074936.GG112168@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-22 00:49:36, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180622 07:22]:
> > * Pavel Machek <pavel@ucw.cz> [180621 12:18]:
> > > Hi!
> > >=20
> > > V4.18 is slower than it should be.
> > >=20
> > > user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
> > > | wc -c
> > > 10044291
> > > 52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
> > > user@devuan:~$ uname -a
> > > Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
> > > 19:26:37 CEST 2018 armv7l GNU/Linux
> > >=20
> > > That bzip should take 12 seconds, not minute.
> > >=20
> > > Any ideas? Do you see it, too?
> >=20
> > I've noticed firefox is super slow.. Git bisect time?
>=20
> Hmm not happening for me at least on duovero and droid4,
> I'm getting about 20s for v4.17 and v4.18-rc1.

Okay, so I know what was wrong with my config. I had l2cache disabled
-- and this solved it:

+CONFIG_OUTER_CACHE=3Dy
+CONFIG_OUTER_CACHE_SYNC=3Dy
+CONFIG_CACHE_L2X0=3Dy
+CONFIG_PL310_ERRATA_588369=3Dy
+CONFIG_PL310_ERRATA_727915=3Dy
+CONFIG_PL310_ERRATA_753970=3Dy
+CONFIG_PL310_ERRATA_769419=3Dy

Now I'm at 12 seconds.

user@devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 - | wc =
-c
10043993
11.41user 0.44system 11.63 (0m11.637s) elapsed 101.97%CPU
user@devuan:~$ uname -a
Linux devuan 4.18.0-rc2-88315-g3452793-dirty #756 SMP Wed Jun 27 22:16:59 C=
EST 2018 armv7l GNU/Linux
user@devuan:~$

I was about to add "facepalm" emoji here, as disabling l2 cache is
major mistake. OTOH if you also see 20 seconds, then either there is
another problem, or you need to enable l2 cache, too (and I don't have
to feel too bad for misconfiguring it).

Best regards,=20
								=09
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsz+noACgkQMOfwapXb+vLv9wCgvy5LVExAipJ5pCWfhIza+HhJ
P3IAoIrEWA6dwHbqkReGap/LZU6rfT/+
=trJd
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
