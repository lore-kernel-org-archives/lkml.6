Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3377C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6ED21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tr55SYIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAYGNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:13:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59472 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAYGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:13:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0P68hXW177929;
        Fri, 25 Jan 2019 06:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cSsSIfNJzSgTtm3+V4AFS9NdlqG4Rh3ZwU/ep9NMHlo=;
 b=tr55SYIHoAEaMOoVM/RL0cYDDJXff1evgUCPnHYUKoDyPVqAEQd9evBxPRZlkYb6g79G
 NiCsr4TW0wsuPFv71RUJXXgZ3W5CDIh+wjxeoA3+Ml2vsDByd6M1Psh3Bium1ZnOenzD
 bg46cnD1Rb7MOHGLI6IN3wqGqMN8DXocxQU3BaI1414BvfYc/4udwqt9FeHrIInZbAEW
 QkMLQGq5fT54pEXgAXavUr8is8FQrRXmSHBu6q55i4tuj8z1XwgDsEy6xe2llb82Mbd9
 TBG/tWWJecU8Stm3ktHK5Bofejb3ZkIC+KREyrEj/o7lD/yNSjz+K33IX2agZqCaTin8 bw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2q3uav3vc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 06:13:06 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0P6D62c031124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 06:13:06 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0P6D2P5004808;
        Fri, 25 Jan 2019 06:13:03 GMT
