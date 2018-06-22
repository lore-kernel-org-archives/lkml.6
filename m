Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB780C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8646924051
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8646924051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbeFVKYm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:24:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33016 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbeFVKYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:24:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B3391596;
        Fri, 22 Jun 2018 03:24:40 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2A8E3F557;
        Fri, 22 Jun 2018 03:24:39 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <tnowicki@caviumnetworks.com>, <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-mm@kvack.org>, <wanghuiqiang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhongjiang <zhongjiang@huawei.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
References: <20180619120714.GE13685@dhcp22.suse.cz>
        <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
        <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
        <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
        <20180619151425.GH13685@dhcp22.suse.cz>
        <87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
        <20180619163256.GA18952@e107981-ln.cambridge.arm.com>
        <814205eb-ae86-a519-bed0-f09b8e2d3a02@huawei.com>
        <87602d3ccl.fsf@e105922-lin.cambridge.arm.com>
        <5c083c9c-473f-f504-848b-48506d0fd380@huawei.com>
        <20180622091153.GU10465@dhcp22.suse.cz>
Date:   Fri, 22 Jun 2018 11:24:38 +0100
In-Reply-To: <20180622091153.GU10465@dhcp22.suse.cz> (Michal Hocko's message
        of "Fri, 22 Jun 2018 11:11:53 +0200")
Message-ID: <87y3f7yv89.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 22-06-18 16:58:05, Hanjun Guo wrote:
>> On 2018/6/20 19:51, Punit Agrawal wrote:
>> > Xie XiuQi <xiexiuqi@huawei.com> writes:
>> > 
>> >> Hi Lorenzo, Punit,
>> >>
>> >>
>> >> On 2018/6/20 0:32, Lorenzo Pieralisi wrote:
>> >>> On Tue, Jun 19, 2018 at 04:35:40PM +0100, Punit Agrawal wrote:
>> >>>> Michal Hocko <mhocko@kernel.org> writes:
>> >>>>
>> >>>>> On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
>> >>>>> [...]
>> >>>>>> In terms of $SUBJECT, I wonder if it's worth taking the original patch
>> >>>>>> as a temporary fix (it'll also be easier to backport) while we work on
>> >>>>>> fixing these other issues and enabling memoryless nodes.
>> >>>>>
>> >>>>> Well, x86 already does that but copying this antipatern is not really
>> >>>>> nice. So it is good as a quick fix but it would be definitely much
>> >>>>> better to have a robust fix. Who knows how many other places might hit
>> >>>>> this. You certainly do not want to add a hack like this all over...
>> >>>>
>> >>>> Completely agree! I was only suggesting it as a temporary measure,
>> >>>> especially as it looked like a proper fix might be invasive.
>> >>>>
>> >>>> Another fix might be to change the node specific allocation to node
>> >>>> agnostic allocations. It isn't clear why the allocation is being
>> >>>> requested from a specific node. I think Lorenzo suggested this in one of
>> >>>> the threads.
>> >>>
>> >>> I think that code was just copypasted but it is better to fix the
>> >>> underlying issue.
>> >>>
>> >>>> I've started putting together a set fixing the issues identified in this
>> >>>> thread. It should give a better idea on the best course of action.
>> >>>
>> >>> On ACPI ARM64, this diff should do if I read the code correctly, it
>> >>> should be (famous last words) just a matter of mapping PXMs to nodes for
>> >>> every SRAT GICC entry, feel free to pick it up if it works.
>> >>>
>> >>> Yes, we can take the original patch just because it is safer for an -rc
>> >>> cycle even though if the patch below would do delaying the fix for a
>> >>> couple of -rc (to get it tested across ACPI ARM64 NUMA platforms) is
>> >>> not a disaster.
>> >>
>> >> I tested this patch on my arm board, it works.
>> > 
>> > I am assuming you tried the patch without enabling support for
>> > memory-less nodes.
>> > 
>> > The patch de-couples the onlining of numa nodes (as parsed from SRAT)
>> > from NR_CPUS restriction. When it comes to building zonelists, the node
>> > referenced by the PCI controller also has zonelists initialised.
>> > 
>> > So it looks like a fallback node is setup even if we don't have
>> > memory-less nodes enabled. I need to stare some more at the code to see
>> > why we need memory-less nodes at all then ...
>> 
>> Yes, please. From my limited MM knowledge, zonelists should not be
>> initialised if no CPU and no memory on this node, correct me if I'm
>> wrong.
>
> Well, as long as there is a code which can explicitly ask for a specific
> node than it is safer to have zonelists configured. Otherwise you just
> force callers to add hacks and figure out the proper placement there.
> Zonelists should be cheep to configure for all possible nodes. It's not
> like we are talking about huge amount of resources.

I agree. The current problem stems from not configuring the zonelists
for nodes that don't have onlined cpu and memory. Lorenzo's patch fixes
the configuration of such nodes.

For allocation requests targeting memory-less nodes, the allocator will
take the slow path and fall back to one of the other nodes based on the
zonelists.

I'm not sure how common such allocations are but I'll work on enabling
CONFIG_HAVE_MEMORYLESS_NODES on top of Lorenzo's patch. AIUI, this
config improves the fallback mechanism by starting the search from a
near-by node with memory.
