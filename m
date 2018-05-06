Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeEFVlD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 17:41:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:35273 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeEFVlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 17:41:02 -0400
From: NeilBrown <neil@brown.name>
To: James Hogan <jhogan@kernel.org>
Date: Mon, 07 May 2018 07:40:49 +1000
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: c-r4k: fix data corruption related to cache coherence.
In-Reply-To: <87vacdlf8d.fsf@notabene.neil.brown.name>
References: <87sh7klyhc.fsf@notabene.neil.brown.name> <20180425214650.GA25917@saruman> <87h8nzlzf1.fsf@notabene.neil.brown.name> <20180425220834.GC25917@saruman> <87vacdlf8d.fsf@notabene.neil.brown.name>
Message-ID: <87lgcwcvj2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi James,
 this hasn't appear in linux-next yet, or in any branch
 of
   git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git

 Should I expect it to?

Thanks,
NeilBrown

On Fri, Apr 27 2018, NeilBrown wrote:

> When DMA will be performed to a MIPS32 1004K CPS, the
> L1-cache for the range needs to be flushed and invalidated
> first.
> The code currently takes one of two approaches.
> 1/ If the range is less than the size of the dcache, then
>    HIT type requests flush/invalidate cache lines for the
>    particular addresses.  HIT-type requests a globalised
>    by the CPS so this is safe on SMP.
>
> 2/ If the range is larger than the size of dcache, then
>    INDEX type requests flush/invalidate the whole cache.
>    INDEX type requests affect the local cache only. CPS
>    does not propagate them in any way.  So this invalidation
>    is not safe on SMP CPS systems.
>
> Data corruption due to '2' can quite easily be demonstrated by
> repeatedly "echo 3 > /proc/sys/vm/drop_caches" and then sha1sum
> a file that is several times the size of available memory.
> Dropping caches means that large contiguous extents (large than
> dcache) are more likely.
>
> This was not a problem before Linux-4.8 because option 2 was
> never used if CONFIG_MIPS_CPS was defined.  The commit
> which removed that apparently didn't appreciate the full
> consequence of the change.
>
> We could, in theory, globalize the INDEX based flush by sending an IPI
> to other cores.  These cache invalidation routines can be called with
> interrupts disabled and synchronous IPI require interrupts to be
> enabled.  Asynchronous IPI may not trigger writeback soon enough.
> So we cannot use IPI in practice.
>
> We can already test is IPI would be needed for an INDEX operation
> with r4k_op_needs_ipi(R4K_INDEX).  If this is True then we mustn't try
> the INDEX approach as we cannot use IPI.  If this is False (e.g. when
> there is only one core and hence one L1 cache) then it is safe to
> use the INDEX approach without IPI.
>
> This patch avoids options 2 if r4k_op_needs_ipi(R4K_INDEX), and so
> eliminates the corruption.
>
> Fixes: c00ab4896ed5 ("MIPS: Remove cpu_has_safe_index_cacheops")
> Cc: stable@vger.kernel.org # v4.8+
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  arch/mips/mm/c-r4k.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 6f534b209971..e12dfa48b478 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -851,9 +851,12 @@ static void r4k_dma_cache_wback_inv(unsigned long ad=
dr, unsigned long size)
>  	/*
>  	 * Either no secondary cache or the available caches don't have the
>  	 * subset property so we have to flush the primary caches
> -	 * explicitly
> +	 * explicitly.
> +	 * If we would need IPI to perform an INDEX-type operation, then
> +	 * we have to use the HIT-type alternative as IPI cannot be used
> +	 * here due to interrupts possibly being disabled.
>  	 */
> -	if (size >=3D dcache_size) {
> +	if (!r4k_op_needs_ipi(R4K_INDEX) && size >=3D dcache_size) {
>  		r4k_blast_dcache();
>  	} else {
>  		R4600_HIT_CACHEOP_WAR_IMPL;
> @@ -890,7 +893,7 @@ static void r4k_dma_cache_inv(unsigned long addr, uns=
igned long size)
>  		return;
>  	}
>=20=20
> -	if (size >=3D dcache_size) {
> +	if (!r4k_op_needs_ipi(R4K_INDEX) && size >=3D dcache_size) {
>  		r4k_blast_dcache();
>  	} else {
>  		R4600_HIT_CACHEOP_WAR_IMPL;
> --=20
> 2.14.0.rc0.dirty

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrvdmIACgkQOeye3VZi
gblfHRAAgf8cjAtiUtHQcthwyvpc+S+TIUiVtf8tCbiLyDfoDHp7zeXK45cyUZfN
Tlf1VJ2psDZ0GIVhfr0ZBY0Db4bEpDg7aCZ55vs7V7HlDVum9TJW2nRoz4wX1ss7
EFkIUXlOs7ABC04CfeC/NdfH53DAE4GQDSdK6C/8kweiPksUY0uq8o+hEL/ILxRi
mnPFuFR2zycNHe9/k6maqNJigNF4Os788EtaopdzupKueqfN9eel+Lfla8y6phkd
A9NmXBnKEj/52kP8fUfTlPWfBgNq1oy1D0fF1c1ePCVwJ9MtfaR8rdZ0MZ77arRd
XjY27O5DzG+M+Chdd/Lscyob+Mab7jDA4bULBBBRxDmYJGCAV4Ftw4Ru/DHtQDvd
YJEg0DkQhoOtdO4XIDI44L73ltZaCYiUwtdoxhESYdMl6tmHkaNjEZR2dmPjFcZm
MtdAhB59ZeCj/boP5+JijFcqtyVAAOPk47mN7swb3nzO8xCwTQHtZe3mcTBPhHAc
VoK0kekL8oW5WvsTDdiINSq1c8cM6yGR2NrAdp60j/2SsDWnYa2NWUAn8CWfB+uj
5je55gZMa63DRRrllop9e+X7aeFH1d++0fY/KpEg7y0bj7EGlrf0CIWroORl61Iq
u4bHxFyIoSR8gS/+RcukkH2Fk5r3i2AKEOAMUCR3ZLUb0Z2l4bs=
=Adyd
-----END PGP SIGNATURE-----
--=-=-=--
