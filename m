Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FF4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3841621834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YeINWPjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3841621834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeHMLDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:03:37 -0400
Received: from ozlabs.org ([203.11.71.1]:44665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeHMLDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:03:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ppcX10sFz9s7Q;
        Mon, 13 Aug 2018 18:22:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534148543;
        bh=wqgWaP4E5W3HovJ6tbm+oVAE7r3X09bADk495VCvt2c=;
        h=Date:From:To:Cc:Subject:From;
        b=YeINWPjqZIgBK/91ajnQOamdCmrpwuRqfBGaoAnhVhcAGO9fvisvTpv+nABDqw2X3
         QiOcP2yg/QVkvApKaH9aBUAfSBCS7YpzfTbTzdevu60N1YF0Qj+fYXZ1tswZ4sLZGb
         6wg4EQNsyPGUPri8/bzLVeCIVbCZZ1KkwnOlpIc1sEGaRq3qVjdF94m7YZugQq6U4D
         xn95RBDeKxGXcy0WQHw1+C86ZBEwN/7RtiVs5Ha5RcCTsX/fmZNnUaP0bHCORC+84i
         H4NIn/QZJ7ddCdKHD8AbLYsBD3GQJrHaFQKhx9pMIrhajbOLtmZlQVoziFNm/0BJiz
         5qsBcLPe5JEjw==
Date:   Mon, 13 Aug 2018 18:22:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsO8cmc=?= Billeter <j@bitron.ch>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180813182218.595fe0bc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/i8v81v0_6pKOT5ElPwG24Y9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i8v81v0_6pKOT5ElPwG24Y9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

kernel/exit.c: In function 'reparent_leader':
kernel/exit.c:640:3: error: too few arguments to function 'group_send_sig_i=
nfo'
   group_send_sig_info(p->signal->pdeath_signal_proc,
   ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/sched/signal.h:6:0,
                 from include/linux/sched/cputime.h:5,
                 from kernel/exit.c:14:
include/linux/signal.h:262:12: note: declared here
 extern int group_send_sig_info(int sig, struct siginfo *info,
            ^~~~~~~~~~~~~~~~~~~

Caused by commit

  b04bd4d0117c ("prctl: add PR_[GS]ET_PDEATHSIG_PROC")

interacting with commit

  0102498083d5 ("signal: Pass pid type into group_send_sig_info")

from the uerns tree.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 13 Aug 2018 18:07:07 +1000
Subject: [PATCH] merge fix up for "signal: Pass pid type into
 group_send_sig_info"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 7b72bed283d4..066c66448258 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -638,7 +638,7 @@ static void reparent_leader(struct task_struct *father,=
 struct task_struct *p,
=20
 	if (p->signal->pdeath_signal_proc)
 		group_send_sig_info(p->signal->pdeath_signal_proc,
-				    SEND_SIG_NOINFO, p);
+				    SEND_SIG_NOINFO, p, PIDTYPE_TGID);
=20
 	/* We don't want people slaying init. */
 	p->exit_signal =3D SIGCHLD;
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/i8v81v0_6pKOT5ElPwG24Y9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltxP7oACgkQAVBC80lX
0GzdwQf9EmRTqtPBceXGFGX3rfkOvFom64t3bUMsLuP/zhBdpD51TLCa1mjg6h/b
S6+aVAOihJlbxGygtbIeR6lU+S3+5gYkDy29mXji8KWD1cspYr8FhW1q7SQ5n8kK
s8LvQEZE2IXJFyxNkejhGYmDIuKY/y/JVK3rSKkb3D6YZ6F2U1UW2kpRMr7IMhHu
fnXZfRBdTTFiEKPhFEk4kS3MxLEWAnVonWdkeP4dd8q9qP0S0+5oRCpddwlBwodp
jnn+dWsXxt3BucWzdyMG8fTEqKXVrJICSeABIRrtdPngV/AEhdygQ8rMTDmLgU0I
AtAJnJ+zxs2+zVwdeN6Nlw0VWGAeXg==
=L4bW
-----END PGP SIGNATURE-----

--Sig_/i8v81v0_6pKOT5ElPwG24Y9--
