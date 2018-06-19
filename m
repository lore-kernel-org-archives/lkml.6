Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D076C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D822075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TzjhRKis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D822075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937206AbeFSBKi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:10:38 -0400
Received: from ozlabs.org ([203.11.71.1]:57911 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937125AbeFSBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:10:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418qdk69kZz9s2R;
        Tue, 19 Jun 2018 11:10:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529370635;
        bh=EHo1bUSzw324Le7MlEsnw5nsMnymTQMOLz5q/BRAQ2k=;
        h=Date:From:To:Cc:Subject:From;
        b=TzjhRKisSL0d4x5D14gJuUtQOXQCB+KOObAUPTBFecltQZTtec33hdtQVkXfflfbm
         O5XwXj3jHiHuE7DJb/8qpH+hTUX3GC8ejUaOP2JzbYESQecTukKHobyFvQbBy3Z0Hh
         +1yyTrMPE9GTU/7PDU/m0Pw6D7Tje+oj+e8assODG0Rbtl8cKc9JzhWppG5KoafS8B
         lggIZEXgEgyY1DZWk2wikCxe2DCuHcgFrlcUq9BNmYcq3RTv194jJrWs56zVq9/33S
         CAFJU7DFrGwNMAkwfdKdUTTrlaQjn1eskRlpilGQSMTIttied0WimuT1mL3l1ADc4q
         fZd2+18ReSNwA==
Date:   Tue, 19 Jun 2018 11:10:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the overlayfs tree
Message-ID: <20180619111034.65953fe8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dKliGKXayxMZKJJXIFK4So4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dKliGKXayxMZKJJXIFK4So4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got conflicts in:

  include/linux/fs.h

between commit:

  e8f97b0a52b3 ("vfs: optionally don't account file in nr_files")

from the overlayfs tree and commit:

  db39e40a9682 ("new syscall: open_tree(2)")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/fs.h
index ef2a9bba4e11,55ddf123023c..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -154,9 -157,9 +157,12 @@@ typedef int (dio_iodone_t)(struct kioc
  /* File is capable of returning -EAGAIN if I/O will block */
  #define FMODE_NOWAIT	((__force fmode_t)0x8000000)
 =20
+ /* File represents mount that needs unmounting */
+ #define FMODE_NEED_UNMOUNT     ((__force fmode_t)0x10000000)
+=20
 +/* File does not contribute to nr_files count */
- #define FMODE_NOACCOUNT	((__force fmode_t)0x10000000)
++#define FMODE_NOACCOUNT	((__force fmode_t)0x20000000)
 +
  /*
   * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
   * that indicates that they should check the contents of the iovec are

--Sig_/dKliGKXayxMZKJJXIFK4So4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoWAoACgkQAVBC80lX
0Gz2Ugf/aMmdZh9LEcyCGrS5eqHw6EN2JJfa7DqJx8gYZfU1Vido90IB9XpwihEY
sTeMyBhijxi9itryu+zRUUq9GiF0PayEgOXM7pdY2cm8pvvvoW73ZQ2eAexLep+5
+T4Ty2PD1LtlB+0RuG8RmvXBf16gPkawXXzJGqSUAX1PvdTirt24V9bZESkepDur
X4bkt3aiFBEprvZvfrka4Iht2frVGciBYAPTd1WT/HampqHbvEVHhzTRw3W8oPJv
D/10m4Kw8i4u1rI1eRsRn3W09PJNiEjm2ElHvG2RaiGxtsXTb6otdUUm+Sedaizb
WeT/e+Z+QKHeNhukiccqnNEOIPPJoQ==
=eFtb
-----END PGP SIGNATURE-----

--Sig_/dKliGKXayxMZKJJXIFK4So4--
