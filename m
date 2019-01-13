Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D930C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4425620850
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bxK1jfhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfAMX2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:28:03 -0500
Received: from ozlabs.org ([203.11.71.1]:46383 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfAMX2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:28:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dCSw0zhZz9s3q;
        Mon, 14 Jan 2019 10:27:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547422080;
        bh=6C6iQQPcmqzyvdBkomHSE09hYUY0nhOCNUVgk4MGlrk=;
        h=Date:From:To:Cc:Subject:From;
        b=bxK1jfhFGrc/A++UBbUC7biw16Wf2pkWUy3c6ouYF11ZVEO2KpyLX+R1Sbq3onCKd
         +orQaThZOzVJOF6Gjr5LY4flmu51lzAEnLXIzGv4Mv0LcwtJ+124n+0Ym1blTxtnZJ
         naYhFkDNncwIhcGwMqVVya8OJGeIknFkhHBiH6qNoNVUVhOvJRXvMfxDo2aHSirQgJ
         Dn9WROwTkQJDEEZ4a8b1okICUrwtTV3luqH54O+RBDczXBN9mu592j1KHr52dSiyHs
         e/6d60EGRQsKPFgpqlzJvZ6RRKzilHQuKgKmV7g9JuyNPUpROzHOUe8rdUoJYJ3gV2
         c//jrxwhSuvEw==
Date:   Mon, 14 Jan 2019 10:27:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with the vfs-fixes tree
Message-ID: <20190114102753.1bf83b5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/77eBvyHVTzbBN4F7m=pcuRj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/77eBvyHVTzbBN4F7m=pcuRj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  kernel/cgroup/cgroup-internal.h

between commit:

  61aa329d0762 ("cgroup: saner refcounting for cgroup_root")

from the vfs-fixes tree and commit:

  b3678086951a ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")

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

diff --cc kernel/cgroup/cgroup-internal.h
index c9a35f09e4b9,ff86943ea1c8..000000000000
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@@ -197,12 -213,10 +215,10 @@@ int cgroup_path_ns_locked(struct cgrou
  			  struct cgroup_namespace *ns);
 =20
  void cgroup_free_root(struct cgroup_root *root);
- void init_cgroup_root(struct cgroup_root *root, struct cgroup_sb_opts *op=
ts);
+ void init_cgroup_root(struct cgroup_fs_context *ctx);
 -int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flag=
s);
 +int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
  int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask);
- struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flag=
s,
- 			       struct cgroup_root *root, unsigned long magic,
- 			       struct cgroup_namespace *ns);
+ int cgroup_do_get_tree(struct fs_context *fc);
 =20
  int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp);
  void cgroup_migrate_finish(struct cgroup_mgctx *mgctx);

--Sig_/77eBvyHVTzbBN4F7m=pcuRj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw7yXkACgkQAVBC80lX
0Gy/ywf+IqeuMx52pBL5lYTdZw8OG776f5pjOQZNpKAS6DcpNYRmiKlZLGWe/N19
x5uN4NDkPFaj+yxJdc+JSJOimfsaPQuaAHcr7hSKb+V4WDI7bXMigYjimj80q8X/
OU1naSyP0HPhm5VQ/eV3IiKGsGSpzfZWgUJdEO8lK2Eoaxid431ejA57Y5myA+Ut
AYv5SPZBGSNDi1ltWnmlM/PjTaCVQmimrxw3gZbY876rzkIlwcDwTzmVE9iCDM9B
oAhO0+HrEUwAtPdWkXfdc5yCQ0yASPPvTUzeTz2JEEV+4j7Ja5MVfwqh3PwP3vLq
Pmx0V90NLId23W/YL7JQ31tHGvBDlg==
=CPO8
-----END PGP SIGNATURE-----

--Sig_/77eBvyHVTzbBN4F7m=pcuRj--
