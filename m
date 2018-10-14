Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C7C28CF8
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 02:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0842077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 02:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0842077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbeJNKVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 06:21:36 -0400
Received: from hermes.aosc.io ([199.195.250.187]:34303 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725734AbeJNKVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 06:21:36 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 778CB4E155;
        Sun, 14 Oct 2018 02:42:07 +0000 (UTC)
Message-ID: <92e92f817d4df753d654124514e89c62f40d52eb.camel@aosc.io>
Subject: Re: [PATCH v4 07/10] dt-bindings: phy: add binding for Allwinner
 USB3 PHY
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Sun, 14 Oct 2018 10:41:29 +0800
In-Reply-To: <20181005205855.GA2458@bogus>
References: <20181004122855.22981-1-icenowy@aosc.io>
         <20181004122855.22981-8-icenowy@aosc.io> <20181005205855.GA2458@bogus>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-10-05五的 15:58 -0500，Rob Herring写道：
> On Thu, Oct 04, 2018 at 08:28:52PM +0800, Icenowy Zheng wrote:
> > The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> > external USB3 pins of the SoC.
> > 
> > Add a device tree binding for the PHY.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > Changes in v4:
> > - Changed Vbus regulator property to vbus-supply.
> > 
> > Changes in v3:
> > - Added Chen-Yu's Review tag.
> > 
> > No changes in v2, v1.
> > 
> >  .../bindings/phy/sun50i-usb3-phy.txt          | 23
> > +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-
> > usb3-phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-
> > phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> > new file mode 100644
> > index 000000000000..9f49c6b8c7e7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> > @@ -0,0 +1,23 @@
> > +Allwinner sun50i USB3 PHY
> > +-----------------------
> > +
> > +Required properties:
> > +- compatible : should be one of
> > +  * allwinner,sun60i-h6-usb3-phy
> > +- reg : a list of offset + length pairs
> > +- #phy-cells : from the generic phy bindings, must be 0
> > +- clocks : phandle + clock specifier for the phy clock
> > +- resets : phandle + reset specifier for the phy reset
> > +
> > +Optional Properties:
> > +- vbus-supply : a phandle to a regulator that provides power to
> > VBUS.
> 
> This belongs in a connector node as it is part of the connector
> unless 
> the phy physically needs Vbus for power.
> 
> But others have done this, so all the phys can just be wrong...

How should we reference the connector?

Via OF graph or simply a property in PHY node?

> 
> > +
> > +Example:
> > +	usb3phy: phy@5210000 {
> 
> usb-phy@
> 
> > +		compatible = "allwinner,sun50i-h6-usb3-phy";
> > +		reg = <0x5210000 0x10000>;
> > +		clocks = <&ccu CLK_USB_PHY1>;
> > +		resets = <&ccu RST_USB_PHY1>;
> > +		#phy-cells = <0>;
> > +		status = "disabled";
> 
> Don't show status in examples.
> 
> > +	};
> > -- 
> > 2.18.0
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

