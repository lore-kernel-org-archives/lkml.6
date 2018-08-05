Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF319C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6F6219A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6F6219A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeHEXmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:42:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42771 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeHEXmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:42:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2194E80686; Sun,  5 Aug 2018 23:36:17 +0200 (CEST)
Date:   Sun, 5 Aug 2018 23:36:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrew Pinski <pinskia@gmail.com>
Cc:     mpatocka@redhat.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk,
        thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180805213615.GA1862@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit=
 a
> > strange problem.
> >
> > When I use the links browser in graphics mode on the framebuffer, I get
> > occasional pixel corruption. Links does memcpy, memset and 4-byte writes
> > on the framebuffer - nothing else.
> >
> > I found out that the pixel corruption is caused by overlapping unaligned
> > stp instructions inside memcpy. In order to avoid branching, the arm64
> > memcpy implementation may write the same destination twice with differe=
nt
> > alignment. If I put "dmb sy" between the overlapping stp instructions, =
the
> > pixel corruption goes away.
> >
> > This seems like a hardware bug. Is it a known errata? Do you have any
> > workarounds for it?
>=20
> Yes fix Links not to use memcpy on the framebuffer.
> It is undefined behavior to use device memory with memcpy.

No, I don't think so. Why do you think so?

I'm pretty sure that gcc is allowed to do memcpy-like tricks even when
memcpy is not mentioned explicitely.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltnbc8ACgkQMOfwapXb+vLvEwCghtwM3E5SHKxBPLoBsgO5P+Qj
/9AAnRly8i+WwIXprkcYsopqJ7QrwYdh
=qgvv
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
