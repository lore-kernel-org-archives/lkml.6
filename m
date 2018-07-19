Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E706ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E2E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E2E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeGSFRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:17:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:59530 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeGSFRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:17:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6J4ZOEF020357;
        Wed, 18 Jul 2018 23:35:25 -0500
Message-ID: <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc.
 BMC control fields
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        stewart@linux.ibm.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 Jul 2018 14:35:24 +1000
In-Reply-To: <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
         <20180711053122.30773-2-andrew@aj.id.au>
         <20180711200450.GB17291@rob-hp-laptop>
         <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
         <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
         <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
         <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
         <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
         <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
         <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
         <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
         <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-19 at 11:58 +0930, Andrew Jeffery wrote:
> > > I agree
> > > that not using /dev/mem is a good thing, but there are several ways
> > > you could do that independent of any DT binding.
> > 
> > Such as ? The only other option is to have one or more kernel drivers
> > that have built-in the precise and complete list of those tunables that
> > need to be exposed.
> > 
> > It's not impossible, but I worry that it's not going to scale terribly
> > well, and that vendors will constantly "fork" that driver to add
> > different things to that list.
> 
> Picking on that last point, "different things" doesn't necessarily
> mean "different fields in the SoC" (though it may). We could just
> need to use different initial values for the fields already
> described. 

I don't worry about initial values too much. Those could be specified
by userspace. It would be trivial to have something akin to
/etc/sysctl.conf that contains the initial values and a script blasting
them early. In fact I prefer this being in userspace to be frank. It
could be in the initramfs if we want it done early enough, maybe with a
usermode helper.

Unless we have some demonstrable reasons why some of these must be set
before the various kernel drivers initialize.

> So taking that into account, the field descriptions could vary wildly
> from platform to platform - where "platform" here is the combination
> of the BMC, its host system, and the host system's required
> configuration - not just referring to the BMC in isolation.  That in
> turn may cause a fork of the driver (changes that are incompatible
> with other platforms), or not scale terribly well as Ben suggests.

I really only worry about the actual set of registers/fields. I think
folding in initial values goes a bit too far.

> The initial value concept can help reduce the impact on userspace as
> userpace may no-longer need to care about it, so I think it's a
> desirable property.

I don't worry too much about userspace containing system specific bits
and pieces such as a config file with the appropriate initial values
for the platform. Userspace will have to contain platform specific
stuff regardless (if anything, stuff like thermal control is
intrinsicly different from one platform to the next).

>  With respect to devicetree, the field definitions will stay in the
> SoC dtsi, but the initial values would be described on a per-platform 
> basis in the dts.

If the fields are in the SoC dtsi, then Rob has a reasonable argument
that the list of fields is rather fixed for a given SoC and thus could
be hard wired in the driver.... 

I think at this stage, we need to create more clarity. In order to do
that, I think we need to come up with a list, as exhaustive as we can,
of what are the fields/register we need for our platforms, and find any
reason why userspace wouldn't be a good enough location to stick the
initial values.

Then we need Dell and Yadro (and maybe others) to help with their
variant of that list for the same SoCs to begin with.

With that, we'll get an idea of whether we think we can get a
reasonable stable long term list that's appropriate for most vendors.

If that's the case, then my objections to have it in the kernel instead
of the DT fade away a bit.

If one or two of those fields absolutely must have their defaults
early, then we can consider a specific set of one or two properties in
the SoC node for that SoC family that provides those specific defaults.

But unless we have that list, I think we'll be throwing too many
hypotheticals around to convince Rob and others.

Andrew, can you start with a list that shows what you expect us to need
on our systems ?

Cheers,
Ben

