Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7AAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FCF218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeLZNib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:38:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:31975 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbeLZNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="113358933"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2018 05:37:02 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005OY-D7; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.579378360@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:55 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Fengguang Wu <fengguang.wu@intel.com>
cc:     kvm@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
cc:     Fan Du <fan.du@intel.com>
cc:     Yao Yuan <yuan.yao@intel.com>
cc:     Peng Dong <dongx.peng@intel.com>
cc:     Huang Ying <ying.huang@intel.com>
CC:     Liu Jingqi <jingqi.liu@intel.com>
cc:     Dong Eddie <eddie.dong@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>
cc:     Zhang Yi <yi.z.zhang@linux.intel.com>
cc:     Dan Williams <dan.j.williams@intel.com>
Subject: [RFC][PATCH v2 09/21] mm: avoid duplicate peer target node
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0020-page_alloc-avoid-duplicate-peer-target-node.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure 1:1 peer node mapping on broken BIOS

	node distances:
	node   0   1   2   3
	  0:  10  21  20  20
	  1:  21  10  20  20
	  2:  20  20  10  20
	  3:  20  20  20  10

or with numa=fake=4U

	node distances:
	node   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
	  0:  10  10  10  10  21  21  21  21  17  17  17  17  28  28  28  28
	  1:  10  10  10  10  21  21  21  21  17  17  17  17  28  28  28  28
	  2:  10  10  10  10  21  21  21  21  17  17  17  17  28  28  28  28
	  3:  10  10  10  10  21  21  21  21  17  17  17  17  28  28  28  28
	  4:  21  21  21  21  10  10  10  10  28  28  28  28  17  17  17  17
	  5:  21  21  21  21  10  10  10  10  28  28  28  28  17  17  17  17
	  6:  21  21  21  21  10  10  10  10  28  28  28  28  17  17  17  17
	  7:  21  21  21  21  10  10  10  10  28  28  28  28  17  17  17  17
	  8:  17  17  17  17  28  28  28  28  10  10  10  10  28  28  28  28
	  9:  17  17  17  17  28  28  28  28  10  10  10  10  28  28  28  28
	 10:  17  17  17  17  28  28  28  28  10  10  10  10  28  28  28  28
	 11:  17  17  17  17  28  28  28  28  10  10  10  10  28  28  28  28
	 12:  28  28  28  28  17  17  17  17  28  28  28  28  10  10  10  10
	 13:  28  28  28  28  17  17  17  17  28  28  28  28  10  10  10  10
	 14:  28  28  28  28  17  17  17  17  28  28  28  28  10  10  10  10
	 15:  28  28  28  28  17  17  17  17  28  28  28  28  10  10  10  10

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 mm/page_alloc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux.orig/mm/page_alloc.c	2018-12-23 19:48:27.366110325 +0800
+++ linux/mm/page_alloc.c	2018-12-23 19:48:27.362110332 +0800
@@ -6941,16 +6941,22 @@ static int find_best_peer_node(int nid)
 	int n, val;
 	int min_val = INT_MAX;
 	int peer = NUMA_NO_NODE;
+	static nodemask_t target_nodes = NODE_MASK_NONE;
 
 	for_each_online_node(n) {
 		if (n == nid)
 			continue;
 		val = node_distance(nid, n);
+		if (val == LOCAL_DISTANCE)
+			continue;
+		if (node_isset(n, target_nodes))
+			continue;
 		if (val < min_val) {
 			min_val = val;
 			peer = n;
 		}
 	}
+	node_set(peer, target_nodes);
 	return peer;
 }
 


