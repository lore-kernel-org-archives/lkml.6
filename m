Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE13D218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeLZNj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:39:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:31975 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbeLZNhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="113358926"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005O3-8C; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.229014333@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:49 +0800
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
Subject: [RFC][PATCH v2 03/21] x86/numa_emulation: fix fake NUMA in uniform case
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=fix-fake-numa.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Du <fan.du@intel.com>

The index of numa_meminfo is expected to the same as of numa_meminfo.blk[].
and numa_remove_memblk_from break the expectation.

2S system does not break, because

before numa_remove_memblk_from
index  nid
0	0
1	1

after numa_remove_memblk_from

index  nid
0	1
1	1

If you try to configure uniform fake node in 4S system.
index  nid
0	0
1	1
2       2
3	3

node 3 will be removed by numa_remove_memblk_from when iterate index 2.
so we only create fake node for 3 physcial node, and a portion of memroy
wasted as much as it hit lost pages checking in numa_meminfo_cover_memory.

Signed-off-by: Fan Du <fan.du@intel.com>

---
 arch/x86/mm/numa_emulation.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- linux.orig/arch/x86/mm/numa_emulation.c	2018-12-23 19:20:51.570664269 +0800
+++ linux/arch/x86/mm/numa_emulation.c	2018-12-23 19:20:51.566664364 +0800
@@ -381,7 +381,21 @@ void __init numa_emulation(struct numa_m
 		goto no_emu;
 
 	memset(&ei, 0, sizeof(ei));
-	pi = *numa_meminfo;
+
+	{
+		/* Make sure the index is identical with nid */
+		struct numa_meminfo *mi = numa_meminfo;
+		int nid;
+
+		for (i = 0; i < mi->nr_blks; i++) {
+			nid = mi->blk[i].nid;
+			pi.blk[nid].nid = nid;
+			pi.blk[nid].start = mi->blk[i].start;
+			pi.blk[nid].end = mi->blk[i].end;
+		}
+		pi.nr_blks = mi->nr_blks;
+
+	}
 
 	for (i = 0; i < MAX_NUMNODES; i++)
 		emu_nid_to_phys[i] = NUMA_NO_NODE;


