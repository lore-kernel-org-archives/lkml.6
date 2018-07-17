Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C17ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A422920877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A422920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeGQEnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:43:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:53928 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbeGQEnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:43:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6H4CF3K015654;
        Mon, 16 Jul 2018 23:12:17 -0500
Message-ID: <7125cc74b640b941ea6f86e1f719cc25eeae9f78.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Date:   Tue, 17 Jul 2018 14:12:15 +1000
In-Reply-To: <20180716153308.GA13044@rob-hp-laptop>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
         <20180712034847.12878-2-benh@kernel.crashing.org>
         <20180716153308.GA13044@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 09:33 -0600, Rob Herring wrote:
> On Thu, Jul 12, 2018 at 01:48:43PM +1000, Benjamin Herrenschmidt wrote:
> > This isn't per-se a real device, it's a pseudo-device that
> > represents the use of the Aspeed built-in ColdFire to
> > implement the FSI protocol by bitbanging the GPIOs instead
> > of doing it from the ARM core.
> > 
> > Thus it's a drop-in replacement for the existing
> > fsi-master-gpio pseudo-device for use on systems based
> > on the Aspeed chips. It has most of the same properties,
> > plus some more needed to operate the coprocessor.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> >  .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > new file mode 100644
> > index 000000000000..431bf8a423ce
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> > @@ -0,0 +1,36 @@
> > +Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> > +------------------------------------------------------------------------
> > +
> > +Required properties:
> > + - compatible =
> > +	"aspeed,ast2400-cf-fsi-master" for an AST2400 based system
> > +   or
> > +	"aspeed,ast2500-cf-fsi-master" for an AST2500 based system
> > +
> > + - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
> > + - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
> > + - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
> > + - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
> > + - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
> > +                                          functions (eg, external FSI masters)
> > + - memory-region = <phandle>;		: Reference to the reserved memory for
> > +                                          the ColdFire. Must be 2M aligned on
> > +					  AST2400 and 1M aligned on AST2500
> > + - aspeed,sram = <phandle>;		: Reference to the SRAM node.
> > + - aspeed,cvic = <phandle>;		: Reference to the CVIC node.
> > +
> > +Examples:
> > +
> > +    fsi-master {
> > +        compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
> > +
> > +	clock-gpios = <&gpio 0>;
> > +        data-gpios = <&gpio 1>;
> > +        enable-gpios = <&gpio 2>;
> > +        trans-gpios = <&gpio 3>;
> > +        mux-gpios = <&gpio 4>;
> > +
> > +	memory-region = <&coldfire_memory>;
> > +	sram = <&sram>;
> > +	cvic = <&cvic>;
> 
> Need to update the example. With that

Ah right, thanks. The next spin will have that fixed and will go into
the fsi tree.

> Reviewed-by: Rob Herring <robh@kernel.org>
