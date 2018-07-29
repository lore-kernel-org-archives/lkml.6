Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EE2C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2803620873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 16:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2803620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeG2S00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:26:26 -0400
Received: from shelob.surriel.com ([96.67.55.147]:47952 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeG2S00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:26:26 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjoyJ-00005D-6J; Sun, 29 Jul 2018 12:55:07 -0400
Message-ID: <1532883305.28585.17.camel@surriel.com>
Subject: Re: [PATCH 10/10] mm,sched: conditionally skip lazy TLB mm
 refcounting
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun, 29 Jul 2018 12:55:05 -0400
In-Reply-To: <FC4DF151-463C-4CED-8962-9056648BFEDC@amacapital.net>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-11-riel@surriel.com>
         <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
         <1532866319.28585.12.camel@surriel.com>
         <FC4DF151-463C-4CED-8962-9056648BFEDC@amacapital.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MYo/Jv5bfiIuWaF+WkM8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MYo/Jv5bfiIuWaF+WkM8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-07-29 at 08:29 -0700, Andy Lutomirski wrote:
> > On Jul 29, 2018, at 5:11 AM, Rik van Riel <riel@surriel.com> wrote:
> >=20
> > > On Sat, 2018-07-28 at 21:21 -0700, Andy Lutomirski wrote:
> > > On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com>
> > > wrote:
> > > > Conditionally skip lazy TLB mm refcounting. When an
> > > > architecture
> > > > has
> > > > CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is
> > > > used in
> > > > lazy TLB mode anywhere will get shot down from exit_mmap, and
> > > > there
> > > > in no need to incur the cache line bouncing overhead of
> > > > refcounting
> > > > a lazy TLB mm.
> > >=20
> > > Unless I've misunderstood something, this patch results in idle
> > > tasks
> > > whose active_mm has been freed still having active_mm pointing at
> > > freed memory.=20
> >=20
> > Patch 9/10 is supposed to ensure that the lazy TLB CPUs get
> > switched to init_mm before an mm is freed. No CPU should ever
> > have its active_mm pointing at a freed mm.
> >=20
> > Your message made me re-read the code, and now I realize that
> > leave_mm does not actually do that.
> >=20
> > Looking at the other callers of leave_mm, I might not be the
> > only one surprised by that; xen_drop_mm_ref comes to mind.
> >=20
> > I guess I should some code to leave_mm to have it actually
> > clear active_mm and call the conditional refcount drop helper
> > function.
> >=20
> > Does that clear up the confusion?
>=20
> Kind of. But what=E2=80=99s the point of keeping active_mm?  On architect=
ures
> that opt in to the new mode, there won=E2=80=99t be any code that cares a=
bout
> it=E2=80=99s value.  What=E2=80=99s the benefit of keeping it around?  If=
 you ifdef
> it out, then it can=E2=80=99t possibly point to freed memory, and there=
=E2=80=99s
> nothing to worry about.

I would like to get to that point, but in a way that does
not leave the code too difficult to follow.

Getting rid of ->active_mm in context_switch() is straightforward,
but I am not sure at all what to do about idle_task_exit() for
example.

All the subtleties I ran into just with this phase of the
code suggests (to me at least) that we should probably do
this one step at a time.

I agree on the same end goal, though :)

--=20
All Rights Reversed.
--=-MYo/Jv5bfiIuWaF+WkM8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltd8WkACgkQznnekoTE
3oOKvAf/SIM1JQB9eK0FIQ0gFeL9UlTwdU2KfwwhEGof/tXFMGIhThoxC65/IYl/
UEKj/dwslfUIipfYoctzJ8NpYlp8lTZqw/lNVNDgI43NAw23sqWMClabCnAyl4nS
HXXeBstU9py1ZYujz0re3MBHklWl7sd0bF6/0zLq1WyJUUYTbAffwt9ZqO2HrG2x
YNz6y6mLGkYy6L5Ow3Y2Esr1xyq64+y1wPYbr73jelx5xUaL7vH1QeEX5COe9+Bh
Va1c4p6gUrWb2epEopbUHILZ+kfoGQ1co+Oxj71oP+RCJorMuGqC4a6nqvqXY0y7
iY4H4SFhJfXx2+nodIkPOouTGbC2vQ==
=IYfO
-----END PGP SIGNATURE-----

--=-MYo/Jv5bfiIuWaF+WkM8--

