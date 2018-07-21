Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3E22084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3E22084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeGUDBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 23:01:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39783 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725139AbeGUDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 23:01:25 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fghLm-0002jj-CM; Sat, 21 Jul 2018 03:10:26 +0100
Date:   Sat, 21 Jul 2018 03:10:26 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20180721021026.GQ14131@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+hz2tM55CCA8Ej21"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] tools/lib/api/fs/fs.c: Fix misuse of strncpy()
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+hz2tM55CCA8Ej21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

gcc 8 reports:

In function 'fs__env_override',
    inlined from 'fs__get_mountpoint' at fs/fs.c:228:6:
fs/fs.c:222:2: error: 'strncpy' specified bound 4096 equals destination siz=
e [-Werror=3Dstringop-truncation]
  strncpy(fs->path, override_path, sizeof(fs->path));
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I'm not convinced it makes sense to truncate the copied string here,
but since we're already doing so let's ensure it's still null-
terminated.  Use strlcpy() instead.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org
---
 tools/lib/api/fs/fs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -12,6 +12,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/mount.h>
+#include <linux/string.h>
=20
 #include "fs.h"
 #include "debug-internal.h"
@@ -219,7 +220,7 @@ static bool fs__env_override(struct fs *
 		return false;
=20
 	fs->found =3D true;
-	strncpy(fs->path, override_path, sizeof(fs->path));
+	strlcpy(fs->path, override_path, sizeof(fs->path));
 	return true;
 }
=20

--+hz2tM55CCA8Ej21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW1KWEee/yOyVhhEJAQqblRAA0IxyoXB5eflvwdKYEcbloZ2e3WcFEw6U
AxhgvDS88n5oSKJCOwgCvuwOgh4OuTcyLg7vIumqD+ZAb7CMNe0Nypvx+1w0qJf/
jT3LbsN2G/MOtTQhXANGicSUTwST1QJrjZqrGYDS3RqoHxk2XUDIiPJk5DfYijqe
YRLSNH9D69phfCBWV3Se+TSusPzaJBEwLGMdJmr/E/Sk66vqSXcJSd1K5pHuxwQW
Mluef22Zom/WFndMFGhnIPChX/9u7xLT/WRDR2Hwew3QZGJ9ooTsE0jGlVEWk+0Q
8+45bsu5EDOJdTjfDFWMgIt0MlA10D1GmCZvlq2wLYoOLA/CFndvFu4A+ItP6hDC
6PiSAUkSCBerWMzjit60gT8PduxiK3Xrkn7hG68TF/leKgaQoyUJiUsaXtcuqSAC
FPg6fKqk9Owpf/ZGNixnkYpHwR49rndgVpcEvnm2IDIhjM/JGiyK/as/qGvo5r7O
iSrhW3TaBl11YH4D6ulpBkuxfBXBo3GwX4h5Kkaqajl5OrnuzV4SHhfV5LciwEkN
x0ud+vCQLK+IVVTr3geHZPdFcbwFQROaAK+JxMaJAwcEcXIl7KggQKWNvmb3QTy4
YlYe7p4RpScIAjjYLDIR2ewcXZsJzZ1ldlAr7letRneMn0xZUGpEjtv7RwacBQ5l
3fRVgx/+bY8=
=wRjB
-----END PGP SIGNATURE-----

--+hz2tM55CCA8Ej21--
