Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeCIIxf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:53:35 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58591 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeCIIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:53:33 -0500
Date: Fri, 9 Mar 2018 09:53:23 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: Document THC63LVD1024
 LVDS decoder
Message-ID: <20180309085323.GC14819@w540>
References: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
 <CGME20180308152434epcas2p273cdc2c4bfe226a0f3dd55c15993bef5@epcas2p2.samsung.com>
 <1520522643-11756-2-git-send-email-jacopo+renesas@jmondi.org>
 <41900058-274f-c533-f744-17e495a3beb2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41900058-274f-c533-f744-17e495a3beb2@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Fri, Mar 09, 2018 at 09:01:24AM +0100, Andrzej Hajda wrote:
> On 08.03.2018 16:24, Jacopo Mondi wrote:
> > Document Thine THC63LVD1024 LVDS decoder.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  .../bindings/display/bridge/thine,thc63lvd1024.txt | 59 ++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> > new file mode 100644
> > index 0000000..53b6453
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> > @@ -0,0 +1,59 @@
> > +THine Electronics THC63LVD1024 LVDS receiver
> > +--------------------------------------------
> > +
> > +The THC63LVD1024 is an LVDS receiver designed to convert multiple LVDS streams
> > +to digital CMOS/TTL parallel data.
>
>You say multiple streams, but bindings describe only one stream.

I'm always confused by the fact that "bindings should describe
hardware" even when the driver does not support some features the
hardware provides.

In this case, the driver and its bindigns does not expose "MODE1/2"
pins that are used to control single/double stream mode, assuming they
are hard-wired and single/double stream mode is not controllable by
the SoC.

I should have reserved two more ports for one (optional) additional input and
one (optional) additional output, as chip can be configured to work in
that mode even if MODE1/2 are not hardwired.

Will add them in v2.

> > +
> > +Required properties:
> > +- compatible: Shall be one of the following:
> > +  "thine,thc63lvd1024",
> > +  "lvds-decoder"
> > +
> > +Optional properties:
> > +- supply-vcc: Power supply for TTL output and digital circuitry
> > +- supply-cvcc: Power supply for TTL CLOCKOUT signal
> > +- supply-lvcc: Power supply for LVDS inputs
> > +- supply-pvcc: Power supply for PLL circuitry
> > +- pwnd-gpio: Power down GPIO signal. Active low.
>
> Specs [1] uses "/PDWN" name for the pin, moreover gpios suffix is preferred.
>
> Another issue I see is two possibly contradicting conventions:
> 1. Properties should be named according to specs - so here it should be
> named pdwn-gpios.
> 2. The bindings tries to be generic for lvds decoders, in such case
> probably preferred name should be more generic, maybe power-gpios.
>
> Personally I would prefer 1, in such case generic lvds-decoder driver
> should look for gpio names according to compatible string.
>

I will go for 1 and associate the power control gpio name to the
matched compatible string.

"thine,thc63lvd1024" will look for "pwnd-gpios"
"lvds,decoder" will look for "power-gpios"

> [1]: http://www.thine.co.jp/files/topics/179_ext_12_0.pdf
>
> > +- oe-gpio: Output enable GPIO signal. Active high.
>
> oe-gpios
>
> > +
> > +The THC63LVD1024 has two video ports, whose connections are modeled according
> > +to OF graph bindings specified by Documentation/devicetree/bindings/graph.txt
> > +
> > +- Port@0: LVDS input port
> > +- Port@1: Digital CMOS/TTL parallel output
>
> According to specs it has two lvds input and two parallel output ports,
> maybe it would be good to describe all here.

I will in v2.

Thanks
   j

>
> Regards
> Andrzej
>
> > +
> > +Example:
> > +-------
> > +
> > +	lvds_decoder: decoder-0 {
> > +		compatible = "thine,thc63lvd1024";
> > +
> > +		vcc-supply = <&reg_lvds_vcc>;
> > +		lvcc-supply = <&reg_lvds_lvcc>;
> > +
> > +		pwdn-gpio = <&gpio4 15 GPIO_ACTIVE_LOW>;
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> > +
> > +				lvds_dec_in: endpoint {
> > +					remote-endpoint = <&lvds_out>;
> > +				};
> > +			};
> > +
> > +			port@1{
> > +				reg = <1>;
> > +
> > +				lvds_dec_out: endpoint {
> > +					remote-endpoint = <&adv7511_in>;
> > +				};
> > +
> > +			};
> > +
> > +		};
> > +	};
>
>
