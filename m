Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeCMAFU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:05:20 -0400
Received: from ozlabs.org ([103.22.144.67]:33489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbeCMAFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:05:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 11:04:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brad Mouring <brad.mouring@ni.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180313110451.384886eb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Fm/Z6NMU1vj.usZZALOpR5k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fm/Z6NMU1vj.usZZALOpR5k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/phy/phy.c

between commit:

  a2c054a896b8 ("net: phy: Tell caller result of phy_change()")

from the net tree and commit:

  4fff2d33c707 ("net: phy: remove phy_error from phy_disable_interrupts")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/phy/phy.c
index 9aabfa1a455a,c2d9027be863..000000000000
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@@ -617,77 -617,6 +617,68 @@@ static void phy_error(struct phy_devic
  	phy_trigger_machine(phydev, false);
  }
 =20
 +/**
 + * phy_disable_interrupts - Disable the PHY interrupts from the PHY side
 + * @phydev: target phy_device struct
 + */
 +static int phy_disable_interrupts(struct phy_device *phydev)
 +{
 +	int err;
 +
 +	/* Disable PHY interrupts */
 +	err =3D phy_config_interrupt(phydev, PHY_INTERRUPT_DISABLED);
 +	if (err)
- 		goto phy_err;
++		return err;
 +
 +	/* Clear the interrupt */
- 	err =3D phy_clear_interrupt(phydev);
- 	if (err)
- 		goto phy_err;
-=20
- 	return 0;
-=20
- phy_err:
- 	phy_error(phydev);
-=20
- 	return err;
++	return phy_clear_interrupt(phydev);
 +}
 +
 +/**
 + * phy_change - Called by the phy_interrupt to handle PHY changes
 + * @phydev: phy_device struct that interrupted
 + */
 +static irqreturn_t phy_change(struct phy_device *phydev)
 +{
 +	if (phy_interrupt_is_valid(phydev)) {
 +		if (phydev->drv->did_interrupt &&
 +		    !phydev->drv->did_interrupt(phydev))
 +			return IRQ_NONE;
 +
 +		if (phydev->state =3D=3D PHY_HALTED)
 +			if (phy_disable_interrupts(phydev))
 +				goto phy_err;
 +	}
 +
 +	mutex_lock(&phydev->lock);
 +	if ((PHY_RUNNING =3D=3D phydev->state) || (PHY_NOLINK =3D=3D phydev->sta=
te))
 +		phydev->state =3D PHY_CHANGELINK;
 +	mutex_unlock(&phydev->lock);
 +
 +	/* reschedule state queue work to run as soon as possible */
 +	phy_trigger_machine(phydev, true);
 +
 +	if (phy_interrupt_is_valid(phydev) && phy_clear_interrupt(phydev))
 +		goto phy_err;
 +	return IRQ_HANDLED;
 +
 +phy_err:
 +	phy_error(phydev);
 +	return IRQ_NONE;
 +}
 +
 +/**
 + * phy_change_work - Scheduled by the phy_mac_interrupt to handle PHY cha=
nges
 + * @work: work_struct that describes the work to be done
 + */
 +void phy_change_work(struct work_struct *work)
 +{
 +	struct phy_device *phydev =3D
 +		container_of(work, struct phy_device, phy_queue);
 +
 +	phy_change(phydev);
 +}
 +
  /**
   * phy_interrupt - PHY interrupt handler
   * @irq: interrupt line

--Sig_/Fm/Z6NMU1vj.usZZALOpR5k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqnFaMACgkQAVBC80lX
0Gyywwf/WyvZVTF9G3nBjHuszibU4akTAi9hAsnEvCtBTKXx7W0gGC0Bnk24Vy7L
Wl3iTM2JUGtRDTNgLDfX5GatNti+1u3k4fBIva51lYfQzQysQcuIqo22ojiidsth
0xk1QOwxXjOBZhXUCoh7dl61DFvZsgolbpeo4qMpOvMAuKvRuZNeIlTkC3MK8WR2
vEsvJoB8cGoejfjuli2A/BO5IAQRqyxlR/xTUzAa9ZzMtKldUH8szvJpeCE1Khbs
qbXkI45klWJ/fzAgrwtbimJ6ep/nsgl8IVxzGrpkvEY6iRlunwN5eMCuZBKLwkuc
6JOTPrpBQJcFWpKYuTQhk+0IGKKn3w==
=nSOI
-----END PGP SIGNATURE-----

--Sig_/Fm/Z6NMU1vj.usZZALOpR5k--
