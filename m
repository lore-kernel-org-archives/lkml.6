Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED45C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150B62084C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150B62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeKOI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:58:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:50974 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeKOI6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:58:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 14:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="106314887"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2018 14:53:03 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/7] node: Add memory caching attributes
Date:   Wed, 14 Nov 2018 15:49:17 -0700
Message-Id: <20181114224921.12123-5-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181114224921.12123-2-keith.busch@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System memory may have side caches to help improve access speed. While
the system provided cache is transparent to the software accessing
these memory ranges, applications can optimize their own access based
on cache attributes.

In preparation for such systems, provide a new API for the kernel to
register these memory side caches under the memory node that provides it.

The kernel's sysfs representation is modeled from the cpu cacheinfo
attributes, as seen from /sys/devices/system/cpu/cpuX/cache/. Unlike CPU
cacheinfo, though, a higher node's memory cache level is nearer to the
CPU, while lower levels are closer to the backing memory. Also unlike
CPU cache, the system handles flushing any dirty cached memory to the
last level the memory on a power failure if the range is persistent.

The exported attributes are the cache size, the line size, associativity,
and write back policy.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/base/node.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/node.h |  23 ++++++++++
 2 files changed, 140 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 232535761998..bb94f1d18115 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -60,6 +60,12 @@ static DEVICE_ATTR(cpumap,  S_IRUGO, node_read_cpumask, NULL);
 static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
 
 #ifdef CONFIG_HMEM
+struct node_cache_obj {
+	struct kobject kobj;
+	struct list_head node;
+	struct node_cache_attrs cache_attrs;
+};
+
 const struct attribute_group node_access_attrs_group;
 
 #define ACCESS_ATTR(name) 						\
@@ -101,6 +107,115 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs)
 		pr_info("failed to add performance attribute group to node %d\n",
 			nid);
 }
+
+struct cache_attribute_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct node_cache_attrs *, char *);
+};
+
+#define CACHE_ATTR(name, fmt) 						\
+static ssize_t name##_show(struct node_cache_attrs *cache,		\
+			   char *buf)					\
+{									\
+	return sprintf(buf, fmt "\n", cache->name);			\
+}									\
+static struct cache_attribute_entry cache_attr_##name = __ATTR_RO(name);
+
+CACHE_ATTR(size, "%lld")
+CACHE_ATTR(level, "%d")
+CACHE_ATTR(line_size, "%d")
+CACHE_ATTR(associativity, "%d")
+CACHE_ATTR(write_policy, "%d")
+
+static struct attribute *cache_attrs[] = {
+	&cache_attr_level.attr,
+	&cache_attr_associativity.attr,
+	&cache_attr_size.attr,
+	&cache_attr_line_size.attr,
+	&cache_attr_write_policy.attr,
+	NULL,
+};
+
+static ssize_t cache_attr_show(struct kobject *kobj, struct attribute *attr,
+			       char *page)
+{
+	struct cache_attribute_entry *entry =
+			container_of(attr, struct cache_attribute_entry, attr);
+	struct node_cache_obj *cache_obj =
+			container_of(kobj, struct node_cache_obj, kobj);
+	return entry->show(&cache_obj->cache_attrs, page);
+}
+
+static const struct sysfs_ops cache_ops = {
+	.show	= &cache_attr_show,
+};
+
+static struct kobj_type cache_ktype = {
+	.default_attrs	= cache_attrs,
+	.sysfs_ops	= &cache_ops,
+};
+
+void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
+{
+	struct node_cache_obj *cache_obj;
+	struct node *node;
+
+	if (!node_online(nid) || !node_devices[nid])
+		return;
+
+	node = node_devices[nid];
+	list_for_each_entry(cache_obj, &node->cache_attrs, node) {
+		if (cache_obj->cache_attrs.level == cache_attrs->level) {
+			dev_warn(&node->dev,
+				"attempt to add duplicate cache level:%d\n",
+				cache_attrs->level);
+			return;
+		}
+	}
+
+	if (!node->cache_kobj)
+		node->cache_kobj = kobject_create_and_add("cache",
+							  &node->dev.kobj);
+	if (!node->cache_kobj)
+		return;
+
+	cache_obj = kzalloc(sizeof(*cache_obj), GFP_KERNEL);
+	if (!cache_obj)
+		return;
+
+	cache_obj->cache_attrs = *cache_attrs;
+	if (kobject_init_and_add(&cache_obj->kobj, &cache_ktype, node->cache_kobj,
+				 "index%d", cache_attrs->level)) {
+		dev_warn(&node->dev, "failed to add cache level:%d\n",
+			 cache_attrs->level);
+		kfree(cache_obj);
+		return;
+	}
+	list_add_tail(&cache_obj->node, &node->cache_attrs);
+}
+
+static void node_remove_caches(struct node *node)
+{
+	struct node_cache_obj *obj, *next;
+
+	if (!node->cache_kobj)
+		return;
+
+	list_for_each_entry_safe(obj, next, &node->cache_attrs, node) {
+		list_del(&obj->node);
+		kobject_put(&obj->kobj);
+		kfree(obj);
+	}
+	kobject_put(node->cache_kobj);
+}
+
+static void node_init_caches(unsigned int nid)
+{
+	INIT_LIST_HEAD(&node_devices[nid]->cache_attrs);
+}
+#else
+static void node_init_caches(unsigned int nid) { }
+static void node_remove_caches(struct node *node) { }
 #endif
 
 #define K(x) ((x) << (PAGE_SHIFT - 10))
@@ -345,6 +460,7 @@ static void node_device_release(struct device *dev)
 	 */
 	flush_work(&node->node_work);
 #endif
+	node_remove_caches(node);
 	kfree(node);
 }
 
@@ -658,6 +774,7 @@ int __register_one_node(int nid)
 
 	/* initialize work queue for memory hot plug */
 	init_node_hugetlb_work(nid);
+	node_init_caches(nid);
 
 	return error;
 }
diff --git a/include/linux/node.h b/include/linux/node.h
index 6a1aa6a153f8..f499a17f84bc 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -36,6 +36,27 @@ struct node_hmem_attrs {
 	unsigned int write_latency;
 };
 void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs);
+
+enum cache_associativity {
+	NODE_CACHE_DIRECT_MAP,
+	NODE_CACHE_INDEXED,
+	NODE_CACHE_OTHER,
+};
+
+enum cache_write_policy {
+	NODE_CACHE_WRITE_BACK,
+	NODE_CACHE_WRITE_THROUGH,
+	NODE_CACHE_WRITE_OTHER,
+};
+
+struct node_cache_attrs {
+	enum cache_associativity associativity;
+	enum cache_write_policy write_policy;
+	u64 size;
+	u16 line_size;
+	u8  level;
+};
+void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
 #endif
 
 struct node {
@@ -46,6 +67,8 @@ struct node {
 #endif
 #ifdef CONFIG_HMEM
 	struct node_hmem_attrs hmem_attrs;
+	struct list_head cache_attrs;
+	struct kobject *cache_kobj;
 #endif
 };
 
-- 
2.14.4

