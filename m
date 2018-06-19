Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D32BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067D320693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067D320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeFSEFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:05:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:36765 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbeFSEFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:05:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5CD6FAC44;
        Tue, 19 Jun 2018 04:05:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Christoph Hellwig <hch@infradead.org>
Date:   Tue, 19 Jun 2018 14:05:23 +1000
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] kbuild: build modules from code in multiple directories.
In-Reply-To: <20180618082017.GA4752@infradead.org>
References: <152929708853.17463.17302660556961083137.stgit@noble> <20180618082017.GA4752@infradead.org>
Message-ID: <87po0ne7zw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18 2018, Christoph Hellwig wrote:

> On Mon, Jun 18, 2018 at 02:55:20PM +1000, NeilBrown wrote:
>> This set of patches makes it possible to build a module from
>> code in multiple directories without needing to list files from one
>> directory in the Makefile of another directory.
>>=20
>> The code was developed for lustre (which is now out-of-tree :-( ) but
>> can be useful elsewhere, such as for xfs and btrfs and others.
>>=20
>> In fs/xfs/Makefile the section:
>>=20
>> xfs-y				+=3D $(addprefix libxfs/, \
>> 				   xfs_ag.o \
>> 				   xfs_alloc.o \
>> 				.....
>>=20
>> could become
>>=20
>> xfs-y +=3D libxfs/
>>=20
>> and then in fs/xfs/libxfs/Makefile we would have
>>=20
>> modobj-$(CONFIG_XFS_FS) +=3D xfs_ag.o \
>> 			   xfs_alloc.o \
>> 			   .....
>>=20
>> A similar process could move filenames for scrub/* from the
>> fs/xfs/Makefile to fs/xfs/scrub/Makefile
>
> How about you actually convert it as an example?

Sure ... found a bug while testing it.  Thanks :-)

From=20ac7953b4ba6d9a2a69dab84dd772aafca38d8377 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.com>
Date: Tue, 19 Jun 2018 13:59:16 +1000
Subject: [PATCH] kbuild/xfs: example modobj-m conversion

This is a demonstration patch to show how
xfs can be changed to make use of the proposed modobj-m=3D
functionality, should the xfs developers want that.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/xfs/Makefile        | 78 ++--------------------------------------------=
----
 fs/xfs/libxfs/Makefile | 43 ++++++++++++++++++++++++++++
 fs/xfs/scrub/Makefile  | 29 +++++++++++++++++++
 3 files changed, 74 insertions(+), 76 deletions(-)
 create mode 100644 fs/xfs/libxfs/Makefile
 create mode 100644 fs/xfs/scrub/Makefile

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 2f3f75a7f180..0ba854045fe9 100644
=2D-- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -15,47 +15,7 @@ obj-$(CONFIG_XFS_FS)		+=3D xfs.o
 xfs-y				+=3D xfs_trace.o
=20
 # build the libxfs code first
=2Dxfs-y				+=3D $(addprefix libxfs/, \
=2D				   xfs_ag.o \
=2D				   xfs_alloc.o \
=2D				   xfs_alloc_btree.o \
=2D				   xfs_attr.o \
=2D				   xfs_attr_leaf.o \
=2D				   xfs_attr_remote.o \
=2D				   xfs_bit.o \
=2D				   xfs_bmap.o \
=2D				   xfs_bmap_btree.o \
=2D				   xfs_btree.o \
=2D				   xfs_da_btree.o \
=2D				   xfs_da_format.o \
=2D				   xfs_defer.o \
=2D				   xfs_dir2.o \
=2D				   xfs_dir2_block.o \
=2D				   xfs_dir2_data.o \
=2D				   xfs_dir2_leaf.o \
=2D				   xfs_dir2_node.o \
=2D				   xfs_dir2_sf.o \
=2D				   xfs_dquot_buf.o \
=2D				   xfs_ialloc.o \
=2D				   xfs_ialloc_btree.o \
=2D				   xfs_iext_tree.o \
=2D				   xfs_inode_fork.o \
=2D				   xfs_inode_buf.o \
=2D				   xfs_log_rlimit.o \
=2D				   xfs_ag_resv.o \
=2D				   xfs_rmap.o \
=2D				   xfs_rmap_btree.o \
=2D				   xfs_refcount.o \
=2D				   xfs_refcount_btree.o \
=2D				   xfs_sb.o \
=2D				   xfs_symlink_remote.o \
=2D				   xfs_trans_resv.o \
=2D				   xfs_types.o \
=2D				   )
=2D# xfs_rtbitmap is shared with libxfs
=2Dxfs-$(CONFIG_XFS_RT)		+=3D $(addprefix libxfs/, \
=2D				   xfs_rtbitmap.o \
=2D				   )
+xfs-y				+=3D libxfs/
=20
 # highlevel code
 xfs-y				+=3D xfs_aops.o \
@@ -127,38 +87,4 @@ xfs-$(CONFIG_SYSCTL)		+=3D xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+=3D xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+=3D xfs_pnfs.o
=20
=2D# online scrub/repair
=2Difeq ($(CONFIG_XFS_ONLINE_SCRUB),y)
=2D
=2D# Tracepoints like to blow up, so build that before everything else
=2D
=2Dxfs-y				+=3D $(addprefix scrub/, \
=2D				   trace.o \
=2D				   agheader.o \
=2D				   alloc.o \
=2D				   attr.o \
=2D				   bmap.o \
=2D				   btree.o \
=2D				   common.o \
=2D				   dabtree.o \
=2D				   dir.o \
=2D				   ialloc.o \
=2D				   inode.o \
=2D				   parent.o \
=2D				   refcount.o \
=2D				   rmap.o \
=2D				   scrub.o \
=2D				   symlink.o \
=2D				   )
=2D
=2Dxfs-$(CONFIG_XFS_RT)		+=3D scrub/rtbitmap.o
=2Dxfs-$(CONFIG_XFS_QUOTA)		+=3D scrub/quota.o
=2D
=2D# online repair
=2Difeq ($(CONFIG_XFS_ONLINE_REPAIR),y)
=2Dxfs-y				+=3D $(addprefix scrub/, \
=2D				   agheader_repair.o \
=2D				   repair.o \
=2D				   )
=2Dendif
=2Dendif
+xfs-$(CONFIG_XFS_ONLINE_SCRUB)	+=3D scrub/
diff --git a/fs/xfs/libxfs/Makefile b/fs/xfs/libxfs/Makefile
new file mode 100644
index 000000000000..9b90c289bdda
=2D-- /dev/null
+++ b/fs/xfs/libxfs/Makefile
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-y +=3D -I$(src)/..
+
+# xfs_rtbitmap is shared with libxfs
+xobj-$(CONFIG_XFS_RT)		+=3D xfs_rtbitmap.o
+
+modobj-$(CONFIG_XFS_FS) +=3D	   xfs_ag.o \
+				   xfs_alloc.o \
+				   xfs_alloc_btree.o \
+				   xfs_attr.o \
+				   xfs_attr_leaf.o \
+				   xfs_attr_remote.o \
+				   xfs_bit.o \
+				   xfs_bmap.o \
+				   xfs_bmap_btree.o \
+				   xfs_btree.o \
+				   xfs_da_btree.o \
+				   xfs_da_format.o \
+				   xfs_defer.o \
+				   xfs_dir2.o \
+				   xfs_dir2_block.o \
+				   xfs_dir2_data.o \
+				   xfs_dir2_leaf.o \
+				   xfs_dir2_node.o \
+				   xfs_dir2_sf.o \
+				   xfs_dquot_buf.o \
+				   xfs_ialloc.o \
+				   xfs_ialloc_btree.o \
+				   xfs_iext_tree.o \
+				   xfs_inode_fork.o \
+				   xfs_inode_buf.o \
+				   xfs_log_rlimit.o \
+				   xfs_ag_resv.o \
+				   xfs_rmap.o \
+				   xfs_rmap_btree.o \
+				   xfs_refcount.o \
+				   xfs_refcount_btree.o \
+				   xfs_sb.o \
+				   xfs_symlink_remote.o \
+				   xfs_trans_resv.o \
+				   xfs_types.o \
+				   $(xobj-y)
diff --git a/fs/xfs/scrub/Makefile b/fs/xfs/scrub/Makefile
new file mode 100644
index 000000000000..f91818a0e6ee
=2D-- /dev/null
+++ b/fs/xfs/scrub/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Tracepoints like to blow up, so build that before everything else
+
+ccflags-y +=3D -I$(src)/..
+ccflags-y +=3D -I$(src)/../libxfs
+
+xobj-$(CONFIG_XFS_RT)		+=3D rtbitmap.o
+xobj-$(CONFIG_XFS_QUOTA)	+=3D quota.o
+xobj-$(CONFIG_XFS_ONLINE_REPAIR)+=3D agheader_repair.o \
+				   repair.o
+
+modobj-$(CONFIG_XFS_FS) +=3D	   trace.o \
+				   agheader.o \
+				   alloc.o \
+				   attr.o \
+				   bmap.o \
+				   btree.o \
+				   common.o \
+				   dabtree.o \
+				   dir.o \
+				   ialloc.o \
+				   inode.o \
+				   parent.o \
+				   refcount.o \
+				   rmap.o \
+				   scrub.o \
+				   symlink.o \
+				   $(xobj-y)
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsogQMACgkQOeye3VZi
gblolxAApgmgcWZP7IJUrVc13ywt1AtxzavWKvjGnj5ghn/tj4iIrxjvk9XBR/+B
m0gK1X1rJL0eNLU2biuYg6SD2uOhJIWXZcgPgujUoSblow/80ifF0qQ3MGZUc97I
ql+n1g8p7q7em6mbf7qfEYrHRbwyTURuj8dCNZKO7gyD7LwWa791xgfIWEtFHEKV
cL3OjEY5f6pOE8qMQ9GJx0lyR4gfUzzWNr21P33+Fak/Zne4wTHNyRWwTfaZeIXq
H6d3rAaD/FUsPFWJ83vF3dq4RftLneCP6+eFGnwQ/X/A/4KxjT4VWeg4gOpI4U6r
JvfWpjyylj/V99G7oYNRJWZxLyKDSwDIQEoZOIp0sL184ZgCs9wWJIVm7QpWaq5E
cR926qDtn45xbAfPJJCej8INNFr2d8neV/bDuubgFxQN0vSnhDPuFPIORklvTa6z
XQJlXy2cs8QGzqwElgkee/IhCBwm2NKrN695Lp28/0lgVhTnCmOWVIXMp8kAb+6Z
PbjuPdWbzQMDRLCguhEO59cP5P+qOvXRX5tTSSx2SpXGAw//1h7d+sZASfDy8pNa
/0GdLAjjnQMF5nyOR0kQchXUKQ1EPgCamVBJnPm5baohCQo9PPK2kzqewicD1pqe
hKVQvwEKbPkFeJDebHP/W8hBsZTrYcsPafalZaWZxZXqMSTAFcc=
=wfOQ
-----END PGP SIGNATURE-----
--=-=-=--
