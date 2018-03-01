Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030262AbeCALpl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:45:41 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36957 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967808AbeCALpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:45:39 -0500
X-Google-Smtp-Source: AG47ELtUhGngt2kxCaVe/bk9Ql+wa5lXXS+L5Qx+MyJOMaoKdjzi609/C3ZgxDf3Xhzjf52z8BWTdw==
Date: Thu, 1 Mar 2018 01:45:35 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] sound/pci/ice1712: replace strcpy() with scnprintf()
Message-ID: <20180301114535.bf3ibzcpvohyjweu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pzq3s3rhinyipkia"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pzq3s3rhinyipkia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace unsafe uses of strcpy() to copy the name
argument into the sid.name buffer with scnprintf()
to guard against possible buffer overflows.

Even though we don't actually care about the return
value in this specific case, scnprintf() is still
preferred over snprintf() due to scnprintf() returning
the much more logical length of what was *actually* encoded
into the destination array instead of returning length
the resulting string *would* be, assuming it all fit
into the destination array as snprintf() does.

Maybe one day someone will use the return value, and
since the behavior is exactly the same apart from the
return value it would be better to account for that
possibility and program defensively.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index 0dbaccf61f33270608..0abacc64168f895d53 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
@@ -425,10 +426,9 @@ DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, =
1);
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 				     const char *name)
 {
-	struct snd_ctl_elem_id sid;
-	memset(&sid, 0, sizeof(sid));
-	/* FIXME: strcpy is bad. */
-	strcpy(sid.name, name);
+	struct snd_ctl_elem_id sid =3D {0};
+
+	scnprintf(sid.name, sizeof(sid.name), "%s", name);
 	sid.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
 	return snd_ctl_find_id(card, &sid);
 }
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index d145b5eb7ff86d978d..332f6226548c6a089a 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
@@ -785,10 +786,9 @@ DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, =
1);
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 				     const char *name)
 {
-	struct snd_ctl_elem_id sid;
-	memset(&sid, 0, sizeof(sid));
-	/* FIXME: strcpy is bad. */
-	strcpy(sid.name, name);
+	struct snd_ctl_elem_id sid =3D {0};
+
+	scnprintf(sid.name, sizeof(sid.name), "%s", name);
 	sid.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
 	return snd_ctl_find_id(card, &sid);
 }
--=20
2.16.2

--pzq3s3rhinyipkia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqX598ACgkQruvLfWhy
VBlsZBAAhllgpGNi4srM1CNx+LXINi3MmCpkniGncV6c0zhJMaYN1fXOY25r3Z6b
pw7qQr5uM02YC2d7Ca2dMQNZpOULO4TLXQw69cXqm6j7y0XA6T8CX2zCfUzTSfVt
lMkMjMKoXYvnbfh9HMwPvVjk9DlRZbmjOh4ovrm+FrZ3ZAYLCTuPK4x6DVPDG4zb
860Cx34A4siLVj9lhC+WSHaq2BaTrer3FTF7U7yQYO3eiJwTZKelCywAiCpr/P1T
/sJpTDJNJKzdbP4Xn3CYSWfF6C9/Y0iciPFYoa437RNBJZDWi1aF4+rP5rKheQKU
Kh0jBVEDfOb5VsTWZR8QiYa00g1HV0+IrC0z2Al3eMuv6SOYH0qxIx0y9/OhzcAt
65yVUyS9XCuCs1jMhRqe+KVL/JOZAJgQupv0XoPYMicYhJ1nWjSX/rIGbUFqcWjC
vImP7CB0ZYpmkXgcWt7twPFuvF/m0ubWOPlDHr0hzCf6s+6MgVMSReA28veMqbT3
XqgbmsTtHi9DP8I/48PPiDhrxlHbL1FBCYdNtKZcXWn4tQ51wM70V6NUkQgR8SOQ
RBWXMwld28CfroM69W2CNPfXPixGT/XY9N0ARTZkl9jt6QpJwgQcBmLLGLWnO8t4
QvY+LScpo3vPCaXye/oeZVSauCiR+4jHmr7Hm0hTppMjDVcZxgg=
=YKWX
-----END PGP SIGNATURE-----

--pzq3s3rhinyipkia--
