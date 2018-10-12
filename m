Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A5C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BEF20644
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BEF20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeJLUHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:07:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58776 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbeJLUHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:07:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9CF2480A55; Fri, 12 Oct 2018 14:35:12 +0200 (CEST)
Date:   Fri, 12 Oct 2018 14:35:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, sfr@canb.auug.org.au,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: -next20181010,1011 regression: thinkpad x60 (32 bit) dies during
 boot.
Message-ID: <20181012123512.GA5565@amd>
References: <20181010195920.GA13860@amd>
 <20181010200331.GA13975@amd>
 <20181011180328.GA6740@amd>
 <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
 <20181012102459.GA4469@amd>
 <20181012105254.GA114888@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20181012105254.GA114888@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Problem is still there in today's next.
> > >=20
> > > So what came in between -next20181005 and the first bad one? kernel/s=
ched/*
> > > being the first place to look at.
> >=20
> > kernel/sched does not seem to contain anything too scary.
> >=20
> > I know that -next20181005 works ok, and I know -next20181010 is
> > bad. Is there easy way to bisect using that information? I can do
> > bisect between -next and mainline, but that's a lot of patches and
> > thus not much fun :-(.
> >=20
> > In the meantime, I reproduced the failure with T40p. Is there someone
> > with working x86-32 in -next?
>=20
> Does latest -tip fail too? If yes then I suspect bisection would be neede=
d.

I already started bisect on -next (T40p is my test machine, so bisect
is not that bad).

The log so far is:

								Pavel

# bad: [771b65e89c8a51d611b8049718693a4202e4f732] Add linux-next specific f=
iles for 20181011
# good: [7876320f88802b22d4e2daf7eb027dd14175a0f8] Linux 4.19-rc4
git bisect start '771b65e89c8a51d611b8049718693a4202e4f732' '7876320f88802b=
22d4e2daf7eb027dd14175a0f8'
# good: [43faff25da004eabce691268da34065b3690f5ca] Merge remote-tracking br=
anch 'net-next/master'
git bisect good 43faff25da004eabce691268da34065b3690f5ca
# good: [3e2beb7db82a880319aa2f0dcafa820f3f5206d3] Merge remote-tracking br=
anch 'spi/for-next'
git bisect good 3e2beb7db82a880319aa2f0dcafa820f3f5206d3
# bad: [74411e5fd30ae540491c4d6142af6ee6b2b22f09] Merge remote-tracking bra=
nch 'char-misc/char-misc-next'
git bisect bad 74411e5fd30ae540491c4d6142af6ee6b2b22f09
# bad: [c810d907775aa2aa753e836a122613fd2416b14d] Merge remote-tracking bra=
nch 'kvm/linux-next'
git bisect bad c810d907775aa2aa753e836a122613fd2416b14d
# good: [fac07d2ba7b2764e3002ff9bc7861742a84a2ef6] Merge branch 'perf/core'
git bisect good fac07d2ba7b2764e3002ff9bc7861742a84a2ef6
# bad: [d74865bd3996c7a6f3e8ce6e626c1fe474e39494] Merge branch 'x86/mm'
git bisect bad d74865bd3996c7a6f3e8ce6e626c1fe474e39494
# good: [dcd2d0cece1608b2be9184786c900807ec947076] Merge branch 'x86/asm'
git bisect good dcd2d0cece1608b2be9184786c900807ec947076


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvAlQAACgkQMOfwapXb+vI5TwCgxLNHJzccyZBJsrW4UByfgsCB
7d0An0OTtR9pVNdAVRiAl06WrecE6J8D
=R5nQ
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
