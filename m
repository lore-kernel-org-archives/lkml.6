Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56797C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B6620693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R+QpQqok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B6620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937153AbeFSBrb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:47:31 -0400
Received: from ozlabs.org ([203.11.71.1]:50647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934880AbeFSBr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:47:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418rSH3Gx8z9s2t;
        Tue, 19 Jun 2018 11:47:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529372847;
        bh=kPrl+vY6FK8fLpmxeDwJhG0I8NBTS89hUs6CHJ5E9dI=;
        h=Date:From:To:Cc:Subject:From;
        b=R+QpQqokaQMfLhpVGk24L0B1rZ3UHgQz48N2zLVhfWdS+rEnK+Z/rIFcHAj1iWV9x
         QtsJTj8eq8H8fliw5kXBtLSfyJl1ILxhYBSYhj3lgX+XMiMBLS5gWDZWsYB8/PgReK
         i/Cj8QkBhS+YdCkSLviU3MVCcqYcgmAgK61Tk8+riZSive8jGTyUPVHH4sUvGA5fcr
         FSJAxGpFKVsja4ZBHGCwcaW48A7iXwEqTDyU03Ux8RI6jZxKkg/1WB22K+FdGaUUg4
         JNbssSWt3sca6KWE7Kzz3P0SUORZ9eQHRDb633mss3ZOyX096KpCXp46avXbh2BivE
         dq9QCrSPolwew==
Date:   Tue, 19 Jun 2018 11:47:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180619114726.7086cecd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ix7nnKTXVgbpsz5fTv/M.Ou"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ix7nnKTXVgbpsz5fTv/M.Ou
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/scsi/cxlflash/ocxl_hw.c:62:12: error: initialization from incompati=
ble pointer type [-Werror=3Dincompatible-pointer-types]
  .mount  =3D ocxlflash_fs_mount,
            ^~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/ocxl_hw.c:62:12: note: (near initialization for 'ocxl=
flash_fs_type.mount')

Caused by commit

  6eebfb42b5d6 ("vfs: Require specification of size of mount data for inter=
nal mounts")

interacting with commit

  926a62f9bd53 ("scsi: cxlflash: Support adapter file descriptors for OCXL")

from Linus' tree.

I have applide the following merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 19 Jun 2018 11:42:15 +1000
Subject: [PATCH] scsi: cxlflash: update for fs_type->mount API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_h=
w.c
index 0a95b5f25380..5ad1d5cfb0a8 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -45,12 +45,13 @@ static const struct dentry_operations ocxlflash_fs_dops=
 =3D {
  * @flags:	Flags for the filesystem.
  * @dev_name:	Device name associated with the filesystem.
  * @data:	Data pointer.
+ * @data_size:	Size of the mount data.
  *
  * Return: pointer to the directory entry structure
  */
 static struct dentry *ocxlflash_fs_mount(struct file_system_type *fs_type,
 					 int flags, const char *dev_name,
-					 void *data)
+					 void *data, size_t data_size)
 {
 	return mount_pseudo(fs_type, "ocxlflash:", NULL, &ocxlflash_fs_dops,
 			    OCXLFLASH_FS_MAGIC);
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ix7nnKTXVgbpsz5fTv/M.Ou
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsoYK4ACgkQAVBC80lX
0GyqnAf9GGRtYVVCymk9WXqXNc1OqqeA+f9TkILMeDIlmXZ1nyeMGHQ2P3u4hrdo
8CEScqenE6YnlUNzFVyA++JMysWky0YqsnTVaARq1nGsVaNgJIJmSoOvwtJkxx4d
6QoXMoizXOWnBRvN8RuzcOmbNAIZpNQPLpOgAwjmnqOVXD2FWKmlCrGH3J1mlgWP
cAAe76y7whOJAxImPxDY8OXqy7ObyQO0c+pRiOY8LQUIf0ddvBeCeZ9DU3vOCbyi
QOoi46XrI6RkGgtD3M8b0JdEKfFvVavQRi+q5BuVNZWIlQ3Lva/WewRV5iA1hx+S
7ZIkPI3l4W4xcU/v2OAHY4U4h5nuQw==
=Wfa1
-----END PGP SIGNATURE-----

--Sig_/ix7nnKTXVgbpsz5fTv/M.Ou--
