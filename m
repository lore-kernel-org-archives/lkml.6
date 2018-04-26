Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeDZX2s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:28:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57831 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeDZX2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:28:47 -0400
From: NeilBrown <neil@brown.name>
To: James Hogan <jhogan@kernel.org>
Date: Fri, 27 Apr 2018 09:28:34 +1000
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: c-r4k: fix data corruption related to cache coherence.
In-Reply-To: <20180425220834.GC25917@saruman>
References: <87sh7klyhc.fsf@notabene.neil.brown.name> <20180425214650.GA25917@saruman> <87h8nzlzf1.fsf@notabene.neil.brown.name> <20180425220834.GC25917@saruman>
Message-ID: <87vacdlf8d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


When DMA will be performed to a MIPS32 1004K CPS, the
L1-cache for the range needs to be flushed and invalidated
first.
The code currently takes one of two approaches.
1/ If the range is less than the size of the dcache, then
   HIT type requests flush/invalidate cache lines for the
   particular addresses.  HIT-type requests a globalised
   by the CPS so this is safe on SMP.

2/ If the range is larger than the size of dcache, then
   INDEX type requests flush/invalidate the whole cache.
   INDEX type requests affect the local cache only. CPS
   does not propagate them in any way.  So this invalidation
   is not safe on SMP CPS systems.

Data corruption due to '2' can quite easily be demonstrated by
repeatedly "echo 3 > /proc/sys/vm/drop_caches" and then sha1sum
a file that is several times the size of available memory.
Dropping caches means that large contiguous extents (large than
dcache) are more likely.

This was not a problem before Linux-4.8 because option 2 was
never used if CONFIG_MIPS_CPS was defined.  The commit
which removed that apparently didn't appreciate the full
consequence of the change.

We could, in theory, globalize the INDEX based flush by sending an IPI
to other cores.  These cache invalidation routines can be called with
interrupts disabled and synchronous IPI require interrupts to be
enabled.  Asynchronous IPI may not trigger writeback soon enough.
So we cannot use IPI in practice.

We can already test is IPI would be needed for an INDEX operation
with r4k_op_needs_ipi(R4K_INDEX).  If this is True then we mustn't try
the INDEX approach as we cannot use IPI.  If this is False (e.g. when
there is only one core and hence one L1 cache) then it is safe to
use the INDEX approach without IPI.

This patch avoids options 2 if r4k_op_needs_ipi(R4K_INDEX), and so
eliminates the corruption.

Fixes: c00ab4896ed5 ("MIPS: Remove cpu_has_safe_index_cacheops")
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 arch/mips/mm/c-r4k.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6f534b209971..e12dfa48b478 100644
=2D-- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -851,9 +851,12 @@ static void r4k_dma_cache_wback_inv(unsigned long addr=
, unsigned long size)
 	/*
 	 * Either no secondary cache or the available caches don't have the
 	 * subset property so we have to flush the primary caches
=2D	 * explicitly
+	 * explicitly.
+	 * If we would need IPI to perform an INDEX-type operation, then
+	 * we have to use the HIT-type alternative as IPI cannot be used
+	 * here due to interrupts possibly being disabled.
 	 */
=2D	if (size >=3D dcache_size) {
+	if (!r4k_op_needs_ipi(R4K_INDEX) && size >=3D dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
@@ -890,7 +893,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsig=
ned long size)
 		return;
 	}
=20
=2D	if (size >=3D dcache_size) {
+	if (!r4k_op_needs_ipi(R4K_INDEX) && size >=3D dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlriYKMACgkQOeye3VZi
gbniDBAAnSJUETvc8auIPKdOblDCNbWrTCARob7ac7YKM1PCa3vOaBV+pdGEwDRN
bcYBZxgAuM83B3kCUEmgImrNR+hVOLjKkCTfYHOt3+3rGMg4QjsJTtvYQGrD7OlU
tm+xw51GbMuojSbFe5lGvEZVZGMPMMX9euZxq5iUm78TR3ESmcL1anj+DaITpKSX
BiXxFgxJv8y7V4pQhaMXW1WjEK5BrVCNckRlt+g1v1o2lygsvO58W5OE2MLWNZlr
0n3L2gN8hDC1D6wT/ZSL3MagJLGBtMp86HTUtxRPwa6T7fHeMzmXJd4plj/pwvCb
bdVJDJgXQL3bOjUI1qJ7rq2G8LK/DJhagBBz5ilfOC2okg/8ofNYitupDV4sA5NV
VQCa2SQN6wQeKw6rZ4yL4D8zEQ14+1qOiyaiDX4DURatajbxdbXknfj5EoOFR4tA
cUWikvUXHT/j/lx7WP6bpp+aM+yzSAjQgOMWkr+b9CqirJ1CJ9usmF5WDiyK4P0t
ky3Wx6LzcoRe7R6u1IQsLNM/rCPwdij7eaOld0HPdGPVOK+fXH/9t2p8wnelfS7k
2OJot1lqRCLrng3EIBbb0XI0VG1UmpCNAF30fB+fmULM99UCLUHokE74riEB9gYE
McIudL5MydymyVpKkTtDKzPuhiGXHQDkseT+fspaPmA9oxBOqv8=
=IIOa
-----END PGP SIGNATURE-----
--=-=-=--
