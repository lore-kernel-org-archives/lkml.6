Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23672C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9642085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9642085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbeKGBP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:15:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387480AbeKGBP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:15:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3987BEBD;
        Tue,  6 Nov 2018 07:50:08 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D61D73F5CF;
        Tue,  6 Nov 2018 07:50:05 -0800 (PST)
Date:   Tue, 6 Nov 2018 15:50:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, alankao@andestech.com, zong@andestech.com,
        anup@brainfault.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        robh+dt@kernel.org, tglx@linutronix.de
Subject: Re: [RFC 0/2] Add RISC-V cpu topology
Message-ID: <20181106155000.GA25372@e107155-lin>
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com>
 <866dedbc78ab4fa0e3b040697e112106@mailhost.ics.forth.gr>
 <20181106141331.GA28458@e107155-lin>
 <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <969fc2a5198984e0dfe8c3f585dc65f9@mailhost.ics.forth.gr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:26:01PM +0200, Nick Kossifidis wrote:
> Στις 2018-11-06 16:13, Sudeep Holla έγραψε:
> > On Fri, Nov 02, 2018 at 08:58:39PM +0200, Nick Kossifidis wrote:
> > > Hello All,
> > >
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
> > > >
> > >
> > > I was also about to start a discussion about CPU topology on RISC-V
> > > after the last swtools group meeting. The goal is to provide the
> > > scheduler with hints on how to distribute tasks more efficiently
> > > between harts, by populating the scheduling domain topology levels
> > > (https://elixir.bootlin.com/linux/v4.19/ident/sched_domain_topology_level).
> > > What we want to do is define cpu groups and assign them to
> > > scheduling domains with the appropriate SD_ flags
> > > (https://github.com/torvalds/linux/blob/master/include/linux/sched/topology.h#L16).
> > >
> >
> > OK are we defining a CPU topology binding for Linux scheduler ?
> > NACK for all the approaches that assumes any knowledge of OS scheduler.
> >
>
> Is there any standard regarding CPU topology on the device tree spec ? As
> far as I know there is none. We are talking about a Linux-specific Device
> Tree binding so I don't see why defining a binding for the Linux scheduler
> is out of scope.

There may not be much on CPU topology in device tree spec, but that
doesn't mean we are defining something Linux specific here just because
there's bunch of LKML are cc-ed. We do have dedicated device tree ML for
a reason.

> Do you have cpu-map on other OSes as well ?
>

Nothing prevents them not to. I have seen increase in the projects
relying on DT these days.

> > > So the cores that belong to a scheduling domain may share:
> > > CPU capacity (SD_SHARE_CPUCAPACITY / SD_ASYM_CPUCAPACITY)
> > > Package resources -e.g. caches, units etc- (SD_SHARE_PKG_RESOURCES)
> > > Power domain (SD_SHARE_POWERDOMAIN)
> > >
> >
> > Too Linux kernel/scheduler specific to be part of $subject
> >
>
> All lists on the cc list are Linux specific, again I don't see your point
> here are we talking about defining a standard CPU topology scheme for the
> device tree spec or a Linux-specific CPU topology binding such as cpu-map ?
>

See above.

> Even on this case your point is not valid, the information of two harts
> sharing a common power domain or having the same or not capacity/max
> frequency (or maybe capabilities/extensions in the future), is not Linux
> specific. I just used the Linux specific macros used by the Linux scheduler
> to point out the code path.

The CPU topology can be different from the frequency or the power domains
and we do have specific bindings to provide those information. So let's
try to keep that out of this discussion.

> Even on other OSes we still need a way to include this information on the
> CPU topology, and currently cpu-map doesn't. Also the Linux implementation
> of cpu-map ignores multiple levels of shared resources, we only get one
> level for SMT and one level for MC last time I checked.
>

But that doesn't make it any easy if you influence the bindings based on
Linux scheduler. So just define how hardware is and allow each OS to
choose it's own way to utilise that information. That's how most of the
generic DT bindings are defined.

> > > In this context I believe using words like "core", "package",
> > > "socket" etc can be misleading. For example the sample topology you
> > > use on the documentation says that there are 4 cores that are part
> > > of a package, however "package" has a different meaning to the
> > > scheduler. Also we don't say anything in case they share a power
> > > domain or if they have the same capacity or not. This mapping deals
> > > only with cache hierarchy or other shared resources.
> > >
> >
> > {Un,}fortunately those are terms used by hardware people.
> >
>
> And they are wrong, how the harts are physically packed doesn't imply
> their actual topology. In general the "translation" is not always straight
> forward, there are assumptions in place. We could use "cluster" of harts or
> "group" of harts instead, they are more abstract.
>

Indeed. I agree those terminologies may not be best, but they are already
used one. We need to map on to those generic ones, though the translations
may not be simple. We do have the same issues on ARM. If we try to build
in such information into DT, then it becomes more configuration file for
OS than platform description IMO.

--
Regards,
Sudeep
