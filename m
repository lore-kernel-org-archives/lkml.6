Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BC4204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BC4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeKBVQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:16:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeKBVQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:16:10 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F056097B68C14;
        Fri,  2 Nov 2018 20:09:06 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 2 Nov 2018
 20:08:59 +0800
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
To:     Peter Zijlstra <peterz@infradead.org>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
 <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
 <20181031204622.GB3141@hirez.programming.kicks-ass.net>
 <bf2b890a-4ce7-d0f6-0663-84a1a6e8dbd2@huawei.com>
 <20181102105003.GK3178@hirez.programming.kicks-ass.net>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <be3f2f03-6d19-2c6a-e859-c946594e3af1@huawei.com>
Date:   Fri, 2 Nov 2018 12:08:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181102105003.GK3178@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 10:50, Peter Zijlstra wrote:
> On Thu, Nov 01, 2018 at 10:01:05AM +0000, John Garry wrote:
>> On 31/10/2018 20:46, Peter Zijlstra wrote:
>
>>>> I also note that if I apply the patch, below, to reject the invalid NUMA
>>>> distance, we're still getting a warning/error:
>>>>
>>>> [    7.144407] CPU: All CPU(s) started at EL2
>>>> [    7.148678] alternatives: patching kernel code
>>>> [    7.153557] ERROR: Node-0 not representative
>>>> [    7.153557]
>>>> [    7.159365]   10 15 20 25
>>>> [    7.162097]   15 10 25 30
>>>> [    7.164832]   20 25 10 15
>>>> [    7.167562]   25 30 15 10
>>>
>>> Yeah, that's an 'obviously' broken topology too.
>>>
>>
>> AFAICT, this conforms to ACPI spec SLIT rules, and the kernel SLIT
>> validation allows this also. So maybe we should shout louder here or even
>> mark the SLIT as invalid if totally broken.
>
> Right. Part of the problem is that I only have a few necessary
> conditions (symmetry, trace-identity, node0-complete-distance) for the
> distance table, but together they are not sufficient to determine if a
> topology is 'good'.
>
> (also, strictly speaking, non-symmetric topologies are possible -- think
> uni-directional mesh links -- we've just not ever seen and validated
> those)
>
> That said; I can certainly make this code give up and warn harder on
> those conditions.

That sounds reasonable, but I think that you would know better on the 
policy of whether it's better to give up when conditions are not met.

Regardless, a louder warn sounds good.

>
> How is something like the below?
>
> ---
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9d74371e4aad..41e703dd875f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1207,6 +1218,11 @@ sd_init(struct sched_domain_topology_level *tl,
>  	return sd;
>  }
>
> +static const struct cpumask *cpu_system_mask(int cpu)
> +{
> +	return cpu_online_mask;
> +}
> +
>  /*
>   * Topology list, bottom-up.
>   */
> @@ -1337,7 +1353,7 @@ void sched_init_numa(void)
>  	int level = 0;
>  	int i, j, k;
>
> -	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
> +	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);

Ahhhh, unfortuately this change in isolation is not fixing the crash for 
me. I'm still crashing in the same place repeatedly.

