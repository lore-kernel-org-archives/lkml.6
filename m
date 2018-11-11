Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD832C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6892C214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6892C214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeKLEfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:35:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48816 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729404AbeKLEfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:35:01 -0500
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLujc-0005Xq-Gc; Sun, 11 Nov 2018 18:45:26 +0000
Date:   Sun, 11 Nov 2018 18:45:24 +0000
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Message-ID: <20181111184524.fux4taownc6ndbx6@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yox42ydsmjky7enj"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] perf tools: Suppress potential format-truncation warning in
 util/pmu.c
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yox42ydsmjky7enj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Depending on which functions are inlined in util/pmu.c, the
snprintf() calls in perf_pmu__parse_{scale,unit,per_pkg,snapshot}()
might trigger a warning:

util/pmu.c: In function 'pmu_aliases':
util/pmu.c:178:31: error: '%s' directive output may be truncated writing up=
 to 255 bytes into a region of size between 0 and 4095 [-Werror=3Dformat-tr=
uncation=3D]
  snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
                               ^~

I found this when trying to build perf from Linux 3.16 with gcc 8.
However I can reproduce the problem in mainline if I force
__perf_pmu__new_alias() to be inlined.

Suppress this by using scnprintf() as has been done elsewhere in
perf.

Cc: stable@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/util/pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7799788f662f..25c7d2a4e91b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -145,7 +145,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias =
*alias, char *dir, char *
 	int fd, ret =3D -1;
 	char path[PATH_MAX];
=20
-	snprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd =3D=3D -1)
@@ -175,7 +175,7 @@ static int perf_pmu__parse_unit(struct perf_pmu_alias *=
alias, char *dir, char *n
 	ssize_t sret;
 	int fd;
=20
-	snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd =3D=3D -1)
@@ -205,7 +205,7 @@ perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, c=
har *dir, char *name)
 	char path[PATH_MAX];
 	int fd;
=20
-	snprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd =3D=3D -1)
@@ -223,7 +223,7 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_ali=
as *alias,
 	char path[PATH_MAX];
 	int fd;
=20
-	snprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
+	scnprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
=20
 	fd =3D open(path, O_RDONLY);
 	if (fd =3D=3D -1)

--yox42ydsmjky7enj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvoeL8ACgkQ57/I7JWG
EQmKAg/+LakjIvwrKOfXk6giksH7EN0IN+VK+WL5/yn7yBL9ds3CnizU9ek5jmAt
vKLu8FnsHuTJFKgV5KtaOe3fuzQX05YUUggC0A7K2CDeHV9sijexsoO+jEiMEPjs
80cvdi4WqoLcx3nC7gXbiEBu8wEyeUPheSCY68a/9O9Nv20S5X1HwFdcNQwiVPhh
rtg4dVj2OzVdtZJ1vNQUDjWt+pbhdNhZ8/MHnxew5wRv83LifiM7zDAQb/1zCkIk
RY+bjLElVL4e/kuuT00OofUplUFhJWQB37ij5ieuMu07mCrK7XzX1p2/yk11kS6u
qeYiXf0IogqWKfinpQ4BtadWhsCliyXYMD4TOm0Fa0db+tdrFw2S8QAi/9Vw2VKT
ayILOxk/Pod8cd1FcxB3AnpxcpxzWojGB9vbDoWphYnfYpYNv1XGEy3WVwVQnMrZ
KpWJ/FPF1gAoq+ZvSRtEXo8aT7u2GFlpNjolhLxf4Mi2QQXCjIX7zKS+rA+cXNJ8
giSUKptFAOMKJ36A/Q9H4Hp8kC+nVQlhWYkTIFWIZn8H2m/l5fL3kmoHPigPB0/9
cLcewNyrXDwmaJSP1xGA2zyi8+SDMAGzWZ0ZPQcbq7tN7fIXnP1ALV5T66pYFWxg
nCxhqakTychWXP3cd8eHTuswmdCIMgUG1RzHuKc0pnxE8nu13Kg=
=oPvQ
-----END PGP SIGNATURE-----

--yox42ydsmjky7enj--
