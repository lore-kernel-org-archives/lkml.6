Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D1EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7B02064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7B02064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeH2Xlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:41:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33160 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbeH2Xln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:41:43 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fv6N3-0001xt-In; Wed, 29 Aug 2018 20:43:18 +0100
Date:   Wed, 29 Aug 2018 20:43:17 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     x86@kernel.org
Cc:     Helmut Grohne <helmutg@debian.org>, linux-kernel@vger.kernel.org
Message-ID: <20180829194317.GA4765@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] x86: Allow generating user-space headers without a compiler
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When bootstrapping an architecture, it's usual to generate the
kernel's user-space headers (make headers_install) before building a
compiler.  Move the compiler check (for asm goto support) to the
archprepare target so that it is only done when building code for the
target.

Fixes: e501ce957a78 ("x86: Force asm-goto")
Reported-by: Helmut Grohne <helmutg@debian.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 94859241bc3e..7df47ff45f68 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -175,10 +175,6 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
   endif
 endif
=20
-ifndef CC_HAVE_ASM_GOTO
-  $(error Compiler lacks asm-goto support.)
-endif
-
 #
 # Jump labels need '-maccumulate-outgoing-args' for gcc < 4.5.2 to prevent=
 a
 # GCC bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D46226).  There's=
 no way
@@ -312,6 +308,13 @@ PHONY +=3D vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=3Darch/x86/entry/vdso $@
=20
+archprepare: checkbin
+checkbin:
+ifndef CC_HAVE_ASM_GOTO
+	@echo Compiler lacks asm-goto support.
+	@exit 1
+endif
+
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW4b3Vee/yOyVhhEJAQrYQBAAsbdu3ljD4ZY9N3b63K5f/JeOptuf4a8H
V2wLKxWJdsA76hMJLQaFJ32Yi205eVxh8vGgl0UyyewENo9Tf2vCDqHw4phtaudh
WaoXnFuvoskAOw77ApQF1dM0TZv3S78f2r2urFHrEeNQY4INbIQZIqEM9vqwAiL4
Me7mtnxSkd58y5dGNc0OhClbo5Oox8brfJmJwaxp4nTSh7fl99wZz6kbO3wF2vFu
d+n7GdY0sFIkOWhU94PlpVmVZnY5pwL9PBQ8tAiNEf2+rzSXkIogiUu1fzj9TJ4T
snoqztdZ0RKpKDYb9/WVzO7nvYAwCNNxYhlfeqQrKQxuLd6v2jtwZAbvqklIq0x2
WSIb2AhdfOYdVjovzzNDO+qMVALgECXzkWJDIW6LAH/rlxHkM3l1K7lrs1VZqL+p
VZXyIbCV35Sjj/DqjId8xx/zHard/+uXdFqmydadzXsU1Sy8XhheJmscLGwehxWD
PWs/Gb+/Gj+x3X4mWmKkqFhVW56Foq0CM4NllzQMzHXcMz+7kGE43GeBYZkgAqPW
GSRmcQ3aoy+wacWLVSlpNorFHyAsQJRTuJbBzdeHDBcwvY4r1MBq7wWjCyVlylNj
5fzaO2YOA4ZhAOlMDFyqJ+GGBXXpDdjlSJ82YOLOoDJ/qyQyfIPxj/zoJjbMFGsr
3Mm9UuvTQks=
=DAvE
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
