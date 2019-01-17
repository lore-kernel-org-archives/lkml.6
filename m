Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA74C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B554820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BjW3v6Gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfAQVWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:22:41 -0500
Received: from ozlabs.org ([203.11.71.1]:40691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfAQVWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:22:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gcVQ1hs4z9sDr;
        Fri, 18 Jan 2019 08:22:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547760159;
        bh=M6xoHTnXmMc42IK6fxxEPRo3Q+evfDZtyOSeUX2tqZo=;
        h=Date:From:To:Cc:Subject:From;
        b=BjW3v6GdaCWTi1xGAgDy7BncesKkoS9Szqvhh7rzaVi76Jsxfq9jwkx8T/2eReFxo
         5JvNXXxZ69YfHw4vabyf6FDiqnxw3QJIoG9iqBtJQJLoDH2PbTlprQjyZB6eT0mh8L
         MDdYqayArjO7dclWP5Zed059MBvlCjaugC9BhFfJFJycyrtKGjV7F6VdOl3WJxXC8X
         RhBKFc1txbVt2ouOue1d5svZa6dxPHd4QFye9D/NayNhRbzLpo20mPiL97tbLRAvHY
         gHkgMll7My7lERcTLJqeWmv2BMxfIRMgNMAWAtINPfXfi2Y9jswpqxeCjrY6rrIvEO
         3WYUk4q6h++UA==
Date:   Fri, 18 Jan 2019 08:22:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: linux-next: manual merge of the arc-current tree with Linus' tree
Message-ID: <20190118082237.4cb892c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+cLRlcqQ.iby8NRqd33W9Aw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+cLRlcqQ.iby8NRqd33W9Aw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arc-current tree got a conflict in:

  arch/arc/mm/fault.c

between commit:

  d8d7d842e828 ("arch/arc/mm/fault.c: remove caller signal_pending_branch p=
redictions")

from Linus' tree and commit:

  ce3e02e8be58 ("ARC: mm: do_page_fault fixes #1: relinquish mmap_sem if si=
gnal arrives while handle_mm_fault")

from the arc-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arc/mm/fault.c
index a1d723197084,535cf18e8bf2..000000000000
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@@ -141,12 -141,17 +141,17 @@@ good_area
  	 */
  	fault =3D handle_mm_fault(vma, address, flags);
 =20
- 	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
 -	if (unlikely(fatal_signal_pending(current))) {
 +	if (fatal_signal_pending(current)) {
- 		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
- 			up_read(&mm->mmap_sem);
- 		if (user_mode(regs))
+=20
+ 		/*
+ 		 * if fault retry, mmap_sem already relinquished by core mm
+ 		 * so OK to return to user mode (with signal handled first)
+ 		 */
+ 		if (fault & VM_FAULT_RETRY) {
+ 			if (!user_mode(regs))
+ 				goto no_context;
  			return;
+ 		}
  	}
 =20
  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);

--Sig_/+cLRlcqQ.iby8NRqd33W9Aw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxA8h0ACgkQAVBC80lX
0GyLAwf7BLnSKmuQV1SRxUTc4sQVuaTbJ6Le68lfRqFU0PWOtCqcXxffmy1xUsKN
ihgJ+mu25mw9ZpX2razrtAxJJDy2jyDdlZ8E+Q9o0PZQ6/natcaUBIxayvnBsGiC
SjfEAAS7l1Q5Lt5fYydY6ZQBfYyVNM64lQtr8rrcspmgSusS0Jxj5QxpZZVZ+8Hu
19f6JiFrpjGS4v3ISC32Rv13GuJYTg++ASnnvwfZiMOYVtTmkNDEaY26of+fXnOa
4P5lNPjTo62MDV/o7EKSqVuqRTS8HqUiJ68c9z1rZbzSTZ+6l87vqjtBwcBuPV7j
TVw3x7fboUP2t7C6jVYXRr0PI0iHdg==
=eZEw
-----END PGP SIGNATURE-----

--Sig_/+cLRlcqQ.iby8NRqd33W9Aw--
