Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB85C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E412A2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E412A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeKUGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:12:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53138 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbeKUGMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:12:39 -0500
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gPBtx-0004cu-5a; Tue, 20 Nov 2018 19:41:38 +0000
Date:   Tue, 20 Nov 2018 19:41:37 +0000
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20181111174751.kaw2d7gsatiezagu@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4fay4fnrht5xxtum"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] perf tools: Check for over-long path in is_directory()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4fay4fnrht5xxtum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

is_directory() uses sprintf() which could potentially result in a
stack buffer overrun.  Change to use snprintf() and assert that
the output fits in the buffer.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
A better fix would be to pass the directory fd in and use fstatat()
but I don't know whether you want to support older kernel versions
or C libraries that don't support this.

Ben.

 tools/perf/util/path.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index ca56ba2dd3da..333e20f78ced 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -84,8 +84,11 @@ bool is_directory(const char *base_path, const struct di=
rent *dent)
 {
 	char path[PATH_MAX];
 	struct stat st;
+	int len;
+
+	len =3D snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
+	assert((size_t)len < sizeof(path));
=20
-	sprintf(path, "%s/%s", base_path, dent->d_name);
 	if (stat(path, &st))
 		return false;
=20

--4fay4fnrht5xxtum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlv0Y2cACgkQ57/I7JWG
EQlsPhAAnmUlvQh7FpY32bdKSu6ZPML9uf3FQBd0MT9ZZvlo9LwsTH2JkoEv9KLu
wWjfjmu7UJ+M9kgFvrKz8FB1OeLhDPKRCju8DdC/uWkoPY/eSH44abBz6ZTu2BKD
dXio6ePo3EhdUPaCH898OcYH/6cJSwMN6e2OVep7CORXcay3yMk14B3MbT15e0tc
8uWIeYr2YaHrPRIwuz5NNPDMCYIF9rpMGmcFCLCcV1fs9Po8Kxvg5nZaofcxggcV
YPPxKH0CAbkp8VbqCKh6IS2gBmDimnB67+DDYxGCMiYWPaFsKVbiPGdjh++cvVZS
WLdxA3EAFrIPBt6bF3rFegvIwGB7Sb7b1IqQ9Qq05MHQ4JA1C2WH2kXHNxs0BURJ
AQhr7Xb+9VhuK5gO1NcmJDXvJjY3ApxGC9NWXoWbH3V7SK7/AL1MCEhoAOo7+0wO
6dRp3BOUAfXK/mvo3Ibmb4VbMVJPLi4nuBsidymNw8+BX8/nrJwas8wYp8WUfbDW
a2fDhO+T9cE6P3hGbnRVF8tD4oXw/o/Lxkr4iLap+Y9C3iXVQwIudgd07w4r2LlC
o+zwDGWfzv8ZxsDtdQYGemdjjeeduH2vpYMyZMHSBCAqMS4Bs9/cS58rnUO4yOFo
EB6gRWRT26EQga018HPfu8Oopdw4re6hoqllmfAx+mFugTBkm08=
=NumP
-----END PGP SIGNATURE-----

--4fay4fnrht5xxtum--
