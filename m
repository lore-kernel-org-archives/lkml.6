Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeENQvx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:51:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41462 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeENQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:51:52 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Niklas =?ISO-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, horms@verge.net.au,
        geert@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
Date: Mon, 14 May 2018 19:52:07 +0300
Message-ID: <3200357.ZFfGXgsVol@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180514094900.GF30519@bigcity.dyn.berto.se>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org> <26780153.JLo9OE30iv@avalon> <20180514094900.GF30519@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EGpxCB011898

Hi Niklas,

On Monday, 14 May 2018 12:49:00 EEST Niklas Söderlund wrote:
> On 2018-05-14 05:49:41 +0300, Laurent Pinchart wrote:
> 
> [snip]
> 
> >>> +&vin4 {
> >>> +	pinctrl-0 = <&vin4_pins>;
> >>> +	pinctrl-names = "default";
> >>> +
> >>> +	status = "okay";
> >>> +
> >>> +	ports {
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <0>;
> >>> +
> >>> +		port@0 {
> >>> +			reg = <0>;
> >>> +			vin4_in: endpoint {
> >>> +				hsync-active = <0>;
> >>> +				vsync-active = <0>;
> >> 
> >> Comparing this to the Gen2 bindings some properties are missing,
> >> 
> >> bus-width = <24>;
> >> pclk-sample = <1>;
> >> data-active = <1>;
> >> 
> >> This is not a big deal as the VIN driver don't use these properties so
> >> no functional change should come of this but still a difference.
> > 
> > I think the VIN DT bindings should be updated to explicitly list the
> > endpoint properties that are mandatory, optional, or not allowed.
> 
> I think it's documented as it reference video-interfaces.txt which lists
> all these properties as optional. And in deed they are all optional.

I don't think that's good enough. They're all listed as optional in video-
interfaces.txt as the generic documentation can't know whether a particular 
device will require a particular property or not. It's the responsibility of 
device DT bindings to refine the bindings description. The VIN DT bindings 
should explicitly list the properties that apply to the VIN and tell whether 
they're optional or mandatory for the VIN. For optional properties, the 
default behaviour when the property is not specified should be documented too.

For instance, does VIN support selecting which pixel clock edge to sample data 
on ? If so the pclk-sample property should listed as either mandatory or 
optional with a documented default, even if not used by the driver today.

> If the VIN driver makes use of all the optional ones is another matter. How
> do we know that the remote subdevice is not looking at its remote
> endpoint for bus parameters not considered by the rcar-vin driver?

No driver should parse properties of remote nodes, as those properties are to 
be interpreted in the context of the remote node's DT bindings, which the 
driver doesn't know about. Parsing OF graph properties (ports and endpoints) 
is an exception, as by connecting a remote node to the local node with OF 
graph properties you imply that the remote node uses OF graph DT bindings, so 
those properties (and only those properties) can be parsed.

> The thing is that the rcar-vin driver only looks at the remote endpoint
> for these properties and ignores the on its local endpoint. Maybe some
> v4l2 framework change is needed here to make sure the bus properties are
> the same on both endpoints of a link. But I fear such a change would
> break a lot of stuff.

Properties are specified on both endpoints to account for components such as 
inverter gates between the two devices. They can thus be different on the two 
sides, that's perfectly valid. The VIN driver should parse its local 
properties, not the remote properties.

-- 
Regards,

Laurent Pinchart
