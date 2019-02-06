Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94602175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfBFKqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:46:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfBFKqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:46:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 16630B7C2F6F0E17D115;
        Wed,  6 Feb 2019 18:46:12 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 18:46:04 +0800
Date:   Wed, 6 Feb 2019 10:45:52 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCHv5 10/10] doc/mm: New documentation for memory
 performance
Message-ID: <20190206104552.00003bad@huawei.com>
In-Reply-To: <20190124230724.10022-11-keith.busch@intel.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190124230724.10022-11-keith.busch@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 16:07:24 -0700
Keith Busch <keith.busch@intel.com> wrote:

> Platforms may provide system memory where some physical address ranges
> perform differently than others, or is side cached by the system.
> 
> Add documentation describing a high level overview of such systems and the
> perforamnce and caching attributes the kernel provides for applications
> wishing to query this information.
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
Hi Keith,

Nice doc in general. Comments inline.

> ---
>  Documentation/admin-guide/mm/numaperf.rst | 167 ++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/numaperf.rst
> 
> diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
> new file mode 100644
> index 000000000000..52999336a8ed
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/numaperf.rst
> @@ -0,0 +1,167 @@
> +.. _numaperf:
> +
> +=============
> +NUMA Locality
> +=============
> +
> +Some platforms may have multiple types of memory attached to a single
> +CPU. These disparate memory ranges share some characteristics, such as
> +CPU cache coherence, but may have different performance. For example,
> +different media types and buses affect bandwidth and latency.

This seems a bit restrictive, but I it gives a starting point.
I guess anyone who has a more complex system should look elsewhere for
how this maps to it!

> +
> +A system supporting such heterogeneous memory by grouping each memory
> +type under different "nodes" based on similar CPU locality and performance
> +characteristics.  Some memory may share the same node as a CPU, and others
> +are provided as memory only nodes. While memory only nodes do not provide
> +CPUs, they may still be directly accessible, or local, to one or more
> +compute nodes.

Perhaps define directly accessible?  I'm not keen on saying that they don't
involve an interconnect as that rules out things like CCIX with remote
memory homes.  The reality is this patch set works fine for that case.

The one or more compute nodes can only happen (I think) with a very weird
setup of an interconnect involved which is likely to have other data on it.

