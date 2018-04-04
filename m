Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDDNHe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:07:34 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:46042 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeDDNHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:07:30 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] drm: bridge: add API to query the expected input formats of bridges
Date: Wed, 04 Apr 2018 16:07:37 +0300
Message-ID: <1811029.jLvDxETu2H@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180327130231.GO27746@w540>
References: <20180326212447.7380-1-peda@axentia.se> <fcc47402-d758-4062-0565-f5977b85b206@axentia.se> <20180327130231.GO27746@w540>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First of all, thank you for the patch. This generates more discussion than I 
had anticipated, which is both good and bad. I'll comment through the e-mail, 
and try to explain both my initial idea, and also where it could lead us.

On Tuesday, 27 March 2018 16:02:31 EEST jacopo mondi wrote:
> On Tue, Mar 27, 2018 at 02:12:42PM +0200, Peter Rosin wrote:
> > On 2018-03-27 11:47, jacopo mondi wrote:
> >> On Mon, Mar 26, 2018 at 11:24:44PM +0200, Peter Rosin wrote:
> >>> Bridges may affect the required bus output format of the encoder, in
> >>> which case it may be wrong to use the output format of the panel or
> >>> connector as is. Add infrastructure to address this problem.
> >> 
> >> Bridges not only affect the format expected by the connector at the
> >> end of the display pipeline, they may perform encoding/decoding
> >> between protocols and their accepted input formats may be unrelated to
> >> the connector at the end of the pipeline as there may an arbitrary
> >> number of bridges in between.
> >> 
> >> Eg.
> >> 
> >> ENCODER                                                CONNECTOR
> >> 
> >> |DU LVDS| ->lvds-> |THC63| ->rgb-> |ADV7511| ->hdmi-> |HDMI connector|
> >> 
> >> The fact that THC63 wants a specific LVDS input format is unrelated to
> >> the format required by the HDMI connector at the end of the pipeline.
> >> 
> >> I would just state here that bridges need a way to report their
> >> accepted media bus formats, and this patch extends the DRM Bridge APIs
> >> to implement that.
> > 
> > Yes, I can add some words, but I would like to clear up the naming
> > before re-spinning.
> > 
> >>> Signed-off-by: Peter Rosin <peda@axentia.se>
> >>> ---
> >>> 
> >>>  drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++++++++
> >>>  include/drm/drm_bridge.h     | 18 ++++++++++++++++++
> >>  2 files changed, 50 insertions(+)
> >>> 
> >>> diff --git a/drivers/gpu/drm/drm_bridge.c
> >>> b/drivers/gpu/drm/drm_bridge.c
> >>> index 1638bfe9627c..f85e61b7416e 100644
> >>> --- a/drivers/gpu/drm/drm_bridge.c
> >>> +++ b/drivers/gpu/drm/drm_bridge.c
> >>> @@ -348,6 +348,38 @@ void drm_bridge_enable(struct drm_bridge *bridge)
> >>> 
> >>>  }
> >>>  EXPORT_SYMBOL(drm_bridge_enable);
> >>> 
> >>> +/**
> >>> + * drm_bridge_input_formats - get the expected bus input format of the
> >>> bridge
> >> 
> >> I may be biased by the V4L2 APIs, but this seems to me very much like
> >> similar to g_fmt/s_fmt callbacks we have there. Bridges have an input
> >> and
> > 
> > g_fmt/s_fmt says nothing to me. Graphics format? Source Format? I have
> > no idea if those guesses are even close? So, that seems like poor naming
> > to me. The only reason I see to go that way is for the sake of
> > consistency.
> 
> Sorry, I wasn't clear here.
> 
> To me this operation seems like a "get format" and I see space for
> future implementation of "set format" operations  and also
> "enum_formats" to implement format negotiation between bridges...

A bit of context is probably needed here to bridge (no pun intended) DRM and 
V4L2.

On the V4L2 side we have an object, named v4l2_subdev, that is analogous to 
drm_bridge. A v4l2_subdev models a component in a video pipeline, using 
abstract operations in a similar fashion to the drm_bridge_funcs. There are, 
however, several major differences between drm_bridge and v4l2_subdev.

drm_bridge models a particular kind of component, namely video encoders, 
decoders or transcoders. A bridge is thus based on the implicit notion of 
having a single input and a single output, neither of them exposed explicitly.

v4l2_subdev models any type of component in a video pipeline and for that 
reason has a variable number of inputs and outputs. The inputs and outputs are 
exposed explicitly through the v4l2_subdev API (in terms of the number of 
inputs/outputs, their type, and how they interact with the v4l2_subdev 
operations).

As drm_bridge models one particular kind of component, the bridge operations 
are tailored to the feature of those components. Not all operations are 
mandatory (pre_enable or post_disable are optional for instance), but they all 
apply to all bridges conceptually.

As v4l2_subdev models any type of component, the subdev operations have to 
support a wide variety of device features. There are thus many more 
operations, and not all of them are applicable to all type of v4l2_subdev. 
Operations that don't make sense for a particular v4l2_subdev instance (think 
about video tuner control for a camera sensor for instance) are simply not 
implemented.

The drm_bridge framework hardcodes an operational model for bridges. 
Operations are called in a particular order on all bridges in a chain. For 
instance the enable operation is called from source to sink (bridge closest to 
the display controller to bridge closest to the connector), while the disable 
operation is called from sink to source.

The v4l2_subdev framework doesn't hardcode an operation model. It is up to the 
top-level V4L2 driver (equivalent to the display controller driver) to call 
subdev operations in order applicable for the use cases it needs to support.

This being said, let's talk about formats. In V4L2 a v4l2_subdev exposes 
operations to explicitly configure formats on all inputs and outputs 
(generically called pads in V4L2). Three operations are supported: .get_fmt() 
to retrieve the current format, .set_fmt() to set a format, and 
enum_mbus_code() and .enum_frame_size() to enumerate supported formats (I 
won't go into details regarding why enumeration is split in two operations, 
that's irrelevant here). It is important to note that format enumeration is 
mostly static (it tells what a v4l2_subdev supports), while get and set 
operations are dynamic (getting and setting, and more generically negotiating, 
formats).

DRM has an API to enumerate the formats supported by connectors (through the 
drm_connector->display_info.bus_formats field). There is no API exposed to 
userspace to pick the desired format, neither at the connector level, or for 
bridges in the pipeline (bridges are not exposed to userspace at all). There 
is also no in-kernel API to enumerate formats supported by bridges or to get/
set a bridge format. Display controller are expected to pick an output format 
suitable for the output pipeline based on the formats supported by the 
connector and the selected display mode, and bridges are expected to just work 
without needing to care about formats.

This model is starting to show its shortcomings now that we need to support 
bridges that convert formats. In Jacopo's case, an LVDS decoder transforms 
LVDS RGB to parallel RGB, and the display controller needs to know which LVDS 
format to output based on what the bridge expects. In Peter's case, an LVDS 
encoder transfer 24-bit RGB to LVDS RGB, but has the LSBs tied to ground on 
the input side, and thus requires the display controller to output RGB565.

Now that we're done with the introduction, let's move on, please see below.

> >> an output formats, and that calls for something that takes that into
> >> account, as well as they may have different input ports with different
> >> accepted formats but I would for now simplify this to just 'g_fmt()'
> > 
> > You mean rename the function to drm_bridge_g_fmt(), right?
> 
> Yeah, something like "drm_bridge_get_format(next_bridge)"
> 
> > As indicated above, I'm not that fond of it, but don't really care
> > either. Maintainers?
> 
> I do not care much about the name too ofc, I think the real meat is
> below...
> 
> >>> + * @bridge: bridge control structure
> >>> + * @bus_formats: where to store a pointer to the bus input formats
> >>> + *
> >>> + * Calls the &drm_bridge_funcs.input_formats op for the frist bridge
> >>> in the
> >>> + * chain that has registered this op.
> >> 
> >> I'm not sure passing the call down the pipeline is desirable. Each
> >> component should make sure its output format is accepted as the next
> >> bridge input format, passing the call to the next bridge is not
> >> different that getting to the connector at the end of the pipeline and
> >> return to the initial caller its supported format. Do you agree with
> >> this?
> > 
> > Not passing down the call does one of two things. Either all bridges have
> > to implement the call or all users have to walk the pipeline "manually".
> > I don't like either or those options, so I still think it is good to
> > pass the call down the pipeline.
> > 
> > *time passes*
> > 
> > Oh, you do not think it is useful for the bridge to have a callback but
> > still report "no format change", and that the call down to pipeline
> > should only happen for bridges that have not implemented the op. But I
> > do think that is useful, see below.
> > 
> >>> + *
> >>> + * Note that the bridge passed should normally be the bridge closest to
> >>> the
> >>> + * encoder, but possibly the bridge closest to an intermediate bridge
> >>> in
> >>> + * convoluted cases.
> >>> + *
> >> 
> >> As I see this, any bridge in the arbitrary long pipeline should call
> >> this operation on next bridge if it supports different output formats.
> >> Ie. I would not name here the encoder nor refer to the bridge position
> >> in the pipeline.
> > 
> > Ok, I can change that, it just seemed like a convoluted case to me.
> > I mean, if this was a real issue and complicated pipelines were
> > common, something along the lines of this patch series would be
> > available already. Right? I guess not, but how the &#/%# have people
> > been coping?
> > 
> >>> + * RETURNS:
> >>> + * The number of bus input formats the bridge accepts. Zero means that
> >>> + * the chain of bridges are not converting the bus format and that the
> >>> + * format of the drm_connector should be used.
> >> 
> >> How do we get to the connector format from a bridge that has maybe
> >> other components in between in the pipeline?
> >> 
> >> If a bridge do not report any supported format, it won't implement
> >> this callback and things will work as they work today.
> > 
> > Unless the bridge optionally changes the format. If the bridge has no
> > way to say "no format change" even with the callback in place, it
> > has to juggle different ops structs, which seems like a big hammer.
> > So, I'm in favor of calling down the pipeline in two cases. A) when
> > a bridge does not implement the op and B) when the op returns zero.
> 
> Why do you think the bridge format conversion plays a role here?
> 
> Maybe here's where I lost you, possibly because of my limited
> knowledge of the DRM realm and its actual use cases.
> 
> As I see it, this new API allows two bridges to synchronize on which
> image format or LVDS mode 'bridge' should output to 'next_bridge'
> input.
> 
> The "mode_set" callback walks all element of the display pipeline,
> and when one component has to select which image format or LVDS mode
> to output to its next kin, if the next one is a panel it inspects the
> display_info field, it it's a bridge it uses this new API to get the
> format it accepts.
> 
> If the next bridge does not implement this callback, things work as they
> do today (in our specific use case, by chance :)
> 
> > Maintainers?
> 
> Yes, let's scale to more knowledgeable people than me, as I gave my
> opinion already but it is based on the single use case I know for
> real.

I think it's important here to take a step back and look where we come from, 
what we need, and where we want to go.

The first part is easy. As explained above, the current state is that we know 
what formats a connector supports, and we have no other API whatsoever, 
neither to userspace or inside the kernel, to handle format in the display 
output pipeline.

What we need is at least static format information. In the two cases described 
above the bridge connected to the display controller output requires a 
specific format (RGB565 for Peter, LVDS JEIDA for Jacopo). There is no need to 
walk to pipeline and query all bridges, we can get the necessary information 
from the first bridge in the chain.

Where we want to go is the real question. We need at least static information, 
so we could expose it through a new bus_formats field in the drm_bridge 
structure, similar to the bus_formats field in the drm_display_info structure. 
This would solve the two problems at hand. However, such a solution wouldn't 
allow us to configure formats through the pipeline, and wouldn't allow us to 
query the format a bridge needs based on the format needed by the next bridge 
in the chain. It would thus be limited to specific cases, and one could argue 
that it would be too limited.

A more generic solution might be better, to support dynamic negotiation of 
formats through the pipeline. I believe this would be needed in the long run 
anyway, so it's tempting to give it a try today. However, as we don't have any 
real use case yet, one might argue that we would design the API incorrectly, 
which I can't completely disagree with. Nonetheless, if we were to design such 
an API, I agree with Daniel that it should be based on bridge states. Such a 
solution would allow negotiation of formats through the pipeline (using a yet 
to be designed process), and would then allow the display controller to 
retrieve the negotiated format expected by the first bridge from the bridge 
state.

I don't think we would design the API between the display controller and the 
first bridge wrong (it would just be a matter of reading the negotiated format 
from the first bridge's state, there's little room for design issues there), 
but the format negotiation through the pipeline would need more thoughts. One 
option (just thinking out loud) would be to start with the connector format, 
and then ask each bridge in the chain, from last to first, for the input 
format it needs to generate the expected output format. More complex schemes 
might be needed, especially when the connector supports multiple formats, or 
when a bridge can accept multiple input formats to generate a given output 
format. In those cases picking the first supported format could work, but it 
might not always lead to the optimal pipeline configuration.

Another point I want to mention is that in Peter's case the LVDS encoder 
requires RGB888 at its input, but the PCB routing transforms RGB565 to RGB888 
by shifting signals and tying the LSBs to ground. That information really 
belongs to DT as it isn't intrinsic to either the display controller or the 
LVDS encoder. I however wonder whether it should be expressed as a format, or 
in a different form. In V4L2 we have standardized bus-width and data-shift DT 
properties (see Documentation/devicetree/bindings/media/video-interfaces.txt) 
to expose how signals are connected in the PCB. This allows expressing 
transformations instead of hardcoding formats, which can be useful if the 
bridge can still accept multiple input formats. One example of this is raw 
camera sensors that can output multiple bayer patterns (BGGR, GBRG, GRBG or 
RGGB) with 10 bits per pixel, combined with a PCB that connects D[9:2] of the 
sensor to D[7:0] of the camera controller. BGGR10 would be turned into BGGR8, 
GBRG10 into GBRG8, and so on. The camera controller should thus not hardcode a 
particular format in DT as there are multiple options that can be selected at 
runtime. I can imagine a similar setup for the display, with a bridge 
configurable through I2C that could accept different formats, combined with 
the PCB performing some weird routing.

Finally, still regarding Peter's case, the decision to output RGB565 instead 
of RGB888 (which the LVDS encoder expects) is due to PCB routing between the 
display controller and the LVDS encoder. This isn't a property of the LVDS 
encoder or the display controller, but of their hardware connection. This 
patch series uses a DT property in the LVDS encoder DT node to convey that 
information, but wouldn't it be equally correct (or incorrect :-)) to instead 
use a DT property in the display controller DT node ?

> >>> + */
> >>> +int drm_bridge_input_formats(struct drm_bridge *bridge,
> >>> +			     const u32 **bus_formats)
> >>> +{
> >>> +	int ret = 0;
> >>> +
> >>> +	if (!bridge)
> >>> +		return 0;
> >>> +
> >>> +	if (bridge->funcs->input_formats)
> >>> +		ret = bridge->funcs->input_formats(bridge, bus_formats);
> >>> +
> >>> +	return ret ?: drm_bridge_input_formats(bridge->next, bus_formats);
> >> 
> >> See my comment on the call propagation down in the pipeline.
> >> 
> >>> +}
> >>> +EXPORT_SYMBOL(drm_bridge_input_formats);
> >>> +
> >>>  #ifdef CONFIG_OF
> >>>  /**
> >>>   * of_drm_find_bridge - find the bridge corresponding to the device
> >>>   node in
> >>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> >>> index 682d01ba920c..ae8d3c4af0b8 100644
> >>> --- a/include/drm/drm_bridge.h
> >>> +++ b/include/drm/drm_bridge.h
> >>> @@ -220,6 +220,22 @@ struct drm_bridge_funcs {
> >>>  	 * The enable callback is optional.
> >>>  	 */
> >>>  	void (*enable)(struct drm_bridge *bridge);
> >>> +
> >>> +	/**
> >>> +	 * @input_formats:
> >>> +	 *
> >>> +	 * The callback reports the expected bus input formats of the
> >>> bridge.
> >>> +	 *
> >>> +	 * The @input_formats callback is optional. The bridge is assumed to
> >>> +	 * not convert the bus format if the callback is not installed.
> >>> +	 *
> >>> +	 * RETURNS:
> >>> +	 *
> >>> +	 * Zero if the bridge does not convert the bus format, otherwise the
> >>> +	 * number of bus input formats returned in &bus_formats.
> >>> +	 */
> >>> +	int (*input_formats)(struct drm_bridge *bridge,
> >>> +			     const u32 **bus_formats);
> >> 
> >> Consider g_fmt() here as well, or a function name that captures that we
> >> want to know the supported format (and possibly configure it as well
> >> one day, if ever possible).
> > 
> > The naming here should obviously follow the naming of the exported
> > function.
> > 
> >>>  };
> >>>  
> >>>  /**
> >>> @@ -263,6 +279,8 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
> >>>  			struct drm_display_mode *adjusted_mode);
> >>>  void drm_bridge_pre_enable(struct drm_bridge *bridge);
> >>>  void drm_bridge_enable(struct drm_bridge *bridge);
> >>> +int drm_bridge_input_formats(struct drm_bridge *bridge,
> >>> +			     const u32 **bus_formats);
> >>> 
> >>>  #ifdef CONFIG_DRM_PANEL_BRIDGE
> >>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,

-- 
Regards,

Laurent Pinchart
