Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BF1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFB62086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFB62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeKGVg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:36:56 -0500
Received: from foss.arm.com ([217.140.101.70]:49736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeKGVg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:36:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4ED80D;
        Wed,  7 Nov 2018 04:06:51 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E639E3F5CF;
        Wed,  7 Nov 2018 04:06:48 -0800 (PST)
Date:   Wed, 7 Nov 2018 12:06:46 +0000
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
Message-ID: <20181107120645.sc3wjgr2yakvxktl@lakrids.cambridge.arm.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
 <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
 <abcae019e6ae749b17ecb0c721fd3177@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abcae019e6ae749b17ecb0c721fd3177@mailhost.ics.forth.gr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:31:34AM +0200, Nick Kossifidis wrote:
> Mark and Sundeep thanks a lot for your feedback, I guess you convinced
> me that having a device tree binding for the scheduler is not a
> correct approach. It's not a device after all and I agree that the
> device tree shouldn't become an OS configuration file.

Good to hear.

> Regarding multiple levels of shared resources my point is that since
> cpu-map doesn't contain any information of what is shared among the
> cluster/core members it's not easy to do any further translation. Last
> time I checked the arm code that uses cpu-map, it only defines one
> domain for SMT, one for MC and then everything else is ignored. No
> matter how many clusters have been defined, anything above the core
> level is the same (and then I guess you started talking about adding
> "packages" on the representation side).

While cpu-map doesn't contain that information today, we can *add* that
information to the cpu-map binding if necessary.

> The reason I proposed to have a binding for the scheduler directly is
> not only because it's simpler and closer to what really happens in the
> code, it also makes more sense to me than the combination of cpu-map
> with all the related mappings e.g.  for numa or caches or power
> domains etc.
> 
> However you are right we could definitely augment cpu-map to include
> support for what I'm saying and clean things up, and since you are
> open about improving it here is a proposal that I hope you find
> interesting:
> 
> At first let's get rid of the <thread> nodes, they don't make sense:
> 
> thread0 {
>  cpu = <&CPU0>;
> };
> 
> A thread node can't have more than one cpu entry and any properties
> should be on the cpu node itself, so it doesn't / can't add any
> more information. We could just have an array of cpu nodes on the
> <core> node, it's much cleaner this way.
> 
> core0 {
>  members = <&CPU0>, <&CPU1>;
> };

Hold on. Rather than reinventing things from first principles, can we
please discuss what you want to *achieve*, i.e. what information you
need?

Having a node is not a significant cost, and there are reasons we may
want thread nodes. For example, it means that we can always refer to any
level of topology with a phandle, and we might want to describe
thread-affine devices in future.

There are a tonne of existing bindings that are ugly, but re-inventing
them for taste reasons alone is more costly to the ecosystem than simply
using the existing bindings. We avoid re-inventing bindings unless there
is a functional problem e.g. cases which they cannot possibly describe.

> Then let's allow the cluster and core nodes to accept attributes that are
> common for the cpus they contain. Right now this is considered invalid.
> 
> For power domains we have a generic binding described on
> Documentation/devicetree/bindings/power/power_domain.txt
> which basically says that we need to put power-domains = <power domain
> specifiers>
> attribute on each of the cpu nodes.

FWIW, given this is arguably topological, I'm not personally averse to
describing this in the cpu-map, if that actually gains us more than the
complexity require to support it.

Given we don't do this for device power domains, I suspect that it's
simpler to stick with the existing binding.

> The same happens with the capacity binding specified for arm on
> Documentation/devicetree/bindings/arm/cpu-capacity.txt
> which says we should add the capacity-dmips-mhz on each of the cpu nodes.

The cpu-map was intended to expose topological dtails, and this isn't
really a topological property. For example, Arm DynamIQ systems can have
heterogeneous CPUs within clusters.

I do not think it's worth moving this, tbh.

> The same also happens with the generic numa binding on
> Documentation/devicetree/bindings/numa.txt
> which says we should add the nuna-node-id on each of the cpu nodes.

Is there a strong gain from moving this?

[...]

> Finally from the examples above I'd like to stress out that the distinction
> between a cluster and a core doesn't make much sense and it also makes the
> representation more complicated. To begin with, how would you call the setup
> on HiFive Unleashed ? A cluster of 4 cores that share the same L3 cache ?

Not knowing much about the hardware, I can't really say.

I'm not sure I follow why the distinction between a cluster and a core
is non-sensical. A cluster is always a collection of cores.

A hart could be a core in its own right, or it could be a thread under a
core, which shares functional units with other harts within that core.

Arguably, we could have mandated that the topology always needed to
describe down to a thread, even if a core only had a single thread. That
ship has sailed, however.

Thanks,
Mark.
