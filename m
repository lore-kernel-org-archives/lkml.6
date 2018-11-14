Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31312C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDDB2245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDDB2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeKOI6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:58:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:50974 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeKOI6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:58:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 14:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="106314877"
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
Subject: [PATCH 1/7] node: Link memory nodes to their compute nodes
Date:   Wed, 14 Nov 2018 15:49:14 -0700
Message-Id: <20181114224921.12123-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory-only nodes will often have affinity to a compute node, and
platforms have ways to express that locality relationship.

A node containing CPUs or other DMA devices that can initiate memory
access are referred to as "memory iniators". A "memory target" is a
node that provides at least one phyiscal address range accessible to a
memory initiator.

In preparation for these systems, provide a new kernel API to link
the target memory node to its initiator compute node with symlinks to
each other.

The following example shows the new sysfs hierarchy setup for memory node
'Y' local to commpute node 'X':

  # ls -l /sys/devices/system/node/nodeX/initiator*
  /sys/devices/system/node/nodeX/targetY -> ../nodeY

  # ls -l /sys/devices/system/node/nodeY/target*
  /sys/devices/system/node/nodeY/initiatorX -> ../nodeX

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/base/node.c  | 32 ++++++++++++++++++++++++++++++++
 include/linux/node.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 86d6cd92ce3d..a9b7512a9502 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -372,6 +372,38 @@ int register_cpu_under_node(unsigned int cpu, unsigned int nid)
 				 kobject_name(&node_devices[nid]->dev.kobj));
 }
 
+int register_memory_node_under_compute_node(unsigned int m, unsigned int p)
+{
+	int ret;
+	char initiator[20], target[17];
+
+	if (!node_online(p) || !node_online(m))
+		return -ENODEV;
+	if (m == p)
+		return 0;
+
+	snprintf(initiator, sizeof(initiator), "initiator%d", p);
+	snprintf(target, sizeof(target), "target%d", m);
+
+	ret = sysfs_create_link(&node_devices[p]->dev.kobj,
+				&node_devices[m]->dev.kobj,
+				target);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&node_devices[m]->dev.kobj,
+				&node_devices[p]->dev.kobj,
+				initiator);
+	if (ret)
+		goto err;
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
diff --git a/include/linux/node.h b/include/linux/node.h
index 257bb3d6d014..1fd734a3fb3f 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -75,6 +75,8 @@ extern int register_mem_sect_under_node(struct memory_block *mem_blk,
 extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 					   unsigned long phys_index);
 
+extern int register_memory_node_under_compute_node(unsigned int m, unsigned int p);
+
 #ifdef CONFIG_HUGETLBFS
 extern void register_hugetlbfs_with_node(node_registration_func_t doregister,
 					 node_registration_func_t unregister);
-- 
2.14.4

