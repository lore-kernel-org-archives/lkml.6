Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C09C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855C92084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855C92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeLKBGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:06:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:24625 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729427AbeLKBFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:05:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 17:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="117705176"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2018 17:05:45 -0800
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 03/12] node: Link memory nodes to their compute nodes
Date:   Mon, 10 Dec 2018 18:03:01 -0700
Message-Id: <20181211010310.8551-4-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181211010310.8551-1-keith.busch@intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory-only nodes will often have affinity to a compute node that can
initiate memory access. Platforms may have various ways to express that
locality. The nodes that initiate memory requests closest to a memory
target node may be considered to have 'primary' access.

In preparation for these systems, provide a way for the kernel to link the
target memory node to its primary initiator compute nodes with symlinks
to each other. Also add memory target and initiator node masks showing
the same relationship.

The following example show the node's new sysfs hierarchy setup for
memory node 'Y' with primary access to commpute node 'X':

  # ls -l /sys/devices/system/node/nodeX/primary_target*
  /sys/devices/system/node/nodeX/primary_targetY -> ../nodeY

  # ls -l /sys/devices/system/node/nodeY/primary_initiator*
  /sys/devices/system/node/nodeY/primary_initiatorX -> ../nodeX

A single initiator may have primary access to multiple memory targets, and
the targets may also have primary access from multiple memory initiators.

The following demonstrates how this may look for a theoretical system
with 8 memory nodes and 2 compute nodes.

  # cat /sys/devices/system/node/node0/primary_mem_nodelist
  0,2,4,6

  # cat /sys/devices/system/node/node1/primary_mem_nodelist
  1,3,5,7

And then going the other way to identify the cpu lists of a node's
primary targets:

  # cat /sys/devices/system/node/node0/primary_target*/primary_cpu_nodelist | tr "\n" ","
  0,0,0,0

  # cat /sys/devices/system/node/node1/primary_target*/primary_cpu_nodelist
  1,1,1,1

As an example of what you may be able to do with this, let's say we have
a PCIe storage device, /dev/nvme0n1, attached to a particular node, and
we want to run IO to it using only CPUs and Memory that share primary
access. The following shell script is such an example to achieve
that goal:

  #!/bin/bash
  DEV_NODE=/sys/devices/system/node/node$(cat /sys/block/nvme0n1/device/device/numa_node)
  numactl --membind=$(cat ${DEV_NODE}/primary_mem_nodelist) \
            --cpunodebind=$(cat ${DEV_NODE}/primary_cpu_nodelist) \
            -- fio --filename=/dev/nvme0n1 --bs=4k --name=access-test

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/base/node.c  | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/node.h |  4 +++
 2 files changed, 89 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 86d6cd92ce3d..50412ce3fd7d 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -56,6 +56,46 @@ static inline ssize_t node_read_cpulist(struct device *dev,
 	return node_read_cpumap(dev, true, buf);
 }
 
+static ssize_t node_read_nodemap(nodemask_t *mask, bool list, char *buf)
+{
+	return list ? scnprintf(buf, PAGE_SIZE - 1, "%*pbl\n",
+				nodemask_pr_args(mask)) :
+		      scnprintf(buf, PAGE_SIZE - 1, "%*pb\n",
+				nodemask_pr_args(mask));
+}
+
+static ssize_t primary_mem_nodelist_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct node *n = to_node(dev);
+	return node_read_nodemap(&n->primary_mem_nodes, true, buf);
+}
+
+static ssize_t primary_mem_nodemask_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct node *n = to_node(dev);
+	return node_read_nodemap(&n->primary_mem_nodes, false, buf);
+}
+
+static ssize_t primary_cpu_nodelist_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct node *n = to_node(dev);
+	return node_read_nodemap(&n->primary_cpu_nodes, true, buf);
+}
+
+static ssize_t primary_cpu_nodemask_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct node *n = to_node(dev);
+	return node_read_nodemap(&n->primary_cpu_nodes, false, buf);
+}
+
+static DEVICE_ATTR_RO(primary_mem_nodelist);
+static DEVICE_ATTR_RO(primary_mem_nodemask);
+static DEVICE_ATTR_RO(primary_cpu_nodemask);
+static DEVICE_ATTR_RO(primary_cpu_nodelist);
 static DEVICE_ATTR(cpumap,  S_IRUGO, node_read_cpumask, NULL);
 static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
 
@@ -240,6 +280,10 @@ static struct attribute *node_dev_attrs[] = {
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_primary_mem_nodelist.attr,
+	&dev_attr_primary_mem_nodemask.attr,
+	&dev_attr_primary_cpu_nodemask.attr,
+	&dev_attr_primary_cpu_nodelist.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(node_dev);
@@ -372,6 +416,42 @@ int register_cpu_under_node(unsigned int cpu, unsigned int nid)
 				 kobject_name(&node_devices[nid]->dev.kobj));
 }
 
+int register_memory_node_under_compute_node(unsigned int m, unsigned int p)
+{
+	struct node *init, *targ;
+	char initiator[28]; /* "primary_initiator4294967295\0" */
+	char target[25]; /* "primary_target4294967295\0" */
+	int ret;
+
+	if (!node_online(p) || !node_online(m))
+		return -ENODEV;
+	if (m == p)
+		return 0;
+
+	snprintf(initiator, sizeof(initiator), "primary_initiator%d", p);
+	snprintf(target, sizeof(target), "primary_target%d", m);
+
+	init = node_devices[p];
+	targ = node_devices[m];
+
+	ret = sysfs_create_link(&init->dev.kobj, &targ->dev.kobj, target);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&targ->dev.kobj, &init->dev.kobj, initiator);
+	if (ret)
+		goto err;
+
+	node_set(m, init->primary_mem_nodes);
+	node_set(p, targ->primary_cpu_nodes);
+
+	return 0;
+ err:
+	sysfs_remove_link(&node_devices[p]->dev.kobj,
+			  kobject_name(&node_devices[m]->dev.kobj));
+	return ret;
+}
+
 int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 {
 	struct device *obj;
@@ -580,6 +660,11 @@ int __register_one_node(int nid)
 			register_cpu_under_node(cpu, nid);
 	}
 
+	if (node_state(nid, N_MEMORY))
+		node_set(nid, node_devices[nid]->primary_mem_nodes);
+	if (node_state(nid, N_CPU))
+		node_set(nid, node_devices[nid]->primary_cpu_nodes);
+
 	/* initialize work queue for memory hot plug */
 	init_node_hugetlb_work(nid);
 
diff --git a/include/linux/node.h b/include/linux/node.h
index 257bb3d6d014..3d06de045cbf 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -21,6 +21,8 @@
 
 struct node {
 	struct device	dev;
+	nodemask_t	primary_mem_nodes;
+	nodemask_t	primary_cpu_nodes;
 
 #if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HUGETLBFS)
 	struct work_struct	node_work;
@@ -75,6 +77,8 @@ extern int register_mem_sect_under_node(struct memory_block *mem_blk,
 extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 					   unsigned long phys_index);
 
+extern int register_memory_node_under_compute_node(unsigned int m, unsigned int p);
+
 #ifdef CONFIG_HUGETLBFS
 extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
 					 node_registration_func_t unregister);
-- 
2.14.4

