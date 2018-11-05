Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53278C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CD120869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CD120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeKET7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:59:40 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33193 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeKET7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:59:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 20263207F4; Mon,  5 Nov 2018 11:40:35 +0100 (CET)
Received: from localhost (unknown [185.94.189.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3FE76207B0;
        Mon,  5 Nov 2018 11:40:13 +0100 (CET)
Date:   Mon, 5 Nov 2018 11:40:13 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 03/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Message-ID: <20181105104013.lvijeim57vojjfip@flea>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oxno3av5f5bcb3xw"
Content-Disposition: inline
In-Reply-To: <20181103100900.30313-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oxno3av5f5bcb3xw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 03, 2018 at 03:38:53PM +0530, Jagan Teki wrote:
> Burst mode display timings are different from convectional
> video mode so update the horizontal and vertical timings.
>=20
> Reference code taken from BSP
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_hsa  =3D 0;
> dsi_hbp  =3D 0;
> dsi_hact =3D x*dsi_pixel_bits[format]/8;
> dsi_hblk =3D dsi_hact;
> dsi_hfp  =3D 0;
> dsi_vblk =3D 0;
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 108 ++++++++++++++-----------
>  1 file changed, 60 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun=
4i/sun6i_mipi_dsi.c
> index 077b57ec964c..4965b2c71e4c 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -479,59 +479,71 @@ static void sun6i_dsi_setup_timings(struct sun6i_ds=
i *dsi,
> =20
>  	/* Do all timing calculations up front to allocate buffer space */
> =20
> -	/*
> -	 * A sync period is composed of a blanking packet (4 bytes +
> -	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
> -	 * minimal size is therefore 10 bytes
> -	 */
> +	if (device->mode_flags =3D=3D MIPI_DSI_MODE_VIDEO_BURST) {
> +		hsa =3D 0;
> +		hbp =3D 0;
> +		hblk =3D mode->hdisplay * Bpp;
> +		hfp =3D 0;
> +		vblk =3D 0;
> +	} else {
> +		/*
> +		 * A sync period is composed of a blanking packet (4 bytes +
> +		 * payload + 2 bytes) and a sync event packet (4 bytes). Its
> +		 * minimal size is therefore 10 bytes
> +		 */
>  #define HSA_PACKET_OVERHEAD	10
> -	hsa =3D max((unsigned int)HSA_PACKET_OVERHEAD,
> -		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
> -
> -	/*
> -	 * The backporch is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 */
> +		hsa =3D max((unsigned int)HSA_PACKET_OVERHEAD,
> +			  (mode->hsync_end - mode->hsync_start) * Bpp -
> +			  HSA_PACKET_OVERHEAD);
> +
> +		/*
> +		 * The backporch is set using a blanking packet (4 bytes +
> +		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +		 */
>  #define HBP_PACKET_OVERHEAD	6
> -	hbp =3D max((unsigned int)HBP_PACKET_OVERHEAD,
> -		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
> -
> -	/*
> -	 * hblk seems to be the line + porches length.
> -	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
> -	 * payload + 2 bytes). So minimal size is 10 bytes
> -	 */
> +		hbp =3D max((unsigned int)HBP_PACKET_OVERHEAD,
> +			  (mode->htotal - mode->hsync_end) * Bpp -
> +			  HBP_PACKET_OVERHEAD);
> +
> +		/*
> +		 * hblk seems to be the line + porches length.
> +		 * The blank is set using a blanking packet (4 bytes + 4 bytes
> +		 * + payload + 2 bytes). So minimal size is 10 bytes
> +		 */
>  #define HBLK_PACKET_OVERHEAD	10
> -	hblk_max =3D (mode->htotal - (mode->hsync_end - mode->hsync_start)) * B=
pp;
> -	hblk_max -=3D HBLK_PACKET_OVERHEAD;
> -	hblk =3D max_t(unsigned int, HBLK_PACKET_OVERHEAD, hblk_max);
> -
> -	/*
> -	 * The frontporch is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 *
> -	 * According to BSP code, extra 10 bytes(which is hblk packet overhead)
> -	 * is adding for hfp packet overhead since hfp depends on hblk.
> -	 */
> +		hblk_max =3D (mode->htotal -
> +			   (mode->hsync_end - mode->hsync_start)) * Bpp;
> +		hblk_max -=3D HBLK_PACKET_OVERHEAD;
> +		hblk =3D max_t(unsigned int, HBLK_PACKET_OVERHEAD, hblk_max);
> +
> +		/*
> +		 * The frontporch is set using a blanking packet (4 bytes +
> +		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +		 *
> +		 * According to BSP code, extra 10 bytes(which is hblk packet
> +		 * overhead) is adding for hfp packet overhead since hfp
> +		 * depends on hblk.
> +		 */
>  #define HFP_PACKET_OVERHEAD	6
> -	hfp_pkt_overhead =3D (HFP_PACKET_OVERHEAD + HBLK_PACKET_OVERHEAD);
> -	hfp =3D max((unsigned int)hfp_pkt_overhead,
> -		  (mode->hsync_start - mode->hdisplay) * Bpp -
> -		  hfp_pkt_overhead);
> -
> -	/*
> -	 * The vertical blank is set using a blanking packet (4 bytes +
> -	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -	 */
> +		hfp_pkt_overhead =3D (HFP_PACKET_OVERHEAD + HBLK_PACKET_OVERHEAD);
> +		hfp =3D max((unsigned int)hfp_pkt_overhead,
> +			  (mode->hsync_start - mode->hdisplay) * Bpp -
> +			  hfp_pkt_overhead);
> +
> +		/*
> +		 * The vertical blank is set using a blanking packet (4 bytes +
> +		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +		 */
>  #define VBLK_PACKET_OVERHEAD	6
> -	if (device->lanes =3D=3D 4) {
> -		int tmp;
> -
> -		tmp =3D (mode->htotal * Bpp) * mode->vtotal -
> -		      (hblk + VBLK_PACKET_OVERHEAD);
> -		vblk =3D (device->lanes - tmp % device->lanes);
> -	} else {
> -		vblk =3D 0;
> +		if (device->lanes =3D=3D 4) {
> +			int tmp;
> +
> +			tmp =3D (mode->htotal * Bpp) * mode->vtotal -
> +			      (hblk + VBLK_PACKET_OVERHEAD);
> +			vblk =3D (device->lanes - tmp % device->lanes);
> +		} else {
> +			vblk =3D 0;
> +		}
>  	}

We should make this a couple of functions to make things more
readable.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--oxno3av5f5bcb3xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AeDQAKCRDj7w1vZxhR
xYHJAQCzcpDuQnKovM0bUuEaS44c1YuP0f06cccSNeUzXBrEjAD/U4yoeMnwnp8Q
jr8dQQ8uRSXbkbuA8nGR/mo5xpvspw4=
=a7j+
-----END PGP SIGNATURE-----

--oxno3av5f5bcb3xw--
