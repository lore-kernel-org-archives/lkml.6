Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24E9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667F12087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667F12087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeGPAO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:14:59 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34534 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbeGPAO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:14:59 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1feqmQ-0000lW-NY; Sun, 15 Jul 2018 19:50:18 -0400
Message-ID: <1531698618.26425.4.camel@surriel.com>
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
From:   Rik van Riel <riel@surriel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com
Date:   Sun, 15 Jul 2018 19:50:18 -0400
In-Reply-To: <20180715225951.GC30102@gmail.com>
References: <20180710142833.26231-1-riel@surriel.com>
         <20180710142833.26231-2-riel@surriel.com>
         <20180715225951.GC30102@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VN0oHTDJx4LSussIuGVw"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VN0oHTDJx4LSussIuGVw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-16 at 00:59 +0200, Ingo Molnar wrote:
> * Rik van Riel <riel@surriel.com> wrote:
>=20
> > The mm_struct always contains a cpumask bitmap, regardless of
> > CONFIG_CPUMASK_OFFSTACK. That means the first step can be to
> > simplify things, and simply have one bitmask at the end of the
> > mm_struct for the mm_cpumask.
> >=20
> > This does necessitate moving everything else in mm_struct into
> > an anonymous sub-structure, which can be randomized when struct
> > randomization is enabled.
> >=20
> > The second step is to determine the correct size for the
> > mm_struct slab object from the size of the mm_struct
> > (excluding the cpu bitmap) and the size the cpumask.
> >=20
> > For init_mm we can simply allocate the maximum size this
> > kernel is compiled for, since we only have one init_mm
> > in the system, anyway.
> >=20
> > Pointer magic by Mike Galbraith, to evade -Wstringop-overflow
> > getting confused by the dynamically sized array.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
>=20
> Is this an Acked-by in disguise, or did this patch route via Mike?

Mike found an issue with the patch and sent a
fix, so I added his S-o-b to this patch as
well.

--=20
All Rights Reversed.
--=-VN0oHTDJx4LSussIuGVw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltL3boACgkQznnekoTE
3oPjPgf6A41NIpkLxSiS6GvJD1trDA0xZI81OXY6arXHNkUYS0yKkxmLN+/fyijp
ARHho8i+h/SJDrYaaal0NEB4VSL4DefFGKsYJckYtO0DtjCfh4a/2798iCQfv0SK
CVlCstRMdyDbf97FfZk0oQGntNBhlMaTWa+eSOz3nRy/aLNklS0GJgS0ESTrlXMk
eHenZyW10xTr/yhqJqEj1kXIALOjYY+oGtRntLkHTRekuR625xUlgyJantCFR0ZP
xGVoqvdlsr6i8rmpumICVVy0091mCgOA497G2SucEmUylZTZpU3tOla0jQUuGG4p
ltbXiq+p0Td36PVc0CaJyFNVEZ4+xQ==
=e6KY
-----END PGP SIGNATURE-----

--=-VN0oHTDJx4LSussIuGVw--

