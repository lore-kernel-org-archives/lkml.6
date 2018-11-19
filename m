Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA052080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA052080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeKSNIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:08:13 -0500
Received: from foss.arm.com ([217.140.101.70]:49934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeKSNIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:08:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5C7E80D;
        Sun, 18 Nov 2018 18:46:05 -0800 (PST)
Received: from [10.162.0.72] (unknown [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AF7A3F5A0;
        Sun, 18 Nov 2018 18:46:03 -0800 (PST)
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
To:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <79caebd8-ebf1-58b5-31e7-ead3626a1ec7@arm.com>
Date:   Mon, 19 Nov 2018 08:16:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181114224921.12123-2-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2018 04:19 AM, Keith Busch wrote:
> Memory-only nodes will often have affinity to a compute node, and
> platforms have ways to express that locality relationship.

It may not have a local affinity to any compute node but it might have a
valid NUMA distance from all available compute nodes. This is particularly
true when the coherent device memory which is accessible from all available
compute nodes without having local affinity to any compute node other than
the device compute which may or not be represented as a NUMA node in itself.

But in case of normally system memory also, a memory only node might be far
from other CPU nodes and may not have CPUs of it's own. In that case there
is no local affinity anyways.

> 
> A node containing CPUs or other DMA devices that can initiate memory
> access are referred to as "memory iniators". A "memory target" is a

Memory initiators should also include heterogeneous compute elements like
GPU cores, FPGA elements etc apart from CPU and DMA engines.

> node that provides at least one phyiscal address range accessible to a
> memory initiator.

This definition for "memory target" makes sense. Coherent accesses within
PA range from all possible "memory initiators" which should also include
heterogeneous compute elements as mentioned before.

> 
> In preparation for these systems, provide a new kernel API to link
> the target memory node to its initiator compute node with symlinks to
> each other.

Makes sense but how would we really define NUMA placement for various
heterogeneous compute elements which are connected differently to the
system bus differently than the CPU and DMA. 

> 
> The following example shows the new sysfs hierarchy setup for memory node
> 'Y' local to commpute node 'X':
> 
>   # ls -l /sys/devices/system/node/nodeX/initiator*
>   /sys/devices/system/node/nodeX/targetY -> ../nodeY
> 
>   # ls -l /sys/devices/system/node/nodeY/target*
>   /sys/devices/system/node/nodeY/initiatorX -> ../nodeX

This inter linking makes sense but once we are able to define all possible
memory initiators and memory targets as NUMA nodes (which might not very
trivial) taking into account heterogeneous compute environment. But this
linking at least establishes the coherency relationship between memory
initiators and memory targets.

> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/base/node.c  | 32 ++++++++++++++++++++++++++++++++
>  include/linux/node.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 86d6cd92ce3d..a9b7512a9502 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -372,6 +372,38 @@ int register_cpu_under_node(unsigned int cpu, unsigned int nid)
>  				 kobject_name(&node_devices[nid]->dev.kobj));
>  }
>  
> +int register_memory_node_under_compute_node(unsigned int m, unsigned int p)
> +{
> +	int ret;
> +	char initiator[20], target[17];

20, 17 seems arbitrary here.

> +
> +	if (!node_online(p) || !node_online(m))
> +		return -ENODEV;

Just wondering how a NUMA node for group of GPU compute elements will look
like which are not manage by kernel but are still memory initiators having
access to a number of memory targets.

> +	if (m == p)
> +		return 0;

Why skip ? Should not we link memory target to it's own node which can be
it's memory initiator as well. Caller of this linking function might decide
on whether the memory target is accessible from same NUMA node as a memory
initiator or not.

> +
> +	snprintf(initiator, sizeof(initiator), "initiator%d", p);
> +	snprintf(target, sizeof(target), "target%d", m);
> +
> +	ret = sysfs_create_link(&node_devices[p]->dev.kobj,
> +				&node_devices[m]->dev.kobj,
> +				target);
> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_link(&node_devices[m]->dev.kobj,
> +				&node_devices[p]->dev.kobj,
> +				initiator);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> + err:
> +	sysfs_remove_link(&node_devices[p]->dev.kobj,
> +			  kobject_name(&node_devices[m]->dev.kobj));
> +	return ret;
> +}
> +
>  int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
>  {
>  	struct device *obj;
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 257bb3d6d014..1fd734a3fb3f 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -75,6 +75,8 @@ extern int register_mem_sect_under_node(struct memory_block *mem_blk,
>  extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  					   unsigned long phys_index);
>  
> +extern int register_memory_node_under_compute_node(unsigned int m, unsigned int p);
> +
>  #ifdef CONFIG_HUGETLBFS
>  extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
>  					 node_registration_func_t unregister);
>
The code is all good but as mentioned before the primary concern is whether
this semantics will be able to correctly represent all possible present and
future heterogeneous compute environments with multi attribute memory. This
is going to be a kernel API. So apart from various NUMA representation for
all possible kinds, the interface has to be abstract with generic elements
and room for future extension.
