Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11C8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59A72077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59A72077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKIBaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:30:19 -0500
Received: from foss.arm.com ([217.140.101.70]:44134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeKIBaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:30:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B04380D;
        Thu,  8 Nov 2018 07:54:12 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 233E53F5CF;
        Thu,  8 Nov 2018 07:54:09 -0800 (PST)
Date:   Thu, 8 Nov 2018 15:54:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, alankao@andestech.com, zong@andestech.com,
        anup@brainfault.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Message-ID: <20181108155404.32ja7bbxu62nyytt@lakrids.cambridge.arm.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
 <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
 <abcae019e6ae749b17ecb0c721fd3177@mailhost.ics.forth.gr>
 <20181107120645.sc3wjgr2yakvxktl@lakrids.cambridge.arm.com>
 <b3a38a178699278c09a9c9ce6421ddd8@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a38a178699278c09a9c9ce6421ddd8@mailhost.ics.forth.gr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:45:36PM +0200, Nick Kossifidis wrote:
> Στις 2018-11-07 14:06, Mark Rutland έγραψε:
> > On Wed, Nov 07, 2018 at 04:31:34AM +0200, Nick Kossifidis wrote:
> > > Mark and Sundeep thanks a lot for your feedback, I guess you convinced
> > > me that having a device tree binding for the scheduler is not a
> > > correct approach. It's not a device after all and I agree that the
> > > device tree shouldn't become an OS configuration file.
> > 
> > Good to hear.
> > 
> > > Regarding multiple levels of shared resources my point is that since
> > > cpu-map doesn't contain any information of what is shared among the
> > > cluster/core members it's not easy to do any further translation. Last
> > > time I checked the arm code that uses cpu-map, it only defines one
> > > domain for SMT, one for MC and then everything else is ignored. No
> > > matter how many clusters have been defined, anything above the core
> > > level is the same (and then I guess you started talking about adding
> > > "packages" on the representation side).
> > 
> > While cpu-map doesn't contain that information today, we can *add* that
> > information to the cpu-map binding if necessary.
> > 
> > > The reason I proposed to have a binding for the scheduler directly is
> > > not only because it's simpler and closer to what really happens in the
> > > code, it also makes more sense to me than the combination of cpu-map
> > > with all the related mappings e.g.  for numa or caches or power
> > > domains etc.
> > > 
> > > However you are right we could definitely augment cpu-map to include
> > > support for what I'm saying and clean things up, and since you are
> > > open about improving it here is a proposal that I hope you find
> > > interesting:
> > > 
> > > At first let's get rid of the <thread> nodes, they don't make sense:
> > > 
> > > thread0 {
> > >  cpu = <&CPU0>;
> > > };
> > > 
> > > A thread node can't have more than one cpu entry and any properties
> > > should be on the cpu node itself, so it doesn't / can't add any
> > > more information. We could just have an array of cpu nodes on the
> > > <core> node, it's much cleaner this way.
> > > 
> > > core0 {
> > >  members = <&CPU0>, <&CPU1>;
> > > };
> > 
> > Hold on. Rather than reinventing things from first principles, can we
> > please discuss what you want to *achieve*, i.e. what information you
> > need?
> > 
> > Having a node is not a significant cost, and there are reasons we may
> > want thread nodes. For example, it means that we can always refer to any
> > level of topology with a phandle, and we might want to describe
> > thread-affine devices in future.
> 
> You can use the phandle of the cpu node, the thread node doesn't add
> anything more than complexity to the representation.

That adds complexity elsewhere, because the phandle of a CPU node is not
a child of the cpu-map node, and you can't simply walk up the tree
hierarchy to find parent nodes.

I see no reason to change this part of the binding. Given it's already
out there, with existing parsing code, changing it only serves to add
complexity to any common code which has to parse this.

Can we please drop the idea of dropping the thread node?

> > There are a tonne of existing bindings that are ugly, but re-inventing
> > them for taste reasons alone is more costly to the ecosystem than simply
> > using the existing bindings. We avoid re-inventing bindings unless there
> > is a functional problem e.g. cases which they cannot possibly describe.
> 
> We are talking about using something for RISC-V and possibly common across
> different archs and, I don't see why we should keep the ugliness of a
> binding spec plus in this case the <trhead> node can't possibly describe
> anything else than a cpu=<node> alias, it's redundant.

While it may be ugly, removing it only serves to add complexity for
common parsing code, and removes flexibility that we may want in future.
Its presence does not cause any technical problem.

For better or worse we're all sharing the same codebase here. The common
case matters, as does the complexity of the codebase as a whole.

I realise it can be frustrating to have to use something you feel is
sub-optimal, but putting up with a few nodes which you personally feel
are redundant is of much lower cost to the ecosystem than having
incompatible bindings where we could have one. If you put up with that,
you can focus your efforts on more worthwhile technical exercises.

> > > Then let's allow the cluster and core nodes to accept attributes
> > > that are
> > > common for the cpus they contain. Right now this is considered
> > > invalid.
> > > 
> > > For power domains we have a generic binding described on
> > > Documentation/devicetree/bindings/power/power_domain.txt
> > > which basically says that we need to put power-domains = <power domain
> > > specifiers>
> > > attribute on each of the cpu nodes.
> > 
> > FWIW, given this is arguably topological, I'm not personally averse to
> > describing this in the cpu-map, if that actually gains us more than the
> > complexity require to support it.
> > 
> > Given we don't do this for device power domains, I suspect that it's
> > simpler to stick with the existing binding.
> > 
> > > The same happens with the capacity binding specified for arm on
> > > Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > > which says we should add the capacity-dmips-mhz on each of the cpu
> > > nodes.
> > 
> > The cpu-map was intended to expose topological dtails, and this isn't
> > really a topological property. For example, Arm DynamIQ systems can have
> > heterogeneous CPUs within clusters.
> > 
> > I do not think it's worth moving this, tbh.
> > 
> > > The same also happens with the generic numa binding on
> > > Documentation/devicetree/bindings/numa.txt
> > > which says we should add the nuna-node-id on each of the cpu nodes.
> > 
> > Is there a strong gain from moving this?
> > 
> > [...]
> 
> Right now with the device tree spec and the above bindings we can
> use the information from cpu nodes to infer the cache topology,
> the memory topology, the power domain topology etc.
> 
> We have of_find_next_cache_node and of_find_last_cache_level for example
> that use "next-level-cache" and are used on powerpc (where this spec comes
> from), that we can further build on top of them (since this is now part
> of the  device tree spec anyway), to e.g. populate the levels of cache,
> the levels of shared cache and finally create cpu masks for the different
> cache sharing levels.

The cpu-map binding does not describe cache topology. I never suggested
that it did.

> This is standards-compliant, arch-independent (they are on of/base.c), and
> it provides a concrete hint on CPU topology rather grouping harts to classes
> like "core", "package", "socket", "cluster" etc that don't mean anything
> specific and we assume to map to specific levels of cache sharing.

Please note that I have never suggested "package", and I'm not sure what
that's in response to.

Please also not that while the cache topology and CPU topology are
somewhat related, in general (this is at least true on ARM systems)
there's no strict mapping between the two, which is why we have separate
bindings in the first place.

Distinct CPU topologies could look identical in cache topology, and
vice-versa.

> The same goes for the power domain topology, numa topology, or for
> understanding how the cpus are grouped in terms of capacity, we can
> always just use the above bindings on cpu nodes and be done with it.
> 
> The way I see it cpu-map doesn't add anything new to the spec at this
> point, it's just there for convenience so that people don't have to add all
> these infos on the cpu nodes. Instead of adding cache nodes and use the
> next-level-cache property like the device tree spec says, we have cpu-map
> that presents how the harts are "packed" inside the chip, assuming that
> their packing also aligns on how they share their caches (they say
> nothing about how they share their power domain or other attributes).

The cpu-map and cache bindings describe separate topological details,
and neither is intended to replace the other. There are plenty of DT
files with both.

> In a sense it goes against your rule of "re-inventing them for taste
> reasons alone is more costly to the ecosystem than simply using the
> existing bindings", I fail to see anything else than "taste reasons"
> when it comes to cpu-map, since there are existing bindings for
> inferring the CPU topology already, they are just not that convenient.

If you believe that's the case, then you can perfectly use the existing
cache and NUMA bindings, and not describe the cpu topology at all, no
need to change cpu-map or come up with a new binding.

> I'm proposing to add the option (not enforce) of adding those
> attributes that are meant to be used on cpu nodes, on the various
> groups/classes of the cpu-map, this way cpu-map will provide something
> more meaningful and at least improve the representation side of
> things. On the implementation side it might save us the burden of
> infering the topology from parsing all cpu nodes each time. It's also
> backwards compatible with what you already have, the only thing that's
> not backwards compatible is the removal of the <thread> node, which I
> don't think is such a big deal to fix.

Sorry, but as I have stated repeatedly, this complicates the common code
for what you admit is a matter of taste. I would rather maintain the
simplicity of this binding and existing parsing code, and not
potentially break other parsers, if the only cost is a few nodes which
you personally consider to be redundant.

> > > Finally from the examples above I'd like to stress out that the
> > > distinction between a cluster and a core doesn't make much sense
> > > and it also makes the representation more complicated. To begin
> > > with, how would you call the setup on HiFive Unleashed ? A cluster
> > > of 4 cores that share the same L3 cache ?
> > 
> > Not knowing much about the hardware, I can't really say.
> > 
> > I'm not sure I follow why the distinction between a cluster and a core
> > is non-sensical. A cluster is always a collection of cores.
> > 
> > A hart could be a core in its own right, or it could be a thread under a
> > core, which shares functional units with other harts within that core.
> > 
> > Arguably, we could have mandated that the topology always needed to
> > describe down to a thread, even if a core only had a single thread. That
> > ship has sailed, however.
> 
> So we agree, the "core" doesn't say anything useful regarding the
> topology, why keep using this distinction on a binding for RISC-V and
> possibly other archs (since we are also talking on an arch-independent
> approach) ?

We keep it because the binding has already been finalised and is use in
practice. The existing binding and parsing code is *sufficient* for your
needs. Personal taste and minor savings in the number of nodes in a DT
are not compelling reasons to change this when the cost is complexity
that we have to maintain *forever*.

Thanks,
Mark.
