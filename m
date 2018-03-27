Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeC0Jrz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:47:55 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34483 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0Jrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:47:53 -0400
X-Originating-IP: 2.224.242.101
Date: Tue, 27 Mar 2018 11:47:43 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] drm: bridge: add API to query the expected input
 formats of bridges
Message-ID: <20180327094743.GL27746@w540>
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <20180326212447.7380-3-peda@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter,
   thanks for the patches

On Mon, Mar 26, 2018 at 11:24:44PM +0200, Peter Rosin wrote:
> Bridges may affect the required bus output format of the encoder, in
> which case it may be wrong to use the output format of the panel or
> connector as is. Add infrastructure to address this problem.

Bridges not only affect the format expected by the connector at the
end of the display pipeline, they may perform encoding/decoding
between protocols and their accepted input formats may be unrelated to
the connector at the end of the pipeline as there may an arbitrary
number of bridges in between.

Eg.

ENCODER                                                CONNECTOR
  |                                                         |
|DU LVDS| ->lvds-> |THC63| ->rgb-> |ADV7511| ->hdmi-> |HDMI connector|

The fact that THC63 wants a specific LVDS input format is unrelated to
the format required by the HDMI connector at the end of the pipeline.

I would just state here that bridges need a way to report their
accepted media bus formats, and this patch extends the DRM Bridge APIs
to implement that.

>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     | 18 ++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe9627c..f85e61b7416e 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -348,6 +348,38 @@ void drm_bridge_enable(struct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(drm_bridge_enable);
>
> +/**
> + * drm_bridge_input_formats - get the expected bus input format of the bridge

I may be biased by the V4L2 APIs, but this seems to me very much like
similar to g_fmt/s_fmt callbacks we have there. Bridges have an input and
an output formats, and that calls for something that takes that into
account, as well as they may have different input ports with different
accepted formats but I would for now simplify this to just 'g_fmt()'

> + * @bridge: bridge control structure
> + * @bus_formats: where to store a pointer to the bus input formats
> + *
> + * Calls the &drm_bridge_funcs.input_formats op for the frist bridge in the
> + * chain that has registered this op.

I'm not sure passing the call down the pipeline is desirable. Each
component should make sure its output format is accepted as the next
bridge input format, passing the call to the next bridge is not
different that getting to the connector at the end of the pipeline and
return to the initial caller its supported format. Do you agree with this?

> + *
> + * Note that the bridge passed should normally be the bridge closest to the
> + * encoder, but possibly the bridge closest to an intermediate bridge in
> + * convoluted cases.
> + *

As I see this, any bridge in the arbitrary long pipeline should call
this operation on next bridge if it supports different output formats.
Ie. I would not name here the encoder nor refer to the bridge position
in the pipeline.

> + * RETURNS:
> + * The number of bus input formats the bridge accepts. Zero means that
> + * the chain of bridges are not converting the bus format and that the
> + * format of the drm_connector should be used.

How do we get to the connector format from a bridge that has maybe
other components in between in the pipeline?

If a bridge do not report any supported format, it won't implement
this callback and things will work as they work today.

> + */
> +int drm_bridge_input_formats(struct drm_bridge *bridge,
> +			     const u32 **bus_formats)
> +{
> +	int ret = 0;
> +
> +	if (!bridge)
> +		return 0;
> +
> +	if (bridge->funcs->input_formats)
> +		ret = bridge->funcs->input_formats(bridge, bus_formats);
> +
> +	return ret ?: drm_bridge_input_formats(bridge->next, bus_formats);

See my comment on the call propagation down in the pipeline.

> +}
> +EXPORT_SYMBOL(drm_bridge_input_formats);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node in
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 682d01ba920c..ae8d3c4af0b8 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -220,6 +220,22 @@ struct drm_bridge_funcs {
>  	 * The enable callback is optional.
>  	 */
>  	void (*enable)(struct drm_bridge *bridge);
> +
> +	/**
> +	 * @input_formats:
> +	 *
> +	 * The callback reports the expected bus input formats of the bridge.
> +	 *
> +	 * The @input_formats callback is optional. The bridge is assumed to
> +	 * not convert the bus format if the callback is not installed.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * Zero if the bridge does not convert the bus format, otherwise the
> +	 * number of bus input formats returned in &bus_formats.
> +	 */
> +	int (*input_formats)(struct drm_bridge *bridge,
> +			     const u32 **bus_formats);

Consider g_fmt() here as well, or a function name that captures that we want
to know the supported format (and possibly configure it as well one
day, if ever possible).

Thanks
   j

>  };
>
>  /**
> @@ -263,6 +279,8 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
>  			struct drm_display_mode *adjusted_mode);
>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
>  void drm_bridge_enable(struct drm_bridge *bridge);
> +int drm_bridge_input_formats(struct drm_bridge *bridge,
> +			     const u32 **bus_formats);
>
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
> --
> 2.11.0
>

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJauhM/AAoJEHI0Bo8WoVY80qUQALBcrH+ujGYDUnRL/gC6fiKs
i8CeGyAGbaBgC+KetUzTunOwGW55m2jF7E82ZSosywODJ4tBdeOf+p9eM6ibVB3O
ujTypppDnThh1z71cUje1XREYX6D4CD90NxqODbfMAWfW7YOCg3QvteMIgXdf21T
959iwKWNDQRbjCtqL+pU609kPYqmyrdM8E36EjAKY4yb6gI2+1uDcjg9VOuAx7aO
V9r1GsvQkOE1eqaf0d50Z+NAaRl2yVhrvnzLRD4+0zjFD89b2gL9MnivC/CMM5WJ
iAep+c0UkNAAXYGBhY3H36Q1YbHrXWbIIjeBDe6r485/LFyHprVX/u8W0huIoeoW
ADpoRFl3XSBH0drAqimREFnXnccAqvHRnntGk9PZa8mNFzKJAp5VWMlnyXvRKsCf
qlDKnEC/butVEPc62/2dfMGwIuqVWu+TtFWZJx7QhmVl5/14bas8zF+iOtstAPjD
JmgHn2TTBlmHpAJDEMYztxVqtfDLB/WvW3Xdih8zZ1uNgFxr1DYBAO0mGQQ/mHwA
S4nOAyDaRzhpr7omKEfxMAQ+odlTpCyqxf45Jik4fcBFy/DsqDOKgA1nWxahklPq
5xFnV+M6bpsjXb+MvcAK077RRpl0zMeprfeSubUONQBnifOdJPbyTexCAC1irPyS
zFS9e5QAcmanO9BDjnMH
=u+dg
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
