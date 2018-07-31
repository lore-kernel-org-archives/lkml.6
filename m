Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322CBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB678208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB678208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeGaCnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:43:51 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50716 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbeGaCnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:43:51 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fkJ6p-000106-FK; Mon, 30 Jul 2018 21:05:55 -0400
Message-ID: <1532999155.28585.56.camel@surriel.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon, 30 Jul 2018 21:05:55 -0400
In-Reply-To: <20180730162653.GM2494@hirez.programming.kicks-ass.net>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
         <20180729155452.37eddc11@imladris.surriel.com>
         <20180730095502.GG2494@hirez.programming.kicks-ass.net>
         <1532961011.28585.30.camel@surriel.com>
         <20180730162653.GM2494@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-E7KE3RR1bBJyyka+rda/"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E7KE3RR1bBJyyka+rda/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
>=20
> So for ARCH_NO_ACTIVE_MM we never touch ->active_mm and therefore
> ->active_mm =3D=3D ->mm.

Close, but not true for kernel threads, which have a=20
NULL ->mm, but a non-null ->active_mm that gets passed
to enter_lazy_tlb().

I stuck to the structure of your code, but ended up
removing all the ifdefs because the final mmdrop requires
that we actually keep track of the ->active_mm across
potentially several kernel->kernel context switches.

Ifdefs around the reference counting code are also not
needed, because grab_lazy_mm and drop_lazy_mm already
contain the equivalent of an ifdef themselves.

By morning I should know what the test results look
like. I expect they will be identical to my patches,
since the refcounting is disabled completely anyway :)

> > +       /*
> > +        * kernel -> kernel   lazy + transfer active
> > +        *   user -> kernel   lazy + mmgrab() active
> > +        *
> > +        * kernel ->   user   switch + mmdrop() active
> > +        *   user ->   user   switch
> > +        */
> > +       if (!next->mm) {                                // to
> > kernel
> > +               enter_lazy_tlb(prev->active_mm, next);
> > +
>=20
> #ifndef ARCH_NO_ACTIVE_MM
> > +               next->active_mm =3D prev->active_mm;
> > +               if (prev->mm)                           // from
> > user
> > +                       mmgrab(prev->active_mm);
>=20
> 		else
> 			prev->active_mm =3D NULL;
> > +#endif
> > +       } else {                                        // to user
> > +               switch_mm_irqs_off(prev->active_mm, next->mm,
> > next);
> > +
>=20
> #ifndef ARCH_NO_ACTIVE_MM
> > +               if (!prev->mm) {                        // from
> > kernel
> > +                       /* will mmdrop() in finish_task_switch().
> > */
> > +                       rq->prev_mm =3D prev->active_mm;
> > +                       prev->active_mm =3D NULL;
> > +               }
> > +#endif
>=20
>=20
--=20
All Rights Reversed.
--=-E7KE3RR1bBJyyka+rda/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltftfMACgkQznnekoTE
3oPq/ggAuz6InKyTy2j2MY+yjCf8dKDUbsE/AYffIZfSRjj2k2SNu6fqx7VPPM4M
UmAgECAp3RpBJFB0dH70GFb/dD+j1KLzCfNZA+1Qz+WZ7DdeylZcujos9Lph7nMw
fD1MQFxO9bk+zt1XuVCChnNx1FphE2GVauZMDWRRYgs5oehegesRwQ5MC4HWhNe1
AqhqSIg+FZx5EZo1vQmsBHPIS2ygMXHx8+6vQ84o1D+QNEDuMesmQmzWMozNZYak
ar13GRAvo9+J41WMeaqq0zGh+jHBmzGwKYlMHkCwiN/79IDiodAscIJ+H8EUQY9v
CxN+UM5kRBGsHW0Y4HY0nnTs04Jt/Q==
=hkbD
-----END PGP SIGNATURE-----

--=-E7KE3RR1bBJyyka+rda/--

