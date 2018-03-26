Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeCZTDg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:03:36 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:44866 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZTDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:03:34 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [RFC PATCH 2/3] drm: bridge: panel: allow override of the bus format
Date: Mon, 26 Mar 2018 22:03:31 +0300
Message-ID: <1986009.iWteaM7My3@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <e0f5d89d-83ee-31ae-0b48-e34fe94883c5@axentia.se>
References: <20180317221525.18534-1-peda@axentia.se> <7015227.p44CVkfgjM@avalon> <e0f5d89d-83ee-31ae-0b48-e34fe94883c5@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

(CC'ing Jacopo Mondi)

On Sunday, 25 March 2018 15:01:11 EEST Peter Rosin wrote:
> On 2018-03-20 14:56, Laurent Pinchart wrote:
> > Hi Peter,
> > 
> > Thank you for the patch.
> > 
> > On Sunday, 18 March 2018 00:15:24 EET Peter Rosin wrote:
> >> Useful if the bridge does some kind of conversion of the bus format.
> >> 
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >> 
> >>  drivers/gpu/drm/bridge/panel.c | 22 +++++++++++++++++++++-
> >>  include/drm/drm_bridge.h       |  1 +
> >>  2 files changed, 22 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/panel.c
> >> b/drivers/gpu/drm/bridge/panel.c index 6d99d4a3beb3..ccef0283ff41 100644
> >> --- a/drivers/gpu/drm/bridge/panel.c
> >> +++ b/drivers/gpu/drm/bridge/panel.c
> >> @@ -22,6 +22,7 @@ struct panel_bridge {
> >>  	struct drm_connector connector;
> >>  	struct drm_panel *panel;
> >>  	u32 connector_type;
> >> +	u32 bus_format;
> >>  };
> >>  
> >>  static inline struct panel_bridge *
> >> @@ -40,8 +41,15 @@ static int panel_bridge_connector_get_modes(struct
> >> drm_connector *connector) {
> >>  	struct panel_bridge *panel_bridge =
> >>  		drm_connector_to_panel_bridge(connector);
> >> 
> >> +	int ret;
> >> +
> >> +	ret = drm_panel_get_modes(panel_bridge->panel);
> >> +
> >> +	if (panel_bridge->bus_format)
> >> +		drm_display_info_set_bus_formats(&connector->display_info,
> >> +						 &panel_bridge->bus_format, 1);
> > 
> > While I agree with the problem statement and, to some extent, the DT
> > bindings, I don't think this is the right implementation. You've
> > correctly noted that display controller shouldn't blindly use the formats
> > reported by the panel through the connector formats, and that hacking the
> > panel driver to override the formats isn't a good idea, so I wouldn't
> > override the formats reported by the connector. I would instead extend
> > the drm_bridge API to report formats at bridge inputs. This would be more
> > generic and allow each bridge to configure itself according to the next
> > bridge in the chain.
> > 
> > I'm not sure whether this API extension should be in the form of a new
> > bridge function, or if the formats should be stored in the drm_bridge
> > structure directly as done for connectors in the display info structure.
> > I'm tempted by the former, but I'm open to discussions.
> 
> Ok, I can look into that, but let me check if I got this right. From the
> very little of the code that I have looked at, I have gathered that display
> controllers handle bridges explicitly, right?

That's correct, yes. Or, rather, they handle the first bridge in the chain, 
and then other bridges are handled recursively.

> If so, by extending the bridge (with either a new function or new data) you
> impose changes to all display controllers wanting to handle this new bridge
> input-format. If so, I assume I can leave out the changes to all display
> controllers that I do not care about. Correct?

That's correct.

> Also, don't hold your breath waiting for a v2, but I'll try to get to it :-)

I won't hold my breath, but Jacopo might :-) He has a similar issue to solve 
(reporting the LVDS modes supported by the bridge).

> >> -	return drm_panel_get_modes(panel_bridge->panel);
> >> +	return ret;
> >>  }
> >>  
> >>  static const struct drm_connector_helper_funcs
> >> @@ -203,6 +211,18 @@ void drm_panel_bridge_remove(struct drm_bridge
> >> *bridge)
> >>  }
> >>  EXPORT_SYMBOL(drm_panel_bridge_remove);
> >> 
> >> +void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32
> >> bus_format)
> >> +{
> >> +	struct panel_bridge *panel_bridge;
> >> +
> >> +	if (!bridge)
> >> +		return;
> >> +
> >> +	panel_bridge = drm_bridge_to_panel_bridge(bridge);
> >> +	panel_bridge->bus_format = bus_format;
> >> +}
> >> +EXPORT_SYMBOL(drm_panel_bridge_set_bus_format);
> >> +
> >>  static void devm_drm_panel_bridge_release(struct device *dev, void *res)
> >>  {
> >>  	struct drm_bridge **bridge = res;
> >> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >> index 682d01ba920c..81903b92f187 100644
> >> --- a/include/drm/drm_bridge.h
> >> +++ b/include/drm/drm_bridge.h
> >> @@ -268,6 +268,7 @@ void drm_bridge_enable(struct drm_bridge *bridge);
> >>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
> >>  					u32 connector_type);
> >>  void drm_panel_bridge_remove(struct drm_bridge *bridge);
> >> +void drm_panel_bridge_set_bus_format(struct drm_bridge *bridge, u32
> >> bus_format);
> >> struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
> >>  					     struct drm_panel *panel,
> >>  					     u32 connector_type);

-- 
Regards,

Laurent Pinchart
