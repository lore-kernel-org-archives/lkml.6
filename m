Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F132C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2C92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2C92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937813AbeFSMwU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:52:20 -0400
Received: from foss.arm.com ([217.140.101.70]:49250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937580AbeFSMwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A60E80D;
        Tue, 19 Jun 2018 05:52:18 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E6CF3F557;
        Tue, 19 Jun 2018 05:52:17 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Michal Hocko <mhocko@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
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
References: <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
        <20180607122152.GP32433@dhcp22.suse.cz>
        <a880df29-b656-d98d-3037-b04761c7ed78@huawei.com>
        <20180611085237.GI13364@dhcp22.suse.cz>
        <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
        <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
        <20180611145330.GO13364@dhcp22.suse.cz>
        <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
        <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
        <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
        <20180619120714.GE13685@dhcp22.suse.cz>
Date:   Tue, 19 Jun 2018 13:52:16 +0100
In-Reply-To: <20180619120714.GE13685@dhcp22.suse.cz> (Michal Hocko's message
        of "Tue, 19 Jun 2018 14:07:14 +0200")
Message-ID: <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 19-06-18 20:03:07, Xie XiuQi wrote:
> [...]
>> I tested on a arm board with 128 cores 4 numa nodes, but I set CONFIG_NR_CPUS=72.
>> Then node 3 is not be created, because node 3 has no memory, and no cpu.
>> But some pci device may related to node 3, which be set in ACPI table.
>
> Could you double check that zonelists for node 3 are generated
> correctly?

The cpus in node 3 aren't onlined and there's no memory attached - I
suspect that no zonelists are built for this node.

We skip creating a node, if the number of SRAT entries parsed exceeds
NR_CPUS[0]. This in turn prevents onlining the numa node and so no
zonelists will be created for it.

I think the problem will go away if the cpus are restricted via the
kernel command line by setting nr_cpus.

Xie, can you try the below patch on top of the one enabling memoryless
nodes? I'm not sure this is the right solution but at least it'll
confirm the problem.

Thanks,
Punit

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/acpi_numa.c?h=v4.18-rc1#n73

-- >8 --
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index d190a7b231bf..fea0f7164f1a 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -70,11 +70,9 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
        if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
                return;

-   if (cpus_in_srat >= NR_CPUS) {
+ if (cpus_in_srat >= NR_CPUS)
                pr_warn_once("SRAT: cpu_to_node_map[%d] is too small, may not be able to use all cpus\n",
                             NR_CPUS);
-           return;
-   }

        pxm = pa->proximity_domain;
        node = acpi_map_pxm_to_node(pxm);
