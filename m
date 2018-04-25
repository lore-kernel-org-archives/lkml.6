Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeDYVrD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbeDYVq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:46:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D1214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 25 Apr 2018 22:46:51 +0100
From: James Hogan <jhogan@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: c-r4k: fix data corruption related to cache
 coherence.
Message-ID: <20180425214650.GA25917@saruman>
References: <87sh7klyhc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <87sh7klyhc.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi NeilBrown,

On Wed, Apr 25, 2018 at 02:08:15PM +1000, NeilBrown wrote:
> Cc: stable@vger.kernel.org (v4.8)

FYI my preferred form of this is:

Cc: <stable@vger.kernel.org> # 4.8+

>  	/*
>  	 * Either no secondary cache or the available caches don't have the
>  	 * subset property so we have to flush the primary caches
> -	 * explicitly
> +	 * explicitly.
> +	 * As Index type operations are not globalized by CM, we must
> +	 * use the HIT type when CM is present.

I don't think Index type operations *can* be sensibly globalised to
separate primary caches, since they directly index the lines in the
cache rather than any particular physical or virtual address, so this
fundamental issue doesn't sound specific to the CM.

I'm not entirely clear OTOH whether there are any non-CM r4k-like SMP
capable cores that don't have coherent IO or inclusive caches.
- Octeon doesn't use c-r4k and has coherent IO
- Netlogic appear to have coherent IO=20
- Loongson64 have inclusive caches
- bmips, only bmips5000 appears to have multicore (not just multi-thread
  with I presume shared dcaches), and that has inclusive caches

So I suppose that does just leave non-multicore and CM systems as
potentially reaching these bits of code...

>  	 */
> -	if (size >=3D dcache_size) {
> +	if (!mips_cm_present() && size >=3D dcache_size) {

=2E.. but even for CM systems its only if there are foreign CPUs running
(i.e. not just threads on the same core sharing the same dcache) that it
actually matters.

So I'm thinking "!mips_cm_present()" should probably be replaced with
"!r4k_op_needs_ipi(R4K_INDEX)" (and the comment updated to mention that
IPI calls aren't implemented here).

That effectively means:
	!CONFIG_SMP || cpumask_empty(&cpu_foreign_map[0])

Otherwise the patch looks spot on. Thanks for spotting this!

Cheers
James

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuD3SgAKCRA1zuSGKxAj
8jxaAQCjN7fGjCbL9rA4R+BAfse5BLH8yfkHr3MGSlqlg1WdgAEAvcze6SBWRFlC
LxHvEdBgz+wy9S+LYgU2ERRG62e6FQ0=
=j2yT
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
