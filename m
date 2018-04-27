Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757443AbeD0GST (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:18:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57907 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757286AbeD0GSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:18:17 -0400
From: NeilBrown <neil@brown.name>
To: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Date: Fri, 27 Apr 2018 16:18:05 +1000
Subject: [PATCH/RFC] mtd: spi-nor: honour max_message_size for spi-nor writes.
cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <87efj1kw9u.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,
 I've labeled this an RFC because I'm really not sure about removing the
 error path from spi_nor_write() -- maybe that really matters.  But on
 my hardware, performing multiple small spi writes to the flash seems
 to work.

 The spi driver is drivers/staging/mt7621-spi.  Possibly this needs to
 use DMA instead of a FIFO (assuming the hardware can) - or maybe
 drivers/spi/spi-mt65xx.c can be made to work on this hardware, though
 that is for an ARM SOC and mt7621 is a MIPS SOC.

 I note that openwrt has similar patches:
  target/linux/generic/pending-4.14/450-mtd-spi-nor-allow-NOR-driver-to-wri=
te-fewer-bytes-th.patch

 They also change the spi driver to do a short write, rather
 than change m25p80 to request a short write.

 Is there something horribly wrong with this?

Thanks,
NeilBrown

=2D----------------------8<------------------------

m25p80 honours max_message_size and max_transfer_size
for reads, but not for writes.
I have a driver that has a max message size of 36 bytes
(command, address, 32 bytes data, all places in a FIFO
in the controller).
This requires m25p80_write() to honour the size limits.
For that to work, spi-nor needs to quietly accept partial
writes.

With this, I can successfully re-flash my device.

Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 drivers/mtd/devices/m25p80.c  | 3 ++-
 drivers/mtd/spi-nor/spi-nor.c | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index a4e18f6aaa33..7ded13507604 100644
=2D-- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -117,7 +117,8 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t=
 to, size_t len,
=20
 	t[data_idx].tx_buf =3D buf;
 	t[data_idx].tx_nbits =3D data_nbits;
=2D	t[data_idx].len =3D len;
+	t[data_idx].len =3D min3(len, spi_max_transfer_size(spi),
+			       spi_max_message_size(spi) - cmd_sz);
 	spi_message_add_tail(&t[data_idx], &m);
=20
 	ret =3D spi_sync(spi, &m);
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 42ae9a1529bb..cfa15f2801ad 100644
=2D-- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1445,13 +1445,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_=
t to, size_t len,
 			goto write_err;
 		*retlen +=3D written;
 		i +=3D written;
=2D		if (written !=3D page_remain) {
=2D			dev_err(nor->dev,
=2D				"While writing %zu bytes written %zd bytes\n",
=2D				page_remain, written);
=2D			ret =3D -EIO;
=2D			goto write_err;
=2D		}
 	}
=20
 write_err:
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlriwJ4ACgkQOeye3VZi
gbmRwBAAwi4AdVg4ovvqDLYTp/CuEgtnrWESRutah65+tJ54Gvn1pRWfmuUC2WuT
DSwHd/l4QtvVGMUvfD/2j5mHjfdLrqfDLWok9Q1mMDH0mg8tYHOshHvpXlB0bj7T
SpQ1RQQoQnLJKg6y5tvvTr5DK/PRKUZaF5Yule7JknSxVeRFsnnuB9AdzbCH1Hzz
7iJH3Tgu4g2YzsaXRRwaI1+rMSGZEGSwsGXX3g6zXY9aSEaipK42t2gfnQ5r8Ysu
HBHOVGY8v2/A+iD5NgOGeZ4LUjznYHQNPlj7+T+zG3fqYKqKYNgw/Lwjl09c1QjW
mBTn7+DD/p/p8gLy/4uB2RLAMbunCAWBFqCL+AnSQ9A7mK5s9N0VjkRcvYYJvygM
WO2qqMQ1i7q9m8fC33gW085Nl12AtcZqctYscqtc+OrBDyrp+GE41PFpnTR5p0Oz
kBbnkYF8flY+zX81W7XwnKkOaeOfvESlagSOTCLs5n75Hrpr1Ve50pUuD3tyPqNU
VyL8BcvkzYBAf7drKVTz+pnlTur52+eWCvGA+IeRE/WJUSh4hSZ3nI/reAsC7Hoh
DowFOpi3+YenTskDsmIp+hzLY1sxbn06lHaDnMz5i40fWX4iRHTikjkNceN+oXzR
TOkZ7T6Pf9mMyiY1rclRzNiEXI0kcHddOpYpFHQUwH+Dbtwmwn0=
=XTh7
-----END PGP SIGNATURE-----
--=-=-=--
