Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeDCCav (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:30:51 -0400
Received: from ozlabs.org ([103.22.144.67]:59367 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbeDCCau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:30:50 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 12:29:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Casey Leedom <leedom@chelsio.com>,
        Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: linux-next: manual merge of the pci tree with Linus' tree
Message-ID: <20180403122955.1822dbc5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ry7YLf==porYJlWAXwk89wS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ry7YLf==porYJlWAXwk89wS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Today's linux-next merge of the pci tree got a conflict in:

  drivers/pci/quirks.c

between commit:

  7dcf688d4c78 ("PCI/cxgb4: Extend T3 PCI quirk to T4+ devices")

from Linus' tree and commit:

  996058573b22 ("PCI/VPD: Move VPD quirks to vpd.c")

from the pci tree.

I fixed it up (I removed the section from this file and added the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 3 Apr 2018 12:17:20 +1000
Subject: [PATCH] PCI/cxgb4: merge fix up for move of quirk_chelsio_extend_v=
pd()

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pci/vpd.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 00b8b5d37056..8617565ba561 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -617,19 +617,28 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
=20
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
-	pci_set_vpd_size(dev, 8192);
+	int chip =3D (dev->device & 0xf000) >> 12;
+	int func =3D (dev->device & 0x0f00) >>  8;
+	int prod =3D (dev->device & 0x00ff) >>  0;
+
+	/*
+	 * If this is a T3-based adapter, there's a 1KB VPD area at offset
+	 * 0xc00 which contains the preferred VPD values.  If this is a T4 or
+	 * later based adapter, the special VPD is at offset 0x400 for the
+	 * Physical Functions (the SR-IOV Virtual Functions have no VPD
+	 * Capabilities).  The PCI VPD Access core routines will normally
+	 * compute the size of the VPD by parsing the VPD Data Structure at
+	 * offset 0x000.  This will result in silent failures when attempting
+	 * to accesses these other VPD areas which are beyond those computed
+	 * limits.
+	 */
+	if (chip =3D=3D 0x0 && prod >=3D 0x20)
+		pci_set_vpd_size(dev, 8192);
+	else if (chip >=3D 0x4 && func < 0x8)
+		pci_set_vpd_size(dev, 2048);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x20, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x21, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x22, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x23, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x24, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x25, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x26, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x30, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x31, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x32, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x35, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x36, quirk_chelsio_extend_=
vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x37, quirk_chelsio_extend_=
vpd);
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
+			quirk_chelsio_extend_vpd);
+
 #endif
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Ry7YLf==porYJlWAXwk89wS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrC5yMACgkQAVBC80lX
0Gwb4ggAkUIY+UJoWYmSZ65t/NsCX/vsiYx+wArSDvPnNr0FVqc3/dXIl2+oS1N9
MPBLlXRTpD1Y8isOm4dI9HD/TFGsbqM50UOAVSS+E4lD7YU4gck0/qHbrmJUXU+x
m6gBBUgbZ+uEZmm8aArwtY1jF3hKKf0LdX/J1w2JRpJuj8u3bvzqx0Cc3PQTLnug
suYPQz031fA5gh86qCNSKA0yjZ2ipo04Ii8OVRSthJ2WQjjAcL3Jwv7+SXIhbtMa
saUexz6LBY4q+LM5XsPcb8Ac3O4P1FhQOtJHmp00v15jpUOTsrQLUgCQ0+kYs8kh
Af2EKLMX4MsiKiFcqpiIHx8XIsZ3Gw==
=ar49
-----END PGP SIGNATURE-----

--Sig_/Ry7YLf==porYJlWAXwk89wS--
