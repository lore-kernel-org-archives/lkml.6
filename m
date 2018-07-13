Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D62ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC9214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFC9214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbeGMBIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:08:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:60734 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387836AbeGMBIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:08:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6D0t2rO004186;
        Thu, 12 Jul 2018 19:55:04 -0500
Message-ID: <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc.
 BMC control fields
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, stewart@linux.ibm.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 13 Jul 2018 10:55:02 +1000
In-Reply-To: <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
References: <20180711053122.30773-1-andrew@aj.id.au>
         <20180711053122.30773-2-andrew@aj.id.au>
         <20180711200450.GB17291@rob-hp-laptop>
         <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
         <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-12 at 09:11 -0600, Rob Herring wrote:
> On Wed, Jul 11, 2018 at 6:54 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > 
> > Hi Rob,
> > 
> > Thanks for the response.
> > 
> > On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
> > > On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > > > Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> > > > provide remote management of (primarily) server platforms. BMCs are
> > > > often tightly coupled to the platform in terms of behaviour and provide
> > > > many hardware features integral to booting and running the host system.
> > > > 
> > > > Some of these hardware features are simple, for example scratch
> > > > registers provided by the BMC that are exposed to both the host and the
> > > > BMC. In other cases there's a single bit switch to enable or disable
> > > > some of the provided functionality.
> > > > 
> > > > The documentation defines bindings for fields in registers that do not
> > > > integrate well into other driver models yet must be described to allow
> > > > the BMC kernel to assume control of these features.
> > > 
> > > So we'll get a new binding when that happens? That will break
> > > compatibility.
> > 
> > Can you please expand on this? I'm not following.
> 
> If we have a subsystem in the future, then there would likely be an
> associated binding which would be different. So if you update the DT,
> then old kernels won't work with it.

What kind of "subsystem" ? There is almost no way there could be one
for that sort of BMC tunables. We've look at several BMC chips out
there and requirements from several vendors, BIOS and system
manufacturers and it's all over the place.

> > I feel like this is an argument of tradition. Maybe people have
> > been dissuaded from doing so when they don't have a reasonable use-
> > case? I'm not saying that what I'm proposing is unquestionably
> > reasonable, but I don't want to dismiss it out of hand.
> 
> One of experience. The one that stands out is clock bindings.
> Initially we were doing a node per clock modelling which could end up
> being 100s of nodes and is difficult to get right (with DT being an
> ABI).
> 
> It comes up with system controller type blocks too that just have a
> bunch of random registers. Those change in every SoC and not in any
> controlled or ordered way that would make describing the individual
> sub-functions in DT worthwhile.

So what's the alternative ? Because without something like what we
propose, what's going to happen is /dev/mem ... that's what people do
today.

> > > A node per register bit doesn't scale.
> > 
> > It isn't meant to scale in terms of a single system. Using it
> > extensively is very likely wrong. Separately, register-bit-led does
> > pretty much the same thing. Doesn't the scale argument apply there?
> > Who is to stop me from attaching an insane number of LEDs to a
> > system?
> 
> Review.
> 
> If you look, register-bit-led is rarely used outside of some ARM, Ltd.
> boards. It's simply quite rare to have MMIO register bits that have a
> fixed function of LED control.

Well, same here, we hope to review what goes upstream to make it
reasonable. Otherwise it doens't matter. If a random vendor, let's say
IBM, chose to chip a system where they put an insane amount of cruft in
there, it will only affect those systems's BMC and the userspace stack
on it.

Thankfully that stack is OpenBMC and IBM is aiming at having their
device-tree's upstream, thus reviewed, thus it won't happen.

*Anything* can be abused. The point here is that we have a number,
thankfully rather small, maybe a dozen or two, of tunables that are
quite specific to a combination (system vendor, bmc vendor, system
model) which control a few HW features that essentially do *NOT* fit in
a subsystem.

For everything that does, we have created proper drivers (and are doing
more).


> > Obviously if there are lots of systems using it sparingly and
> > legitimately then maybe there's a scale issue, but isn't that just
> > a reality of different hardware designs? Whoever is implementing
> > support for the system is going to have to describe the hardware
> > one way or another.
> > 
> > > 
> > > Maybe this should be modelled using GPIO binding? There's a line there
> > > too as whether the signals are "general purpose" or not.
> > 
> > I don't think so, mainly because some of the things it is intended to be used for are not GPIOs. For instance, take the DAC mux I've described in the patch. It doesn't directly influence anything external to the SoC (i.e. it's certainly not a traditional GPIO in any sense). However, it does *indirectly* influence the SoC's behaviour by muxing the DAC internally between:
> > 
> > 0. VGA device exposed on the host PCIe bus
> > 1. The "Graphics CRT" controller
> > 2. VGA port A
> > 3. VGA port B
> 
> And this mux control is fixed in the SoC design?

