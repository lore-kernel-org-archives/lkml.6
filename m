Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D3720892
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D3720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeKKLej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:34:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42988 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbeKKLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:34:38 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLeqc-0002DH-Vv; Sun, 11 Nov 2018 01:47:35 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLeqc-0002mu-O9; Sun, 11 Nov 2018 01:47:34 +0000
Message-ID: <885e13ee1ad51cd3a841378ed4b50878f7f61b72.camel@decadent.org.uk>
Subject: Re: stable/linux-3.16.y build: 178 builds: 1 failed, 177 passed, 2
 errors, 57 warnings (v3.16.52)
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Manfred Spraul <manfred@colorfullife.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "kernelci.org bot" <bot@kernelci.org>
Cc:     Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "3.16.x" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 11 Nov 2018 01:47:27 +0000
In-Reply-To: <0ecf39a8-dfc1-e895-ad6b-e2cf21a30e01@colorfullife.com>
References: <5a4b7192.08f4500a.dd9fa.064c@mx.google.com>
         <CAK8P3a1ffauonXr-ew5Y2kkn8qkFE1N27xJtnD4UaJmj+y1hwg@mail.gmail.com>
         <0ecf39a8-dfc1-e895-ad6b-e2cf21a30e01@colorfullife.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-RPm4WinLd4OxyA3L1bhL"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RPm4WinLd4OxyA3L1bhL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-01-13 at 19:51 +0100, Manfred Spraul wrote:
> Hi Arnd,
>=20
> On 01/03/2018 12:15 AM, Arnd Bergmann wrote:
> > > 2 ipc/sem.c:377:6: warning: '___p1' may be used uninitialized in this=
 function [-Wmaybe-uninitialized]
> > This code was last touched in 3.16 by the backport of commit
> > 5864a2fd3088 ("ipc/sem.c: fix complex_count vs. simple op race")
> >=20
> > The warning is in "smp_load_acquire(&sma->complex_mode))", and I suspec=
t
> > that commit 27d7be1801a4 ("ipc/sem.c: avoid using spin_unlock_wait()")
> > avoided the warning upstream by removing the smp_mb() before it.
> The smp_mb() pairs with spin_unlock_wait() in complexmode_enter()
> It is removed by commit 27d7be1801a4 ("ipc/sem.c: avoid using=20
> spin_unlock_wait()").
>=20
>  From what I see, it doesn't exist in any of the stable kernels=20
> (intentionally, the above commit is a rewrite for better performance).
>=20
> ___p1 is from smp_load_acquire()
>  >        typeof(*p) ___p1 =3D READ_ONCE(*p);                            =
   \
>=20
> I don't see how ___p1 could be used uninitialized. Perhaps a compiler iss=
ue?

On arm64 smp_load_acquire() was implemented in assembly that only
supported 4-byte and 8-byte words.  And complex_mode is a bool (1-byte)=20
field.

So I believe the fix is:

878a84d5a8a1 arm64: add missing data types in smp_load_acquire/smp_store_re=
lease

Ben.

--=20
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.


--=-RPm4WinLd4OxyA3L1bhL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvnijAACgkQ57/I7JWG
EQkPWg/+PIUVxT2NY0yaQACvuH07iy4ZQqRZz1yEH42I1D5Ss+mZ0js752ht2Nh+
kolWgk6bvu550xeIgfRhKrAdTa7I7yZMLpqo0Cpeo/bnoVFWccCSa2T7ZvU5IzfV
KITEaQxBqM2fEll/VD9JnsZNRekge6PnjVzPXcqvDLvLUyyuZE3gKjzqxf8T3Xkr
0wCyGxLa3n68TCyt4ba7x7yd+Mvg9KIq/pw49finy/DmH0RwLCvCkKugnOh2dVAT
heA9MdNdSmkqVVCfv0QUXyjCBHjag3+HhBOFzBXd3nTVnMBRxesv9GjsswyUJ7hp
lBj0Ujb/bPqZmp6bKy+Aatecij/oTqlLzYaf36prBP9a4BofDRpDwDCxekkxfozZ
0q9/VMHoSa43Oq8QPYN2BgekZrPntVcTbgNVQwzgMNDKptB7bfU7OTunAj0E2+pw
pmWUulbfkNyhfFE+ncIyeW4eI/B3oFmH59/rFCqyODQ3z+AX93dVqtzT54V9Hj+O
BHvMgN8prqJbJzV1Fk9YOgBjCoAlThFu7iI4g6IEDXhWpSQ5Y8JtBXsiSIRQ23Gg
+tEdapvZyqiBP9tjDI6cJAcICD5CwUX3g5NhHCY0kRrMVADNpr/OhFXCv4sq64xO
I3ZsHS2B2OhxcG4VLAcd/3MGym+wBmwzSysCCL8hBYSsl7V0lyE=
=0VTi
-----END PGP SIGNATURE-----

--=-RPm4WinLd4OxyA3L1bhL--
