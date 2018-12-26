Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455BFC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3F6218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeLZNhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:37:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:33941 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbeLZNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121185460"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2018 05:37:01 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005Nz-7S; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.164047705@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:48 +0800
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
Subject: [RFC][PATCH v2 02/21] acpi/numa: memorize NUMA node type from SRAT table
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0002-acpi-Memorize-numa-node-type-from-SRAT-table.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Du <fan.du@intel.com>

Mark NUMA node as DRAM or PMEM.

This could happen in boot up state (see the e820 pmem type
override patch), or on fly when bind devdax device with kmem
driver.

It depends on BIOS supplying PMEM NUMA proximity in SRAT table,
that's current production BIOS does.

Signed-off-by: Fan Du <fan.du@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 arch/x86/include/asm/numa.h |    2 ++
 arch/x86/mm/numa.c          |    2 ++
 drivers/acpi/numa.c         |    5 +++++
 3 files changed, 9 insertions(+)

--- linux.orig/arch/x86/include/asm/numa.h	2018-12-23 19:20:39.890947888 +0800
+++ linux/arch/x86/include/asm/numa.h	2018-12-23 19:20:39.890947888 +0800
@@ -30,6 +30,8 @@ extern int numa_off;
  */
 extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
+extern nodemask_t numa_nodes_pmem;
+extern nodemask_t numa_nodes_dram;
 
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
--- linux.orig/arch/x86/mm/numa.c	2018-12-23 19:20:39.890947888 +0800
+++ linux/arch/x86/mm/numa.c	2018-12-23 19:20:39.890947888 +0800
@@ -20,6 +20,8 @@
 
 int numa_off;
 nodemask_t numa_nodes_parsed __initdata;
+nodemask_t numa_nodes_pmem;
+nodemask_t numa_nodes_dram;
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
--- linux.orig/drivers/acpi/numa.c	2018-12-23 19:20:39.890947888 +0800
+++ linux/drivers/acpi/numa.c	2018-12-23 19:20:39.890947888 +0800
@@ -297,6 +297,11 @@ acpi_numa_memory_affinity_init(struct ac
 
 	node_set(node, numa_nodes_parsed);
 
+	if (ma->flags & ACPI_SRAT_MEM_NON_VOLATILE)
+		node_set(node, numa_nodes_pmem);
+	else
+		node_set(node, numa_nodes_dram);
+
 	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
 		node, pxm,
 		(unsigned long long) start, (unsigned long long) end - 1,


