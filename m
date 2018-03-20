Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeCTMSq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:18:46 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:33589 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeCTMSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:18:42 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Archit Taneja <architt@codeaurora.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, a.hajda@samsung.com,
        airlied@linux.ie, horms@verge.net.au, magnus.damm@gmail.com,
        geert@linux-m68k.org, niklas.soderlund@ragnatech.se,
        sergei.shtylyov@cogentembedded.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm: Add LVDS decoder bridge
Date: Tue, 20 Mar 2018 14:19:47 +0200
Message-ID: <2410970.hS6IIXmmEj@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180310180031.GJ4023@w540>
References: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org> <b0eec899-424f-f71d-8c1f-9ff8f0211f7f@codeaurora.org> <20180310180031.GJ4023@w540>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Saturday, 10 March 2018 20:00:31 EET jacopo mondi wrote:
> On Sat, Mar 10, 2018 at 11:23:19AM +0530, Archit Taneja wrote:
> > On Friday 09 March 2018 07:21 PM, Jacopo Mondi wrote:
> > > Hello,
> > >
> > > after some discussion on the proposed bindings for generic lvds
> > > decoder and Thine THC63LVD1024, I decided to drop the THC63 specific
> > > part and just live with a transparent decoder that does not support any
> > > configuration from DT.
> > >
> > > Dropping THC63 support to avoid discussion on how to better implement
> > > support for a DRM bridge with 2 input ports and focus on LVDS mode
> > > propagation through bridges as explained in v1 cover letter (for DRM
> > > people: please see [1] as why I find difficult to implement support for
> > > bridges with multiple input endpoints)
> > >
> > > Same base branch as v1, with same patches for V3M Eagle applied on top.
> > > git://jmondi.org/linux v3m/v4.16-rc3/base
> > >
> > > Thanks
> > >
> > >    j
> > >
> > > v1 -> v2:
> > > - Drop support for THC63LVD1024
> > >
> > > [1] I had a quick at how to model a DRM bridge with multiple input
> > > ports, and I see a blocker in how DRM identifies and matches bridges
> > > using the devices node in place of the endpoint nodes.
> > >
> > > As THC63LVD1024 supports up to 2 LVDS inputs and 2 LVDS outputs, I see
> > > only a few ways to support that:
> > > 
> > >  1) register 2 drm bridges from the same driver (one for each
> > >     input/output pair) but they would both be matches on the same device
> > >     node when the preceding bridge calls "of_drm_find_bridge()".
> > 
> > I think this is the way to go. DRM doesn't say anywhere that we can't have
> > 2 drm_bridge-s contained in a single device.

I agree, but it only works as long as the two bridges are independent. The 
THC63LVD1024 can also work in single-in, dual-out and dual-in, single-out 
modes, in which case we will need a more generic solution. I'm fine ignoring 
the problem on the driver side for now until someone needs to support such a 
setup, but the DT bindings need to be right.

> > About the issue with
> > of_drm_find_bridge(), if you set the 2 bridge's 'of_node' field to
> > the bridge1 and bridge2 nodes as shown below, wouldn't that suffice. From
> > what I know, we don't necessarily need to set the bridge's of_node
> > to the device (i.e, thschip) itself.
> 
> That's fine, but this implies that the preceding bridge (or encoder) in the
> DRM pipeline has then to collect the "port" node and match on it
> specifically when it attaches this driver. This introduces an ad-hoc
> policy that prevents this driver from being easily integrated in
> existing pipelines (where bridges are matched on the device node).
> 
> Also, I don't know much about the DRM framework, but it seems to me
> that the helper function designed to find the next component to attach
> to in the DRM pipeline is:
> 
> drm_of_find_panel_or_bridge():
>         remote = of_graph_get_remote_node();
>                 ep = of_graph_get_endpoint_by_regs();
>                 return of_graph_get_remote_port_parent();  <-- This returns
> the device node of_drm_find_panel(remote);
>         of_drm_find_bridge(remote);
> 
> I so dare to say matching on device node is kind of the intended way
> to do things in DRM, and this driver with two endpoints that wants to
> be matched on port nodes would be kind of special one that does not
> work as other driver expects to.
> 
> Is my understanding correct, or have I misinterpreted something?

I agree with you, so I hope your understanding is correct :-) We have the 
exact same issue in V4L2 where we used to always match on the device node, but 
recently the ADV7482 required matching on port nodes. The solution that was 
proposed was to support matching on both the device node and the port nodes, 
with automatic lookup of the device node from the port node if no direct match 
is found. I think this would work well in DRM too. Regardless of what we 
decide to do, we need to ensure that we don't create two separate categories 
of bridges with different matching rules that won't be compatible.

> > thschip {
> > 	...
> > 	ports {
> > 		bridge1: port@0 {
> > 			...
> > 		};
> > 		bridge2: port@1 {
> > 			...
> > 		};
> > 	};
> > };
> > 
> > >  2) register a single bridge with multiple "next bridges", but when the
> > >     bridge gets attached I don't see a way on how to identify on which
> > >     next bridge "drm_bridge_attach()" on, as it depends on the endpoint
> > >     the current bridge has been attached on first, and we don't have
> > >     that information.

For the general case I think we'll need to start adding port index arguments 
to the bridge API, but as stated above I'm fine ignoring this for now and 
creating two bridges.

> > >  3) Register more instances of the same chip in DTS, one for each
> > >     input/output pair. They gonna share supplies and gpios, and I don't
> > >     like that.

I don't think this is a good idea.

> > > I had a quick look at the currently in mainline bridges and none of them
> > > has multiple input endpoints, except for HDMI audio endpoint, which I
> > > haven't found in use in any DTS. I guess the problem has been already
> > > debated and maybe solved in the past, so feel free to point me to other
> > > sources.
> > >
> > > Jacopo Mondi (3):
> > >   dt-bindings: display: bridge: Document LVDS to parallel decoder
> > >   drm: bridge: Add LVDS decoder driver
> > >   arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
> > >  
> > >  .../bindings/display/bridge/lvds-decoder.txt       |  42 ++++++
> > >  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 +++-
> > >  drivers/gpu/drm/bridge/Kconfig                     |   8 ++
> > >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> > >  drivers/gpu/drm/bridge/lvds-decoder.c              | 157 ++++++++++++++
> > >  5 files changed, 237 insertions(+), 2 deletions(-)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/display/bridge/lvds-decoder.txt
> > >  create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c

-- 
Regards,

Laurent Pinchart
