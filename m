Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeCJK5H (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 05:57:07 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41648 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeCJK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 05:57:04 -0500
X-Google-Smtp-Source: AG47ELsc4pSdBzf5QA5W/wA0qxWrAX35m3A2H2J3nxjo05fULjaENynNCO8CUMNNy+bucXeNfgKRCg==
Date: Sat, 10 Mar 2018 00:56:59 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v2] scripts/kconfig: cleanup symbol handling code
Message-ID: <20180310105659.7e34lk4kvcbl64lg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5oo6xr74tsg54goh"
Content-Disposition: inline
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5oo6xr74tsg54goh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Many of the variable names in scripts/kconfig/symbol.c are
far too terse to the point of not at all identifying _what_
they are actually used for (`p` and `l` as a couple examples),
and overall there is a large amount of code that could use
some cleaning up.

Give more explicit names to these variables, fix a couple cases
where different variables were sharing the same name and shadowing
each other, and overall cleanup a bit of the messiness in
sym_expand_string_value() and sym_escape_string_value()
while maintaining equivalent program behavior.

Suggested-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 2220bc4b051bd914e3..9ee32ddb44e193719c 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -5,8 +5,8 @@
=20
 #include <ctype.h>
 #include <stdlib.h>
-#include <string.h>
 #include <regex.h>
+#include <linux/string.h>
 #include <sys/utsname.h>
=20
 #include "lkc.h"
