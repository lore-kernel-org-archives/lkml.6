Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED761C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B896B2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ACbssjWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfBGEov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:44:51 -0500
Received: from ozlabs.org ([203.11.71.1]:52617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfBGEou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:44:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w5MM3LPFz9s9G;
        Thu,  7 Feb 2019 15:44:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549514687;
        bh=D9Bjn2mwK+ZMsO25baKD6qvhC/cOsmYdAD+Pj5qAwb8=;
        h=Date:From:To:Cc:Subject:From;
        b=ACbssjWwaaayxpTD+Nok/DH6RZwKUyKp94Rx8Fq/HIRwWUCeBkRLrrcxOIrYWPuL6
         GCikpvXjoFOIiE8ms7tMTOnVWoTwQ4+2YHUOZ9qrIChoNdi/CSBwAbGnDQx2dnGTQ5
         jl7Qo/jql11YM33NaFq2FdXYJY2vEUIFWohLl+/oklh+hwgqXOyJIpIteOrxeVuilj
         b5Q2WDbI3J0jA0F8zkFksd7+I+dZIx7i/V/O2ztGwS+E89C1UNN89FStqsm+bXArSt
         Wkt/DoYuidhOxHB9HWJsiUZJi3uPk1MstI7vAO6PPYC0ZYyoYYHyHL8OmFkuj8D2kx
         EG0QBbYc94JEQ==
Date:   Thu, 7 Feb 2019 15:44:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        James Smart <jsmart2021@gmail.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20190207154446.3f48c496@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ue6pta1EE95HH1kFzSVzLSz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ue6pta1EE95HH1kFzSVzLSz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/lpfc/lpfc_nvme.c

between commit:

  7961cba6f7d8 ("scsi: lpfc: nvme: avoid hang / use-after-free when destroy=
ing localport")

from Linus' tree and commit:

  4c47efc140fa ("scsi: lpfc: Move SCSI and NVME Stats to hardware queue str=
uctures")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/scsi/lpfc/lpfc_nvme.c
index c84621a80ee5,e73895674f39..000000000000
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@@ -2592,16 -2178,14 +2180,14 @@@ lpfc_nvme_destroy_localport(struct lpfc
  #if (IS_ENABLED(CONFIG_NVME_FC))
  	struct nvme_fc_local_port *localport;
  	struct lpfc_nvme_lport *lport;
- 	struct lpfc_nvme_ctrl_stat *cstat;
  	int ret;
 +	DECLARE_COMPLETION_ONSTACK(lport_unreg_cmp);
 =20
  	if (vport->nvmei_support =3D=3D 0)
  		return;
 =20
  	localport =3D vport->localport;
 -	vport->localport =3D NULL;
  	lport =3D (struct lpfc_nvme_lport *)localport->private;
- 	cstat =3D lport->cstat;
 =20
  	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
  			 "6011 Destroying NVME localport %p\n",
@@@ -2616,9 -2200,7 +2202,8 @@@
  	/* Wait for completion.  This either blocks
  	 * indefinitely or succeeds
  	 */
 -	lpfc_nvme_lport_unreg_wait(vport, lport);
 +	lpfc_nvme_lport_unreg_wait(vport, lport, &lport_unreg_cmp);
 +	vport->localport =3D NULL;
- 	kfree(cstat);
 =20
  	/* Regardless of the unregister upcall response, clear
  	 * nvmei_support.  All rports are unregistered and the

--Sig_/ue6pta1EE95HH1kFzSVzLSz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbt74ACgkQAVBC80lX
0GxtbQf/ZJILLO3jB/mjCIb5iXksgOlv7kZDUHbXMI8ObU6+XFNoYEcY4aQ/vixa
UapXCyfeJWh7hJpKh8qCow42WT+RbU/owF4j6QFW14QJUR/jZrxhMstLe5u2BOzk
9RwmiZbWb4e2JTfN+A5VVa0YbCyH8zQqOoUDJNNXTkYVyOYBsVOSf+4otrinqgb0
mtIjfM003h3AVLmzSLu2BALqNyABEgB7Atco8Jy+Bl/VFxcR8V4yeX2EJ4DjbgXt
ma6dP7hpoPkmToK9AKylVd8jNiKspY7kkPKaYZf4IdxpyvQmc+9SBVXP4HvcazM5
Ul/rw4FEjkhTdM5l66FU/fV5JXIp6w==
=tK8/
-----END PGP SIGNATURE-----

--Sig_/ue6pta1EE95HH1kFzSVzLSz--
