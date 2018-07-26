Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F60CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D9E20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeGZTfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:35:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52362 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbeGZTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:35:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AFC16805DD; Thu, 26 Jul 2018 20:17:52 +0200 (CEST)
Date:   Thu, 26 Jul 2018 20:17:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Jan Beulich <JBeulich@suse.com>, mingo@elte.hu,
        rdunlap@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: use 32-bit XOR to zero registers
Message-ID: <20180726181750.GA4404@amd>
References: <5B30C32902000078001CD6D5@prv1-mh.provo.novell.com>
 <a68a703f-5d74-a2eb-4b26-0fe3e6e48705@infradead.org>
 <5B31DDFF02000078001CDC03@prv1-mh.provo.novell.com>
 <20180626113822.ch3erlyud5wsxvvg@khazad-dum.debian.net>
 <20180726091916.GA23471@amd>
 <20180726114537.GA12408@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20180726114537.GA12408@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-07-26 13:45:37, Ingo Molnar wrote:
>=20
> * Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > On Tue 2018-06-26 08:38:22, Henrique de Moraes Holschuh wrote:
> > > On Tue, 26 Jun 2018, Jan Beulich wrote:
> > > > >>> On 25.06.18 at 18:33, <rdunlap@infradead.org> wrote:
> > > > > On 06/25/2018 03:25 AM, Jan Beulich wrote:
> > > > >> Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms - =
use
> > > > >> 32-bit ones instead.
> > > > >=20
> > > > > Hmph.  Is that considered a bug (errata)?
> > > >=20
> > > > No.
> > > >=20
> > > > > URL/references?
> > > >=20
> > > > Intel's Optimization Reference Manual says so (in rev 040 this is i=
n section
> > > > 16.2.2.5 "Zeroing Idioms" as a subsection of the Goldmont/Silvermont
> > > > descriptions).
> > > >=20
> > > > > Are these changes really only zeroing the lower 32 bits of the re=
gister?
> > > > > and that's all that the code cares about?
> > > >=20
> > > > No - like all operations targeting a 32-bit register, the result is=
 zero
> > > > extended to the entire 64-bit destination register.
> > >=20
> > > Missing information that would have been helpful in the commit messag=
e:
> > >=20
> > > When the processor can recognize something as a zeroing idiom, it
> > > optimizes that operation on the front-end.  Only 32-bit XOR r,r is
> > > documented as a zeroing idiom according to the Intel optimization
> > > manual.  While a few Intel processors recognize the 64-bit version of
> > > XOR r,r as a zeroing idiom, many won't.
> > >=20
> > > Note that the 32-bit operation extends to the high part of the 64-bit
> > > register, so it will zero the entire 64-bit register.  The 32-bit
> > > instruction is also one byte shorter.
> >=20
> > Actually, I believe that should be comment in code.
>=20
> Agreed - mind sending a patch that adds it?

Ok. Would /* write to low 32 bits clears high 32 bits, too */ be
reasonable comment?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltaEE4ACgkQMOfwapXb+vJpvgCgwC86z5+1d0wsyp52F9LzrYkC
T88AniQBS4LfPhLSCDQxmVTJJgYzE5Qh
=gIoD
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
