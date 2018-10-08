Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD1BC64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972952087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972952087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJHQZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:25:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37199 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbeJHQZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:25:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 289A8207CC; Mon,  8 Oct 2018 11:14:16 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id E88EC206A1;
        Mon,  8 Oct 2018 11:14:05 +0200 (CEST)
Date:   Mon, 8 Oct 2018 11:14:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 18/29] drm/sun4i: dw-hdmi: Add quirk for setting TMDS
 clock
Message-ID: <20181008091406.yjs2u22fmj72e4rj@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-19-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4nrl5kiexzifpjc7"
Content-Disposition: inline
In-Reply-To: <20181007093905.11253-19-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4nrl5kiexzifpjc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 07, 2018 at 11:38:54AM +0200, Jernej Skrabec wrote:
> It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
> all. At this point it is not clear whether it is just not necessary or
> it would cause some kind of issues.
>=20
> Add a quirk for it.
>=20
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 5 ++++-
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
> index ec122136ee9d..e9e93f174b35 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> @@ -165,7 +165,9 @@ static int sun8i_dw_hdmi_bind(struct device *dev, str=
uct device *master,
>  		goto err_disable_clk_tmds;
>  	}
> =20
> -	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
> +	if (hdmi->quirks->set_rate)
> +		drm_encoder_helper_add(encoder,
> +				       &sun8i_dw_hdmi_encoder_helper_funcs);

That seems a bit backward, it only works because we only have mode_set
at the moment, and the only thing it does is changing the clock
rate. As soon as we change one of these two assumptions, the code will
break.

Why not just return in mode_set if that boolean is true?

>  	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
>  			 DRM_MODE_ENCODER_TMDS, NULL);
> =20
> @@ -235,6 +237,7 @@ static int sun8i_dw_hdmi_remove(struct platform_devic=
e *pdev)
> =20
>  static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks =3D {
>  	.mode_valid =3D sun8i_dw_hdmi_mode_valid_a83t,
> +	.set_rate =3D true,
>  };
> =20
>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] =3D {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
> index a645b8bc9f58..f9eb663865a4 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> @@ -173,6 +173,7 @@ struct sun8i_hdmi_phy {
>  struct sun8i_dw_hdmi_quirks {
>  	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
>  					   const struct drm_display_mode *mode);
> +	bool set_rate;

This triggers a check in checkpatch. You should address them (and
there's several in your series).

With both addressed,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4nrl5kiexzifpjc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu7H90ACgkQ0rTAlCFN
r3RDVQ//UsnNe06VS+oeSCOXymJ0QJAdJgKi0c4yRLULRFP/RMNSo1B6pclCFnqd
Lb6k+GQNHA14iomXWWF/ZOPsMo1UXInR/4lLbzo05S+bB7k/1E7ArvPT+zyEbJCc
ma/y52Tkn+6KqthW08mArJ5qtl/S508c/iN44Bt1TbBxd5bqzVxO6Ex689hiiOxj
ki09L78/+dG7I93vUtc96hqlw1kJyxVHCKF0QfohzG3AO6PbVsJGsgEf70pTLxHm
XYJzs0V9hDuIBIDzed9zYRwCElzyIug5fkf0htL5490P5R2ko/OZEOCrwbgcdM51
wXoI9S/y5Kb6KfDb078UbcGYHPui9lTDaqG19AEQoY8EgL+kailHg8EEQU6DmEus
nwQebiPdA9pz09+Nw/k7TzkHWE2yvpXQoy1MqlsO/QyrhztfBCnsC0GM5R6v43j6
X+f9gi44mEMbRtkpo3VBzDPj8/8bfmEZrYCOf5kHQKNwfWxZBdhsA7vjlNkFPPHT
jGgg/Bpss9jvlyQi+kl0ywk1esVkryx3Sj07V7g4k9wC0yEv8Itkd9/3mRXNBtOU
DTbV3ll5AsKdTjsCVGkqBcxLK9cAcVQId6M724f8ISXXWmbG3U1vkZexvU3OtPOg
DRNdAxl895tijb3IYllb0WarIctjkQ6OoM7Y6IwXRaInh/kAm9s=
=v5Md
-----END PGP SIGNATURE-----

--4nrl5kiexzifpjc7--
