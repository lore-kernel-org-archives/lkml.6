Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeBCHzp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 02:55:45 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37983 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeBCHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 02:55:39 -0500
X-Google-Smtp-Source: AH8x226LCV/uLkAaCc4xLLHsRQ7cHMzEV79ORrL2Cywafm+L6zs0vAb0kGaN6UatEM4FriEoueBMWA==
Date: Sat, 3 Feb 2018 08:55:31 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com
Subject: Re: [PATCH v2 2/2] HID: core: Fix size as type u32
Message-ID: <20180203075531.GA707@gmail.com>
References: <20180108024141.10590-1-aaron.ma@canonical.com>
 <20180108024141.10590-2-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20180108024141.10590-2-aaron.ma@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Mon, Jan 08, 2018 at 10:41:41AM +0800, Aaron Ma wrote:
> When size is negative, calling memset will make segment fault.
> Declare the size as type u32 to keep memset safe.
>=20
> size in struct hid_report is unsigned, fix return type of
> hid_report_len to u32.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/hid/hid-core.c | 10 +++++-----
>  include/linux/hid.h    |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 0c3f608131cf..cf81c53e3b98 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1390,7 +1390,7 @@ u8 *hid_alloc_report_buf(struct hid_report *report,=
 gfp_t flags)
>  	 * of implement() working on 8 byte chunks
>  	 */
> =20
> -	int len =3D hid_report_len(report) + 7;
> +	u32 len =3D hid_report_len(report) + 7;
> =20
>  	return kmalloc(len, flags);
>  }
> @@ -1455,7 +1455,7 @@ void __hid_request(struct hid_device *hid, struct h=
id_report *report,
>  {
>  	char *buf;
>  	int ret;
> -	int len;
> +	u32 len;
> =20
>  	buf =3D hid_alloc_report_buf(report, GFP_KERNEL);
>  	if (!buf)
> @@ -1481,14 +1481,14 @@ void __hid_request(struct hid_device *hid, struct=
 hid_report *report,
>  }
>  EXPORT_SYMBOL_GPL(__hid_request);
> =20
> -int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int=
 size,
> +int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32=
 size,
>  		int interrupt)
>  {
>  	struct hid_report_enum *report_enum =3D hid->report_enum + type;
>  	struct hid_report *report;
>  	struct hid_driver *hdrv;
>  	unsigned int a;
> -	int rsize, csize =3D size;
> +	u32 rsize, csize =3D size;
>  	u8 *cdata =3D data;
>  	int ret =3D 0;
> =20
> @@ -1546,7 +1546,7 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
>   *
>   * This is data entry for lower layers.
>   */
> -int hid_input_report(struct hid_device *hid, int type, u8 *data, int siz=
e, int interrupt)
> +int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 siz=
e, int interrupt)
>  {
>  	struct hid_report_enum *report_enum;
>  	struct hid_driver *hdrv;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index d491027a7c22..9bc296eebc98 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -841,7 +841,7 @@ extern int hidinput_connect(struct hid_device *hid, u=
nsigned int force);
>  extern void hidinput_disconnect(struct hid_device *);
> =20
>  int hid_set_field(struct hid_field *, unsigned, __s32);
> -int hid_input_report(struct hid_device *, int type, u8 *, int, int);
> +int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
>  int hidinput_find_field(struct hid_device *hid, unsigned int type, unsig=
ned int code, struct hid_field **field);
>  struct hid_field *hidinput_get_led_field(struct hid_device *hid);
>  unsigned int hidinput_count_leds(struct hid_device *hid);
> @@ -1088,13 +1088,13 @@ static inline void hid_hw_wait(struct hid_device =
*hdev)
>   *
>   * @report: the report we want to know the length
>   */
> -static inline int hid_report_len(struct hid_report *report)
> +static inline u32 hid_report_len(struct hid_report *report)

hid_report_len() is used in several files.
If we think it is a good idea to change the return type, we should fix
these files as well.

[08:47:56]marcus@little:~/git/linux$ git grep -l hid_report_len
drivers/hid/hid-core.c
drivers/hid/hid-input.c
drivers/hid/hid-multitouch.c
drivers/hid/hid-rmi.c
drivers/hid/usbhid/hid-core.c
drivers/hid/wacom_sys.c
drivers/staging/greybus/hid.c
include/linux/hid.h

>  {
>  	/* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->id > 0) */
>  	return ((report->size - 1) >> 3) + 1 + (report->id > 0);
>  }
> =20
> -int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int=
 size,
> +int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32=
 size,
>  		int interrupt);
> =20
>  /* HID quirks API */
> --=20
> 2.14.3

Best regards
Marcus Folkesson
>=20

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlp1au8ACgkQiIBOb1ld
UjJn9A//d4/NQvTAvtwNlF4dW7CHiNGQQpYB10dxf59BnuPbnwUq48X15ikB1Zc7
OEtOheen2LkI+GYHa0AWtBHsLVvpoVxaHgNuBiDs0X9qL57WhS+dw1Mvn2tO3wKf
UWCBet6Uxf8GjtcPl4kwAlm2rgbfazjB3uwXoA9VLOmr49eTfkMBCd7Mq/toF1zt
Ku8rmj4X8AqVJqBJZfeLezsrbOhL7QhUtevA1WUaGdEeChfm8lEu6pPyIbqv3lIh
rQQCaneSkQ7wkinubj2Q0AQ/uwQoLp97Wbv0dAPBOtK/nurvd9JZFgyL2BUVrVRL
JkJB7qPLDwoO4QQdowXzWaqFLiTmPlji5vfDqkilLAyVJyBSfHY9Ul/q7H+GkDgl
L3qtP+rSBv7t/DnOaqxGN/X0tVhlBDTCseeKZn+v5GQcSV0zZB0T4I1lj4R2j4z9
aqY6wFXGrWkcnzL7S+zOLi/B3q1nDEh8Quvtrs1q/Zp7S300jHK6Mwdc1+GEbRlm
5uoACNxSQlaIGICCDIc8LYo4B+uIgkv9M+D1kDsP5pxzRPI691womm1Nx8btLP8G
SzlrAvZQt1ZXNrf2+vyWXA43Cus9WTKuhfy80TeL4G0e0+5DqFxlDEOths8+zrI0
mOk3p+W+YrnrS/gNulvRiH25JbjWldM+nw4iXHka0sjCk46Xd44=
=f5fo
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
