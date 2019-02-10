Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C76CC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639A921736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfBJRUX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:20:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfBJRUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:20:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 646346BB552E6B6B1F0;
        Mon, 11 Feb 2019 01:20:18 +0800 (CST)
Received: from localhost (10.47.91.52) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Feb 2019
 01:20:12 +0800
Date:   Sun, 10 Feb 2019 17:19:58 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Brice Goglin <Brice.Goglin@inria.fr>
CC:     Keith Busch <keith.busch@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 10/13] node: Add memory caching attributes
Message-ID: <20190210171958.00003ab2@huawei.com>
In-Reply-To: <4a7d1c0c-c269-d7b2-11cb-88ad62b70a06@inria.fr>
References: <20190116175804.30196-1-keith.busch@intel.com>
        <20190116175804.30196-11-keith.busch@intel.com>
        <4a7d1c0c-c269-d7b2-11cb-88ad62b70a06@inria.fr>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.91.52]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2019 09:20:53 +0100
Brice Goglin <Brice.Goglin@inria.fr> wrote:

> Hello Keith
> 
> Could we ever have a single side cache in front of two NUMA nodes ? I
> don't see a way to find that out in the current implementation. Would we
> have an "id" and/or "nodemap" bitmask in the sidecache structure ?

This is certainly a possible thing for hardware to do.

ACPI IIRC doesn't provide any means of representing that - your best
option is to represent it as two different entries, one for each of the
memory nodes.  Interesting question of whether you would then claim
they were half as big each, or the full size.  Of course, there are
other possible ways to get this info beyond HMAT, so perhaps the interface
should allow it to be exposed if available?

Also, don't know if it's just me, but calling these sidecaches is
downright confusing.  In ACPI at least they are always
specifically referred to as Memory Side Caches.
I'd argue there should even by a hyphen Memory-Side Caches, the point
being that that they are on the memory side of the interconnected
rather than the processor side.  Of course an implementation
choice might be to put them off to the side (as implied by sidecaches)
in some sense, but it's not the only one.

</terminology rant> :)

Jonathan