This specific family of SoC (Aspeed) support those 4 configurations.
How they need to be configured at runtime depends on the combination of
system vendor and system model, along with in some cases the need to
switch it at runtime.

This is just one example. Another one is the handful of scratch
registers that need to be populated with the "right" values for the
host system BIOS, VGA BIOS and VGA driver. (The host bits access them
via LPC IO space).

The host system BIOS will read some basic config info there before its
IPMI stack is up (and some BIOSes already rely on that). The VGA BIOS
will get some strapping info and panel info. The VGA driver (which is
already upstream, has been for a long time) will look for other things
in some of these guys, such as connector configuration.

Andrew, if it helps, we could put together a list of what we typically
need on an OpenPower system today. That would give people like Rob a
better idea of what this is all about.

> > 
> > Maybe this could be modelled by pinmux, but then we still need some
> > way to expose the mux functions to userspace for selection
> > (userspace needs to transition arbitrarily between at least options
> > 0 and 1 at runtime), at which point we haven't achieved much beyond
> > adding a whole heap of infrastructure in the chain.
> > 
> > Given 0 and 1, maybe exposing attributes in relevant drivers would
> > be reasonable, except 0 isn't exposed on the SoC's internal bus so
> > there is no driver on the BMC-side to do so. Taking into account 2
> > and 3 are also purely hardware paths further dashes the idea, as
> > the configuration doesn't really "belong" to the Graphics CRT
> > device more than it belongs anywhere else, except for the fact that
> > there isn't anywhere else to expose it.
> > 
> > Further, the BMC's kernel can't make the decision as to when to
> > switch the mux as it knows nothing of the host's state. The BMC
> > userspace is controlling the host's boot state and so *does* know
> > when to flip the switch. Finally, the mux is in separate IP to the
> > CRT or VGA blocks: It lives in the System Control Unit.
> > 
> > My current point of view is the DAC mux field is effectively its
> > own device, and we need to control it from userspace, so we need
> > some way to describe it (i.e. not ignore it) in order for its
> > capability to be exposed.
> > 
> > I'm fully aware what I'm proposing isn't awesome as it's not
> > providing any real abstraction, but the problem(s) at hand also
> > seem to defy abstraction, and in order to avoid a plethora of
> > bespoke bindings I thought it was reasonable to define something
> > generic.
> > 
> > All-in-all I appreciate the suggestion, but assuming you agree with
> > my reasoning above do you have thoughts on other alternatives?
> 
> Seems the controls are more fixed than I first thought. All the data
> you have here could simply be within a driver. Help me understand what
> functions are fixed (in the SoC) and which ones vary by board. Only
> what's changing per board really needs to go into DT.

Most of these things is specific to a given board or may even need to
be changed at runtime.

For example the VGA mux is system specific, *and* will change at
runtime on some systems. For example, on IBM systems, the BMC will
route its internal CRT display controller to the VGA port in order to
display early boot progress information when the host hasn't
initialized its graphics driver yet, and route the host VGA to the VGA
port when the host has.

(To clarify, the BMC has 2 display controllers: one for use by the SoC
ARM itself, and one exposed to the host via PCIe, this routes which one
gets to output to the VGA port).

The scratch registers are similar. Their content tend to be specific to
a specific BIOS vendor/system manufacturer. It might need to change
from boot to boot based configuration changes the user might do via the
BMC IPMI or web interface.

Another example is that the SoC can expose a couple of PCIe devices to
the host, a given vendor will want to control whether to do that and
which ones to expose. This can be fixed or tunable. Some vendors want
the user to be able to control (via IPMI or web UI or some other
mechanism) whether the SoC internal VGA shows up or not depending on
whether they chose to use a separate discrete GPU, as some OSes get
confused when in the presence of multiple different graphic adapters.

Talking of which: Andrew, did you put "default values" in your binding
? That would be a nice way to deal with system specific immutables, so
that userspace doesn't even have to care.

So to clarify once and for all, *anything* that fits in a subsystem,
we're putting in one. All the random board control is all GPIOs and
that's fine as well. For some things that require a bit of fiddly usage
like the "MBOX" logic between BIOS and BMC we are also doing a
dedicated driver.

But there's a few stragglers here, and they tend to be so
board/system/BIOS specific that it's not sustainable to create/change
random drivers all the time just for exposing those few tunables.

Cheers,
Ben.