Received: from [10.159.139.185] (/10.159.139.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Jan 2019 22:13:02 -0800
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal
 RAM
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, mhocko@suse.com,
        linux-nvdimm@lists.01.org, tiwai@suse.de, ying.huang@intel.com,
        linux-mm@kvack.org, jglisse@redhat.com, bp@suse.de,
        baiyaowei@cmss.chinamobile.com, zwisler@kernel.org,
        bhelgaas@google.com, fengguang.wu@intel.com,
        akpm@linux-foundation.org
References: <20190124231441.37A4A305@viggo.jf.intel.com>
 <20190124231448.E102D18E@viggo.jf.intel.com>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com>
Date:   Thu, 24 Jan 2019 22:13:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124231448.E102D18E@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9146 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave,

While chatting with my colleague Erwin about the patchset, it occurred
that we're not clear about the error handling part. Specifically,

1. If an uncorrectable error is detected during a 'load' in the hot 
plugged pmem region, how will the error be handled?  will it be
handled like PMEM or DRAM?

2. If a poison is set, and is persistent, which entity should clear
the poison, and badblock(if applicable)? If it's user's responsibility,
does ndctl support the clearing in this mode?

thanks!
-jane


On 1/24/2019 3:14 PM, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This is intended for use with NVDIMMs that are physically persistent
> (physically like flash) so that they can be used as a cost-effective
> RAM replacement.  Intel Optane DC persistent memory is one
> implementation of this kind of NVDIMM.
> 
> Currently, a persistent memory region is "owned" by a device driver,
> either the "Direct DAX" or "Filesystem DAX" drivers.  These drivers
> allow applications to explicitly use persistent memory, generally
> by being modified to use special, new libraries. (DIMM-based
> persistent memory hardware/software is described in great detail
> here: Documentation/nvdimm/nvdimm.txt).
> 
> However, this limits persistent memory use to applications which
> *have* been modified.  To make it more broadly usable, this driver
> "hotplugs" memory into the kernel, to be managed and used just like
> normal RAM would be.
> 
> To make this work, management software must remove the device from
> being controlled by the "Device DAX" infrastructure:
> 
> 	echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
> 	echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> 
> and then bind it to this new driver:
> 
> 	echo -n dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> 	echo -n dax0.0 > /sys/bus/dax/drivers/kmem/bind
> 
> After this, there will be a number of new memory sections visible
> in sysfs that can be onlined, or that may get onlined by existing
> udev-initiated memory hotplug rules.
> 
> This rebinding procedure is currently a one-way trip.  Once memory
> is bound to "kmem", it's there permanently and can not be
> unbound and assigned back to device_dax.
> 
> The kmem driver will never bind to a dax device unless the device
> is *explicitly* bound to the driver.  There are two reasons for
> this: One, since it is a one-way trip, it can not be undone if
> bound incorrectly.  Two, the kmem driver destroys data on the
> device.  Think of if you had good data on a pmem device.  It
> would be catastrophic if you compile-in "kmem", but leave out
> the "device_dax" driver.  kmem would take over the device and
> write volatile data all over your good data.
> 
> This inherits any existing NUMA information for the newly-added
> memory from the persistent memory device that came from the
> firmware.  On Intel platforms, the firmware has guarantees that
> require each socket's persistent memory to be in a separate
> memory-only NUMA node.  That means that this patch is not expected
> to create NUMA nodes, but will simply hotplug memory into existing
> nodes.
> 
> Because NUMA nodes are created, the existing NUMA APIs and tools
> are sufficient to create policies for applications or memory areas
> to have affinity for or an aversion to using this memory.
> 
> There is currently some metadata at the beginning of pmem regions.
> The section-size memory hotplug restrictions, plus this small
> reserved area can cause the "loss" of a section or two of capacity.
> This should be fixable in follow-on patches.  But, as a first step,
> losing 256MB of memory (worst case) out of hundreds of gigabytes
> is a good tradeoff vs. the required code to fix this up precisely.
> This calculation is also the reason we export
> memory_block_size_bytes().
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jerome Glisse <jglisse@redhat.com>
> ---
> 
>   b/drivers/base/memory.c |    1
>   b/drivers/dax/Kconfig   |   16 +++++++
>   b/drivers/dax/Makefile  |    1
>   b/drivers/dax/kmem.c    |  108 ++++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 126 insertions(+)
> 
> diff -puN drivers/base/memory.c~dax-kmem-try-4 drivers/base/memory.c
> --- a/drivers/base/memory.c~dax-kmem-try-4	2019-01-24 15:13:15.987199535 -0800
> +++ b/drivers/base/memory.c	2019-01-24 15:13:15.994199535 -0800
> @@ -88,6 +88,7 @@ unsigned long __weak memory_block_size_b
>   {
>   	return MIN_MEMORY_BLOCK_SIZE;
>   }
> +EXPORT_SYMBOL_GPL(memory_block_size_bytes);
>   
>   static unsigned long get_memory_block_size(void)
>   {
> diff -puN drivers/dax/Kconfig~dax-kmem-try-4 drivers/dax/Kconfig
> --- a/drivers/dax/Kconfig~dax-kmem-try-4	2019-01-24 15:13:15.988199535 -0800
> +++ b/drivers/dax/Kconfig	2019-01-24 15:13:15.994199535 -0800
> @@ -32,6 +32,22 @@ config DEV_DAX_PMEM
>   
>   	  Say M if unsure
>   
> +config DEV_DAX_KMEM
> +	tristate "KMEM DAX: volatile-use of persistent memory"
> +	default DEV_DAX
> +	depends on DEV_DAX
> +	depends on MEMORY_HOTPLUG # for add_memory() and friends
> +	help
> +	  Support access to persistent memory as if it were RAM.  This
> +	  allows easier use of persistent memory by unmodified
> +	  applications.
> +
> +	  To use this feature, a DAX device must be unbound from the
> +	  device_dax driver (PMEM DAX) and bound to this kmem driver
> +	  on each boot.
> +
> +	  Say N if unsure.
> +
>   config DEV_DAX_PMEM_COMPAT
>   	tristate "PMEM DAX: support the deprecated /sys/class/dax interface"
>   	depends on DEV_DAX_PMEM
> diff -puN /dev/null drivers/dax/kmem.c
> --- /dev/null	2018-12-03 08:41:47.355756491 -0800
> +++ b/drivers/dax/kmem.c	2019-01-24 15:13:15.994199535 -0800
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2016-2018 Intel Corporation. All rights reserved. */
> +#include <linux/memremap.h>
> +#include <linux/pagemap.h>
> +#include <linux/memory.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/pfn_t.h>
> +#include <linux/slab.h>
> +#include <linux/dax.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include "dax-private.h"
> +#include "bus.h"
> +
> +int dev_dax_kmem_probe(struct device *dev)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +	struct resource *res = &dev_dax->region->res;
> +	resource_size_t kmem_start;
> +	resource_size_t kmem_size;
> +	resource_size_t kmem_end;
> +	struct resource *new_res;
> +	int numa_node;
> +	int rc;
> +
> +	/*
> +	 * Ensure good NUMA information for the persistent memory.
> +	 * Without this check, there is a risk that slow memory
> +	 * could be mixed in a node with faster memory, causing
> +	 * unavoidable performance issues.
> +	 */
> +	numa_node = dev_dax->target_node;
> +	if (numa_node < 0) {
> +		dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
> +			 res, numa_node);
> +		return -EINVAL;
> +	}
> +
> +	/* Hotplug starting at the beginning of the next block: */
> +	kmem_start = ALIGN(res->start, memory_block_size_bytes());
> +
> +	kmem_size = resource_size(res);
> +	/* Adjust the size down to compensate for moving up kmem_start: */
> +        kmem_size -= kmem_start - res->start;
> +	/* Align the size down to cover only complete blocks: */
> +	kmem_size &= ~(memory_block_size_bytes() - 1);
> +	kmem_end = kmem_start+kmem_size;
> +
> +	/* Region is permanently reserved.  Hot-remove not yet implemented. */
> +	new_res = request_mem_region(kmem_start, kmem_size, dev_name(dev));
> +	if (!new_res) {
> +		dev_warn(dev, "could not reserve region [%pa-%pa]\n",
> +			 &kmem_start, &kmem_end);
> +		return -EBUSY;
> +	}
> +
> +	/*
> +	 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
> +	 * so that add_memory() can add a child resource.  Do not
> +	 * inherit flags from the parent since it may set new flags
> +	 * unknown to us that will break add_memory() below.
> +	 */
> +	new_res->flags = IORESOURCE_SYSTEM_RAM;
> +	new_res->name = dev_name(dev);
> +
> +	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static int dev_dax_kmem_remove(struct device *dev)
> +{
> +	/*
> +	 * Purposely leak the request_mem_region() for the device-dax
> +	 * range and return '0' to ->remove() attempts. The removal of
> +	 * the device from the driver always succeeds, but the region
> +	 * is permanently pinned as reserved by the unreleased
> +	 * request_mem_region().
> +	 */
> +	return -EBUSY;
> +}
> +
> +static struct dax_device_driver device_dax_kmem_driver = {
> +	.drv = {
> +		.probe = dev_dax_kmem_probe,
> +		.remove = dev_dax_kmem_remove,
> +	},
> +};
> +
> +static int __init dax_kmem_init(void)
> +{
> +	return dax_driver_register(&device_dax_kmem_driver);
> +}
> +
> +static void __exit dax_kmem_exit(void)
> +{
> +	dax_driver_unregister(&device_dax_kmem_driver);
> +}
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> +module_init(dax_kmem_init);
> +module_exit(dax_kmem_exit);
> +MODULE_ALIAS_DAX_DEVICE(0);
> diff -puN drivers/dax/Makefile~dax-kmem-try-4 drivers/dax/Makefile
> --- a/drivers/dax/Makefile~dax-kmem-try-4	2019-01-24 15:13:15.990199535 -0800
> +++ b/drivers/dax/Makefile	2019-01-24 15:13:15.994199535 -0800
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_DAX) += dax.o
>   obj-$(CONFIG_DEV_DAX) += device_dax.o
> +obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
>   
>   dax-y := super.o
>   dax-y += bus.o
> _
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
> 
