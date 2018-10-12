Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99123C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B4D20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B4D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJMBn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:43:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46195 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeJMBn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:43:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B02C880A50; Fri, 12 Oct 2018 20:10:12 +0200 (CEST)
Date:   Fri, 12 Oct 2018 20:10:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ingo Molnar <mingo@kernel.org>, arnd@arndb.de,
        akpm@linux-foundation.org, luto@kernel.org,
        dave.hansen@linux.intel.com, jroedel@suse.de,
        keescook@chromium.org, torvalds@linux-foundation.org,
        toshi.kani@hpe.com
Cc:     Thomas Gleixner <tglx@linutronix.de>, sfr@canb.auug.org.au,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Avoid VLA in pgd_alloc kills boot on 32-bit machines was Re:
 -next20181010,1011 regression: thinkpad x60 (32 bit) dies during boot.
Message-ID: <20181012181011.GA9098@amd>
References: <20181010195920.GA13860@amd>
 <20181010200331.GA13975@amd>
 <20181011180328.GA6740@amd>
 <alpine.DEB.2.21.1810112208200.1457@nanos.tec.linutronix.de>
 <20181012102459.GA4469@amd>
 <20181012105254.GA114888@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20181012105254.GA114888@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

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

And the winner is...

[1be3f247c2882a82279cbcf43717581ea943b692] x86/mm: Avoid VLA in
pgd_alloc()

"Kernel stack is corrupted in: pgd_alloc" panic kind of suggests this
is right commit.


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvA44MACgkQMOfwapXb+vIrlQCbBgdRd0mW4NBaj7ZH9F4pb8pA
eLoAnjsoazRFhA3VL0aetMS7oIk16Sbj
=mzvd
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
