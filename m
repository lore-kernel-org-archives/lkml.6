Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6447C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A1727F74
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A1727F74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755123AbeF2Ns2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:48:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34672 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754705AbeF2Ns1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:48:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E6480D;
        Fri, 29 Jun 2018 06:48:27 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72CF73F5C0;
        Fri, 29 Jun 2018 06:48:25 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:48:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180629134822.GC16282@e107155-lin>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <d797ebc5-bd7b-4f72-d4fc-840ba7345a15@arm.com>
 <20180629105334.GB18043@e107155-lin>
 <20180629114227.4noje2kx3lcjbcpd@kamzik.brq.redhat.com>
 <20180629115539.w7lgjy2bmucgz7gm@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629115539.w7lgjy2bmucgz7gm@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:55:39PM +0200, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 01:42:27PM +0200, Andrew Jones wrote:
> > On Fri, Jun 29, 2018 at 11:53:34AM +0100, Sudeep Holla wrote:
> > > On Thu, Jun 28, 2018 at 12:12:00PM -0500, Jeremy Linton wrote:
> > > > Hi,
> > > > 
> > > > On 06/28/2018 11:30 AM, Sudeep Holla wrote:
> > > 
> > > [...]
> > > 
> > > > >I am not sure if we can ever guarantee that DT and ACPI will get the
> > > > >same ids whatever counter we use as it depends on the order presented in
> > > > >the firmware(DT or ACPI). So I am not for generating ids for core and
> > > > >threads in that way.
> > > > >
> > > > >So I would like to keep it simple and just have this counters for
> > > > >package ids as demonstrated in Shunyong's patch.
> > > >
> > > > So, currently on a non threaded system, the core id's look nice because they
> > > > are just the ACPI ids. Its the package id's that look strange, we could just
> > > > fix the package ids, but on threaded machines the threads have the nice acpi
> > > > ids, and the core ids are then funny numbers. So, I suspect that is driving
> > > > this as much as the strange package ids.
> > > >
> > > 
> > > Yes, I know that and that's what made be look at topology_get_acpi_cpu_tag
> > > For me, if the PPTT has valid ID, we should use that. Just becuase DT lacks
> > > it and uses counter doesn't mean ACPI also needs to follow that.
> > 
> > AFAIK, a valid ACPI UID doesn't need to be something derivable directly
> > from the hardware, so it's just as arbitrary as the CPU phandle that is
> > in the DT cpu-map, i.e. DT *does* have an analogous leaf node integer.
> > 
> > > 
> > > I am sure some vendor will put valid UID and expect that to be in the
> > > sysfs.
> > 
> > I can't think of any reason that would be useful, especially when the
> > UID is for a thread, which isn't even displayed by sysfs.
> > 
> > > 
> > > > (and as a side, I actually like the PE has a acpi id behavior, but for
> > > > threads its being lost with this patch...)
> > > > 
> > > > Given i've seen odd package/core ids on x86s a few years ago, it never
> > 
> > So this inspired me to grep some x86 topology code. I found
> > arch/x86/kernel/smpboot.c:topology_update_package_map(), which uses
> > a counter to set the logical package id and Documentation/x86/topology.txt
> > states
> > 
> > """
> >   - cpuinfo_x86.logical_id:
> > 
> >     The logical ID of the package. As we do not trust BIOSes to enumerate the
> >     packages in a consistent way, we introduced the concept of logical package
> >     ID so we can sanely calculate the number of maximum possible packages in
> >     the system and have the packages enumerated linearly.
> > """
> 
> Eh, x86 does seem to display the physical, rather than logical (linear)
> IDs in sysfs though,
> 
> arch/x86/include/asm/topology.h:#define topology_physical_package_id(cpu)       (cpu_data(cpu).phys_proc_id)
> 
> """
>   - cpuinfo_x86.phys_proc_id:
> 
>     The physical ID of the package. This information is retrieved via CPUID
>     and deduced from the APIC IDs of the cores in the package.
> """
> 
> So, hmmm...
> 
> But, I think we should either be looking for a hardware derived ID to use
> (like x86), or remap to counters. I don't believe the current scheme of
> using ACPI offsets can be better than counters, and it has consistency and
> human readability issues.
> 

UID was added for the same reason and we *have* to use it if present.
If not, OS can have it's own policy and I am fine with offset. So if
offset hurts eyes, better even the absence of UID in the PPTT. As we
don't have architectural way to derive it, we *have* to rely on platform
providing UID. If it doesn't, why should OS ? I really don't think
counter is the solution as this is user ABI, better be consistent rather
than human readable especially if platforms don't care to provide one.

--
Regards,
Sudeep