Here's relevant log with KASAN enabled:
[   10.655465] 
==================================================================
[   10.662772] BUG: KASAN: use-after-free in 
free_sched_groups.part.1+0x4c/0xf0
[   10.669896] Read of size 8 at addr ffff801db4668000 by task swapper/0/1
[   10.676578]
[   10.678079] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.19.0-rc6-00018-gf417e94-dirty #945
[   10.686432] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
[   10.692940] Call trace:
[   10.695407]  dump_backtrace+0x0/0x230
[   10.699104]  show_stack+0x14/0x20
[   10.702450]  dump_stack+0xa0/0xc4
[   10.705796]  print_address_description+0x60/0x270
[   10.710546]  kasan_report+0x258/0x360
[   10.714243]  __asan_load8+0x84/0xa8
[   10.717764]  free_sched_groups.part.1+0x4c/0xf0
[   10.722339]  destroy_sched_domain+0x50/0x118
[   10.726651]  cpu_attach_domain+0x140/0x450
[   10.730787]  build_sched_domains+0x1750/0x1820
[   10.735274]  sched_init_domains+0x8c/0xb0
[   10.739324]  sched_init_smp+0x2c/0x7c
[   10.743021]  kernel_init_freeable+0x138/0x2f0
[   10.747421]  kernel_init+0x10/0x120
[   10.750941]  ret_from_fork+0x10/0x18
[   10.754547]
[   10.756046] Allocated by task 1:
[   10.759303]  kasan_kmalloc+0xd0/0x180
[   10.763000]  build_sched_domains+0x2d0/0x1820
[   10.767400]  sched_init_domains+0x8c/0xb0
[   10.771448]  sched_init_smp+0x2c/0x7c
[   10.775145]  kernel_init_freeable+0x138/0x2f0
[   10.779544]  kernel_init+0x10/0x120
[   10.783064]  ret_from_fork+0x10/0x18
[   10.786671]
[   10.788168] Freed by task 1:
[   10.791074]  __kasan_slab_free+0x114/0x220
[   10.795209]  kasan_slab_free+0x10/0x18
[   10.798993]  kfree+0x74/0x210
[   10.801986]  free_sched_groups.part.1+0x74/0xf0
[   10.806562]  destroy_sched_domain+0x50/0x118
[   10.810874]  cpu_attach_domain+0x140/0x450
[   10.815009]  build_sched_domains+0x1750/0x1820
[   10.819496]  sched_init_domains+0x8c/0xb0
[   10.823544]  sched_init_smp+0x2c/0x7c
[   10.827241]  kernel_init_freeable+0x138/0x2f0
[   10.831639]  kernel_init+0x10/0x120
[   10.835159]  ret_from_fork+0x10/0x18
[   10.838766]
[   10.840264] The buggy address belongs to the object at ffff801db4668000
[   10.840264]  which belongs to the cache kmalloc-128 of size 128
[   10.852926] The buggy address is located 0 bytes inside of
[   10.852926]  128-byte region [ffff801db4668000, ffff801db4668080)
[   10.864619] The buggy address belongs to the page:
[   10.869459] page:ffff7e0076d19a00 count:1 mapcount:0 
mapping:ffff801dbac0fc00 index:0xffff801db4669f00 compound_mapcount: 0
[   10.880717] flags: 0x1fffc00000008100(slab|head)
[   10.885383] raw: 1fffc00000008100 ffff7e0076d19888 ffff7e0076d19a88 
ffff801dbac0fc00
[   10.893211] raw: ffff801db4669f00 0000000000200001 00000001ffffffff 
0000000000000000
[   10.901037] page dumped because: kasan: bad access detected
[   10.906664]
[   10.908162] Memory state around the buggy address:
[   10.913001]  ffff801db4667f00: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   10.920300]  ffff801db4667f80: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   10.927599] >ffff801db4668000: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   10.934897]                    ^
[   10.938153]  ffff801db4668080: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   10.945453]  ffff801db4668100: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   10.952752] 
==================================================================
[   10.960050] Disabling lock debugging due to kernel taint
[   10.982852] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000
[   10.991738] Mem abort info:
[   10.994554]   ESR = 0x96000004
[   10.997641]   Exception class = DABT (current EL), IL = 32 bits
[   11.003626]   SET = 0, FnV = 0
[   11.006706]   EA = 0, S1PTW = 0
[   11.009878] Data abort info:
[   11.012782]   ISV = 0, ISS = 0x00000004
[   11.016659]   CM = 0, WnR = 0
[   11.019651] [0000000000000000] user address but active_mm is swapper
[   11.026078] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   11.031707] Modules linked in:
[   11.034791] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B 
4.19.0-rc6-00018-gf417e94-dirty #945
[   11.044550] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
[   11.051058] pstate: 40000005 (nZcv daif -PAN -UAO)
[   11.055898] pc : free_sched_groups.part.1+0x4c/0xf0
[   11.060825] lr : free_sched_groups.part.1+0x4c/0xf0
[   11.065750] sp : ffff801db5d4fb60
[   11.069093] x29: ffff801db5d4fb60 x28: 00000000ffff0000
[   11.074462] x27: ffff2000094ad000 x26: ffff801db4b34000
[   11.079830] x25: ffff200008c7e080 x24: 0000000000000001
[   11.085197] x23: ffff200008c7e0c0 x22: ffff801db45b9810
[   11.090565] x21: ffff801db45c8000 x20: 0000000000000000
[   11.095932] x19: 0000000000000000 x18: 0000000034d5d91d
[   11.101300] x17: 00000000b44797ff x16: 0000000000000000
[   11.106667] x15: 0000000000000000 x14: 3d6769726f5f6773
[   11.112035] x13: 2030303230633534 x12: 6264313038666666
[   11.117403] x11: 6678303d6367733e x10: 2d677320313d6367
[   11.122770] x9 : 735f656572662073 x8 : 3038633534626431
[   11.128138] x7 : 3038666666667830 x6 : 0000000000000000
[   11.133505] x5 : ffff2000094ad6c8 x4 : 0000000000000000
[   11.138872] x3 : ffff200008154bf4 x2 : 0000000000000000
[   11.144239] x1 : 176366c3c3548000 x0 : 0000000000000000
[   11.149608] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[   11.156379] Call trace:
[   11.158845]  free_sched_groups.part.1+0x4c/0xf0
[   11.163421]  destroy_sched_domain+0x50/0x118
[   11.167732]  cpu_attach_domain+0x140/0x450
[   11.171868]  build_sched_domains+0x1750/0x1820
[   11.176356]  sched_init_domains+0x8c/0xb0
[   11.180404]  sched_init_smp+0x2c/0x7c
[   11.184100]  kernel_init_freeable+0x138/0x2f0
[   11.188499]  kernel_init+0x10/0x120
[   11.192020]  ret_from_fork+0x10/0x18
[   11.195629] Code: eb15029f 54000200 aa1303e0 94059f92 (f9400274)
[   11.201867] ---[ end trace 794769e2506810a5 ]---
[   11.206558] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[   11.206558]
[   11.215809] SMP: stopping secondary CPUs
[   11.219795] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b
[   11.219795]  ]---


