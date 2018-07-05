Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96D0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7047324069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pJFkcma1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7047324069
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeGEFN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:13:27 -0400
Received: from ozlabs.org ([203.11.71.1]:59099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbeGEFN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:13:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LmGX1Qk3z9s1b;
        Thu,  5 Jul 2018 15:13:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530767604;
        bh=cM3aLEtLUXeunWEm+f7qd7Fi2Id7knAPsg+V2DB/QKY=;
        h=Date:From:To:Cc:Subject:From;
        b=pJFkcma10bS4ZM/HocCN4IZ+HyW3wjaHqGGs5buov/ocLN1bTrlGJFACF80Ve/556
         nbm/MleT+7R+1hrPvIjJSON0h/XsTTN3sbVbAeIdwljfIeifbQBC9TM0/iBZ+TlgXC
         TugPzPl1wSrBO9HCCNDdHCEzrtP+ob7Q0+ZcvtLPLqU5hCVusPt18wTecfPzL5qarT
         dfhKLf3RmKocPBpcKtZcYBf//bcgbb5sWeEAOv6aaZd9jqTikmz+qFp6fVAh/9NuvD
         pDbEvF/La9v9RDHaiwiH5U2dmC+zZkH6tW2vdWDC7Pgg/RBMrABGrW/OZ/zYkSiTIN
         61KqcMp3qcCEw==
Date:   Thu, 5 Jul 2018 15:13:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the ida tree
Message-ID: <20180705151323.42944e0d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k5.3lJdreFOFT4uE26K7p2v"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k5.3lJdreFOFT4uE26K7p2v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

After merging the ida tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

lib/test_xarray.c: In function 'xa_alloc_value':
lib/test_xarray.c:39:16: error: implicit declaration of function 'xa_alloc'=
; did you mean 'ida_alloc'? [-Werror=3Dimplicit-function-declaration]
  XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_value(index), GFP_KERNEL) !=3D 0);
                ^
lib/test_xarray.c:21:6: note: in definition of macro 'XA_BUG_ON'
  if (x) {      \
      ^

Caused by commit

  1af163b61ed6 ("xarray: Track free entries in an XArray")

I have reverted that commit for today (and the following one).

--=20
Cheers,
Stephen Rothwell

--Sig_/k5.3lJdreFOFT4uE26K7p2v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls9qPMACgkQAVBC80lX
0GwkIQf/RlTijTCA9rNpR2QIcD6N0+J2lZRywCbrGbPhctQlbbVAExWVV0dbEF8x
3py+j/WSPS+jHYdWLPTPrT7aacqXnSqLCeM4kFW5/wIr1iSWCvV9FYsftar8TntR
kVmUMu7BWlAi6jNJFzikRXGYqmEE2aKFHfEWCEugOjspG70wxRyZI4fpt/DOctQj
KZ1MoKpQC3x6Wcbr+mpfoti0YhHzo675vjIGxjh+s2O3tZoUlxUTUjBAB/7iKPrR
9N3O0HnF8MgfNAOqkZPr9TQ9oawrOpcXjF0ps6154DG2dhnYUt6NKAicJRav5ioE
e+GA+NrOPvMDuFC6tG3+kg6aVljoGQ==
=AiU3
-----END PGP SIGNATURE-----

--Sig_/k5.3lJdreFOFT4uE26K7p2v--
