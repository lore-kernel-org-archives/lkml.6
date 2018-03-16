Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeCPK5g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:57:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39806 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeCPK5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:57:33 -0400
X-Google-Smtp-Source: AG47ELsqyhs+evkCUkRc+P/nahA6i4fBke0gaANQZnp8Sphmam0X2WlLrqn/I7N6cjweGJyqCKfSdw==
Date: Fri, 16 Mar 2018 00:57:29 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] x86/kvm: replace TASK_UNINTERRUPTIBLE with TASK_KILLABLE
Message-ID: <20180316105729.ykomeftdvlzqm4p6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dila3hn22bplhzf5"
Content-Disposition: inline
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dila3hn22bplhzf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There doesn't seem to be any advantage to having a *completely*
uninterruptible task here. For most users, allowing a task to respond
to the SIGKILL interrupt signal (all other signals are ignored just like
TASK_UNINTERRUPTIBLE) will not impact them at all.

However, for the rare edge-cases where a task becomes stuck, maybe due to
snapshot corruption or some other similarly unrecoverable error, it
is *much* more convenient for a user to be able to have the additional
option of nuking that task with SIGKILL, rather than annoying them by
forcing them to reboot in order to remove the immortal process.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index bc1a27280c4bf77899..7d4faee962e0c2e3c1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -154,8 +154,8 @@ void kvm_async_pf_task_wait(u32 token, int interrupt_ke=
rnel)
=20
 	for (;;) {
 		if (!n.halted)
-			prepare_to_swait(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
-		if (hlist_unhashed(&n.link))
+			prepare_to_swait(&n.wq, &wait, TASK_KILLABLE);
+		if (hlist_unhashed(&n.link) || fatal_signal_pending(current))
 			break;
=20
 		rcu_irq_exit();
--=20
Cheers,
Joey Pabalinas

--dila3hn22bplhzf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqroxkACgkQruvLfWhy
VBmDPQ//ag4/WuE6iw5Jh+vVxbnrakFYr9aAoIri1SNuWKxNqsjs+fpqBmjfW0Em
gF2xP3n42hNfwejg1yQSIqe72dqFjMNTnxmdvYQ/BdM6yZKhf2iECBZIYFQxYDKK
qVIu/WWrzregF++pkyMa9zzLPDSbax/JDouebC8jDlAS91t7cSpJEoAx2Tswn5Od
9RaoreGMKquF/lbkUTXFhuAltARxploYYz8aVn1yTClvu2Jgp2ZTa17RE3DB6hW2
BaGgPt3HA4l6BXqZGRUiMNmn7hqOrHaH8ur5u9P9Ak7xK5ObTFldoNuUYcRyEcrj
89WkglLlxHe62aGVZtDSWSHLvbAsDItuVMLFz6wE4+363MmRN7QItgM0b1s0afEH
4St85tC2cWIJIUD6m3qudzpbFyeDvszr0fVg0d6lJRkeBgrNO7gC4rkqqSe2u7qS
5JlOyzwejqayYjVvkHX41g/RahhGl7eBtYgNS/HUy4JmTegYDkIF23DGp/Pmu/J5
SDfQEhDSU0VYTUg0uTBCsFDajL7RxrzB0jZ3bvB3fClAF4a9UM3P8hxNdGMDCOFX
UajxRiezBHOzdCKGjknoMK4RVZ7CgRRJL3Erc4YKbrWseOdfgUaNawVLRi1Nh5AH
r8f7djLgc0/eVTaJ+hBBlGbW/+aImOyb/VW7FUpqzX9JzwRV0gs=
=9cRh
-----END PGP SIGNATURE-----

--dila3hn22bplhzf5--