The KASAN bug report is essentially the same with and without this change.

I did not try the full patch, and I guess the problem would go away 
after the full patch is applied, but you may want to know the issue still..

Thanks,
John


>  	if (!sched_domains_numa_distance)
>  		return;
>
> @@ -1353,39 +1369,22 @@ void sched_init_numa(void)
>  	 * node_distance(i,j) in order to avoid cubic time.
>  	 */
>  	next_distance = curr_distance;
> +
>  	for (i = 0; i < nr_node_ids; i++) {
>  		for (j = 0; j < nr_node_ids; j++) {
> -			for (k = 0; k < nr_node_ids; k++) {
> -				int distance = node_distance(i, k);
> -
> -				if (distance > curr_distance &&
> -				    (distance < next_distance ||
> -				     next_distance == curr_distance))
> -					next_distance = distance;
> -
> -				/*
> -				 * While not a strong assumption it would be nice to know
> -				 * about cases where if node A is connected to B, B is not
> -				 * equally connected to A.
> -				 */
> -				if (sched_debug() && node_distance(k, i) != distance)
> -					sched_numa_warn("Node-distance not symmetric");
> -
> -				if (sched_debug() && i && !find_numa_distance(distance))
> -					sched_numa_warn("Node-0 not representative");
> -			}
> -			if (next_distance != curr_distance) {
> -				sched_domains_numa_distance[level++] = next_distance;
> -				sched_domains_numa_levels = level;
> -				curr_distance = next_distance;
> -			} else break;
> -		}
> +			int distance = node_distance(0, j);
>
> -		/*
> -		 * In case of sched_debug() we verify the above assumption.
> -		 */
> -		if (!sched_debug())
> -			break;
> +			if (distance > curr_distance &&
> +			    (distance < next_distance ||
> +			     next_distance == curr_distance))
> +				next_distance = distance;
> +
> +		}
> +		if (next_distance != curr_distance) {
> +			sched_domains_numa_distance[level++] = next_distance;
> +			sched_domains_numa_levels = level;
> +			curr_distance = next_distance;
> +		} else break;
>  	}
>
>  	/*
> @@ -1428,7 +1427,24 @@ void sched_init_numa(void)
>  			sched_domains_numa_masks[i][j] = mask;
>
>  			for_each_node(k) {
> -				if (node_distance(j, k) > sched_domains_numa_distance[i])
> +				int distance = node_distance(j, k);
> +
> +				if (!i && j != k) {
> +					sched_numa_warn("Non-trace locality\n");
> +					goto fail;
> +				}
> +
> +				if (distance > curr_distance) {
> +					sched_numa_warn("Node-0 not complete\n");
> +					goto fail;
> +				}
> +
> +				if (distance != node_distance(k, j)) {
> +					sched_numa_warn("Non symmetric\n");
> +					goto fail;
> +				}
> +
> +				if (distance > sched_domains_numa_distance[i])
>  					continue;
>
>  				cpumask_or(mask, mask, cpumask_of_node(k));
> @@ -1437,9 +1453,10 @@ void sched_init_numa(void)
>  	}
>
>  	/* Compute default topology size */
> -	for (i = 0; sched_domain_topology[i].mask; i++);
> +	for (k = 0; sched_domain_topology[k].mask; k++)
> +		;
>
> -	tl = kzalloc((i + level + 1) *
> +	tl = kzalloc((k + level + 1) *
>  			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
>  	if (!tl)
>  		return;
> @@ -1447,7 +1464,7 @@ void sched_init_numa(void)
>  	/*
>  	 * Copy the default topology bits..
>  	 */
> -	for (i = 0; sched_domain_topology[i].mask; i++)
> +	for (i = 0; i < k; i++)
>  		tl[i] = sched_domain_topology[i];
>
>  	/*
> @@ -1478,6 +1495,31 @@ void sched_init_numa(void)
>  	sched_max_numa_distance = sched_domains_numa_distance[level - 1];
>
>  	init_numa_topology_type();
> +
> +	return;
> +
> +fail:
> +	/* Compute default topology size */
> +	for (k = 0; sched_domain_topology[k].mask; k++)
> +		;
> +
> +	tl = kzalloc((k + 2) *
> +			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
> +	if (!tl)
> +		return;
> +
> +	/*
> +	 * Copy the default topology bits..
> +	 */
> +	for (i = 0; i < k; i++)
> +		tl[i] = sched_domain_topology[i];
> +
> +	tl[i] = (struct sched_domain_topology_level){
> +		.mask = cpu_system_mask,
> +		SD_INIT_NAME(SYSTEM)
> +	};
> +
> +	sched_domain_topology = tl;
>  }
>
>  void sched_domains_numa_masks_set(unsigned int cpu)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>


