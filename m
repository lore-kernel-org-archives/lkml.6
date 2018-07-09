Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A5BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05562089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05562089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933347AbeGIViq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:38:46 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44002 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeGIVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:38:45 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fcdrh-0002vY-Rh; Mon, 09 Jul 2018 17:38:37 -0400
Message-ID: <1531172317.5350.33.camel@surriel.com>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Rik van Riel <riel@surriel.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Mon, 09 Jul 2018 17:38:37 -0400
In-Reply-To: <1531059232.4665.38.camel@gmx.de>
References: <20180706215658.18018-1-riel@surriel.com>
         <20180706215658.18018-2-riel@surriel.com>
         <1530951813.22672.10.camel@gmx.de> <1530998709.5350.32.camel@surriel.com>
         <1531059232.4665.38.camel@gmx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-G3vpz9Of2Yh/RdfONeoK"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G3vpz9Of2Yh/RdfONeoK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-07-08 at 16:13 +0200, Mike Galbraith wrote:
> On Sat, 2018-07-07 at 17:25 -0400, Rik van Riel wrote:
> >=20
> > > ./include/linux/bitmap.h:208:3: warning: =E2=80=98memset=E2=80=99 wri=
ting 64
> > > bytes
> > > into a region of size 0 overflows the destination [-Wstringop-
> > > overflow=3D]
> > >    memset(dst, 0, len);
> > >    ^~~~~~~~~~~~~~~~~~~
> >=20
> > I don't understand this one.
> >=20
> > Inside init_mm we have this line:
> >         .cpu_bitmap     =3D { [BITS_TO_LONGS(NR_CPUS)] =3D 0},
> >=20
> > which is the way the documentation suggests statically
> > allocated variable size arrays should be allocated=20
> > and initialized.
> >=20
> > How does that result in a memset of the same size,
> > on the same array, to throw an error like above?
>=20
> Compiler knows that ->cpu_bitmap is 64 bits of storage, and with
> !CPUMASK_OFFSTACK, nr_cpumask_bits =3D NR_CPUS.  With NR_CPUS > 64,
> compiler gripes, with NR_CPUS <=3D 64 it's a happy camper.
>=20
> > What am I doing wrong?
>=20
> Below is what I did to get box to both STHU, and to boot with the
> openSUSE master branch config I sent.  Without the efi_mm hunk, boot
> hangs early with or without the other hunk.
>=20
> I build and boot tested the openSUSE config, a NOPREEMPT+MAXSMP
> config,
> my local config w. NR_CPUS=3D8, and master-rt w. NR_CPUS=3D256, which is
> the only one that got any real exercise (building the others).
>=20

Thank you for tracking that down.

I added your code, and Signed-off-By in patch
1 for version 5 of the series.

--=20
All Rights Reversed.
--=-G3vpz9Of2Yh/RdfONeoK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltD1d0ACgkQznnekoTE
3oPPswf/dExlEf7IrkgQzZhRGsT9nRIExvsX6DcFxIbTAS3GcyxnwRFei/NA0QlM
eXCysp4sNEs/goKmHPM2s0w8hQCSxhcIOuZi2afQJB0gE8yUjmszV63l3Co0X4i+
tiu0BlTL2GDyKd4ESficLjq8CgxuYJm+/HZY5ycqaOTDEZY80WAE3FnluaYNvqlJ
UiraH34mJmtiNSYZt9GSGlbWvrloNIzH7709YBEgdSwG3ppoQHcxFvoS23OzTmQX
eHemCRHFHRZ/vCS82ZHXMMHKjiimISaz15RKUO87OeDjUEBUXTiboeU3G2vI51mk
uE3ZXv4hBz2QbgAQDCj0MKWg/V/rSQ==
=qkuT
-----END PGP SIGNATURE-----

--=-G3vpz9Of2Yh/RdfONeoK--