+ The following diagram shows one such example of two compute
> +nodes with local memory and a memory only node for each of compute node:
> +
> + +------------------+     +------------------+
> + | Compute Node 0   +-----+ Compute Node 1   |
> + | Local Node0 Mem  |     | Local Node1 Mem  |
> + +--------+---------+     +--------+---------+
> +          |                        |
> + +--------+---------+     +--------+---------+
> + | Slower Node2 Mem |     | Slower Node3 Mem |
> + +------------------+     +--------+---------+
> +
> +A "memory initiator" is a node containing one or more devices such as
> +CPUs or separate memory I/O devices that can initiate memory requests.
> +A "memory target" is a node containing one or more physical address
> +ranges accessible from one or more memory initiators.
> +
> +When multiple memory initiators exist, they may not all have the same
> +performance when accessing a given memory target. Each initiator-target
> +pair may be organized into different ranked access classes to represent
> +this relationship. The highest performing initiator to a given target
> +is considered to be one of that target's local initiators, and given
> +the highest access class, 0. Any given target may have one or more
> +local initiators, and any given initiator may have multiple local
> +memory targets.
> +
> +To aid applications matching memory targets with their initiators, the
> +kernel provides symlinks to each other. The following example lists the
> +relationship for the access class "0" memory initiators and targets, which is
> +the of nodes with the highest performing access relationship::
> +
> +	# symlinks -v /sys/devices/system/node/nodeX/access0/targets/
> +	relative: /sys/devices/system/node/nodeX/access0/targets/nodeY -> ../../nodeY
> +
> +	# symlinks -v /sys/devices/system/node/nodeY/access0/initiators/
> +	relative: /sys/devices/system/node/nodeY/access0/initiators/nodeX -> ../../nodeX
> +
> +================
> +NUMA Performance
> +================
> +
> +Applications may wish to consider which node they want their memory to
> +be allocated from based on the node's performance characteristics. If
> +the system provides these attributes, the kernel exports them under the
> +node sysfs hierarchy by appending the attributes directory under the
> +memory node's access class 0 initiators as follows::
> +
> +	/sys/devices/system/node/nodeY/access0/initiators/
> +
> +These attributes apply only when accessed from nodes that have the
> +are linked under the this access's inititiators.
> +
> +The performance characteristics the kernel provides for the local initiators
> +are exported are as follows::
> +
> +	# tree -P "read*|write*" /sys/devices/system/node/nodeY/access0/
> +	/sys/devices/system/node/nodeY/access0/
> +	|-- read_bandwidth
> +	|-- read_latency
> +	|-- write_bandwidth
> +	`-- write_latency

These seem to be under
/sys/devices/system/node/nodeY/access0/initiators/
(so one directory deeper).

> +
> +The bandwidth attributes are provided in MiB/second.
> +
> +The latency attributes are provided in nanoseconds.
> +
> +The values reported here correspond to the rated latency and bandwidth
> +for the platform.
> +
> +==========
> +NUMA Cache
> +==========
> +
> +System memory may be constructed in a hierarchy of elements with various
> +performance characteristics in order to provide large address space of
> +slower performing memory side-cached by a smaller higher performing
> +memory. The system physical addresses that initiators are aware of
> +are provided by the last memory level in the hierarchy. The system
> +meanwhile uses higher performing memory to transparently cache access
> +to progressively slower levels.
> +
> +The term "far memory" is used to denote the last level memory in the
> +hierarchy. Each increasing cache level provides higher performing
> +initiator access, and the term "near memory" represents the fastest
> +cache provided by the system.
> +
> +This numbering is different than CPU caches where the cache level (ex:
> +L1, L2, L3) uses a CPU centric view with each increased level is lower
> +performing. In contrast, the memory cache level is centric to the last
> +level memory, so the higher numbered cache level denotes memory nearer
> +to the CPU, and further from far memory.
> +
> +The memory side caches are not directly addressable by software. When
> +software accesses a system address, the system will return it from the
> +near memory cache if it is present. If it is not present, the system
> +accesses the next level of memory until there is either a hit in that
> +cache level, or it reaches far memory.
> +
> +An application does not need to know about caching attributes in order
> +to use the system. Software may optionally query the memory cache
> +attributes in order to maximize the performance out of such a setup.
> +If the system provides a way for the kernel to discover this information,
> +for example with ACPI HMAT (Heterogeneous Memory Attribute Table),
> +the kernel will append these attributes to the NUMA node memory target.
> +
> +When the kernel first registers a memory cache with a node, the kernel
> +will create the following directory::
> +
> +	/sys/devices/system/node/nodeX/side_cache/
> +
> +If that directory is not present, the system either does not not provide
> +a memory side cache, or that information is not accessible to the kernel.
> +
> +The attributes for each level of cache is provided under its cache
> +level index::
> +
> +	/sys/devices/system/node/nodeX/side_cache/indexA/
> +	/sys/devices/system/node/nodeX/side_cache/indexB/
> +	/sys/devices/system/node/nodeX/side_cache/indexC/
> +
> +Each cache level's directory provides its attributes. For example, the
> +following shows a single cache level and the attributes available for
> +software to query::
> +
> +	# tree sys/devices/system/node/node0/side_cache/
> +	/sys/devices/system/node/node0/side_cache/
> +	|-- index1
> +	|   |-- associativity
> +	|   |-- level

What is the purpose of having level in here?  Isn't it the same as the A..C
in the index naming?

> +	|   |-- line_size
> +	|   |-- size
> +	|   `-- write_policy
> +
> +The "associativity" will be 0 if it is a direct-mapped cache, and non-zero
> +for any other indexed based, multi-way associativity.

Is it worth providing the ACPI mapping in this doc?  We have None, Direct and
'complex'.   Fun question of what None means?  Not specified?

> +
> +The "level" is the distance from the far memory, and matches the number
> +appended to its "index" directory.
> +
> +The "line_size" is the number of bytes accessed on a cache miss.

Maybe "number of bytes accessed from next cache level" ?

> +
> +The "size" is the number of bytes provided by this cache level.
> +
> +The "write_policy" will be 0 for write-back, and non-zero for
> +write-through caching.
> +
> +========
> +See Also
> +========
> +.. [1] https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> +       Section 5.2.27


