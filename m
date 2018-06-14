Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4BB5CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C02208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C02208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936028AbeFNAyW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 20:54:22 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52481 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935720AbeFNAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 20:54:21 -0400
X-Greylist: delayed 87432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 20:54:21 EDT
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8BE61200005;
        Thu, 14 Jun 2018 00:54:16 +0000 (UTC)
Date:   Wed, 13 Jun 2018 20:54:14 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernelnewbies@kernelnewbies.org
Subject: [PATCH v3] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <20180614005414.GA1974@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
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
Changes in v3:
    - Use tx_cfg for the name of temporary buffer (shorter, allows
      copy_from_user call to fit in a single line).
    - Move mutex_{un,}lock calls around memcpy instead of before
      copy_from_user call (was useless since we use a temporary buffer).
    - Remove useless comment before mutex_lock.
---
 drivers/staging/pi433/pi433_if.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433=
_if.c
index b061f77dda41..53a69cb37056 100644
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
+		memcpy(&instance->tx_cfg, &tx_cfg_buffer, sizeof(struct pi433_tx_cfg));
+		mutex_unlock(&device->tx_fifo_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
--=20
2.17.1

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlshvK8ACgkQLVy48vb3
khkZoAgAh+H61tOMRDVAJOAlW/o7AAAxBVQLbrMgeAbz7HrD8sy21reotmrVAAXc
EKAObE+KXh3yhbNPNqmGtrwEdtBqnW+FXPwNy6FYb6pcZKvmG80c0c9GMZKNmQj8
QNytyFD4Xv/VvbAoPu7BofgD/aV6WEzyL2HqSxURJKLJF5JVqr0YikM5YTlcKAyi
bbAWLZPd9rc77yCBJ63b5jXKyAV2kSvmwR/XOL61IaMpoKm5vQsgEB8LizuR0wB2
YzdEHWOe2azoecb4Q9hDjED+W7vwgKtxlzRAaw5d4Rz/GyhmK0uVhxMvmaJLfoVY
S604tMGSKml1d3Ki1/72W6bI7o9rxw==
=zIjn
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
