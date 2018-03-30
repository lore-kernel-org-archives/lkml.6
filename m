Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeC3J65 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:58:57 -0400
Received: from wp227.webpack.hosteurope.de ([80.237.132.234]:46418 "EHLO
        wp227.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751057AbeC3J6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:58:54 -0400
Subject: Re: [PATCH AUTOSEL for 4.15 116/124] genirq/affinity: assign vectors
 to all possible CPUs
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-116-alexander.levin@microsoft.com>
 <0b7c5fd8-118c-6174-3078-c8ff53cb53cd@leemhuis.info>
Message-ID: <bd6f3ab0-9d05-5883-99d6-c489f489dc26@leemhuis.info>
Date: Fri, 30 Mar 2018 11:58:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0b7c5fd8-118c-6174-3078-c8ff53cb53cd@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1522403934;ce274d72;
X-HE-SMSGID: 1f1qo1-0004pa-GU
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lo! On 27.03.2018 20:33, Thorsten Leemhuis wrote:
> On 19.03.2018 16:49, Sasha Levin wrote:
>> From: Christoph Hellwig <hch@lst.de>
>> [ Upstream commit 84676c1f21e8ff54befe985f4f14dc1edc10046b ]
> TWIMC: That commit (also reported by autosel for 4.14) triggered a
> regression in 4.16 reported by Artem Bityutskiy in "regression:
> SCSI/SATA failure" (https://marc.info/?l=linux-kernel&m=151931128006031
> ). […]

For the record, from what I head it in between was fixed by these:

2f31115e940c scsi: core: introduce force_blk_mq
8b834bff1b73 scsi: hpsa: fix selection of reply queue
adbe552349f2 scsi: megaraid_sas: fix selection of reply queue
c3506df85091 scsi: virtio_scsi: unify scsi_host_template
b5b6e8c8d3b4 scsi: virtio_scsi: fix IO hang caused by automatic irq
vector affinity

Ciao, Thorsten

>> Currently we assign managed interrupt vectors to all present CPUs.  This
>> works fine for systems were we only online/offline CPUs.  But in case of
>> systems that support physical CPU hotplug (or the virtualized version of
>> it) this means the additional CPUs covered for in the ACPI tables or on
>> the command line are not catered for.  To fix this we'd either need to
>> introduce new hotplug CPU states just for this case, or we can start
>> assining vectors to possible but not present CPUs.
>>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Tested-by: Stefan Haberland <sth@linux.vnet.ibm.com>
>> Fixes: 4b855ad37194 ("blk-mq: Create hctx for each present CPU")
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  kernel/irq/affinity.c | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
>> index e12d35108225..a37a3b4b6342 100644
>> --- a/kernel/irq/affinity.c
>> +++ b/kernel/irq/affinity.c
>> @@ -39,7 +39,7 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>>  	}
>>  }
>>  
>> -static cpumask_var_t *alloc_node_to_present_cpumask(void)
>> +static cpumask_var_t *alloc_node_to_possible_cpumask(void)
>>  {
>>  	cpumask_var_t *masks;
>>  	int node;
>> @@ -62,7 +62,7 @@ static cpumask_var_t *alloc_node_to_present_cpumask(void)
>>  	return NULL;
>>  }
>>  
>> -static void free_node_to_present_cpumask(cpumask_var_t *masks)
>> +static void free_node_to_possible_cpumask(cpumask_var_t *masks)
>>  {
>>  	int node;
>>  
>> @@ -71,22 +71,22 @@ static void free_node_to_present_cpumask(cpumask_var_t *masks)
>>  	kfree(masks);
>>  }
>>  
>> -static void build_node_to_present_cpumask(cpumask_var_t *masks)
>> +static void build_node_to_possible_cpumask(cpumask_var_t *masks)
>>  {
>>  	int cpu;
>>  
>> -	for_each_present_cpu(cpu)
>> +	for_each_possible_cpu(cpu)
>>  		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
>>  }
>>  
>> -static int get_nodes_in_cpumask(cpumask_var_t *node_to_present_cpumask,
>> +static int get_nodes_in_cpumask(cpumask_var_t *node_to_possible_cpumask,
>>  				const struct cpumask *mask, nodemask_t *nodemsk)
>>  {
>>  	int n, nodes = 0;
>>  
>>  	/* Calculate the number of nodes in the supplied affinity mask */
>>  	for_each_node(n) {
>> -		if (cpumask_intersects(mask, node_to_present_cpumask[n])) {
>> +		if (cpumask_intersects(mask, node_to_possible_cpumask[n])) {
>>  			node_set(n, *nodemsk);
>>  			nodes++;
>>  		}
>> @@ -109,7 +109,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  	int last_affv = affv + affd->pre_vectors;
>>  	nodemask_t nodemsk = NODE_MASK_NONE;
>>  	struct cpumask *masks;
>> -	cpumask_var_t nmsk, *node_to_present_cpumask;
>> +	cpumask_var_t nmsk, *node_to_possible_cpumask;
>>  
>>  	/*
>>  	 * If there aren't any vectors left after applying the pre/post
>> @@ -125,8 +125,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  	if (!masks)
>>  		goto out;
>>  
>> -	node_to_present_cpumask = alloc_node_to_present_cpumask();
>> -	if (!node_to_present_cpumask)
>> +	node_to_possible_cpumask = alloc_node_to_possible_cpumask();
>> +	if (!node_to_possible_cpumask)
>>  		goto out;
>>  
>>  	/* Fill out vectors at the beginning that don't need affinity */
>> @@ -135,8 +135,8 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  
>>  	/* Stabilize the cpumasks */
>>  	get_online_cpus();
>> -	build_node_to_present_cpumask(node_to_present_cpumask);
>> -	nodes = get_nodes_in_cpumask(node_to_present_cpumask, cpu_present_mask,
>> +	build_node_to_possible_cpumask(node_to_possible_cpumask);
>> +	nodes = get_nodes_in_cpumask(node_to_possible_cpumask, cpu_possible_mask,
>>  				     &nodemsk);
>>  
>>  	/*
>> @@ -146,7 +146,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  	if (affv <= nodes) {
>>  		for_each_node_mask(n, nodemsk) {
>>  			cpumask_copy(masks + curvec,
>> -				     node_to_present_cpumask[n]);
>> +				     node_to_possible_cpumask[n]);
>>  			if (++curvec == last_affv)
>>  				break;
>>  		}
>> @@ -160,7 +160,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  		vecs_per_node = (affv - (curvec - affd->pre_vectors)) / nodes;
>>  
>>  		/* Get the cpus on this node which are in the mask */
>> -		cpumask_and(nmsk, cpu_present_mask, node_to_present_cpumask[n]);
>> +		cpumask_and(nmsk, cpu_possible_mask, node_to_possible_cpumask[n]);
>>  
>>  		/* Calculate the number of cpus per vector */
>>  		ncpus = cpumask_weight(nmsk);
>> @@ -192,7 +192,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>>  	/* Fill out vectors at the end that don't need affinity */
>>  	for (; curvec < nvecs; curvec++)
>>  		cpumask_copy(masks + curvec, irq_default_affinity);
>> -	free_node_to_present_cpumask(node_to_present_cpumask);
>> +	free_node_to_possible_cpumask(node_to_possible_cpumask);
>>  out:
>>  	free_cpumask_var(nmsk);
>>  	return masks;
>> @@ -214,7 +214,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>>  		return 0;
>>  
>>  	get_online_cpus();
>> -	ret = min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
>> +	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
>>  	put_online_cpus();
>>  	return ret;
>>  }
>>
