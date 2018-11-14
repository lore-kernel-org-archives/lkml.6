Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05041C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FA82084C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FA82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeKOI6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:58:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:50974 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeKOI6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:58:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 14:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="106314880"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2018 14:53:02 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/7] node: Add heterogenous memory performance
Date:   Wed, 14 Nov 2018 15:49:15 -0700
Message-Id: <20181114224921.12123-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181114224921.12123-2-keith.busch@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heterogeneous memory systems provide memory nodes with latency
and bandwidth performance attributes that are different from other
nodes. Create an interface for the kernel to register these attributes
under the node that provides the memory. If the system provides this
information, applications can query the node attributes when deciding
which node to request memory.

When multiple memory initiators exist, accessing the same memory target
from each may not perform the same as the other. The highest performing
initiator to a given target is considered to be a local initiator for
that target. The kernel provides performance attributes only for the
local initiators.

The memory's compute node should be symlinked in sysfs as one of the
node's initiators.

The following example shows the new sysfs hierarchy for a node exporting
performance attributes:

  # tree /sys/devices/system/node/nodeY/initiator_access
  /sys/devices/system/node/nodeY/initiator_access
  |-- read_bandwidth
  |-- read_latency
  |-- write_bandwidth
  `-- write_latency

The bandwidth is exported as MB/s and latency is reported in nanoseconds.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/base/Kconfig |  8 ++++++++
 drivers/base/node.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/node.h | 22 ++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index ae213ed2a7c8..2cf67c80046d 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -149,6 +149,14 @@ config DEBUG_TEST_DRIVER_REMOVE
 	  unusable. You should say N here unless you are explicitly looking to
 	  test this functionality.
 
+config HMEM
+	bool
+	default y
+	depends on NUMA
+	help
+	  Enable reporting for heterogenous memory access attributes under
+	  their non-uniform memory nodes.
+
 source "drivers/base/test/Kconfig"
 
 config SYS_HYPERVISOR
diff --git a/drivers/base/node.c b/drivers/base/node.c
index a9b7512a9502..232535761998 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -59,6 +59,50 @@ static inline ssize_t node_read_cpulist(struct device *dev,
 static DEVICE_ATTR(cpumap,  S_IRUGO, node_read_cpumask, NULL);
 static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
 
+#ifdef CONFIG_HMEM
+const struct attribute_group node_access_attrs_group;
+
+#define ACCESS_ATTR(name) 						\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr,		\
+			   char *buf)					\
+{									\
+	return sprintf(buf, "%d\n", to_node(dev)->hmem_attrs.name);	\
+}									\
+static DEVICE_ATTR_RO(name);
+
+ACCESS_ATTR(read_bandwidth)
+ACCESS_ATTR(read_latency)
+ACCESS_ATTR(write_bandwidth)
+ACCESS_ATTR(write_latency)
+
+static struct attribute *access_attrs[] = {
+	&dev_attr_read_bandwidth.attr,
+	&dev_attr_read_latency.attr,
+	&dev_attr_write_bandwidth.attr,
+	&dev_attr_write_latency.attr,
+	NULL,
+};
+
+const struct attribute_group node_access_attrs_group = {
+	.name		= "initiator_access",
+	.attrs		= access_attrs,
+};
+
+void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs)
+{
+	struct node *node;
+
+	if (WARN_ON_ONCE(!node_online(nid)))
+		return;
+	node = node_devices[nid];
+	node->hmem_attrs = *hmem_attrs;
+	if (sysfs_create_group(&node->dev.kobj, &node_access_attrs_group))
+		pr_info("failed to add performance attribute group to node %d\n",
+			nid);
+}
+#endif
+
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 static ssize_t node_read_meminfo(struct device *dev,
 			struct device_attribute *attr, char *buf)
diff --git a/include/linux/node.h b/include/linux/node.h
index 1fd734a3fb3f..6a1aa6a153f8 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -17,14 +17,36 @@
 
 #include <linux/device.h>
 #include <linux/cpumask.h>
+#include <linux/list.h>
 #include <linux/workqueue.h>
 
+#ifdef CONFIG_HMEM
+/**
+ * struct node_hmem_attrs - heterogeneous memory performance attributes
+ *
+ * read_bandwidth:	Read bandwidth in MB/s
+ * write_bandwidth:	Write bandwidth in MB/s
+ * read_latency:	Read latency in nanoseconds
+ * write_latency:	Write latency in nanoseconds
+ */
+struct node_hmem_attrs {
+	unsigned int read_bandwidth;
+	unsigned int write_bandwidth;
+	unsigned int read_latency;
+	unsigned int write_latency;
+};
+void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs);
+#endif
+
 struct node {
 	struct device	dev;
 
 #if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HUGETLBFS)
 	struct work_struct	node_work;
 #endif
+#ifdef CONFIG_HMEM
+	struct node_hmem_attrs hmem_attrs;
+#endif
 };
 
 struct memory_block;
-- 
2.14.4

