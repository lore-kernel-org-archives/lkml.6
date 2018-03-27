Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeC0IQI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:16:08 -0400
Received: from relay0.mail.gandi.net ([217.70.178.220]:36293 "EHLO
        relay0-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751001AbeC0IQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:16:06 -0400
X-Originating-IP: 2.224.242.101
Date: Tue, 27 Mar 2018 10:16:01 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Peter Rosin <peda@axentia.se>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [RFC PATCH 2/3] drm: bridge: panel: allow override of the bus
 format
Message-ID: <20180327081601.GJ27746@w540>
References: <20180317221525.18534-1-peda@axentia.se>
 <7015227.p44CVkfgjM@avalon>
 <e0f5d89d-83ee-31ae-0b48-e34fe94883c5@axentia.se>
 <1986009.iWteaM7My3@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <1986009.iWteaM7My3@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

HI Laurent, Peter,

On Mon, Mar 26, 2018 at 10:03:31PM +0300, Laurent Pinchart wrote:
> Hi Peter,
>
> (CC'ing Jacopo Mondi)
>
> On Sunday, 25 March 2018 15:01:11 EEST Peter Rosin wrote:
> > On 2018-03-20 14:56, Laurent Pinchart wrote:
> > > Hi Peter,
> > >
> > > Thank you for the patch.
> > >
> > > On Sunday, 18 March 2018 00:15:24 EET Peter Rosin wrote:
> > >> Useful if the bridge does some kind of conversion of the bus format.
> > >>
> > >> Signed-off-by: Peter Rosin <peda@axentia.se>
> > >> ---
> > >>
> > >>  drivers/gpu/drm/bridge/panel.c | 22 +++++++++++++++++++++-
> > >>  include/drm/drm_bridge.h       |  1 +
> > >>  2 files changed, 22 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/bridge/panel.c
> > >> b/drivers/gpu/drm/bridge/panel.c index 6d99d4a3beb3..ccef0283ff41 100644
> > >> --- a/drivers/gpu/drm/bridge/panel.c
> > >> +++ b/drivers/gpu/drm/bridge/panel.c
> > >> @@ -22,6 +22,7 @@ struct panel_bridge {
> > >>  	struct drm_connector connector;
> > >>  	struct drm_panel *panel;
> > >>  	u32 connector_type;
> > >> +	u32 bus_format;
> > >>  };
> > >>
> > >>  static inline struct panel_bridge *
> > >> @@ -40,8 +41,15 @@ static int panel_bridge_connector_get_modes(struct
> > >> drm_connector *connector) {
> > >>  	struct panel_bridge *panel_bridge =
> > >>  		drm_connector_to_panel_bridge(connector);
> > >>
> > >> +	int ret;
> > >> +
> > >> +	ret = drm_panel_get_modes(panel_bridge->panel);
> > >> +
> > >> +	if (panel_bridge->bus_format)
> > >> +		drm_display_info_set_bus_formats(&connector->display_info,
> > >> +						 &panel_bridge->bus_format, 1);
> > >
> > > While I agree with the problem statement and, to some extent, the DT
> > > bindings, I don't think this is the right implementation. You've
> > > correctly noted that display controller shouldn't blindly use the formats
> > > reported by the panel through the connector formats, and that hacking the
> > > panel driver to override the formats isn't a good idea, so I wouldn't
> > > override the formats reported by the connector. I would instead extend
> > > the drm_bridge API to report formats at bridge inputs. This would be more
> > > generic and allow each bridge to configure itself according to the next
> > > bridge in the chain.
> > >
> > > I'm not sure whether this API extension should be in the form of a new
> > > bridge function, or if the formats should be stored in the drm_bridge
> > > structure directly as done for connectors in the display info structure.
> > > I'm tempted by the former, but I'm open to discussions.
> >
> > Ok, I can look into that, but let me check if I got this right. From the
> > very little of the code that I have looked at, I have gathered that display
> > controllers handle bridges explicitly, right?
>
> That's correct, yes. Or, rather, they handle the first bridge in the chain,
> and then other bridges are handled recursively.
>
> > If so, by extending the bridge (with either a new function or new data) you
> > impose changes to all display controllers wanting to handle this new bridge
> > input-format. If so, I assume I can leave out the changes to all display
> > controllers that I do not care about. Correct?
>
> That's correct.
>
> > Also, don't hold your breath waiting for a v2, but I'll try to get to it :-)
>
> I won't hold my breath, but Jacopo might :-) He has a similar issue to solve
> (reporting the LVDS modes supported by the bridge).
>

I was not :) I jumped late on this, as I restarted the DRM bridge work
yesterday. Peter, can I summarize you my current use case? (which is
quite similar to yours actually)

At the R-Car DU (Display Unit) output, we have an LVDS encoder
connected to a 'transparent' LVDS bridge that converts the input LVDS
stream into digital RGB output to be then HDMI encoded by another
component.

The 'transparent LVDS decoder', for which I'm now writing a driver,
should report what pixel bus format it accepts as input as the DU LVDS
encoder can output an LVDS stream with several different component ordering
schemes. I was about to come up with a proposal last week but you beat
me at time, so I'm happy to base my work on what comes out from this
series.

---- Laurent: On the THC63LVD driver
Laurent: at the same time I would not block the THC63LVD1024 driver. I
can extend bindings to include the "mode map" configuration property,
and squash my Eagle DTS patch on top of Niklas' one. Then make the newly
introduced driver use whatever API comes out from this series with an
incremental patch. Does this work for you? It is true, though, that
we're anyway late for v4.17 and I could send one single series based
on some future version of this and that includes all (bridge driver
and bindings, DU LVDS changes and Eagle DTS), but I feel it's easier
if we got the bridge driver accepted first, and then develop on top of
that.

Thanks
   j

> > >> -	return drm_panel_get_modes(panel_bridge->panel);
> > >> +	return ret;
> > >>  }
> > >>
> > >>  static const struct drm_connector_helper_funcs
> > >> @@ -203,6 +211,18 @@ void drm_panel_bridge_remove(struct drm_bridge
> > >> *bridge)
> > >>  }
> > >>  EXPORT_SYMBOL(drm_panel_bridge_remove);
> > >>
> > >> +void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32
> > >> bus_format)
> > >> +{
> > >> +	struct panel_bridge *panel_bridge;
> > >> +
> > >> +	if (!bridge)
> > >> +		return;
> > >> +
> > >> +	panel_bridge = drm_bridge_to_panel_bridge(bridge);
> > >> +	panel_bridge->bus_format = bus_format;
> > >> +}
> > >> +EXPORT_SYMBOL(drm_panel_bridge_set_bus_format);
> > >> +
> > >>  static void devm_drm_panel_bridge_release(struct device *dev, void *res)
> > >>  {
> > >>  	struct drm_bridge **bridge = res;
> > >> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > >> index 682d01ba920c..81903b92f187 100644
> > >> --- a/include/drm/drm_bridge.h
> > >> +++ b/include/drm/drm_bridge.h
> > >> @@ -268,6 +268,7 @@ void drm_bridge_enable(struct drm_bridge *bridge);
> > >>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
> > >>  					u32 connector_type);
> > >>  void drm_panel_bridge_remove(struct drm_bridge *bridge);
> > >> +void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32
> > >> bus_format);
> > >> struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
> > >>  					     struct drm_panel *panel,
> > >>  					     u32 connector_type);
>
> --
> Regards,
>
> Laurent Pinchart
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJauf3BAAoJEHI0Bo8WoVY8gv8P/0eHdrwnTh5H7RFmvDv6TaUX
oaxlYw+BEgn6iGtpjiCDWH5LRzOHaEKiGbDuyzUM0nPql2UmJQpL4qkLaldEUn5h
Bj/o2ogAQcqM+OhRTzyNCPT8Rc/kh5LLNbxqUA4TYYbPBTjJfqvRUlCRhitutyO6
YVkiKKclYHi36BE5IJRM7PaXz2oVZZZMVRtzGY/w+7iQFt+AoEHsT8gXvLNUakzV
hhdLln/nWoQvtCIlwkPn/azNTCZZR6p05Q081m6HJ1JFom87fyKq8Q3exIXmHInA
XpS9EFS7pvi4ePiTqBvdkciieSe6XpiwuHaScqSiF7TDeRuXat6N65MVDr7zbm9g
Ynm7ZbuEy8MvzqOobLRbNLoMyL6MXdosXjDKlgWihXjnwFWmsUwG1WNhRbVFBWvv
UiZdkcL56XodgkFx1B2atFYvjtX5pyVnCpcz56mgiUvhYdumS3FQ2SmnTPcheRAh
xHVOo8d49V+s2df04zvMYOnUzR4de9SFV6pxyJmEEI/ZclB+duobkHAi1A6hBMQa
kijXstBofIKOOhRMcS6nzksNceymqgZLJwOg8wlV6kq0Qyoi0eOXaSli/AO0JBlU
pWorOrToSCFlRdhMQ7D4XFz/nZD83xACVXv5tHhFAf9IwknEa586dbPKQGyU8+vM
RU4rx+/Y55kRIlyXmXio
=694M
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
