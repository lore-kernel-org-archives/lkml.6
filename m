Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03945C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1567218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeLZNit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:38:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:31979 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbeLZNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="113358931"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2018 05:37:01 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005O7-8z; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.287359389@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:50 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>
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
cc:     Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC][PATCH v2 04/21] x86/numa_emulation: pass numa node type to fake nodes
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0021-x86-numa-Fix-fake-numa-in-uniform-case.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Du <fan.du@intel.com>

Signed-off-by: Fan Du <fan.du@intel.com>
---
 arch/x86/mm/numa_emulation.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- linux.orig/arch/x86/mm/numa_emulation.c	2018-12-23 19:21:11.002206144 +0800
+++ linux/arch/x86/mm/numa_emulation.c	2018-12-23 19:21:10.998206236 +0800
@@ -12,6 +12,8 @@
 
 static int emu_nid_to_phys[MAX_NUMNODES];
 static char *emu_cmdline __initdata;
+static nodemask_t emu_numa_nodes_pmem;
+static nodemask_t emu_numa_nodes_dram;
 
 void __init numa_emu_cmdline(char *str)
 {
@@ -311,6 +313,12 @@ static int __init split_nodes_size_inter
 					       min(end, limit) - start);
 			if (ret < 0)
 				return ret;
+
+			/* Update numa node type for fake numa node */
+			if (node_isset(i, emu_numa_nodes_pmem))
+				node_set(nid - 1, numa_nodes_pmem);
+			else
+				node_set(nid - 1, numa_nodes_dram);
 		}
 	}
 	return nid;
@@ -410,6 +418,12 @@ void __init numa_emulation(struct numa_m
 		unsigned long n;
 		int nid = 0;
 
+		emu_numa_nodes_pmem = numa_nodes_pmem;
+		emu_numa_nodes_dram = numa_nodes_dram;
+
+		nodes_clear(numa_nodes_pmem);
+		nodes_clear(numa_nodes_dram);
+
 		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
 		ret = -1;
 		for_each_node_mask(i, physnode_mask) {


