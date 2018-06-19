Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAADAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D520020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0D520020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966998AbeFSQdH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:33:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966368AbeFSQdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:33:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594461596;
        Tue, 19 Jun 2018 09:33:05 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.207.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443693F246;
        Tue, 19 Jun 2018 09:33:02 -0700 (PDT)
Date:   Tue, 19 Jun 2018 17:32:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        tnowicki@caviumnetworks.com, linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, wanghuiqiang@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhongjiang <zhongjiang@huawei.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
Message-ID: <20180619163256.GA18952@e107981-ln.cambridge.arm.com>
References: <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
 <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
 <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
 <20180619120714.GE13685@dhcp22.suse.cz>
 <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
 <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
 <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
 <20180619151425.GH13685@dhcp22.suse.cz>
 <87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:35:40PM +0100, Punit Agrawal wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
> > [...]
> >> In terms of $SUBJECT, I wonder if it's worth taking the original patch
> >> as a temporary fix (it'll also be easier to backport) while we work on
> >> fixing these other issues and enabling memoryless nodes.
> >
> > Well, x86 already does that but copying this antipatern is not really
> > nice. So it is good as a quick fix but it would be definitely much
> > better to have a robust fix. Who knows how many other places might hit
> > this. You certainly do not want to add a hack like this all over...
> 
> Completely agree! I was only suggesting it as a temporary measure,
> especially as it looked like a proper fix might be invasive.
> 
> Another fix might be to change the node specific allocation to node
> agnostic allocations. It isn't clear why the allocation is being
> requested from a specific node. I think Lorenzo suggested this in one of
> the threads.

I think that code was just copypasted but it is better to fix the
underlying issue.

> I've started putting together a set fixing the issues identified in this
> thread. It should give a better idea on the best course of action.

On ACPI ARM64, this diff should do if I read the code correctly, it
should be (famous last words) just a matter of mapping PXMs to nodes for
every SRAT GICC entry, feel free to pick it up if it works.

Yes, we can take the original patch just because it is safer for an -rc
cycle even though if the patch below would do delaying the fix for a
couple of -rc (to get it tested across ACPI ARM64 NUMA platforms) is
not a disaster.

Lorenzo

-- >8 --
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index d190a7b231bf..877b268ef9fa 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -70,12 +70,6 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 	if (!(pa->flags & ACPI_SRAT_GICC_ENABLED))
 		return;
 
-	if (cpus_in_srat >= NR_CPUS) {
-		pr_warn_once("SRAT: cpu_to_node_map[%d] is too small, may not be able to use all cpus\n",
-			     NR_CPUS);
-		return;
-	}
-
 	pxm = pa->proximity_domain;
 	node = acpi_map_pxm_to_node(pxm);
 
@@ -85,6 +79,14 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 		return;
 	}
 
+	node_set(node, numa_nodes_parsed);
+
+	if (cpus_in_srat >= NR_CPUS) {
+		pr_warn_once("SRAT: cpu_to_node_map[%d] is too small, may not be able to use all cpus\n",
+			     NR_CPUS);
+		return;
+	}
+
 	mpidr = acpi_map_madt_entry(pa->acpi_processor_uid);
 	if (mpidr == PHYS_CPUID_INVALID) {
 		pr_err("SRAT: PXM %d with ACPI ID %d has no valid MPIDR in MADT\n",
@@ -95,7 +97,6 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 
 	early_node_cpu_hwid[cpus_in_srat].node_id = node;
 	early_node_cpu_hwid[cpus_in_srat].cpu_hwid =  mpidr;
-	node_set(node, numa_nodes_parsed);
 	cpus_in_srat++;
 	pr_info("SRAT: PXM %d -> MPIDR 0x%Lx -> Node %d\n",
 		pxm, mpidr, node);
