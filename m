Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCNLLr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:11:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55911 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeCNLLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:11:37 -0400
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
To: Mark Jonas <mark.jonas@de.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hs@denx.de,
        Zhu Yi <yi.zhu5@cn.bosch.com>
References: <1521023596-30108-1-git-send-email-mark.jonas@de.bosch.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <2968f7d1-771b-a605-9c66-62228fe5398e@pengutronix.de>
Date: Wed, 14 Mar 2018 12:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521023596-30108-1-git-send-email-mark.jonas@de.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Hc1ebqjVRUtvmTqiGyNKBGUk26qCATLWv"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hc1ebqjVRUtvmTqiGyNKBGUk26qCATLWv
Content-Type: multipart/mixed; boundary="I0wyz6tAdU2M30FF9Oubq9SxDoncV9lgL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Jonas <mark.jonas@de.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hs@denx.de, Zhu Yi <yi.zhu5@cn.bosch.com>
Message-ID: <2968f7d1-771b-a605-9c66-62228fe5398e@pengutronix.de>
Subject: Re: [PATCH] can: enable multi-queue for SocketCAN devices
References: <1521023596-30108-1-git-send-email-mark.jonas@de.bosch.com>
In-Reply-To: <1521023596-30108-1-git-send-email-mark.jonas@de.bosch.com>

--I0wyz6tAdU2M30FF9Oubq9SxDoncV9lgL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/14/2018 11:33 AM, Mark Jonas wrote:
> From: Zhu Yi <yi.zhu5@cn.bosch.com>
>=20
> The existing SocketCAN implementation provides alloc_candev() to
> allocate a CAN device using a single Tx and Rx queue. This can lead to
> priority inversion in case the single Tx queue is already full with low=

> priority messages and a high priority message needs to be sent while th=
e
> bus is fully loaded with medium priority messages.
>=20
> This problem can be solved by using the existing multi-queue support of=

> the network subsystem. The commit makes it possible to use multi-queue =
in
> the CAN subsystem in the same way it is used in the Ethernet subsystem
> by adding an alloc_candev_mqs() call and accompanying macros. With this=

> support a CAN device can use multi-queue qdisc (e.g. mqprio) to avoid
> the aforementioned priority inversion.
>=20
> The existing functionality of alloc_candev() is the same as before.
>=20
> CAN devices need to have prioritized multiple hardware queues or are
> able to abort waiting for arbitration to make sensible use of
> multi-queues.
>=20
> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> Reviewed-by: Heiko Schocher <hs@denx.de>

Do you have a driver or a patch to make a driver mq aware?

> ---
>  drivers/net/can/dev.c   | 8 +++++---
>  include/linux/can/dev.h | 7 ++++++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index b177956..636f853 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -703,7 +703,8 @@ EXPORT_SYMBOL_GPL(alloc_can_err_skb);
>  /*
>   * Allocate and setup space for the CAN network device
>   */
> -struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb=
_max)
> +struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo=
_skb_max,
> +				    unsigned int txqs, unsigned int rxqs)
>  {
>  	struct net_device *dev;
>  	struct can_priv *priv;
> @@ -715,7 +716,8 @@ struct net_device *alloc_candev(int sizeof_priv, un=
signed int echo_skb_max)
>  	else
>  		size =3D sizeof_priv;
> =20
> -	dev =3D alloc_netdev(size, "can%d", NET_NAME_UNKNOWN, can_setup);
> +	dev =3D alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
> +			       txqs, rxqs);
>  	if (!dev)
>  		return NULL;
> =20
> @@ -734,7 +736,7 @@ struct net_device *alloc_candev(int sizeof_priv, un=
signed int echo_skb_max)
> =20
>  	return dev;
>  }
> -EXPORT_SYMBOL_GPL(alloc_candev);
> +EXPORT_SYMBOL_GPL(alloc_candev_mqs);
> =20
>  /*
>   * Free space of the CAN network device
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 055aaf5..a83e1f6 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -143,7 +143,12 @@ u8 can_dlc2len(u8 can_dlc);
>  /* map the sanitized data length to an appropriate data length code */=

>  u8 can_len2dlc(u8 len);
> =20
> -struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb=
_max);
> +struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo=
_skb_max,
> +				    unsigned int txqs, unsigned int rxqs);
> +#define alloc_candev(sizeof_priv, echo_skb_max) \
> +	alloc_candev_mqs(sizeof_priv, echo_skb_max, 1, 1)
> +#define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
> +	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)

Can you make this a static inline function.

>  void free_candev(struct net_device *dev);
> =20
>  /* a candev safe wrapper around netdev_priv */
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--I0wyz6tAdU2M30FF9Oubq9SxDoncV9lgL--

--Hc1ebqjVRUtvmTqiGyNKBGUk26qCATLWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqpA18ACgkQk9IU1zQo
ZfEkRwf/T+3A1w04OquAomIXZR24YFHHonytYQVBB5S+ani6ndKW0b1IO+c5WTzi
Ua1Pdj4M1iKvhsdBz3dtbBS+hL1yGU2hz1Vw930jZhSpxZB0jOXbFSEGH8KjHW4o
10PjRgwnyh3zuOr4skrCw+qaY7HKn0zzvzRhHN8lOZzA4oY02bs5snl5MMw0E1Iv
ctSkdCmBaUS5Qm3mJvZc4+GqNKFQzevc59aovahxAisegX0vLE/MW6MWDJp045LJ
8yxxfnKWeWJNSGymKQWK1hFktRCIm2S+691SPJT44w032pdQyVqA3fRPdWNOVyMk
Cg1QDd00K+xjc3m4K7CN8FbvRGolcQ==
=HAjX
-----END PGP SIGNATURE-----

--Hc1ebqjVRUtvmTqiGyNKBGUk26qCATLWv--
