Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeERGZ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:25:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35723 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:25:57 -0400
X-Google-Smtp-Source: AB8JxZrYWklUhoLeS00EJXYLH5+FCLGb300y366jgxVGAmTFBEb9YBcyUuU5lFbudgHgh1DEruyaUw==
Date: Thu, 17 May 2018 20:25:53 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v3] scripts/tags.sh: don't parse `ls` for $ALLSOURCE_ARCHS
 generation
Message-ID: <20180518062553.kodjjrlrosrg7vfq@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zg4dzz4qm2b2imuj"
Content-Disposition: inline
User-Agent: NeoMutt/20180323-62-378db9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zg4dzz4qm2b2imuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Parsing `ls` is fragile at best and _will_ fail when $tree
contains spaces. Replace this with a glob-generated string
and directly assign it to $ALLSOURCE_ARCHS (Kconfig is
removed as it isn't an architecture); a subshell is implied
by $(), so `cd` doesn't affect the current working directory.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 78e546ff689c2d5f40..e4aba2983f6272fc44 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -29,14 +29,12 @@ fi
 ignore=3D"$ignore ( -path ${tree}tools ) -prune -o"
=20
 # Find all available archs
 find_all_archs()
 {
-	ALLSOURCE_ARCHS=3D""
-	for arch in `ls ${tree}arch`; do
-		ALLSOURCE_ARCHS=3D"${ALLSOURCE_ARCHS} "${arch##\/}
-	done
+	ALLSOURCE_ARCHS=3D"$(cd "${tree}arch/" && echo *)"
+	ALLSOURCE_ARCHS=3D"${ALLSOURCE_ARCHS/Kconfig}"
 }
=20
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" =3D "" ]; then
 	ALLSOURCE_ARCHS=3D${SRCARCH}
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty


--zg4dzz4qm2b2imuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlr+cfEACgkQruvLfWhy
VBnPYBAApdgT3tXeanYkjzPbfMrg++P966Rd6jiZoErPJQeoPk/iVoZncHMl4Zt7
99RytLnmTJqxRb7cxfJmGi3rrTKCI30ol3B61ucrTTpyIM7Vi6xVMVh6C8kA9Fls
mR6+zMk7jP34BISmFSQAKqHDKl9TZsFjrO8CEqxFlFvyhH0udMcAm0xAt1gAdHj9
1r6Nd1V+EGm9Pi/XgdFPleUXdwDJHFop2A3r/OPV2CyyW4RwFomlI3DNFt4xyQgf
Jq7hq3yJHQeyJ7yph5QeC+v0tiekvTAs2GzGPF6WCyZdU89og8oZWIWi8T+s2HBl
DOmeSKjxBjyntbigD+tV5WoZfqDFw4s+v8N7bRm4Geod7KaEHsKRKnWU4KDsnafG
IPrmF8zvjwmUhj8gOXxw0pBG0yqeEiHeh6xqJ7ujHTX6MT3RAp3BxjzM6GLraVm4
Xshsmzl7qhb4e+RQDRF1E73ou7Mk6mqRYjGD8mwn84tLJvLqhoBGNtQVxF20GPoV
9ZjubHY/bRnKPilBAU1B9zUPjVl/6GqpdDUhlk7gfP79fi5PbQJFCP72gWAIoRLH
pNNk7RpG0l+3HkPljR0iB0y4mVrGGemFXPjURZrStn/uPDiL4sPg9Tawpv0uDNSh
b/N9qrU8V6ux4q7FA+ZD+xW7y5OS2xzQeaJoQSoaAGXz8z4Rc7Q=
=5Jcd
-----END PGP SIGNATURE-----

--zg4dzz4qm2b2imuj--
