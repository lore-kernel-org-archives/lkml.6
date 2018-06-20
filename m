Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA59C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9152086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SYx0yfEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9152086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeFTBpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:45:03 -0400
Received: from ozlabs.org ([203.11.71.1]:48979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753173AbeFTBo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:44:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 419SLw6MNXz9s4v;
        Wed, 20 Jun 2018 11:44:56 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529459098;
        bh=yqn8pC6uj5N1EwgcedbaldaaZhiQZJjGv4K3sFuKc+A=;
        h=Date:From:To:Cc:Subject:From;
        b=SYx0yfEfSCJABsKAfQSeXy1Kh2p2Z7kffye7dkfCWEzkz/i+YGBKp0vh1UXQuScbq
         uw9v2VEtACZI9uJblPFMWl5XFb7f6GMOXnZIWYohamNsItz4xPBh08Vof7BdW7NnQR
         BJYLGqSnK6aS5OVBxyso4gPYi0fTkBa9D8YhKwOKL6l8fz2gY0oaITE6eJrb/Jl+3f
         7zP7FKUwMiSDbdhVWVlNiqR719oWTHS5mB0UkQp+tnU+rLXWD0sD6oZA7sJHzrgjiu
         pm9bx4LMigRlocQyQuVVY2cRc9mjOoqIUDSl6EHSwQTG0sYTitPuMLEU2atYccYtZo
         9rmolULzTVfKA==
Date:   Wed, 20 Jun 2018 11:44:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the userns tree with the vfs tree
Message-ID: <20180620114441.285f5dfa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nqzNhFJcXFpmRS21zpIK=ea"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nqzNhFJcXFpmRS21zpIK=ea
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  fs/proc/internal.h

between commit:

  0223e0999be2 ("procfs: Move proc_fill_super() to fs/proc/root.c")

from the vfs tree and commit:

  04035aa33a12 ("proc: Don't change mount options on remount failure.")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/proc/internal.h
index ea8c5468eafc,69fa8d953cde..000000000000
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@@ -270,10 -252,16 +270,15 @@@ static inline void proc_tty_init(void)=20
  /*
   * root.c
   */
+ struct proc_mount_options {
+ 	kgid_t pid_gid;
+ 	int hide_pid;
+ };
+=20
  extern struct proc_dir_entry proc_root;
 -extern int proc_parse_options(char *options, struct proc_mount_options *o=
pts);
 =20
  extern void proc_self_init(void);
 -extern int proc_remount(struct super_block *, int *, char *);
 +extern int proc_reconfigure(struct super_block *, struct fs_context *);
 =20
  /*
   * task_[no]mmu.c

--Sig_/nqzNhFJcXFpmRS21zpIK=ea
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlspsYkACgkQAVBC80lX
0Gx24wf/YNUJzc1Pll442jxlvQsbnadnfTbmTRBLq9XH1lgdBLL5mmnGKDpXS4V+
0uFSMbvm9y6vNWeOEiAGR2y02CRTDqc9QgMhdaECkq+zN8Z6C+7M9PdhzX5ifAa0
pZf5+0b6B23rM8rMS+hQb3cEkaml2OfGHW70Sn5juTdKWRKoMww9Bd+DzF/LzfG8
OUdSk/wgp988BIhl9+XMdPUS4AKor/pPk9HJxgGrhnZcUyjc2p5HyHInLd407eA+
MLIqIkuDfJYl7fNCH6Q17Tn+X1pUdfT7yyTyWb3t6vFyAaep8GntG5eZLRktxEsT
CNW0KZJXhlvJQpbtFYQjc8xEor2jzw==
=wC3J
-----END PGP SIGNATURE-----

--Sig_/nqzNhFJcXFpmRS21zpIK=ea--
