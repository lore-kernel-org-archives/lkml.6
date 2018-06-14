Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1FC4CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF812208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF812208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964795AbeFNBEr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:04:47 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44063 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935907AbeFNBEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:04:45 -0400
X-Greylist: delayed 86791 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 21:04:45 EDT
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D826F240003;
        Thu, 14 Jun 2018 01:04:44 +0000 (UTC)
Date:   Wed, 13 Jun 2018 21:04:38 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernelnewbies@kernelnewbies.org
Subject: [PATCH v4] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <20180614010438.GB1974@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the PI433_IOC_WR_TX_CFG case in pi433_ioctl, instance->tx_cfg is
modified via

copy_from_user(&instance->tx_cfg, argp, sizeof(struct pi433_tx_cfg)))

without any kind of synchronization. In the case where two threads
would execute this same command concurrently the tx_cfg field might
enter in an inconsistent state.

Additionally: if ioctl(PI433_IOC_WR_TX_CFG) and write() execute
concurrently the tx config might be modified while it is being
copied to the fifo, resulting in potential data corruption.

Fix: Get instance->tx_cfg_lock before modifying tx config in the
PI433_IOC_WR_TX_CFG case in pi433_ioctl.

Also, do not copy data directly from user space to instance->tx_cfg.
Instead use a temporary buffer allowing future checks for correctness
of copied data and simpler code.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v4:
    - Fix incorrect buffer name in memcpy.
---
 drivers/staging/pi433/pi433_if.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433=
_if.c
index b061f77dda41..94e0bfcec991 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -880,6 +880,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsign=
ed long arg)
 	int			retval =3D 0;
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
+	struct pi433_tx_cfg	tx_cfg;
 	void __user *argp =3D (void __user *)arg;
=20
 	/* Check type and command number */
@@ -902,9 +903,11 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsig=
ned long arg)
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_TX_CFG:
-		if (copy_from_user(&instance->tx_cfg, argp,
-				   sizeof(struct pi433_tx_cfg)))
+		if (copy_from_user(&tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
 			return -EFAULT;
+		mutex_lock(&device->tx_fifo_lock);
+		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
+		mutex_unlock(&device->tx_fifo_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
--=20
2.17.1

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlshvyAACgkQLVy48vb3
khn+qQf7BEMeWwZ5N10oascSjuRCuzDKWVMMOMq2nbQcOPPstaZXYC3oU/Ya1/0o
QuwXPSFVLLqeX0u5NmgTnCpeHBI7ANNywxogoB7MnAIw6mbUE8aePNRc7vhvLgyH
AC3D0pLNIqmLFHjav68PVER5i4IPHWeWBTuKiWbYMQ1JI6dE0YKjfFavk2uG2/zu
JRi427DtK/XtgqCTapcBx5YHsIazlmztFIRuO2P8J/0Z+LuRcaEsQjBZmWNTDu9f
MdlDxkrNL5lZJLmWpiX4QewgGLZQ+KER+0zTFlhcbjMp4+nkcUsTBAxtimI3IGp3
gckReFpEmWXT3tkT09JBJyymqIutnA==
=hkYt
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
