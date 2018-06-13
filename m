Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8A4CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A602D208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A602D208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935338AbeFMRjF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:39:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934796AbeFMRjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:39:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C981435;
        Wed, 13 Jun 2018 10:39:02 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652173F25D;
        Wed, 13 Jun 2018 10:39:02 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Xie XiuQi <xiexiuqi@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, tnowicki@caviumnetworks.com,
        linux-pci@vger.kernel.org,
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
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/2] arm64: avoid alloc memory on offline node
References: <1527768879-88161-2-git-send-email-xiexiuqi@huawei.com>
        <20180606154516.GL6631@arm.com>
        <CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTSowTt6t3XerpHnA@mail.gmail.com>
        <20180607105514.GA13139@dhcp22.suse.cz>
        <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
        <20180607122152.GP32433@dhcp22.suse.cz>
        <a880df29-b656-d98d-3037-b04761c7ed78@huawei.com>
        <20180611085237.GI13364@dhcp22.suse.cz>
        <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
        <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
        <20180611145330.GO13364@dhcp22.suse.cz>
        <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
Date:   Wed, 13 Jun 2018 18:39:00 +0100
In-Reply-To: <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com> (Punit Agrawal's
        message of "Tue, 12 Jun 2018 16:08:03 +0100")
Message-ID: <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Punit Agrawal <punit.agrawal@arm.com> writes:


[...]

>
> CONFIG_HAVE_MEMORYLESS node is not enabled on arm64 which means we end
> up returning the original node in the fallback path.
>
> Xie, does the below patch help? I can submit a proper patch if this
> fixes the issue for you.
>
> -- >8 --
> Subject: [PATCH] arm64/numa: Enable memoryless numa nodes
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  arch/arm64/Kconfig   | 4 ++++
>  arch/arm64/mm/numa.c | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eb2cf4938f6d..5317e9aa93ab 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -756,6 +756,10 @@ config USE_PERCPU_NUMA_NODE_ID
>  	def_bool y
>  	depends on NUMA
>  
> +config HAVE_MEMORYLESS_NODES
> +       def_bool y
> +       depends on NUMA
> +
>  config HAVE_SETUP_PER_CPU_AREA
>  	def_bool y
>  	depends on NUMA
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index dad128ba98bf..c699dcfe93de 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -73,6 +73,8 @@ EXPORT_SYMBOL(cpumask_of_node);
>  static void map_cpu_to_node(unsigned int cpu, int nid)
>  {
>  	set_cpu_numa_node(cpu, nid);
> +	set_numa_mem(local_memory_node(nid));

Argh, this should be

        set_cpu_numa_mem(cpu, local_memory_node(nid));

There is not guarantee that map_cpu_to_node() will be called on the
local cpu.

Hanjun, Xie - can you try with the update please?

Thanks,
Punit

> +
>  	if (nid >= 0)
>  		cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
>  }
