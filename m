Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeCTIaA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:30:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:38205 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751450AbeCTI37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:29:59 -0400
From: NeilBrown <neil@brown.name>
To: John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Date: Tue, 20 Mar 2018 19:29:51 +1100
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: remove ralink_halt()
Message-ID: <87370v9mkg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


ralink_halt() does nothing that machine_halt()
doesn't already do, so it adds no value.

It actually causes incorrect behaviour due to the
"unreachable()" at the end.  This tell the compiler that the
end of the function will never be reached, which isn't true.
The compiler responds by not adding a 'return' instruction,
so control simply moves on to whatever bytes come afterwards
in memory.  In my tested, that was the ralink_restart()
function.  This means that an attempt to 'halt' the machine
would actually cause a reboot.

So remove ralink_halt() so that a 'halt' really does halt.

Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 arch/mips/ralink/reset.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index 64543d66e76b..e9531fea23a2 100644
=2D-- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -96,16 +96,9 @@ static void ralink_restart(char *command)
 	unreachable();
 }
=20
=2Dstatic void ralink_halt(void)
=2D{
=2D	local_irq_disable();
=2D	unreachable();
=2D}
=2D
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart =3D ralink_restart;
=2D	_machine_halt =3D ralink_halt;
=20
 	return 0;
 }
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqwxn8ACgkQOeye3VZi
gblkLRAAvwG8WkRAE1caLZ1sbk1UVbj6WvbgJ0g0F6mxky+8sWif0kKsTyOqBSzM
HeR1bw2n4N+IAqgX8EilcO6L2h0tFT60kgZeMFabR9z2S9i1rX7cv7xvF/cmQOiz
84LejiQHNxpFZ8QRrOaRSI+H5D4qxac2hiwrzO60XinEjPKCGoavmXtiWld9Tn7O
3C8OI+t1pEwH3PHSZcD57l5z7HURGnGP9evrl0xvzm523YJiK+HGOnhE/TdHTKLN
mggnBSNKV0hgmIIuMXkv4zu+TbLq8WR/hs8nNLsOSATLayjXDTrwzn63E0tVjjUE
HZy3t6ZjU+Dud9fFoRkhqMm0kfC9/tCW+oW0EwXM6rJLWRD3wZqNRhfxdlN6Xh8X
bXBsAP0LcbrSNj3jlXxhWbMeYTaVtu2R/ZkDkSq4e6JASp1Ly+5AfEpemMJzCyiR
6i4EAh2PdRdYNteKfMMXb3/s6IBmbYQjE9D2ZVptiDi8o0blW+EejKcXsbLqMsmc
gVV3Pa4m0dEF96+TV6lWv8ypr/wGf92kDMum7/A6odcBnKtPRv+gsVIOggf3F9RU
sqvL2GBUEth+G/IYyVh0/o1P33kcJjjbRLXjOAi0c6BKGARkNwP1EpTmbUiwAnY7
jK4jJbsVbPMvG6d2cCxOe1uMGSh/ngO+Kd+lKvP1JPXloxuU11o=
=Rhh6
-----END PGP SIGNATURE-----
--=-=-=--
