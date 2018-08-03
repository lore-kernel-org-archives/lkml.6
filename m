Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F38221774
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F38221774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeHCShy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:37:54 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44220 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:37:54 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fld8D-0000fK-Rb; Fri, 03 Aug 2018 12:40:49 -0400
Message-ID: <1533314448.28585.101.camel@surriel.com>
Subject: Re: [PATCH 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        luto@kernel.org, x86@kernel.org, efault@gmx.de,
        dave.hansen@intel.com
Date:   Fri, 03 Aug 2018 12:40:48 -0400
In-Reply-To: <20180803155618.GB2494@hirez.programming.kicks-ass.net>
References: <20180801100255.4278-1-riel@surriel.com>
         <20180801100255.4278-12-riel@surriel.com>
         <20180803155618.GB2494@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-knht40hDg7MIyJw9CpEZ"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-knht40hDg7MIyJw9CpEZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-03 at 17:56 +0200, Peter Zijlstra wrote:
> On Wed, Aug 01, 2018 at 06:02:55AM -0400, Rik van Riel wrote:
> > Conditionally skip lazy TLB mm refcounting. When an architecture
> > has
> > CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
> > lazy TLB mode anywhere will get shot down from exit_mmap, and there
> > in no need to incur the cache line bouncing overhead of refcounting
> > a lazy TLB mm.
> >=20
> > Implement this by moving the refcounting of a lazy TLB mm to helper
> > functions, which skip the refcounting when it is not necessary.
> >=20
> > Deal with use_mm and unuse_mm by fully splitting out the
> > refcounting
> > of the lazy TLB mm a kernel thread may have when entering use_mm
> > from
> > the refcounting of the mm that use_mm is about to start using.
>=20
>=20
> > @@ -2803,16 +2803,29 @@ context_switch(struct rq *rq, struct
> > task_struct *prev,
> >  	 * membarrier after storing to rq->curr, before returning
> > to
> >  	 * user-space.
> >  	 */
> > +	/*
> > +	 * kernel -> kernel	lazy + transfer active
> > +	 *   user -> kernel	lazy + grab_lazy_mm active
> > +	 *
> > +	 * kernel ->   user	switch + drop_lazy_mm active
> > +	 *   user ->   user	switch
> > +	 */
> > +	if (!mm) {				// to kernel
> >  		next->active_mm =3D oldmm;
> >  		enter_lazy_tlb(oldmm, next);
> > +
> > +		if (prev->mm)			// from user
> > +			grab_lazy_mm(oldmm);
> > +		else
> > +			prev->active_mm =3D NULL;
> > +	} else {				// to user
> >  		switch_mm_irqs_off(oldmm, mm, next);
> > =20
> > +		if (!prev->mm) {		// from kernel
> > +			/* will drop_lazy_mm() in
> > finish_task_switch(). */
> > +			rq->prev_mm =3D oldmm;
> > +			prev->active_mm =3D NULL;
> > +		}
> >  	}
>=20
> So this still confuses the heck out of me; and the Changelog doesn't
> seem to even mention it. You still track and swizzle ->active_mm but
> no
> longer refcount it.
>=20
> Why can't we skip the ->active_mm swizzle and keep ->active_mm =3D=3D
> ->mm.
>=20
> Doing the swizzle but not the refcount just makes me itch.

I am working on that now, it adds another 7-8
patches on top of this series.

The big question is, do we want this optimization
to wait for further cleanups, or should we run with
code that seems to be stable right now, and put
additional cleanups and enhancements on top of it
later?

The end result should be the same.

--=20
All Rights Reversed.
--=-knht40hDg7MIyJw9CpEZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltkhZAACgkQznnekoTE
3oNlvQgAifQvUeHOr0yq2nn3hM4KWZRpBlHqU4qjy7timr2AbXAa71fAj5oTKlQr
l6O+2xGoZQb/LMJb82foQzffRrw3JAhf+tPDKX1i6SCnJ9nE+VUIrPB52xIHR7AQ
AB5h6DSJ1qG2fxWyUPK+Jg5Mj1AxM4hO6HL03yTL2HjqSfwklm+5oaS4EPBEZDLl
RwH4R68x7JcMY2GhkyKgbRsFNsTQpMQe6hOHW0lSACQdne4C5vzoyCVS6AZsPgii
pqucZMh2IPAY1VlMpQF3uXl2EUXlYKZ2FaG4KM8RXAYhfSMRnyn1ZEU/YTqpQHh6
90PfHaHPnsIirE/Do8eoqKkUyhpvgw==
=1OYg
-----END PGP SIGNATURE-----

--=-knht40hDg7MIyJw9CpEZ--

