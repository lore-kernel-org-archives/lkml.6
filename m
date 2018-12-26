Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896E7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632A6218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeLZNjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:39:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:33941 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbeLZNhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185457"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:01 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005ON-BS; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.463947436@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:53 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 07/21] mm: export node type {pmem|dram} under /sys/bus/node
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0005-Export-node-type-pmem-ram-in-sys-bus-node.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Du <fan.du@intel.com>

User space migration daemon could check
/sys/bus/node/devices/nodeX/type for node type.

Software can interrogate node type for node memory type and distance
to get desirable target node in migration.

grep -r . /sys/devices/system/node/*/type
/sys/devices/system/node/node0/type:dram
/sys/devices/system/node/node1/type:dram
/sys/devices/system/node/node2/type:pmem
/sys/devices/system/node/node3/type:pmem

Along with next patch which export `peer_node`, migration daemon
could easily find the memory type of current node, and the target
node in case of migration.

grep -r . /sys/devices/system/node/*/peer_node
/sys/devices/system/node/node0/peer_node:2
/sys/devices/system/node/node1/peer_node:3
/sys/devices/system/node/node2/peer_node:0
/sys/devices/system/node/node3/peer_node:1

Signed-off-by: Fan Du <fan.du@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/base/node.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- linux.orig/drivers/base/node.c	2018-12-23 19:39:04.763414931 +0800
+++ linux/drivers/base/node.c	2018-12-23 19:39:04.763414931 +0800
@@ -233,6 +233,15 @@ static ssize_t node_read_distance(struct
 }
 static DEVICE_ATTR(distance, S_IRUGO, node_read_distance, NULL);
 
+static ssize_t type_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int nid = dev->id;
+
+	return sprintf(buf, is_node_pmem(nid) ? "pmem\n" : "dram\n");
+}
+static DEVICE_ATTR(type, S_IRUGO, type_show, NULL);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_cpumap.attr,
 	&dev_attr_cpulist.attr,
@@ -240,6 +249,7 @@ static struct attribute *node_dev_attrs[
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_type.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(node_dev);


