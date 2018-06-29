Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC7C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CDF23D6F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CDF23D6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeF2R3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:29:25 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35352 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbeF2R3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:29:23 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fYxCw-00031J-KN; Fri, 29 Jun 2018 13:29:18 -0400
Message-ID: <1530293358.16379.8.camel@surriel.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
From:   Rik van Riel <riel@surriel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, mingo@kernel.org,
        kernel-team@fb.com, tglx@linutronix.de, efault@gmx.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Fri, 29 Jun 2018 13:29:18 -0400
In-Reply-To: <667c6fd5-2ab9-d3ca-0791-3d270de98204@linux.intel.com>
References: <20180629142918.26601-1-riel@surriel.com>
         <20180629142918.26601-5-riel@surriel.com>
         <667c6fd5-2ab9-d3ca-0791-3d270de98204@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gEkjRdSic4CizfhXlSIj"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gEkjRdSic4CizfhXlSIj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-29 at 10:05 -0700, Dave Hansen wrote:
> On 06/29/2018 07:29 AM, Rik van Riel wrote:
> > +		/*
> > +		 * If the CPU is not in lazy TLB mode, we are just
> > switching
> > +		 * from one thread in a process to another thread
> > in the same
> > +		 * process. No TLB flush required.
> > +		 */
> > +		if (!was_lazy)
> > +			return;
> > +
> > +		/*
> > +		 * Read the tlb_gen to check whether a flush is
> > needed.
> > +		 * If the TLB is up to date, just use it.
> > +		 * The barrier synchronizes with the tlb_gen
> > increment in
> > +		 * the TLB shootdown code.
> > +		 */
> > +		smp_mb();
> > +		next_tlb_gen =3D atomic64_read(&next-
> > >context.tlb_gen);
> > +		if
> > (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) =3D=3D
> > +				next_tlb_gen)
> > +			return;
>=20
> Nit: it might be nice to have this hunk in a helper like
> cpu_tlbstate_needs_flush(next) to keep this nice and readable.

That helper might not end up as pretty as you would
like, because when the TLB is not up to date, we use
the value of next_tlb_gen in the "if (need_flush)"
branch below.

I would be happy to whip up a "tlb_up_to_date(mm, &next_tlb_gen)"
helper as patch 8/7, though :)

--=20
All Rights Reversed.
--=-gEkjRdSic4CizfhXlSIj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAls2bG4ACgkQznnekoTE
3oNxSAf8DLt7YEL9i97ioTicrGpnEcAvTWGev7csBGiV++tS5zK8Y0r7lu0oHqbz
CVGBti2dMqKjTjleFoIBRJIPdJTw1qHspt2g6yyqLahN2Zuwf/5pYwdO8NXN6e9D
XLat1IYYguBNpOf849YFnTF5b+ixECUM3CaWDKk8MElLlx3ctoZqoMBsJ6jCsGhj
sZVAxCmIANdm7H5rdhpApyOXJycQ30CNNBrtD3ayN0kS7trOfmtNJeCWDous97a7
WiSztYNHXq1fwfL0wf5wZAjgJndmj84POq79Hcvm1tYT6rZqxS87zPAQdwkfEElP
pqjI1x/ya1GwD4BkQW7BlAGKKu/FJw==
=n4b3
-----END PGP SIGNATURE-----

--=-gEkjRdSic4CizfhXlSIj--

