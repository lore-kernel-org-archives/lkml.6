Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeCJSAl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:00:41 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48084 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeCJSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:00:40 -0500
Date: Sat, 10 Mar 2018 19:00:31 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Archit Taneja <architt@codeaurora.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm: Add LVDS decoder bridge
Message-ID: <20180310180031.GJ4023@w540>
References: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
 <b0eec899-424f-f71d-8c1f-9ff8f0211f7f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0eec899-424f-f71d-8c1f-9ff8f0211f7f@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Archit,

On Sat, Mar 10, 2018 at 11:23:19AM +0530, Archit Taneja wrote:
> Hi,
>
> On Friday 09 March 2018 07:21 PM, Jacopo Mondi wrote:
> >Hello,
> >    after some discussion on the proposed bindings for generic lvds decoder and
> >Thine THC63LVD1024, I decided to drop the THC63 specific part and just live with
> >a transparent decoder that does not support any configuration from DT.
> >
> >Dropping THC63 support to avoid discussion on how to better implement support
> >for a DRM bridge with 2 input ports and focus on LVDS mode propagation through
> >bridges as explained in v1 cover letter (for DRM people: please see [1] as why
> >I find difficult to implement support for bridges with multiple input endpoints)
> >
> >Same base branch as v1, with same patches for V3M Eagle applied on top.
> >git://jmondi.org/linux v3m/v4.16-rc3/base
> >
> >Thanks
> >    j
> >
> >v1 -> v2:
> >- Drop support for THC63LVD1024
> >
> >[1] I had a quick at how to model a DRM bridge with multiple input
> >ports, and I see a blocker in how DRM identifies and matches bridges using
> >the devices node in place of the endpoint nodes.
> >
> >As THC63LVD1024 supports up to 2 LVDS inputs and 2 LVDS outputs, I see only
> >a few ways to support that:
> >  1) register 2 drm bridges from the same driver (one for each input/output pair)
> >     but they would both be matches on the same device node when the preceding
> >     bridge calls "of_drm_find_bridge()".
>
> I think this is the way to go. DRM doesn't say anywhere that we can't have 2
> drm_bridge-s contained in a single device. About the issue with
> of_drm_find_bridge(), if you set the 2 bridge's 'of_node' field to
> the bridge1 and bridge2 nodes as shown below, wouldn't that suffice. From
> what I know, we don't necessarily need to set the bridge's of_node
> to the device (i.e, thschip) itself.

That's fine, but this implies that the preceding bridge (or encoder) in the
DRM pipeline has then to collect the "port" node and match on it
specifically when it attaches this driver. This introduces an ad-hoc
policy that prevents this driver from being easily integrated in
existing pipelines (where bridges are matched on the device node).

Also, I don't know much about the DRM framework, but it seems to me
that the helper function designed to find the next component to attach
to in the DRM pipeline is:

drm_of_find_panel_or_bridge():
        remote = of_graph_get_remote_node();
                ep = of_graph_get_endpoint_by_regs();
                return of_graph_get_remote_port_parent();  <-- This returns the device node
        of_drm_find_panel(remote);
        of_drm_find_bridge(remote);

I so dare to say matching on device node is kind of the intended way
to do things in DRM, and this driver with two endpoints that wants to
be matched on port nodes would be kind of special one that does not
work as other driver expects to.

Is my understanding correct, or have I misinterpreted something?

Thanks
   j

>
> thschip {
> 	...
> 	ports {
> 		bridge1: port@0 {
> 			...
> 		};
>
> 		bridge2: port@1 {
> 			...
> 		};
> 	};
> };
>
>
> Thanks,
> Archit
>
> >  2) register a single bridge with multiple "next bridges", but when the bridge
> >     gets attached I don't see a way on how to identify on which next bridge
> >     "drm_bridge_attach()" on, as it depends on the endpoint the current bridge
> >     has been attached on first, and we don't have that information.
> >  3) Register more instances of the same chip in DTS, one for each input/output
> >     pair. They gonna share supplies and gpios, and I don't like that.
> >
> >I had a quick look at the currently in mainline bridges and none of them has
> >multiple input endpoints, except for HDMI audio endpoint, which I haven't found
> >in use in any DTS. I guess the problem has been already debated and maybe solved
> >in the past, so feel free to point me to other sources.
> >
> >Jacopo Mondi (3):
> >   dt-bindings: display: bridge: Document LVDS to parallel decoder
> >   drm: bridge: Add LVDS decoder driver
> >   arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
> >
> >  .../bindings/display/bridge/lvds-decoder.txt       |  42 ++++++
> >  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 +++-
> >  drivers/gpu/drm/bridge/Kconfig                     |   8 ++
> >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> >  drivers/gpu/drm/bridge/lvds-decoder.c              | 157 +++++++++++++++++++++
> >  5 files changed, 237 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/lvds-decoder.txt
> >  create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c
> >
> >--
> >2.7.4
> >
