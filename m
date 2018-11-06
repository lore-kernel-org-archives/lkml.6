Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522BDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246BA2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246BA2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389302AbeKGBqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:46:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36482 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389159AbeKGBqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:46:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A92AEBD;
        Tue,  6 Nov 2018 08:20:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 114B13F5CF;
        Tue,  6 Nov 2018 08:20:53 -0800 (PST)
Date:   Tue, 6 Nov 2018 16:20:51 +0000
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
Message-ID: <20181106162051.w7fyweuxrl7ujzuz@lakrids.cambridge.arm.com>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:26:01PM +0200, Nick Kossifidis wrote:
> Στις 2018-11-06 16:13, Sudeep Holla έγραψε:
> > On Fri, Nov 02, 2018 at 08:58:39PM +0200, Nick Kossifidis wrote:
> > > Στις 2018-11-02 01:04, Atish Patra έγραψε:
> > > > This patch series adds the cpu topology for RISC-V. It contains
> > > > both the DT binding and actual source code. It has been tested on
> > > > QEMU & Unleashed board.
> > > >
> > > > The idea is based on cpu-map in ARM with changes related to how
> > > > we define SMT systems. The reason for adopting a similar approach
> > > > to ARM as I feel it provides a very clear way of defining the
> > > > topology compared to parsing cache nodes to figure out which cpus
> > > > share the same package or core.  I am open to any other idea to
> > > > implement cpu-topology as well.
> > > 
> > > I was also about to start a discussion about CPU topology on RISC-V
> > > after the last swtools group meeting. The goal is to provide the
> > > scheduler with hints on how to distribute tasks more efficiently
> > > between harts, by populating the scheduling domain topology levels
> > > (https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
> > > What we want to do is define cpu groups and assign them to
> > > scheduling domains with the appropriate SD_ flags
> > > (https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).
> > 
> > OK are we defining a CPU topology binding for Linux scheduler ?
> > NACK for all the approaches that assumes any knowledge of OS scheduler.
> 
> Is there any standard regarding CPU topology on the device tree spec ?
> As far as I know there is none. We are talking about a Linux-specific
> Device Tree binding so I don't see why defining a binding for the
> Linux scheduler is out of scope.

Speaking as a DT binding maintainer, please avoid OS-specific DT
bindings wherever possible.

While DT bindings live in the kernel tree, they are not intended to be
Linux-specific, and other OSs (e.g. FreeBSD, zephyr) are aiming to
support the same bindings.

In general, targeting a specific OS is a bad idea, because the
implementation details of that OS change over time, or the bindings end
up being tailored to one specific use-case. Exposing details to the OS
such that the OS can make decisions at runtime is typically better.

> Do you have cpu-map on other OSes as well ?

There is nothing OS-specific about cpu-map, and it may be of use to
other OSs.

> > > So the cores that belong to a scheduling domain may share:
> > > CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
> > > Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
> > > Power domain (SD_SHARE_POWERDOMAIN)
> > > 
> > 
> > Too Linux kernel/scheduler specific to be part of $subject
> 
> All lists on the cc list are Linux specific, again I don't see your
> point here are we talking about defining a standard CPU topology
> scheme for the device tree spec or a Linux-specific CPU topology
> binding such as cpu-map ?

The cpu-map binding is not intended to be Linux specific, and avoids
Linux-specific terminology.

While the cpu-map binding documentation is in the Linux source tree, the
binding itseld is not intended to be Linux-specific, and it deliberately
avoids Linux implementation details.

> Even on this case your point is not valid, the information of two
> harts sharing a common power domain or having the same or not
> capacity/max frequency (or maybe capabilities/extensions in the
> future), is not Linux specific. I just used the Linux specific macros
> used by the Linux scheduler to point out the code path.  Even on other
> OSes we still need a way to include this information on the CPU
> topology, and currently cpu-map doesn't. Also the Linux implementation
> of cpu-map ignores multiple levels of shared resources, we only get
> one level for SMT and one level for MC last time I checked.

Given clusters can be nested, as in the very first example, I don't see
what prevents multiple levels of shared resources.

Can you please given an example of the topology your considering? Does
that share some resources across clusters at some level?

We are certainly open to improving the cpu-map binding.

Thanks,
Mark.
