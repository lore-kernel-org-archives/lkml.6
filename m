Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034285AbeCBHob (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 02:44:31 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42951 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034253AbeCBHo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 02:44:29 -0500
X-Google-Smtp-Source: AG47ELvlyM03Q8cKTD+1qgEinELqEFAiII8RsarTmrEw2jDGf/tyTC8j/hhTFGlK+vLDldLLzfAJaQ==
Date: Thu, 1 Mar 2018 21:44:24 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnaud Lacombe <lacombar@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] scripts/kconfig: replace single character strcat() appends
Message-ID: <20180302074424.2myh3zhxnbpaohjq@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bd6lqbgbkpl4nnon"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bd6lqbgbkpl4nnon
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert strcat() calls which only append single characters
to the end of res into simpler (and most likely cheaper)
single assignment statements.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index cca9663be5ddd91870..67600f48660f2ac142 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -910,8 +910,7 @@ char *sym_expand_string_value(const char *in)
 	 * freed, so make sure to always allocate a new string
 	 */
 	reslen =3D strlen(in) + 1;
-	res =3D xmalloc(reslen);
-	res[0] =3D '\0';
+	res =3D xcalloc(1, reslen);
=20
 	while ((src =3D strchr(in, '$'))) {
 		char *p, name[SYMBOL_MAXLENGTH];
@@ -951,7 +950,7 @@ const char *sym_escape_string_value(const char *in)
 {
 	const char *p;
 	size_t reslen;
-	char *res;
+	char *res, *end;
 	size_t l;
=20
 	reslen =3D strlen(in) + strlen("\"\"") + 1;
@@ -968,25 +967,25 @@ const char *sym_escape_string_value(const char *in)
 		p++;
 	}
=20
-	res =3D xmalloc(reslen);
-	res[0] =3D '\0';
-
-	strcat(res, "\"");
+	res =3D xcalloc(1, reslen);
+	end =3D res;
+	*end++ =3D '\"';
=20
 	p =3D in;
 	for (;;) {
 		l =3D strcspn(p, "\"\\");
 		strncat(res, p, l);
 		p +=3D l;
+		end +=3D l;
=20
 		if (p[0] =3D=3D '\0')
 			break;
=20
-		strcat(res, "\\");
-		strncat(res, p++, 1);
+		*end++ =3D '\\';
+		*end++ =3D *p++;
 	}
+	*end =3D '\"';
=20
-	strcat(res, "\"");
 	return res;
 }
=20
--=20
2.16.2

Sorry about the double send, clipboards are very fickle beasts :(

--bd6lqbgbkpl4nnon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqZANgACgkQruvLfWhy
VBkMpxAA4WWKNhpeoQc9XUH4aQwN6pfAS13WHvB0cT5angyIeG30zEK5FlV8nog+
jif+QVJGKWRqIQzWqI78UQkIJoJz4p8TN/Zfitn0QnXM2koy6GOE8P9Z+itWzxzL
iutNN9/J0QwlBbzF6k0dMU2lot7Z1Bmpm6LcL0ioGIW6oVNQYz46WrhjGNxfl5Hu
flQOsj9CFhgRL0iUizf7N0OaCN8H9dj4lqYfTNMiTr3DYXZuAixAazZ3rTbmUIJV
AxiOEim5LTCGIsxYw1iRrnnhrhu0Dz6bDBC8+LrTyxMoYIxZXsAy+rfv6pxgKweP
O6ZV898YbPvrk1u+WL/gK/MINHAttccssI/p3yr/GToCr41msdXT1HRlnISd2wtM
zutMGF20/tUMB3/N0i52jLyFxDo4bdq4h3ycroc87ttgd51rwHRfBd8KJUMqPS6/
aNlyFc3w724HunPdNYU5b9QJcL4wiEypmTxdJNEwBq2oIt+FTIuSoWbRUUF3l+9p
O+GSsfmVD0pTwkwwquXyvTWgQaYj437xDCeJooXY706+19Pr8s4RHziyqTNiyP7P
BVFzEqG7vo+EP0WBt/vIyCN/Ky7WRMqu1C93S3a0tLWPU3BAuYVrVDlY/M/RGzCh
G/flH/1D0wowxQ4qsTkZTxNWZ+5OLWNok0zgUiziwKUfdHTtNE8=
=z1dk
-----END PGP SIGNATURE-----

--bd6lqbgbkpl4nnon--