@@ -337,7 +337,7 @@ void sym_calc_value(struct symbol *sym)
 {
 	struct symbol_value newval, oldval;
 	struct property *prop;
-	struct expr *e;
+	struct expr *expr;
=20
 	if (!sym)
 		return;
@@ -469,7 +469,7 @@ void sym_calc_value(struct symbol *sym)
 		struct symbol *choice_sym;
=20
 		prop =3D sym_get_choice_prop(sym);
-		expr_list_for_each_sym(prop->expr, e, choice_sym) {
+		expr_list_for_each_sym(prop->expr, expr, choice_sym) {
 			if ((sym->flags & SYMBOL_WRITE) &&
 			    choice_sym->visible !=3D no)
 				choice_sym->flags |=3D SYMBOL_WRITE;
@@ -899,94 +899,100 @@ struct symbol *sym_find(const char *name)
  * name to be expanded shall be prefixed by a '$'. Unknown symbol expands =
to
  * the empty string.
  */
-char *sym_expand_string_value(const char *in)
+char *sym_expand_string_value(const char *src)
 {
-	const char *src;
-	char *res;
-	size_t reslen;
+	const char *in;
+	char *res, *out;
+	size_t res_len, src_len;
=20
 	/*
-	 * Note: 'in' might come from a token that's about to be
+	 * Note: 'src' might come from a token that'src about to be
 	 * freed, so make sure to always allocate a new string
 	 */
-	reslen =3D strlen(in) + 1;
-	res =3D xmalloc(reslen);
-	res[0] =3D '\0';
+	res_len =3D strlen(src) + 1;
+	res =3D xmalloc(res_len);
+	out =3D res;
=20
-	while ((src =3D strchr(in, '$'))) {
+	while ((in =3D strchr(src, '$'))) {
 		char *p, name[SYMBOL_MAXLENGTH];
-		const char *symval =3D "";
+		const char *sym_val =3D "";
 		struct symbol *sym;
-		size_t newlen;
+		size_t new_len, sym_len;
=20
-		strncat(res, in, src - in);
-		src++;
+		strscpy(out, src, in - src);
+		out +=3D in - src;
+		in++;
=20
 		p =3D name;
-		while (isalnum(*src) || *src =3D=3D '_')
-			*p++ =3D *src++;
+		while (isalnum(*in) || *in =3D=3D '_')
+			*p++ =3D *in++;
 		*p =3D '\0';
=20
 		sym =3D sym_find(name);
 		if (sym !=3D NULL) {
 			sym_calc_value(sym);
-			symval =3D sym_get_string_value(sym);
+			sym_val =3D sym_get_string_value(sym);
 		}
=20
-		newlen =3D strlen(res) + strlen(symval) + strlen(src) + 1;
-		if (newlen > reslen) {
-			reslen =3D newlen;
-			res =3D xrealloc(res, reslen);
+		sym_len =3D strlen(sym_val);
+		new_len =3D sym_len + strlen(res) + strlen(in) + 1;
+		if (new_len > res_len) {
+			res_len =3D new_len;
+			res =3D xrealloc(res, res_len);
 		}
=20
-		strcat(res, symval);
-		in =3D src;
+		strscpy(out, sym_val, sym_len);
+		out +=3D sym_len;
+		src =3D in;
 	}
-	strcat(res, in);
+	src_len =3D strlen(src);
+	strscpy(out, src, src_len);
+	out +=3D src_len;
+	*out =3D '\0';
=20
 	return res;
 }
=20
-const char *sym_escape_string_value(const char *in)
+const char *sym_escape_string_value(const char *src)
 {
-	const char *p;
-	size_t reslen;
-	char *res;
-	size_t l;
+	const char *in;
+	size_t res_len, in_len;
+	char *res, *out;
=20
-	reslen =3D strlen(in) + strlen("\"\"") + 1;
+	res_len =3D strlen(src) + strlen("\"\"") + 1;
=20
-	p =3D in;
+	in =3D src;
 	for (;;) {
-		l =3D strcspn(p, "\"\\");
-		p +=3D l;
+		in_len =3D strcspn(in, "\"\\");
+		in +=3D in_len;
=20
-		if (p[0] =3D=3D '\0')
+		if (*in =3D=3D '\0')
 			break;
=20
-		reslen++;
-		p++;
+		res_len++;
+		in++;
 	}
=20
-	res =3D xmalloc(reslen);
-	res[0] =3D '\0';
+	res =3D xmalloc(res_len);
+	out =3D res;
+	*out++ =3D '\"';
=20
-	strcat(res, "\"");
-
-	p =3D in;
+	in =3D src;
 	for (;;) {
-		l =3D strcspn(p, "\"\\");
-		strncat(res, p, l);
-		p +=3D l;
+		in_len =3D strcspn(in, "\"\\");
+		strscpy(out, in, in_len);
+		in +=3D in_len;
+		out +=3D in_len;
=20
-		if (p[0] =3D=3D '\0')
+		if (*in =3D=3D '\0')
 			break;
=20
-		strcat(res, "\\");
-		strncat(res, p++, 1);
+		*out++ =3D '\\';
+		*out++ =3D *in++;
 	}
+	*out++ =3D '\"';
+	*out =3D '\0';
=20
-	strcat(res, "\"");
 	return res;
 }
=20
@@ -1014,8 +1020,8 @@ static int sym_rel_comp(const void *sym1, const void =
*sym2)
 	 * exactly; if this is the case, we can't decide which comes first,
 	 * and we fallback to sorting alphabetically.
 	 */
-	exact1 =3D (s1->eo - s1->so) =3D=3D strlen(s1->sym->name);
-	exact2 =3D (s2->eo - s2->so) =3D=3D strlen(s2->sym->name);
+	exact1 =3D (s1->eo - s1->so) =3D=3D (off_t)strlen(s1->sym->name);
+	exact2 =3D (s2->eo - s2->so) =3D=3D (off_t)strlen(s2->sym->name);
 	if (exact1 && !exact2)
 		return -1;
 	if (!exact1 && exact2)
@@ -1390,31 +1396,33 @@ const char *prop_get_type_name(enum prop_type type)
 	return "unknown";
 }
=20
-static void prop_add_env(const char *env)
+static void prop_add_env(const char *env_key)
 {
 	struct symbol *sym, *sym2;
 	struct property *prop;
-	char *p;
+	char *env_val;
=20
 	sym =3D current_entry->sym;
 	sym->flags |=3D SYMBOL_AUTO;
 	for_all_properties(sym, prop, P_ENV) {
 		sym2 =3D prop_get_symbol(prop);
-		if (strcmp(sym2->name, env))
+		if (strcmp(sym2->name, env_key))
 			menu_warn(current_entry, "redefining environment symbol from %s",
 				  sym2->name);
 		return;
 	}
=20
 	prop =3D prop_alloc(P_ENV, sym);
-	prop->expr =3D expr_alloc_symbol(sym_lookup(env, SYMBOL_CONST));
+	prop->expr =3D expr_alloc_symbol(sym_lookup(env_key, SYMBOL_CONST));
=20
 	sym_env_list =3D expr_alloc_one(E_LIST, sym_env_list);
 	sym_env_list->right.sym =3D sym;
+	env_val =3D getenv(env_key);
=20
-	p =3D getenv(env);
-	if (p)
-		sym_add_default(sym, p);
-	else
-		menu_warn(current_entry, "environment variable %s undefined", env);
+	if (likely(env_val)) {
+		sym_add_default(sym, env_val);
+		return;
+	}
+
+	menu_warn(current_entry, "environment variable %s undefined", env_key);
 }
--=20
2.16.2

--5oo6xr74tsg54goh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqjufsACgkQruvLfWhy
VBnPgw/+OMcFdo5BJ5otPdx+8lSdeiIRlnIv9NRnk4HTlsiJDyMBLWRc2QsIbMvp
5X2BbQorijnj+O25K9XEOZnU3bImPaik1XNZBhRC4e2JdeHwrgXiluJ/Ei1AZ9Wa
jqFOz2YEFj2z8R6Zep/7Oceowe8GP7D/vZHSz8zn+l44T627ovSuXPwWVZQPkUDg
1XZ8IYXNXm7ItXvF6LTIYmPgl7n0+HajAKlPuEcqFe31q9QX7H5gMzyEcz/MGGed
8J3bmRlgIthI3G2NUv7LQZmiphwt/o+yaMn83V4cCEWjbk+1BW56MX4t3LUA+Bga
W/WVkBvbTzX87l6tnVv1RSaqzhOt8VXlRHiydHxhs9gSTNciVVT0PMbODmpWNQpb
JO5DsEeGAU6Jy4rYnB/IwLLH98vZpTVzNW+h+GOQD650bbUHQeseDkVErImdilNs
EuW/qu68BRXniUCFonktFhmX44XGMs5x78out1kYscRBWSIok54nbO5/VaA2//Sy
54YwdVM0hYQxBsD3pxoB+nfbq7LyTg0iFQh1f7aQqmSHBEx58FxBTXlVrCB1RfMK
NGZSw2FubXCy5QQpHNotOsZtMq+2jyjv/w17Yb8bMAWOFnf6JLQtejSP7z7ERbHX
Pf+XDdyt33pHRiYGJLs8qE+gwKlzn8LE17oWrxaUsDdVboiRZd4=
=mb9x
-----END PGP SIGNATURE-----

--5oo6xr74tsg54goh--
