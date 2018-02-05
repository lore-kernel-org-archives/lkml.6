Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeBEJLo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:11:44 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45550 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBEJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:11:36 -0500
X-UUID: 309db1e771124bc08ddad7dceadc7bf4-20180205
Message-ID: <1517821892.12510.32.camel@mtkswgap22>
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
From: Ryder Lee <ryder.lee@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>, <linux-kernel@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date: Mon, 5 Feb 2018 17:11:32 +0800
In-Reply-To: <20180205060833.p56dun5i4bvs3jye@rob-hp-laptop>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
         <8651585c91ee40f6ab3e30b893bcfb90fe5c2c25.1515639336.git.ryder.lee@mediatek.com>
         <20180205060833.p56dun5i4bvs3jye@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-05 at 00:08 -0600, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 03:42:44PM +0800, Ryder Lee wrote:
> > As the MediaTek audio hardware block that expose functionalities that are
> > handled by separate subsystems in the kernel, and there are registers that
> > are shared between related drivers.
> > 
> > Switch the current device to an MFD device, add more descriptions about the
> > subsystem and modify example accordingly.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,audsys.txt      | 37 ++++++++++++++++++----
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > index 9b8f578..677af40 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > @@ -1,22 +1,45 @@
> > -MediaTek AUDSYS controller
> > +MediaTek Audio Subsystem
> >  ============================
> > +The audio subsystem is one of the multi-function blocks of MediaTek SoCs.
> > +It contains a system controller, which provides a number registers giving
> > +access to two features: AUDSYS clocks and Audio Front End (AFE) components.
> >  
> > +For the top level node:
> > +- compatible: must be: "syscon", "simple-mfd";
> 
> This should have some SoC specific compatible.

As we don't have a specific driver (compatible string) for it and if we
need to add that I think the term '*-audsys' is very suitable here, but
unfortunately, it has already picked for clock driver (see child node).

I also took ../../marvell/*-system-controller.txt as examples for my
case. Thus, I'm not sure should we still need a new one here?

> > +- reg: register area of the Audio Subsystem
> > +
> > +Required sub-nodes:
> > +
> > +AUDSYS clocks:
> > +-------
> >  The MediaTek AUDSYS controller provides various clocks to the system.
> >  
> >  Required Properties:
> >  
> >  - compatible: Should be one of:
> > -	- "mediatek,mt7622-audsys", "syscon"
> > +	- "mediatek,mt2701-audsys";
> > +	- "mediatek,mt7622-audsys";
> >  - #clock-cells: Must be 1
> >  
> >  The AUDSYS controller uses the common clk binding from
> >  Documentation/devicetree/bindings/clock/clock-bindings.txt
> >  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> 
> There's no register range associated with the clocks? If there is, add a 
> reg property.

No, we don't need reg property here, as the two sub-drivers will obtain
the regmap  which is propagated from the parent.

Thanks

> >  
> > +AFE components:
> > +-------
> > +For common binding part and usage, refer to
> > +../sonud/mt2701-afe-pcm.txt.
> > +
> >  Example:
> >  
> > -audsys: audsys@11220000 {
> > -	compatible = "mediatek,mt7622-audsys", "syscon";
> > -	reg = <0 0x11220000 0 0x1000>;
> > -	#clock-cells = <1>;
> > -};
> > +	audio-subsystem@11220000 {
> > +		compatible = "syscon", "simple-mfd";
> > +		reg = <0 0x11220000 0 0x2000>;
> > +
> > +		audsys: clock {
> > +			compatible = "mediatek,mt2701-audsys";
> > +			#clock-cells = <1>;
> > +		};
> > +
> > +		...
> > +	};
> > -- 
> > 1.9.1
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
