Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8FBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB3020891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB3020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeH0Nzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:55:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33105 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeH0Nzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:55:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B78BA82F70; Mon, 27 Aug 2018 12:09:39 +0200 (CEST)
Date:   Mon, 27 Aug 2018 12:09:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 5/8] backlight: qcom-wled: Restructure the driver for
 WLED3
Message-ID: <20180827100939.GG31905@amd>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-6-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <1535106467-17843-6-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-08-24 15:57:44, Kiran Gunda wrote:
> Restructure the driver to add the support for new WLED
> peripherals.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Changes from V3:
>     - This is the new patch after splitting the=20
>       "backlight: qcom-wled: Add support for WLED4 peripheral" patch
>       to seperate the WLED3 specific restructure.
>=20
> Changes from V4:
>     - Initialize wled->cfg.enabled_strings to 0,1,2,3.
>     - Replaced the WLED3 macro with 3.
>=20
>  drivers/video/backlight/qcom-wled.c | 395 ++++++++++++++++++++++--------=
------
>  1 file changed, 245 insertions(+), 150 deletions(-)
>=20
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backligh=
t/qcom-wled.c
> index 3cd6e75..a746bec 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -15,59 +15,71 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/regmap.h>
> =20
>  /* From DT binding */
> +#define WLED_MAX_STRINGS				4
> +
>  #define WLED_DEFAULT_BRIGHTNESS				2048
> =20
> -#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
> -#define WLED3_CTRL_REG_VAL_BASE				0x40
> +#define WLED_SINK_REG_BRIGHT_MAX			0xFFF

Stop this, no. In previous patch you renamed from ABC123_ to WLED3_,
now you are renaming back to WLED?

Stop messing with the names. I'd actually prefer you to stick with
original driver name, and just add note that this now supports more
hardware.

But yes, _one_ rename is okay. I guess. But renaming it twice in one
series is not acceptable.

> @@ -365,6 +433,15 @@ static int wled_configure(struct wled *wled, struct =
device *dev)
> =20
>  	cfg->num_strings =3D cfg->num_strings + 1;
> =20
> +	string_len =3D of_property_count_elems_of_size(dev->of_node,
> +						     "qcom,enabled-strings",
> +						     sizeof(u32));
> +	if (string_len > 0)
> +		rc =3D of_property_read_u32_array(dev->of_node,
> +						"qcom,enabled-strings",
> +						wled->cfg.enabled_strings,
> +						sizeof(u32));
> +
>  	return 0;
>  }

rc is assigned but never used.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDzeMACgkQMOfwapXb+vIXmACePgeIXKK/zRyi4M6+98I9P+Uu
MHoAnRNPpj7ocSXmDCnbeVB/eidWJ6CB
=Wanx
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
