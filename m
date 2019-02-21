Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1412080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfBUX0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:26:13 -0500
Received: from sauhun.de ([88.99.104.3]:40306 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfBUX0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:26:13 -0500
Received: from localhost (p54B336C3.dip0.t-ipconnect.de [84.179.54.195])
        by pokefinder.org (Postfix) with ESMTPSA id 86DFA2C088A;
        Fri, 22 Feb 2019 00:26:10 +0100 (CET)
Date:   Fri, 22 Feb 2019 00:26:10 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jim Broadus <jbroadus@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     ckeepax@opensource.cirrus.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client
 device.
Message-ID: <20190221232609.d4vxl3osj6mwooey@katana>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzjpahq6uzzczh6h"
Content-Disposition: inline
In-Reply-To: <20190219193027.13882-1-jbroadus@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzjpahq6uzzczh6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 11:30:27AM -0800, Jim Broadus wrote:
> A previous change allowed I2C client devices to discover new IRQs upon
> reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
> assigned in i2c_new_device, that information is lost.
>=20
> For example, the touchscreen and trackpad devices on a Dell Inspiron lapt=
op
> are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> client device structures are initialized during an ACPI walk. After
> removing the i2c_hid device, modprobe fails.
>=20
> This change caches the initial IRQ value in i2c_new_device and then resets
> the client device IRQ to the initial value in i2c_device_remove.
>=20
> Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> Signed-off-by: Jim Broadus <jbroadus@gmail.com>

Adding Benjamin to CC

> ---
>  drivers/i2c/i2c-core-base.c | 9 +++++----
>  include/linux/i2c.h         | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 28460f6a60cc..af87a16ac3a5 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -430,7 +430,7 @@ static int i2c_device_remove(struct device *dev)
>  	dev_pm_clear_wake_irq(&client->dev);
>  	device_init_wakeup(&client->dev, false);
> =20
> -	client->irq =3D 0;
> +	client->irq =3D client->init_irq;
> =20
>  	return status;
>  }
> @@ -741,10 +741,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c=
_board_info const *info)
>  	client->flags =3D info->flags;
>  	client->addr =3D info->addr;
> =20
> -	client->irq =3D info->irq;
> -	if (!client->irq)
> -		client->irq =3D i2c_dev_irq_from_resources(info->resources,
> +	client->init_irq =3D info->irq;
> +	if (!client->init_irq)
> +		client->init_irq =3D i2c_dev_irq_from_resources(info->resources,
>  							 info->num_resources);
> +	client->irq =3D client->init_irq;
> =20
>  	strlcpy(client->name, info->type, sizeof(client->name));
> =20
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 65b4eaed1d96..7e748648c7d3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -333,6 +333,7 @@ struct i2c_client {
>  	char name[I2C_NAME_SIZE];
>  	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
>  	struct device dev;		/* the device structure		*/
> +	int init_irq;			/* irq set at initialization	*/
>  	int irq;			/* irq issued by device		*/
>  	struct list_head detected;
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> --=20
> 2.20.1
>=20

--yzjpahq6uzzczh6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxvM4wACgkQFA3kzBSg
KbZimBAAqUthoS36WAVsPLDvTUfDY3C3XsaX9SAWeX0d8PyDrz6Ba3aUfyt77JwW
WQNn4rceHgav8xpg+1nogCBm6d1RY74tvtTD46SYm8QK1bLyMQAVORGQBb6rSHNK
I+oJalVk1EdHMkeVaPV/4Meof4bVZtkIyga5A1xxWsIvUmmYsmBJHKqqDURxNCKX
O9mKshKQtZRcFMeF7RW93C8om+Edj+X3yaPMjJCumJTEcNroZGTqSEO18CkGznv6
LcE/G/6e6K6fFcrq3gVfZImsu/rnXprspoN1hj49GJ1gTMknoberiGBQ5Ga7juDW
jTTRRiS/XsY36Xqkxv6RkT0BiTwJDmecjygVEr8ANXuuTP8tAyIPrHDVUS1Za++J
GoEZJOYAqsiBnN6Uuev8ibMfA9ICubo18GxYsfM1h2/iOW8ZOTnxmx0MYznpoNY/
Z4wFdxqRs6bufx/UZJ+hVoLhZAPkT+1V2xNY4V74qE8UXEnHxuJoEzGK1tdjw8Jh
H5xhWxDqdQqwkF9pY8ymM7gDYncPkZLnQYc3gVr3d8pMjtWKBKGLTiX+mrqR5TRq
0wfTfvGe/AMOJbiHiKLergJkVY4d1s1aDgQBaAMR6/Hvz5flLwDeN5f/EOm1zvLB
eEX9wurXkd4uq6ijcUJCh/fcaGXqy6Hc04AFMmCitrKJUzvR2zo=
=Ijv+
-----END PGP SIGNATURE-----

--yzjpahq6uzzczh6h--