> 
> Thanks
> 
> Brice
> 
> 
> 
> Le 16/01/2019 à 18:58, Keith Busch a écrit :
> > System memory may have side caches to help improve access speed to
> > frequently requested address ranges. While the system provided cache is
> > transparent to the software accessing these memory ranges, applications
> > can optimize their own access based on cache attributes.
> >
> > Provide a new API for the kernel to register these memory side caches
> > under the memory node that provides it.
> >
> > The new sysfs representation is modeled from the existing cpu cacheinfo
> > attributes, as seen from /sys/devices/system/cpu/cpuX/side_cache/.
> > Unlike CPU cacheinfo, though, the node cache level is reported from
> > the view of the memory. A higher number is nearer to the CPU, while
> > lower levels are closer to the backing memory. Also unlike CPU cache,
> > it is assumed the system will handle flushing any dirty cached memory
> > to the last level on a power failure if the range is persistent memory.
> >
> > The attributes we export are the cache size, the line size, associativity,
> > and write back policy.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/base/node.c  | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/node.h |  39 ++++++++++++++
> >  2 files changed, 181 insertions(+)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 1e909f61e8b1..7ff3ed566d7d 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -191,6 +191,146 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
> >  		pr_info("failed to add performance attribute group to node %d\n",
> >  			nid);
> >  }
> > +
> > +struct node_cache_info {
> > +	struct device dev;
> > +	struct list_head node;
> > +	struct node_cache_attrs cache_attrs;
> > +};
> > +#define to_cache_info(device) container_of(device, struct node_cache_info, dev)
> > +
> > +#define CACHE_ATTR(name, fmt) 						\
> > +static ssize_t name##_show(struct device *dev,				\
> > +			   struct device_attribute *attr,		\
> > +			   char *buf)					\
> > +{									\
> > +	return sprintf(buf, fmt "\n", to_cache_info(dev)->cache_attrs.name);\
> > +}									\
> > +DEVICE_ATTR_RO(name);
> > +
> > +CACHE_ATTR(size, "%llu")
> > +CACHE_ATTR(level, "%u")
> > +CACHE_ATTR(line_size, "%u")
> > +CACHE_ATTR(associativity, "%u")
> > +CACHE_ATTR(write_policy, "%u")
> > +
> > +static struct attribute *cache_attrs[] = {
> > +	&dev_attr_level.attr,
> > +	&dev_attr_associativity.attr,
> > +	&dev_attr_size.attr,
> > +	&dev_attr_line_size.attr,
> > +	&dev_attr_write_policy.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(cache);
> > +
> > +static void node_cache_release(struct device *dev)
> > +{
> > +	kfree(dev);
> > +}
> > +
> > +static void node_cacheinfo_release(struct device *dev)
> > +{
> > +	struct node_cache_info *info = to_cache_info(dev);
> > +	kfree(info);
> > +}
> > +
> > +static void node_init_cache_dev(struct node *node)
> > +{
> > +	struct device *dev;
> > +
> > +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > +	if (!dev)
> > +		return;
> > +
> > +	dev->parent = &node->dev;
> > +	dev->release = node_cache_release;
> > +	if (dev_set_name(dev, "side_cache"))
> > +		goto free_dev;
> > +
> > +	if (device_register(dev))
> > +		goto free_name;
> > +
> > +	pm_runtime_no_callbacks(dev);
> > +	node->cache_dev = dev;
> > +	return;
> > +free_name:
> > +	kfree_const(dev->kobj.name);
> > +free_dev:
> > +	kfree(dev);
> > +}
> > +
> > +void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
> > +{
> > +	struct node_cache_info *info;
> > +	struct device *dev;
> > +	struct node *node;
> > +
> > +	if (!node_online(nid) || !node_devices[nid])
> > +		return;
> > +
> > +	node = node_devices[nid];
> > +	list_for_each_entry(info, &node->cache_attrs, node) {
> > +		if (info->cache_attrs.level == cache_attrs->level) {
> > +			dev_warn(&node->dev,
> > +				"attempt to add duplicate cache level:%d\n",
> > +				cache_attrs->level);
> > +			return;
> > +		}
> > +	}
> > +
> > +	if (!node->cache_dev)
> > +		node_init_cache_dev(node);
> > +	if (!node->cache_dev)
> > +		return;
> > +
> > +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +	if (!info)
> > +		return;
> > +
> > +	dev = &info->dev;
> > +	dev->parent = node->cache_dev;
> > +	dev->release = node_cacheinfo_release;
> > +	dev->groups = cache_groups;
> > +	if (dev_set_name(dev, "index%d", cache_attrs->level))
> > +		goto free_cache;
> > +
> > +	info->cache_attrs = *cache_attrs;
> > +	if (device_register(dev)) {
> > +		dev_warn(&node->dev, "failed to add cache level:%d\n",
> > +			 cache_attrs->level);
> > +		goto free_name;
> > +	}
> > +	pm_runtime_no_callbacks(dev);
> > +	list_add_tail(&info->node, &node->cache_attrs);
> > +	return;
> > +free_name:
> > +	kfree_const(dev->kobj.name);
> > +free_cache:
> > +	kfree(info);
> > +}
> > +
> > +static void node_remove_caches(struct node *node)
> > +{
> > +	struct node_cache_info *info, *next;
> > +
> > +	if (!node->cache_dev)
> > +		return;
> > +
> > +	list_for_each_entry_safe(info, next, &node->cache_attrs, node) {
> > +		list_del(&info->node);
> > +		device_unregister(&info->dev);
> > +	}
> > +	device_unregister(node->cache_dev);
> > +}
> > +
> > +static void node_init_caches(unsigned int nid)
> > +{
> > +	INIT_LIST_HEAD(&node_devices[nid]->cache_attrs);
> > +}
> > +#else
> > +static void node_init_caches(unsigned int nid) { }
> > +static void node_remove_caches(struct node *node) { }
> >  #endif
> >  
> >  #define K(x) ((x) << (PAGE_SHIFT - 10))
> > @@ -475,6 +615,7 @@ void unregister_node(struct node *node)
> >  {
> >  	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
> >  	node_remove_classes(node);
> > +	node_remove_caches(node);
> >  	device_unregister(&node->dev);
> >  }
> >  
> > @@ -755,6 +896,7 @@ int __register_one_node(int nid)
> >  	INIT_LIST_HEAD(&node_devices[nid]->class_list);
> >  	/* initialize work queue for memory hot plug */
> >  	init_node_hugetlb_work(nid);
> > +	node_init_caches(nid);
> >  
> >  	return error;
> >  }
> > diff --git a/include/linux/node.h b/include/linux/node.h
> > index e22940a593c2..8cdf2b2808e4 100644
> > --- a/include/linux/node.h
> > +++ b/include/linux/node.h
> > @@ -37,12 +37,47 @@ struct node_hmem_attrs {
> >  };
> >  void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
> >  			 unsigned class);
> > +
> > +enum cache_associativity {
> > +	NODE_CACHE_DIRECT_MAP,
> > +	NODE_CACHE_INDEXED,
> > +	NODE_CACHE_OTHER,
> > +};
> > +
> > +enum cache_write_policy {
> > +	NODE_CACHE_WRITE_BACK,
> > +	NODE_CACHE_WRITE_THROUGH,
> > +	NODE_CACHE_WRITE_OTHER,
> > +};
> > +
> > +/**
> > + * struct node_cache_attrs - system memory caching attributes
> > + *
> > + * @associativity:	The ways memory blocks may be placed in cache
> > + * @write_policy:	Write back or write through policy
> > + * @size:		Total size of cache in bytes
> > + * @line_size:		Number of bytes fetched on a cache miss
> > + * @level:		Represents the cache hierarchy level
> > + */
> > +struct node_cache_attrs {
> > +	enum cache_associativity associativity;
> > +	enum cache_write_policy write_policy;
> > +	u64 size;
> > +	u16 line_size;
> > +	u8  level;
> > +};
> > +void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
> >  #else
> >  static inline void node_set_perf_attrs(unsigned int nid,
> >  				       struct node_hmem_attrs *hmem_attrs,
> >  				       unsigned class)
> >  {
> >  }
> > +
> > +static inline void node_add_cache(unsigned int nid,
> > +				  struct node_cache_attrs *cache_attrs)
> > +{
> > +}
> >  #endif
> >  
> >  struct node {
> > @@ -51,6 +86,10 @@ struct node {
> >  #if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HUGETLBFS)
> >  	struct work_struct	node_work;
> >  #endif
> > +#ifdef CONFIG_HMEM_REPORTING
> > +	struct list_head cache_attrs;
> > +	struct device *cache_dev;
> > +#endif
> >  };
> >  
> >  struct memory_block;  
> 


