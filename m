Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeE3Mf7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:35:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51652 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbeE3Mf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:35:57 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Maciej Purski <m.purski@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 07/12] dt-bindings: tc358754: add DT bindings
Date: Wed, 30 May 2018 15:35:58 +0300
Message-ID: <1928297.lKUBOH9NhR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180530095915eucas1p27f09c8424d0c3c0619d134c5e7319fa3~zY7uP6Y6R1391213912eucas1p23@eucas1p2.samsung.com>
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com> <2275901.CJI6BsfBlP@avalon> <20180530095915eucas1p27f09c8424d0c3c0619d134c5e7319fa3~zY7uP6Y6R1391213912eucas1p23@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Wednesday, 30 May 2018 12:59:12 EEST Andrzej Hajda wrote:
> On 28.05.2018 12:18, Laurent Pinchart wrote:
> > On Monday, 28 May 2018 12:47:11 EEST Maciej Purski wrote:
> >> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
> >> Bindings describe power supplies, reset gpio and video interfaces.
> >> 
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> >> ---
> >> 
> >>  .../bindings/display/bridge/toshiba,tc358764.txt   | 42 ++++++++++++++++
> >>  1 file changed, 42 insertions(+)
> >>  create mode 100644
> >> 
> >> Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> >> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> >> new
> >> file mode 100644
> >> index 0000000..d09bdc2
> >> --- /dev/null
> >> +++
> >> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
> >> @@ -0,0 +1,42 @@
> >> +TC358764 MIPI-DSI to LVDS panel bridge
> >> +
> >> +Required properties:
> >> +  - compatible: "toshiba,tc358764"
> >> +  - reg: the virtual channel number of a DSI peripheral
> >> +  - vddc-supply: core voltage supply
> >> +  - vddio-supply: I/O voltage supply
> >> +  - vddmipi-supply: MIPI voltage supply
> >> +  - vddlvds133-supply: LVDS1 3.3V voltage supply
> >> +  - vddlvds112-supply: LVDS1 1.2V voltage supply
> > 
> > That's a lot of power supplies. Could some of them be merged together ?
> > See https://patchwork.freedesktop.org/patch/216058/ for an earlier
> > discussion on the same subject.
> 
> Specs says about 3 supply voltage values:
> - 1.2V - digital core, DSI-RX PHY
> - 1.8-3.3V - digital I/O
> - 3.3V - LVDS-TX PHY
> 
> So I guess it should be minimal number of supplies. Natural candidates:
> 
> - vddc-supply: core voltage supply, 1.2V
> - vddio-supply: I/O voltage supply, 1.8V or 3.3V
> - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
> 
> I have changed name of the latest supply to be more consistent with
> other supplies, and changed 1.8-3.3 (which incorrectly suggest voltage
> range), to more precise voltage alternative.

This looks fine to me.

> >> +  - reset-gpios: a GPIO spec for the reset pin
> >> +
> >> +The device node can contain zero to two 'port' child nodes, each with
> >> one
> >> +child
> >> +'endpoint' node, according to the bindings defined in [1].
> >> +The following are properties specific to those nodes.
> >> +
> >> +port:
> >> +  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
> > 
> > This seems pretty vague to me. It could be read as meaning that ports are
> > completely optional, and that the port number you list can be used, but
> > that something else could be used to.
> > 
> > Let's make the port nodes mandatory. I propose the following.
> > 
> > Required nodes:
> > 
> > The TC358764 has DSI and LVDS ports whose connections are described using
> > the OF graph bindings defined in
> > Documentation/devicetree/bindings/graph.txt. The device node must contain
> > one 'port' child node per DSI and LVDS port. The port nodes are numbered
> > as follows.
> > 
> >   Port                  Number
> > -------------------------------------------------------------------
> >   DSI Input             0
> >   LVDS Output           1
> > 
> > Each port node must contain endpoint nodes describing the hardware
> > connections.
> 
> Since the bridge is controlled via DSI bus, DSI input port is not necessary.

I don't agree with this. Regardless of how the bridge is controlled, I think 
we should always use ports to describe the data connections. Otherwise it 
would get more complicated for display controller drivers to use different 
types of bridges.

> >> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> >> +
> >> +Example:
> >> +
> >> +	bridge@0 {
> >> +		reg = <0>;
> >> +		compatible = "toshiba,tc358764";
> >> +		vddc-supply = <&vcc_1v2_reg>;
> >> +		vddio-supply = <&vcc_1v8_reg>;
> >> +		vddmipi-supply = <&vcc_1v2_reg>;
> >> +		vddlvds133-supply = <&vcc_3v3_reg>;
> >> +		vddlvds112-supply = <&vcc_1v2_reg>;
> >> +		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +		port@1 {
> >> +			reg = <1>;
> >> +			lvds_ep: endpoint {
> >> +				remote-endpoint = <&panel_ep>;
> >> +			};
> >> +		};
> >> +	};

-- 
Regards,

Laurent Pinchart
