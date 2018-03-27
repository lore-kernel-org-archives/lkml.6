Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeC0NCr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:02:47 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33503 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbeC0NCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:02:45 -0400
X-Originating-IP: 2.224.242.101
Date: Tue, 27 Mar 2018 15:02:31 +0200
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
Message-ID: <20180327130231.GO27746@w540>
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-3-peda@axentia.se>
 <20180327094743.GL27746@w540>
 <fcc47402-d758-4062-0565-f5977b85b206@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <fcc47402-d758-4062-0565-f5977b85b206@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Peter,

On Tue, Mar 27, 2018 at 02:12:42PM +0200, Peter Rosin wrote:
> Hi Jacopo,
>
> Thanks for the feedback!
>
> On 2018-03-27 11:47, jacopo mondi wrote:
> > Hi Peter,
> >    thanks for the patches
> >
> > On Mon, Mar 26, 2018 at 11:24:44PM +0200, Peter Rosin wrote:
> >> Bridges may affect the required bus output format of the encoder, in
> >> which case it may be wrong to use the output format of the panel or
> >> connector as is. Add infrastructure to address this problem.
> >
> > Bridges not only affect the format expected by the connector at the
> > end of the display pipeline, they may perform encoding/decoding
> > between protocols and their accepted input formats may be unrelated to
> > the connector at the end of the pipeline as there may an arbitrary
> > number of bridges in between.
> >
> > Eg.
> >
> > ENCODER                                                CONNECTOR
> >   |                                                         |
> > |DU LVDS| ->lvds-> |THC63| ->rgb-> |ADV7511| ->hdmi-> |HDMI connector|
> >
> > The fact that THC63 wants a specific LVDS input format is unrelated to
> > the format required by the HDMI connector at the end of the pipeline.
> >
> > I would just state here that bridges need a way to report their
> > accepted media bus formats, and this patch extends the DRM Bridge APIs
> > to implement that.
>
> Yes, I can add some words, but I would like to clear up the naming
> before re-spinning.
>
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++++++++
> >>  include/drm/drm_bridge.h     | 18 ++++++++++++++++++
> >>  2 files changed, 50 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> >> index 1638bfe9627c..f85e61b7416e 100644
> >> --- a/drivers/gpu/drm/drm_bridge.c
> >> +++ b/drivers/gpu/drm/drm_bridge.c
> >> @@ -348,6 +348,38 @@ void drm_bridge_enable(struct drm_bridge *bridge)
> >>  }
> >>  EXPORT_SYMBOL(drm_bridge_enable);
> >>
> >> +/**
> >> + * drm_bridge_input_formats - get the expected bus input format of the bridge
> >
> > I may be biased by the V4L2 APIs, but this seems to me very much like
> > similar to g_fmt/s_fmt callbacks we have there. Bridges have an input and
>
> g_fmt/s_fmt says nothing to me. Graphics format? Source Format? I have
> no idea if those guesses are even close? So, that seems like poor naming
> to me. The only reason I see to go that way is for the sake of consistency.
>

Sorry, I wasn't clear here.

To me this operation seems like a "get format" and I see space for
future implementation of "set format" operations  and also
"enum_formats" to implement format negotiation between bridges...


> > an output formats, and that calls for something that takes that into
> > account, as well as they may have different input ports with different
> > accepted formats but I would for now simplify this to just 'g_fmt()'
>
> You mean rename the function to drm_bridge_g_fmt(), right?

Yeah, something like "drm_bridge_get_format(next_bridge)"

>
> As indicated above, I'm not that fond of it, but don't really care
> either. Maintainers?
>

I do not care much about the name too ofc, I think the real meat is
below...

> >> + * @bridge: bridge control structure
> >> + * @bus_formats: where to store a pointer to the bus input formats
> >> + *
> >> + * Calls the &drm_bridge_funcs.input_formats op for the frist bridge in the
> >> + * chain that has registered this op.
> >
> > I'm not sure passing the call down the pipeline is desirable. Each
> > component should make sure its output format is accepted as the next
> > bridge input format, passing the call to the next bridge is not
> > different that getting to the connector at the end of the pipeline and
> > return to the initial caller its supported format. Do you agree with this?
>
> Not passing down the call does one of two things. Either all bridges have
> to implement the call or all users have to walk the pipeline "manually".
> I don't like either or those options, so I still think it is good to
> pass the call down the pipeline.
>
> *time passes*
>
> Oh, you do not think it is useful for the bridge to have a callback but
> still report "no format change", and that the call down to pipeline
> should only happen for bridges that have not implemented the op. But I
> do think that is useful, see below.
>
> >> + *
> >> + * Note that the bridge passed should normally be the bridge closest to the
> >> + * encoder, but possibly the bridge closest to an intermediate bridge in
> >> + * convoluted cases.
> >> + *
> >
> > As I see this, any bridge in the arbitrary long pipeline should call
> > this operation on next bridge if it supports different output formats.
> > Ie. I would not name here the encoder nor refer to the bridge position
> > in the pipeline.
>
> Ok, I can change that, it just seemed like a convoluted case to me.
> I mean, if this was a real issue and complicated pipelines were
> common, something along the lines of this patch series would be
> available already. Right? I guess not, but how the &#/%# have people
> been coping?
>
> >> + * RETURNS:
> >> + * The number of bus input formats the bridge accepts. Zero means that
> >> + * the chain of bridges are not converting the bus format and that the
> >> + * format of the drm_connector should be used.
> >
> > How do we get to the connector format from a bridge that has maybe
> > other components in between in the pipeline?
> >
> > If a bridge do not report any supported format, it won't implement
> > this callback and things will work as they work today.
>
> Unless the bridge optionally changes the format. If the bridge has no
> way to say "no format change" even with the callback in place, it
> has to juggle different ops structs, which seems like a big hammer.
> So, I'm in favor of calling down the pipeline in two cases. A) when
> a bridge does not implement the op and B) when the op returns zero.
>

Why do you think the bridge format conversion plays a role here?

Maybe here's where I lost you, possibly because of my limited
knowledge of the DRM realm and its actual use cases.

As I see it, this new API allows two bridges to synchronize on which
image format or LVDS mode 'bridge' should output to 'next_bridge'
input.

The "mode_set" callback walks all element of the display pipeline,
and when one component has to select which image format or LVDS mode
to output to its next kin, if the next one is a panel it inspects the
display_info field, it it's a bridge it uses this new API to get the
format it accepts.

If the next bridge does not implement this callback, things work as they
do today (in our specific use case, by chance :)

> Maintainers?
>

Yes, let's scale to more knowledgeable people than me, as I gave my
opinion already but it is based on the single use case I know for
real.

Thanks
   j


> >> + */
> >> +int drm_bridge_input_formats(struct drm_bridge *bridge,
> >> +			     const u32 **bus_formats)
> >> +{
> >> +	int ret = 0;
> >> +
> >> +	if (!bridge)
> >> +		return 0;
> >> +
> >> +	if (bridge->funcs->input_formats)
> >> +		ret = bridge->funcs->input_formats(bridge, bus_formats);
> >> +
> >> +	return ret ?: drm_bridge_input_formats(bridge->next, bus_formats);
> >
> > See my comment on the call propagation down in the pipeline.
> >
> >> +}
> >> +EXPORT_SYMBOL(drm_bridge_input_formats);
> >> +
> >>  #ifdef CONFIG_OF
> >>  /**
> >>   * of_drm_find_bridge - find the bridge corresponding to the device node in
> >> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >> index 682d01ba920c..ae8d3c4af0b8 100644
> >> --- a/include/drm/drm_bridge.h
> >> +++ b/include/drm/drm_bridge.h
> >> @@ -220,6 +220,22 @@ struct drm_bridge_funcs {
> >>  	 * The enable callback is optional.
> >>  	 */
> >>  	void (*enable)(struct drm_bridge *bridge);
> >> +
> >> +	/**
> >> +	 * @input_formats:
> >> +	 *
> >> +	 * The callback reports the expected bus input formats of the bridge.
> >> +	 *
> >> +	 * The @input_formats callback is optional. The bridge is assumed to
> >> +	 * not convert the bus format if the callback is not installed.
> >> +	 *
> >> +	 * RETURNS:
> >> +	 *
> >> +	 * Zero if the bridge does not convert the bus format, otherwise the
> >> +	 * number of bus input formats returned in &bus_formats.
> >> +	 */
> >> +	int (*input_formats)(struct drm_bridge *bridge,
> >> +			     const u32 **bus_formats);
> >
> > Consider g_fmt() here as well, or a function name that captures that we want
> > to know the supported format (and possibly configure it as well one
> > day, if ever possible).
>
> The naming here should obviously follow the naming of the exported function.
>
> Cheers,
> Peter
>
> > Thanks
> >    j
> >
> >>  };
> >>
> >>  /**
> >> @@ -263,6 +279,8 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
> >>  			struct drm_display_mode *adjusted_mode);
> >>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
> >>  void drm_bridge_enable(struct drm_bridge *bridge);
> >> +int drm_bridge_input_formats(struct drm_bridge *bridge,
> >> +			     const u32 **bus_formats);
> >>
> >>  #ifdef CONFIG_DRM_PANEL_BRIDGE
> >>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
> >> --
> >> 2.11.0
> >>
>

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaukDnAAoJEHI0Bo8WoVY8GIsQAIbYIegMNNzAp3+sWdlz8Hum
n+EIkwqj3AVVLdYL4MjX2pbKOcieoVA2nzxR/iYuBkOqN7KfH/zA/48Qb6EtrWm6
cbWB2E/bWcQiDTUw974XhwFY7zgXuRr6WhlVfCA2bWWQck2/0lZLnGmjc5/hBj0d
VK013PHZchN3TXSmQbUyUkggNNqoTcKcjFs/hgRfNTaTSnyHc5n1S5BZYquzqHNF
fIybH/Z6CVbQaQMITndGnVAFDVDDXcuYWz20DZKtoA+1aA/xAz3Udt1E2S4jEVZ3
2Zp8Vxgr4tRA3K7z6a87R2mawZTetYLNwFnrfk7dBGdVexLta3WcwQ8OhbZmAKOp
IU2KQZv5qeYpOW8ZI0v8g5iXIZAu7NhFao2/wLA9krtvo6cv8E+m3eBlUdUA1Ppq
P8IdCQOAysCSyizqebsZ8Z7AP/8TZNNT1qq7Ei242CvwJmx5A1Yok2kFAfHpvw0/
QBtlosSS0bnMwSx7WTRHsyr7GOb7SJkEzA0bI3OzhMSgMResuIkvdtZp/6sZ9XcE
hwFUWnMWyfLWto/1Turzg2gk9FimHAs2SWQqbSKtIKlyYLpUO1GYGR7qQjE3JXVj
c2sn2SF9l87KGMG1tUIMGEddXtqh8rZc0veZGd+5C5B/DdgqN4sM5Z1LGKxaqbyr
9dILVWtdqtHmxzxiU6DL
=VaWH
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
