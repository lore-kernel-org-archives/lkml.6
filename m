Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeCVGZs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 02:25:48 -0400
Received: from ozlabs.org ([103.22.144.67]:50587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbeCVGZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 02:25:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 17:25:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Trapp <darren.trapp@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>
Subject: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20180322172503.2d8e72ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.sejq5UpwT/Hp8Gk=6rRAqc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.sejq5UpwT/Hp8Gk=6rRAqc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

After merging the scsi-mkp tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/scsi/qla2xxx/qla_gs.c: In function 'qla24xx_async_gnnft_done':
drivers/scsi/qla2xxx/qla_gs.c:3974:7: error: 'fc4type' undeclared (first us=
e in this function); did you mean 'fc4type_t'?
  if ((fc4type =3D=3D FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
       ^~~~~~~
       fc4type_t
drivers/scsi/qla2xxx/qla_gs.c:3974:7: note: each undeclared identifier is r=
eported only once for each function it appears in
drivers/scsi/qla2xxx/qla_gs.c:3975:3: error: too few arguments to function =
'qla24xx_async_gpnft'
   qla24xx_async_gpnft(vha, FC4_TYPE_NVME);
   ^~~~~~~~~~~~~~~~~~~
In file included from drivers/scsi/qla2xxx/qla_def.h:4633:0,
                 from drivers/scsi/qla2xxx/qla_gs.c:7:
drivers/scsi/qla2xxx/qla_gbl.h:661:5: note: declared here
 int qla24xx_async_gpnft(scsi_qla_host_t *, u8, srb_t *);
     ^~~~~~~~~~~~~~~~~~~

Caused by commit

  33b28357dd00 ("scsi: qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan")

interacting with commit

  2b5b96473efc ("scsi: qla2xxx: Fix FC-NVMe LUN discovery")

from Linus' tree.

I have added the following merge fix patch for today. Unfortunately it
produces this warning, so a better merge resolution is needed ...

drivers/scsi/qla2xxx/qla_gs.c: In function 'qla24xx_async_gnnft_done':
drivers/scsi/qla2xxx/qla_gs.c:3974:9: warning: 'rp' may be used uninitializ=
ed in this function [-Wmaybe-uninitialized]
  if ((rp->fc4type =3D=3D FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
       ~~^~~~~~~~~


From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 22 Mar 2018 17:09:38 +1100
Subject: [PATCH] scsi: qla2xxx: merge fix in qla_gs.c

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/scsi/qla2xxx/qla_gs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index f84807e850c3..d33f4619332e 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3971,8 +3971,8 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, s=
rb_t *sp)
 	vha->scan.scan_flags &=3D ~SF_SCANNING;
 	spin_unlock_irqrestore(&vha->work_lock, flags);
=20
-	if ((fc4type =3D=3D FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
-		qla24xx_async_gpnft(vha, FC4_TYPE_NVME);
+	if ((rp->fc4type =3D=3D FC4_TYPE_FCP_SCSI) && vha->flags.nvme_enabled)
+		qla24xx_async_gpnft(vha, FC4_TYPE_NVME, NULL);
 }
=20
 static void qla2x00_find_free_fcp_nvme_slot(struct scsi_qla_host *vha,
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/.sejq5UpwT/Hp8Gk=6rRAqc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqzTD8ACgkQAVBC80lX
0GzcQAf9HN781CPZrW7AHoK7heULX0fNP0I6CzAQqTwz2g0Cwse3uoSv1SOKItGE
PKOZG171mHvbRRs+YfKKr4GeS1L8YFesRnB8MmaK2IhtJVz3cfPFkHCseTlwmNdM
EDBMpy14+nca3TWMLSmqrQOedEFUrAZeXoIZWQO0ni7rbRJ5YgXyTa0wNupsGATF
XPlB+KIU+KgHQgCZcIDRFmiycKTPIYsNcyZuZtjydDfiTn+363KaLk4Y9whWNPiI
gxy2s5lwc5ytaae+4K4TMlI7it6c9X3vam2W8cI6Inc4gB1b9LdiMtsBQRVzy2sK
2PWLYd5h8SfkRGZs/5Z+4ABn0tD0mQ==
=h5Ct
-----END PGP SIGNATURE-----

--Sig_/.sejq5UpwT/Hp8Gk=6rRAqc--
