Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeDYEIZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:08:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47051 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbeDYEIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:08:24 -0400
From: NeilBrown <neil@brown.name>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>
Date: Wed, 25 Apr 2018 14:08:15 +1000
Subject: [PATCH] MIPS: c-r4k: fix data corruption related to cache coherence.
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Message-ID: <87sh7klyhc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


When DMA is to be performed to a MIPS32 1004K CPS, the
L1-cache for the range needs to be flushed and invalidated
first.
The code currently takes one of two approaches.
1/ If the range is less than the size of the dcache, then
   HIT type requests flush/invalidate cache lines for the
   particular addresses.  HIT-type requests a globalised
   by the CPS so this is safe on SMP.

2/ If the range is larger than the size of dcache, then
   INDEX type requests flush/invalidate the whole cache.
   INDEX type requests are NOT globalized by CPS so this
   is NOT safe when CPS is used.

Data corruption due to '2' can quite easily be demonstrated by
repeatedly "echo 3 > /proc/sys/vm/drop_caches" and then sha1sum
a file that is several times the size of available memory.
Dropping caches means that large contiguous extents (large than
dcache) are more likely.

This was not a problem before Linux-4.8 because option 2 was
never used if CONFIG_MIPS_CPS was defined.  The commit
which removed that apparently didn't appreciate the full
consequence of the change.

This patch avoids options 2 if mips_cm_present().

Fixes: c00ab4896ed5 ("MIPS: Remove cpu_has_safe_index_cacheops")
Cc: stable@vger.kernel.org (v4.8)
Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 arch/mips/mm/c-r4k.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6f534b209971..f845ec96f31e 100644
=2D-- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -851,9 +851,11 @@ static void r4k_dma_cache_wback_inv(unsigned long addr=
, unsigned long size)
 	/*
 	 * Either no secondary cache or the available caches don't have the
 	 * subset property so we have to flush the primary caches
=2D	 * explicitly
+	 * explicitly.
+	 * As Index type operations are not globalized by CM, we must
+	 * use the HIT type when CM is present.
 	 */
=2D	if (size >=3D dcache_size) {
+	if (!mips_cm_present() && size >=3D dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
@@ -890,7 +892,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsig=
ned long size)
 		return;
 	}
=20
=2D	if (size >=3D dcache_size) {
+	if (!mips_cm_present() && size >=3D dcache_size) {
 		r4k_blast_dcache();
 	} else {
 		R4600_HIT_CACHEOP_WAR_IMPL;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrf/y8ACgkQOeye3VZi
gbmGcBAAh51sMUB2Zncbly8y3PFLlMONlJ+QGkQ/Tqume3ehR9xS4/FkNc9NIErT
RNV0Gz4W/GCLHXVeRqYgCiHNlrzUME5BgsUrElaIt0M7oHUBcb7UdycofnhujcsY
6FHkdQJ82ope8cSqopZ5rF10PAIOUgbW3btI8iu/MC1EM/Z3Pg/3D53YxiM9S6n3
+fFy7rRkCLbS9TW0zLPw61usqLgthd+pozdgskGGUGnVm56qpMYynY/hU8Syk+Yh
6BnuzagKUBezvTTtCzgujiAorzjeqXPrHAD+6ELLgIaGVlJPq3QNCwSmfuxTOBUa
8wTHhvROq9+RZuEBAatietfy15xwxk1u0Bo3yHwNNeg/MWbQ5TFRW/OlV+hOTm7h
21YQMqZ6fTkmdtXCPz0l7lOI7bb0rh1Sez/0hgsGm4RFVn4TFFKKGgJZB/2KVqyd
lm3oeRu4Gunv8di2Wqq1zp6J6TrvBdjBBVooLd/c6UTScQqZ3QrKeW3eu3AOr9zH
MMJ4pFchNvHUhB95co2dQssFNHFIG0CDCQmJoMCQrCKgyIg9ypy9DdWXF+c0XQkF
sKXykLrMfAlmhVWImQ4WD8rAfhS7sSSDEICz4R4iMRVhSeE7o1ZtXLPjmO7CWEvL
JSBvR+GB6KNSMP9reseXeUp286B/OASFLSaSEVYIgfTFESdqYSE=
=1GYc
-----END PGP SIGNATURE-----
--=-=-=--
