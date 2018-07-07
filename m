Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76002C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5821EB7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC5821EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbeGGBu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:50:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:59998 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753796AbeGGBu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:50:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w671oBp3015088;
        Fri, 6 Jul 2018 20:50:12 -0500
Message-ID: <88292b993583020fc28bf0d23177cbd06732d7fc.camel@kernel.crashing.org>
Subject: Re: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sat, 07 Jul 2018 11:50:11 +1000
In-Reply-To: <CAL_JsqLfg+7pUXgXecpObqfUTVvp4QAR150LsMho2EkKtkqgFg@mail.gmail.com>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
         <20180626232605.13420-12-benh@kernel.crashing.org>
         <20180703223046.GA20184@rob-hp-laptop>
         <77039070d470d5d408e750218ddbccf9cb33a78e.camel@kernel.crashing.org>
         <CAL_JsqLfg+7pUXgXecpObqfUTVvp4QAR150LsMho2EkKtkqgFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 10:08 -0600, Rob Herring wrote:
> 
> > It's not really a SOC block from a vendor, it's a pseudo-device in a
> > way. The current one that doesn't use the coldfire offload is just
> > compatible "fsi-master-gpio".
> > 
> > I can add a vendor but what should it be ? aspeed because it runs on
> > the aspeed SoCs only ? ibm because we wrote it and FSI is an IBM
> > protocol ?
> 
> I would say aspeed as it is tied to their chip.
> 
> > 
> > <soc>-<block> doesn't make sense here though.
> 
> But you do already have <soc> in the compatible, but in a slightly
> different form and position. And "cf" is the block.
>
> So I'd propose: aspeed,ast2500-cf-fsi-master

Ok, I'll do that.

> > 
> > > > +
> > > > + - clock-gpios = <gpio-descriptor>;        : GPIO for FSI clock
> > > > + - data-gpios = <gpio-descriptor>; : GPIO for FSI data signal
> > > > + - enable-gpios = <gpio-descriptor>;       : GPIO for enable signal
> > > > + - trans-gpios = <gpio-descriptor>;        : GPIO for voltage translator enable
> > > > + - mux-gpios = <gpio-descriptor>;  : GPIO for pin multiplexing with other
> > > 
> > > So the gpio info is pased to the CF? Otherwise, what's the point of
> > > having these in DT?
> > 
> > In the original version you are looking at, they are not passed to the
> > CF per-se but the driver does use aspeed GPIO specific APIs to
> > configure them to be owned by the CF, so we need the references.
> 
> Okay.
> 
> > However, I've just reworked the ucode with a few tricks to avoid losing
> > singificant performance, so that we can indeed pass them to the CF,
> > thus avoiding the need for a per-system image, so the above are here to
> > stay.
> > 
> > > > +                                          functions (eg, external FSI masters)
> > > > + - memory-region = <phandle>;              : Reference to the reserved memory for
> > > > +                                          the ColdFire. Must be 2M aligned on
> > > > +                                     AST2400 and 1M aligned on AST2500
> > > > + - sram = <phandle>;                       : Reference to the SRAM node.
> > > > + - cvic = <phandle>;                       : Reference to the CVIC node.
> > > 
> > > Vendor prefixes.
> > 
> > On what ? Why would an "sram" pointer have a vendor prefix ? Or a
> > memory region pointer ?
> 
> memory-region is a standard property. sram and cvic are not, so should
> have vendor prefixes. However, perhaps we should add a common "sram"
> property to sram/sram.txt.

Hrm... originally vendor prefix on properties were for things that
didn't have a binding afaik. IE a way for an f-code driver to stash
things in the DT that were vendor specific and retrieve them from the
OS driver for example.

Here with well defined bindings it's rather bloaty don't you think ? I
don't strongly object to doing it, it's just a bit ... odd.

Cheers,
Ben.

