Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D28C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F4A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F4A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937703AbeFSOya (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:54:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756852AbeFSOy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:54:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8B780D;
        Tue, 19 Jun 2018 07:54:28 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C304F3F557;
        Tue, 19 Jun 2018 07:54:27 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
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
References: <a880df29-b656-d98d-3037-b04761c7ed78@huawei.com>
        <20180611085237.GI13364@dhcp22.suse.cz>
        <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
        <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
        <20180611145330.GO13364@dhcp22.suse.cz>
        <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
        <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
        <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
        <20180619120714.GE13685@dhcp22.suse.cz>
        <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
        <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
Date:   Tue, 19 Jun 2018 15:54:26 +0100
In-Reply-To: <20180619140818.GA16927@e107981-ln.cambridge.arm.com> (Lorenzo
        Pieralisi's message of "Tue, 19 Jun 2018 15:08:26 +0100")
Message-ID: <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Tue, Jun 19, 2018 at 01:52:16PM +0100, Punit Agrawal wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>> 
>> > On Tue 19-06-18 20:03:07, Xie XiuQi wrote:
>> > [...]
>> >> I tested on a arm board with 128 cores 4 numa nodes, but I set CONFIG_NR_CPUS=72.
>> >> Then node 3 is not be created, because node 3 has no memory, and no cpu.
>> >> But some pci device may related to node 3, which be set in ACPI table.
>> >
>> > Could you double check that zonelists for node 3 are generated
>> > correctly?
>> 
>> The cpus in node 3 aren't onlined and there's no memory attached - I
>> suspect that no zonelists are built for this node.
>> 
>> We skip creating a node, if the number of SRAT entries parsed exceeds
>> NR_CPUS[0]. This in turn prevents onlining the numa node and so no
>> zonelists will be created for it.
>> 
>> I think the problem will go away if the cpus are restricted via the
>> kernel command line by setting nr_cpus.
>> 
>> Xie, can you try the below patch on top of the one enabling memoryless
>> nodes? I'm not sure this is the right solution but at least it'll
>> confirm the problem.
>
> This issue looks familiar (or at least related):
>
> git log d3bd058826aa

Indeed. Thanks for digging into this.

>
> The reason why the NR_CPUS guard is there is to avoid overflowing
> the early_node_cpu_hwid array.

Ah right... I missed that. The below patch is definitely not what we
want.

> IA64 does something different in
> that respect compared to x86, we have to have a look into this.
>
> Regardless, AFAICS the proximity domains to nodes mappings should not
> depend on CONFIG_NR_CPUS, it seems that there is something wrong in that
> in ARM64 ACPI SRAT parsing.

Not only SRAT parsing but it looks like there is a similar restriction
while parsing the ACPI MADT in acpi_map_gic_cpu_interface().

The incomplete parsing introduces a dependency on the ordering of
entries being aligned between SRAT and MADT when NR_CPUS is
restricted. We want to parse the entire table in both cases so that the
code is robust to reordering of entries.

In terms of $SUBJECT, I wonder if it's worth taking the original patch
as a temporary fix (it'll also be easier to backport) while we work on
fixing these other issues and enabling memoryless nodes.
