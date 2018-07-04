Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE5C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352AA24709
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352AA24709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeGDBQ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:16:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:40989 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932163AbeGDBQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:16:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w641GAWf012835;
        Tue, 3 Jul 2018 20:16:12 -0500
Message-ID: <77039070d470d5d408e750218ddbccf9cb33a78e.camel@kernel.crashing.org>
Subject: Re: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org
Date:   Wed, 04 Jul 2018 11:16:10 +1000
In-Reply-To: <20180703223046.GA20184@rob-hp-laptop>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
         <20180626232605.13420-12-benh@kernel.crashing.org>
         <20180703223046.GA20184@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 16:30 -0600, Rob Herring wrote:
> On Wed, Jun 27, 2018 at 09:26:02AM +1000, Benjamin Herrenschmidt wrote:
> > This isn't per-se a real device, it's a pseudo-device that
> > represents the use of the Aspeed built-in ColdFire to
> > implement the FSI protocol by bitbanging the GPIOs instead
> > of doing it from the ARM core.
> > 
> > Thus it's a drop-in replacement for the existing
> > fsi-master-gpio pseudo-device for use on systems for which
> > a corresponding firmware file exists. It has most of the
> > same properties, plus some more needed to operate the
> > coprocessor.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > new file mode 100644
> > index 000000000000..50913ae685cc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > @@ -0,0 +1,36 @@
> > +Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> > +------------------------------------------------------------------------
> > +
> > +Required properties:
> > + - compatible =
> > +   	      "fsi-master-ast-2400-cf" for an AST2400 based system
> > +	    or
> > +	      "fsi-master-ast-2500-cf" for an AST2500 based system
> 
> <vendor>,<soc>-<block>

It's not really a SOC block from a vendor, it's a pseudo-device in a
way. The current one that doesn't use the coldfire offload is just
compatible "fsi-master-gpio".

I can add a vendor but what should it be ? aspeed because it runs on
the aspeed SoCs only ? ibm because we wrote it and FSI is an IBM
protocol ?

<soc>-<block> doesn't make sense here though.

> > +
> > + - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
> > + - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
> > + - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
> > + - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
> > + - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
> 
> So the gpio info is pased to the CF? Otherwise, what's the point of 
> having these in DT?

In the original version you are looking at, they are not passed to the
CF per-se but the driver does use aspeed GPIO specific APIs to
configure them to be owned by the CF, so we need the references.

However, I've just reworked the ucode with a few tricks to avoid losing
singificant performance, so that we can indeed pass them to the CF,
thus avoiding the need for a per-system image, so the above are here to
stay.

> > +                                          functions (eg, external FSI masters)
> > + - memory-region = <phandle>;		: Reference to the reserved memory for
> > +                                          the ColdFire. Must be 2M aligned on
> > +					  AST2400 and 1M aligned on AST2500
> > + - sram = <phandle>;			: Reference to the SRAM node.
> > + - cvic = <phandle>;			: Reference to the CVIC node.
> 
> Vendor prefixes.

On what ? Why would an "sram" pointer have a vendor prefix ? Or a
memory region pointer ?

> > + - fw-name = <string>;			: The name used to construct the firmware
> > +   	     				  file name (cf-fsi-<name>.bin)
> 
> firmware-name is used in some other places (and is the full filename).

It's gone in the latest version as there's a single FW file now for all
systems.
> 
> > + - fw-platform-sig = <value>;		: A signature value that must match the one
> > +   		     			  contained in the firmware image. Known
> > +					  values are listed in the firmware interface
> > +					  file cf-fsi-fw.h
> 
> Vendor prefix unless you think this could be common.

It's going away.

> > +Examples:
> > +
> > +    fsi-master {
> > +        compatible = "fsi-master-gpio", "fsi-master";
> 
> Forget to update the example?

Indeed :)

> > +        clock-gpios = <&gpio 0>;
> > +        data-gpios = <&gpio 1>;
> > +        enable-gpios = <&gpio 2>;
> > +        trans-gpios = <&gpio 3>;
> > +        mux-gpios = <&gpio 4>;
> > +    }
> > -- 
> > 2.17.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
