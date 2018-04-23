Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754449AbeDWJkO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:40:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59339 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754078AbeDWJkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:40:12 -0400
Date: Mon, 23 Apr 2018 11:40:09 +0200
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: dedekind1@gmail.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC
 check when attaching ubi vol
Message-ID: <20180423094009.5cjvg7jxvwiegq2g@qschulz>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
 <6551534f88b3aa77cc377c4270c4ddf7fe92cdf4.1524214122.git-series.quentin.schulz@bootlin.com>
 <20180420191924.18b81e96@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6t2mtra42yh4ylry"
Content-Disposition: inline
In-Reply-To: <20180420191924.18b81e96@bbrezillon>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6t2mtra42yh4ylry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Boris,

On Fri, Apr 20, 2018 at 07:19:24PM +0200, Boris Brezillon wrote:
> On Fri, 20 Apr 2018 10:52:41 +0200
> Quentin Schulz <quentin.schulz@bootlin.com> wrote:
>=20
> > There's already ECC on NAND pages so there may be no need for one to
> > check the CRC of a UBI volume.
>=20
> That's true that ECC can help detecting corruptions, but I don't think
> this is the actual reason for disabling CRC check at volume open time.
> The actual reason for doing that is when the UBI volume user (in our
> case the squashfs FS) is also checking data consistency on its own
> (which is the case for squashfs).
>=20
> >=20
> > Let's introduce a ubi.nocheck parameter that let one skip the CRC check
> > when attaching a UBI volume.
> >=20
> > This also drastically speeds kernel boot by removing a potentially
> > useless check, e.g. I gained 3.2s on boot time of a SPEAr600-based board
> > for a ~20MB UBI volume used as rootfs.
>=20
> Can you give the old and new open/mount time instead of telling how
> much you gained on the whole boot-time?

# grabserial -v -d /dev/ttyUSB0 -t "Starting kernel"

Kernel command line is:
rootfstype=3Dsquashfs root=3D/dev/ubiblock0_0 ubi.mtd=3Dubi ubi.block=3D0,r=
ootfs mtdparts=3Dnand:92M@36M(ubi)

Current behaviour (CRC checking):
[2.335558 0.017867] ubi0: attaching mtd7
[2.504021 0.168463] ubi0: scanning is finished
[2.519824 0.015803] ubi0: attached mtd7 (name "ubi", size 92 MiB)
[2.523987 0.004163] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 12902=
4 bytes
[2.530447 0.006460] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page siz=
e 512
[2.535836 0.005389] ubi0: VID header offset: 512 (aligned 512), data offset=
: 2048
[2.541601 0.005765] ubi0: good PEBs: 736, bad PEBs: 0, corrupted PEBs: 0
[2.547923 0.006322] ubi0: user volume: 3, internal volumes: 1, max. volumes=
 count: 128
[2.554223 0.006300] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, =
image sequence number: 463835917
[2.562460 0.008237] ubi0: available PEBs: 0, total reserved PEBs: 736, PEBs=
 reserved for bad PEB handling: 20
[2.569779 0.007319] ubi0: background thread "ubi_bgt0d" started, PID 546
[4.550142 1.980363] block ubiblock0_0: created from ubi0:0(rootfs)

Skipping CRC check (ubi.nocheck=3D0,rootfs):
[2.349903 0.019126] ubi0: attaching mtd7
[2.516995 0.167092] ubi0: scanning is finished
[2.527101 0.010106] ubi0: skipping CRC check for volume rootfs
[2.536719 0.009618] ubi0: attached mtd7 (name "ubi", size 92 MiB)
[2.541859 0.005140] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 12902=
4 bytes
[2.547744 0.005885] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page siz=
e 512
[2.552990 0.005246] ubi0: VID header offset: 512 (aligned 512), data offset=
: 2048
[2.560497 0.007507] ubi0: good PEBs: 736, bad PEBs: 0, corrupted PEBs: 0
[2.568010 0.007513] ubi0: user volume: 3, internal volumes: 1, max. volumes=
 count: 128
[2.574723 0.006713] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, =
image sequence number: 463835917
[2.586223 0.011500] ubi0: available PEBs: 0, total reserved PEBs: 736, PEBs=
 reserved for bad PEB handling: 20
[2.592365 0.006142] ubi0: background thread "ubi_bgt0d" started, PID 545
[2.595960 0.003595] block ubiblock0_0: created from ubi0:0(rootfs)

It seems like it's more in the magnitude of 2s rather than 3, but still.

This is retrieved from the boot log.

Thanks,
Quentin

--6t2mtra42yh4ylry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa3anxAAoJEIS4mnU+4PGjU04QAJsGAk//w18sZRftPU4WqW/u
SPYBFfU+W975QRkyxNSdpU0yferh4b+0EAUedAeYfiCLiWYb/kfqVz3+cuJcfulk
0PtCDxrY+POGvwJyxMvKhFVNavGym7OTy7CAnCYcdmABpr8yvrgrKKwoKPD56iQE
QNUneSv6aDq8IRJw0ObG+AXoDfRCM+Yf4P0EwcNjCZK8EqANHzjbM8HJBiyMfOZE
tJWU+nCoVpnQ/B27lcgewaa7TDl0EiSb0X5ku1ARzLlezcOXdsBRWV/ANKd2p2d8
fbBcmQE3l5uL6GMVXdtIgyQkwUcQRzSNdwwdhUiI9rXykTAZryedwttK4kmEAcYT
YKZahwCZ5KqzeOKMbu+6Sn/6NbMfuiUdnnOYONHa9K6Wh4F2a0sF2YvyuGKJV29Q
wDXQ68v98RJBEW/LZLh16NsZiI65PiliF29mk4lE4YnG2BMjpwIwcrH1HjJGJeDL
4kZtn4eMMwffIh2BuGXBo+RbC/vVJCVvY9FkhCsphBjc2EbO+sDTVT6nkxw4YITT
Copcp9DCIOP18oI1RqwtopyeHTKkO5H2WLMItErMQ9gSFOMVrPJYczvdeHQ2YCNn
HfX6rfDh7wKHWqJ48qu0fcoz3NbrlI072tGoqsk6Zdx35iy/e3eOT19YaUWk4DLw
1WywAM50gs6LhGzE4Nd2
=Nqjv
-----END PGP SIGNATURE-----

--6t2mtra42yh4ylry--
