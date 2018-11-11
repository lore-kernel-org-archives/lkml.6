Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2767C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679E62146E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679E62146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeKKLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:20:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42884 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbeKKLUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:20:53 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLedB-0001Rn-E5; Sun, 11 Nov 2018 01:33:41 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLedB-00042V-5i; Sun, 11 Nov 2018 01:33:41 +0000
Message-ID: <fdd2eb6f62663b936077b5705d3ea1504d0a7d97.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16] staging: usbip stub_rx fix static checker warning
 on unnecessary checks
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Shuah Khan <shuahkh@osg.samsung.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        bwh@kernel.org, dan.carpenter@oracle.com
Date:   Sun, 11 Nov 2018 01:33:40 +0000
In-Reply-To: <20180226211241.19335-1-shuahkh@osg.samsung.com>
References: <20180226211241.19335-1-shuahkh@osg.samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-H7xMBZSXf9dND3GmbY2P"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H7xMBZSXf9dND3GmbY2P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-02-26 at 14:12 -0700, Shuah Khan wrote:
> Upstream commit 10c901209306
> ("usbip: stub_rx: fix static checker warning on unnecessary checks")
>=20
> Back-port fix for static checker warning on unnecessary checks
>=20
> smatch warnings:
> drivers/staging/usbip/stub_rx.c:360 get_pipe() warn: impossible
> condition '(pdu->u.cmd_submit.transfer_buffer_length > ((~0 >> 1))) =3D>
> (s32min-s32max > s32max)'
> drivers/staging/usbip/stub_rx.c:501 stub_recv_cmd_submit() warn: always
> true condition '(pdu->u.cmd_submit.transfer_buffer_length <=3D ((~0 >>
> 1))) =3D> (s32min-s32max <=3D s32max)'

I've finally queued this up, thanks.

Ben.

> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/staging/usbip/stub_rx.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> diff --git a/drivers/staging/usbip/stub_rx.c b/drivers/staging/usbip/stub=
_rx.c
> index 35f59747122a..d8544ab9577b 100644
> --- a/drivers/staging/usbip/stub_rx.c
> +++ b/drivers/staging/usbip/stub_rx.c
> @@ -356,14 +356,6 @@ static int get_pipe(struct stub_device *sdev, struct=
 usbip_header *pdu)
> =20
>  	epd =3D &ep->desc;
> =20
> -	/* validate transfer_buffer_length */
> -	if (pdu->u.cmd_submit.transfer_buffer_length > INT_MAX) {
> -		dev_err(&sdev->udev->dev,
> -			"CMD_SUBMIT: -EMSGSIZE transfer_buffer_length %d\n",
> -			pdu->u.cmd_submit.transfer_buffer_length);
> -		return -1;
> -	}
> -
>  	if (usb_endpoint_xfer_control(epd)) {
>  		if (dir =3D=3D USBIP_DIR_OUT)
>  			return usb_sndctrlpipe(udev, epnum);
> @@ -497,8 +489,7 @@ static void stub_recv_cmd_submit(struct stub_device *=
sdev,
>  	}
> =20
>  	/* allocate urb transfer buffer, if needed */
> -	if (pdu->u.cmd_submit.transfer_buffer_length > 0 &&
> -	    pdu->u.cmd_submit.transfer_buffer_length <=3D INT_MAX) {
> +	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
>  		priv->urb->transfer_buffer =3D
>  			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
>  				GFP_KERNEL);
--=20
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.



--=-H7xMBZSXf9dND3GmbY2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvnhvQACgkQ57/I7JWG
EQm+Vg/9GP1OCB9jSRsg30KsTTaPU14ZjdUfFdgpmRBF+vraruTA0PEj6N5uIXn+
1PHYqx4keMY0SEF7j1JUiDk9Pow0YnwmoUt9etHSbS92sbMscluzFZ9b6uTEaRL3
MVClv5V46xnduSTgMNYEOh2+HiJI5ViEe0thtqM+bgUv8g/p/AUm5tYOd9aKT8o1
f2aVvi1Kk3ZOXI32Hk5/CS5fjowcCezL5/232UlyMz9MOvlz2UbwxELBB4qtJsYR
v1/MyiC19JpbFEQSWteeFUj8ArYlWzPe0k8KlMpBiMfhk7giHL3QDJcLG6iF+GYy
Yd8bVSAfdPc7GIW989tW37dsNZf6ud8CrVeRHEBJIooSI0jfjTR8Du29a5zYRh1y
rYSaVzLanUv/C4L9FI3UClUE04aa7LE14m1WUNs1c0MNRPAi/ei/kQ0QqZtTlTXR
Tpc58paPkio3RvQISg60mP6H9ePq/zapssQ61TDqNqeYlVu/ENJBpyUhY8tCJvbS
f1jvesIsypv9duWA8UZaqH5tZfftaEiVq7G2Jb4cz6Yb6sW56FOf/peDsw8m2I9z
w3Xjo22FAbOdHOp1/qxeNA1SSpW1V85N1WXj5Kirt7rY43uFcJxP3nLEOts3eihi
QWgeBuFft9oDQB38971g6dMcHlMRZfdUXiOX6T6cieQXtrYa4xM=
=hIb7
-----END PGP SIGNATURE-----

--=-H7xMBZSXf9dND3GmbY2P--
