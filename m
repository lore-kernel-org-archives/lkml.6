Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeBCNpA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 08:45:00 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44094 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBCNox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 08:44:53 -0500
X-Google-Smtp-Source: AH8x227VWSYZf4q2RKHL499/8p47h7zQY9tpz5XQrNUZaSn6D4byUvUDeAodKG7YBWNd/Lnu1X1YXA==
Date: Sat, 3 Feb 2018 14:44:50 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Zhang Bo <zbsdta@126.com>
Cc: dmitry.torokhov@gmail.com, DRivshin@allworx.com, robh@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.bo19@zte.com.cn
Subject: Re: [PATCH] Input: matrix_keypad - fix keypad does not response
Message-ID: <20180203134450.GC707@gmail.com>
References: <20180203120046.10988-1-zbsdta@126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20180203120046.10988-1-zbsdta@126.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Sat, Feb 03, 2018 at 08:00:46PM +0800, Zhang Bo wrote:
> From: zhangbo <zbsdta@126.com>
>=20
> If matrix_keypad_stop() is calling and the keypad interrupt is triggered,
> disable_row_irqs() is called by both matrix_keypad_interrupt() and
> matrix_keypad_stop() at the same time. then disable_row_irqs() is called
> twice, and the device enter suspend state before keypad->work is executed.
> At this condition the device will start keypad and enable irq once after
> resume. and then irqs are disabled yet because irqs are disabled twice and
> only enable once.
>=20
> Signed-off-by: zhangbo <zbsdta@126.com>

Please use your full real name in the signed-off-by tag.

> ---
>  drivers/input/keyboard/matrix_keypad.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keybo=
ard/matrix_keypad.c
> index 1f316d66e6f7..13fe51824637 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -169,7 +169,8 @@ static void matrix_keypad_scan(struct work_struct *wo=
rk)
>  	/* Enable IRQs again */
>  	spin_lock_irq(&keypad->lock);
>  	keypad->scan_pending =3D false;
> -	enable_row_irqs(keypad);
> +	if (keypad->stopped =3D=3D false)
> +		enable_row_irqs(keypad);
>  	spin_unlock_irq(&keypad->lock);
>  }
> =20
> @@ -202,14 +203,16 @@ static int matrix_keypad_start(struct input_dev *de=
v)
>  {
>  	struct matrix_keypad *keypad =3D input_get_drvdata(dev);
> =20
> +	spin_lock_irq(&keypad->lock);
>  	keypad->stopped =3D false;
> -	mb();
> =20
>  	/*
>  	 * Schedule an immediate key scan to capture current key state;
>  	 * columns will be activated and IRQs be enabled after the scan.
>  	 */
> -	schedule_delayed_work(&keypad->work, 0);
> +	if (keypad->scan_pending =3D=3D false)
> +		schedule_delayed_work(&keypad->work, 0);
> +	spin_unlock_irq(&keypad->lock);
> =20
>  	return 0;
>  }
> @@ -218,14 +221,17 @@ static void matrix_keypad_stop(struct input_dev *de=
v)
>  {
>  	struct matrix_keypad *keypad =3D input_get_drvdata(dev);
> =20
> +	spin_lock_irq(&keypad->lock);
>  	keypad->stopped =3D true;
> -	mb();
> -	flush_work(&keypad->work.work);
>  	/*
>  	 * matrix_keypad_scan() will leave IRQs enabled;
>  	 * we should disable them now.
>  	 */
> -	disable_row_irqs(keypad);
> +	if (keypad->scan_pending =3D=3D false)
> +		disable_row_irqs(keypad);
> +	spin_unlock_irq(&keypad->lock);
> +
> +	flush_work(&keypad->work.work);
>  }


Hum, I think we should use spin_lock_irqsave/spin_lock_irqrestore
instead to be on the safe side.=20
I don't see how we could guarantee that irqs is allways enabled when
calling spin_lock_irq().


> =20
>  #ifdef CONFIG_PM_SLEEP
> --=20
> 2.14.3


Best regards
Marcus Folkesson
>=20

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlp1vM0ACgkQiIBOb1ld
UjLRFw//Z7zK/Z95Lly6nNtnCNkF6fqjB90Dco+4jWIEA5U4o0Mw46FlVmVn1gvm
qzBxzOxAOeBiWoPh+nmmNjDcUuEVy4bMic1tIVCYMs0AL5Thp81lR0srtaDPJgEe
vJGw2mOHhAszzbTongXjNuWLnHuXjShbsfoot5ZZCOjXZsvHkiFrPQwfGPwdmLbK
l2qlTzRxxNmJEumN0mkBaQG6Gg0CIXBeYPpEYXlwRRoNZxoyZC4wmStQep0s+QyO
36rAb1HOqGS61U6UWnj+acmcdlmH7q/ON7lDwDwfuFANOPCMc4SMS2l1l83tNEO/
SAyHHQghu0oy7cMt/F+9CAKGWlZz1UYxw4po12cafYJonCB36nn1CGWy2NKCcFvi
1GV3gXntjs/FPDuRInxYx2GyPRj4dEX1yCOWuAG/OcggNQJw8RzU26LU+mQceJ7B
623+D3/c23ByA8EKvkZQuooWM4fAXw4YQKjMMOZWfv2poqp3DfE4pQcSNGqbzXhq
HtOz1d0naVOPeCKiCBsFlVyaiXUPUD00pboPVGWYUVApMlMcwEr32JyRHands7Nb
7TGfVldSTlGrceNazi+owqHREnGhA/M1N2QRg5NaHnd04Wzfl4i8nNCRfIgVHOEq
0KIUmSb5uKfTi/Nhc8e4ZE+L4HiuM7YdbwT0wpWn4rRKKmcYLNo=
=+2mh
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
