Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbeBZUwJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:52:09 -0500
Received: from sauhun.de ([88.99.104.3]:38593 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752083AbeBZUwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:52:06 -0500
Date: Mon, 26 Feb 2018 21:52:04 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: piix4: Use request_muxed_region
Message-ID: <20180226205204.p37lf7dcl5k7az37@ninjato>
References: <1519678013-32749-1-git-send-email-linux@roeck-us.net>
 <1519678013-32749-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l2qe2bydcixlr3um"
Content-Disposition: inline
In-Reply-To: <1519678013-32749-2-git-send-email-linux@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2qe2bydcixlr3um
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2018 at 12:46:53PM -0800, Guenter Roeck wrote:
> Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
> One example for another driver is the sp5100_tco driver.
>=20
> Use request_muxed_region() to ensure synchronization.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

To understand better: How does this relate to the series Zoltan
Boszormenyi was proposing (in one sentence)?

> ---
> v2: Dropped now unnecessary include of linux/mutex.h
>     Added error message if request_muxed_region() fails
>     Spell out affected driver in commit message
>=20
> Note that I did not try to do a performance analysis.
> Doing so seemed excessive, even more so in the context of
> piix4_imc_sleep() already using request_muxed_region().=20
>=20
>  drivers/i2c/busses/i2c-piix4.c | 55 +++++++++++++++++++-----------------=
------
>  1 file changed, 25 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix=
4.c
> index 4c1f6aaec0fc..90946a8b9a75 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -40,7 +40,6 @@
>  #include <linux/dmi.h>
>  #include <linux/acpi.h>
>  #include <linux/io.h>
> -#include <linux/mutex.h>
> =20
> =20
>  /* PIIX4 SMBus address offsets */
> @@ -153,10 +152,7 @@ static const struct dmi_system_id piix4_dmi_ibm[] =
=3D {
> =20
>  /*
>   * SB800 globals
> - * piix4_mutex_sb800 protects piix4_port_sel_sb800 and the pair
> - * of I/O ports at SB800_PIIX4_SMB_IDX.
>   */
> -static DEFINE_MUTEX(piix4_mutex_sb800);
>  static u8 piix4_port_sel_sb800;
>  static u8 piix4_port_mask_sb800;
>  static u8 piix4_port_shift_sb800;
> @@ -298,12 +294,19 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_=
dev,
>  	else
>  		smb_en =3D (aux) ? 0x28 : 0x2c;
> =20
> -	mutex_lock(&piix4_mutex_sb800);
> +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb")) {
> +		dev_err(&PIIX4_dev->dev,
> +			"SMB base address index region 0x%x already in use.\n",
> +			SB800_PIIX4_SMB_IDX);
> +		return -EBUSY;
> +	}
> +
>  	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
>  	smba_en_lo =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
>  	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
>  	smba_en_hi =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
> -	mutex_unlock(&piix4_mutex_sb800);
> +
> +	release_region(SB800_PIIX4_SMB_IDX, 2);
> =20
>  	if (!smb_en) {
>  		smb_en_status =3D smba_en_lo & 0x10;
> @@ -373,7 +376,12 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_d=
ev,
>  			break;
>  		}
>  	} else {
> -		mutex_lock(&piix4_mutex_sb800);
> +		if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2,
> +					  "sb800_piix4_smb")) {
> +			release_region(piix4_smba, SMBIOSIZE);
> +			return -EBUSY;
> +		}
> +
>  		outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
>  		port_sel =3D inb_p(SB800_PIIX4_SMB_IDX + 1);
>  		piix4_port_sel_sb800 =3D (port_sel & 0x01) ?
> @@ -381,7 +389,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_de=
v,
>  				       SB800_PIIX4_PORT_IDX;
>  		piix4_port_mask_sb800 =3D SB800_PIIX4_PORT_IDX_MASK;
>  		piix4_port_shift_sb800 =3D SB800_PIIX4_PORT_IDX_SHIFT;
> -		mutex_unlock(&piix4_mutex_sb800);
> +		release_region(SB800_PIIX4_SMB_IDX, 2);
>  	}
> =20
>  	dev_info(&PIIX4_dev->dev,
> @@ -679,7 +687,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *ada=
p, u16 addr,
>  	u8 port;
>  	int retval;
> =20
> -	mutex_lock(&piix4_mutex_sb800);
> +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb"))
> +		return -EBUSY;
> =20
>  	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
>  	smbslvcnt  =3D inb_p(SMBSLVCNT);
> @@ -695,8 +704,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *ada=
p, u16 addr,
>  	} while (--retries);
>  	/* SMBus is still owned by the IMC, we give up */
>  	if (!retries) {
> -		mutex_unlock(&piix4_mutex_sb800);
> -		return -EBUSY;
> +		retval =3D -EBUSY;
> +		goto release;
>  	}
> =20
>  	/*
> @@ -753,8 +762,8 @@ static s32 piix4_access_sb800(struct i2c_adapter *ada=
p, u16 addr,
>  	if ((size =3D=3D I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
>  		piix4_imc_wakeup();
> =20
> -	mutex_unlock(&piix4_mutex_sb800);
> -
> +release:
> +	release_region(SB800_PIIX4_SMB_IDX, 2);
>  	return retval;
>  }
> =20
> @@ -899,13 +908,6 @@ static int piix4_probe(struct pci_dev *dev, const st=
ruct pci_device_id *id)
>  		bool notify_imc =3D false;
>  		is_sb800 =3D true;
> =20
> -		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
> -			dev_err(&dev->dev,
> -			"SMBus base address index region 0x%x already in use!\n",
> -			SB800_PIIX4_SMB_IDX);
> -			return -EBUSY;
> -		}
> -
>  		if (dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
>  		    dev->device =3D=3D PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
>  			u8 imc;
> @@ -922,20 +924,16 @@ static int piix4_probe(struct pci_dev *dev, const s=
truct pci_device_id *id)
> =20
>  		/* base address location etc changed in SB800 */
>  		retval =3D piix4_setup_sb800(dev, id, 0);
> -		if (retval < 0) {
> -			release_region(SB800_PIIX4_SMB_IDX, 2);
> +		if (retval < 0)
>  			return retval;
> -		}
> =20
>  		/*
>  		 * Try to register multiplexed main SMBus adapter,
>  		 * give up if we can't
>  		 */
>  		retval =3D piix4_add_adapters_sb800(dev, retval, notify_imc);
> -		if (retval < 0) {
> -			release_region(SB800_PIIX4_SMB_IDX, 2);
> +		if (retval < 0)
>  			return retval;
> -		}
>  	} else {
>  		retval =3D piix4_setup(dev, id);
>  		if (retval < 0)
> @@ -983,11 +981,8 @@ static void piix4_adap_remove(struct i2c_adapter *ad=
ap)
> =20
>  	if (adapdata->smba) {
>  		i2c_del_adapter(adap);
> -		if (adapdata->port =3D=3D (0 << piix4_port_shift_sb800)) {
> +		if (adapdata->port =3D=3D (0 << piix4_port_shift_sb800))
>  			release_region(adapdata->smba, SMBIOSIZE);
> -			if (adapdata->sb800_main)
> -				release_region(SB800_PIIX4_SMB_IDX, 2);
> -		}
>  		kfree(adapdata);
>  		kfree(adap);
>  	}
> --=20
> 2.7.4
>=20

--l2qe2bydcixlr3um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUc3AACgkQFA3kzBSg
KbYttBAAgaikolWwNix5wqLofJc62QPt7Qfn4QMS6IpYBDKSIqEYRSLcaotkI6aF
/jjif9Hs+6S9ypfbypGH1BWvQtlMrbcj/DqZ0nUIxOsqcntoRvBOIfgJ/gQJ3XXc
TD5Thgiai/YGpQQPxY1PJRw11FoS/qWngq4plftN2r/t7WxwSjHbTaIL7+tV5V/h
MwURMwq0byFbBK/0qlMtSVUw8ZaT6wEoR9pVdJksywWrbqHT5vyFvpwQ68OOkm3c
0hI/XievMRsiDGyHSRybcSv//QV1FGvZs2P6ikVWsWS/A2r1UMitewq5BI3GzRtr
Ojerm4aHb+14ToeXmGB/Idc6ppsFDvXQeckYVWNh05n+BZFq4OsM/GVh0CfPb6RG
crgnq6ojc5JwSBEJkk3jncJtSUsC8KIEzmmbhiqJ8e4yXpSSp6uGdvnxNvW5B00F
Of8YUj9DYOcKP8+Es8b3Y+KuHmUB0CvtfFMq8/FE+PdmMtvtN76b7BJTKYyOokCT
1ejGs1byLFvJ9zR2LkoPcJP4sn/pZg0WDhn0dL+bVt5h2Ix7vZHSur7duyRZhftA
dXWvHZYeYHdNykCU6aYo5xDhuo/1d0iuTV0i5HsswqHTiiWEyppugPSNF6oX4kU+
Akdj+q+2nKCQg/MjLyNIqb30RQSx2tBkh0MtaElcTyRv4SENp8o=
=CQ1L
-----END PGP SIGNATURE-----

--l2qe2bydcixlr3um--
