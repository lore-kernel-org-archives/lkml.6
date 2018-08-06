Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47AFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F4A219E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F4A219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHFKw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:52:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59040 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:52:55 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6116C805FA; Mon,  6 Aug 2018 10:44:53 +0200 (CEST)
Date:   Mon, 6 Aug 2018 10:44:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Cc:     Andrew Pinski <pinskia@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180806084451.GB19523@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <20180805213615.GA1862@amd>
 <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-08-06 09:04:33, Ramana Radhakrishnan wrote:
> On Sun, Aug 5, 2018 at 10:36 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > I tried to use a PCIe graphics card on the MacchiatoBIN board and I =
hit a
> >> > strange problem.
> >> >
> >> > When I use the links browser in graphics mode on the framebuffer, I =
get
> >> > occasional pixel corruption. Links does memcpy, memset and 4-byte wr=
ites
> >> > on the framebuffer - nothing else.
> >> >
> >> > I found out that the pixel corruption is caused by overlapping unali=
gned
> >> > stp instructions inside memcpy. In order to avoid branching, the arm=
64
> >> > memcpy implementation may write the same destination twice with diff=
erent
> >> > alignment. If I put "dmb sy" between the overlapping stp instruction=
s, the
> >> > pixel corruption goes away.
> >> >
> >> > This seems like a hardware bug. Is it a known errata? Do you have any
> >> > workarounds for it?
> >>
> >> Yes fix Links not to use memcpy on the framebuffer.
> >> It is undefined behavior to use device memory with memcpy.
> >
> > No, I don't think so. Why do you think so?
>=20
> It is undefined behaviour in the architecture.

Why do you think so? Pointer to documentation would be helpful.

Normal access is used for mmapped areas, and I don't think we want to
 change that.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltoCoMACgkQMOfwapXb+vLMhgCfY8CsLEMJdYhoRujXldzCqFLp
0GgAoI/Pf0nhwq9LnE7FhRGpwabQZBQI
=Wa6e
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
