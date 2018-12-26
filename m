Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0278C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C527218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeLZNjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:39:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:31975 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLZNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 05:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="113358927"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2018 05:37:01 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gc9Mr-0005OB-9m; Wed, 26 Dec 2018 21:37:01 +0800
Message-Id: <20181226133351.348801665@intel.com>
User-Agent: quilt/0.65
Date:   Wed, 26 Dec 2018 21:14:51 +0800
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
Subject: [RFC][PATCH v2 05/21] mmzone: new pgdat flags for DRAM and PMEM
References: <20181226131446.330864849@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0003-mmzone-Introduce-new-flag-to-tag-pgdat-type.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Du <fan.du@intel.com>

One system with DRAM and PMEM, we need new flag
to tag pgdat is made of DRAM or peristent memory.

This patch serves as preparetion one for follow up patch.

Signed-off-by: Fan Du <fan.du@intel.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 include/linux/mmzone.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- linux.orig/include/linux/mmzone.h	2018-12-23 19:29:42.430602202 +0800
+++ linux/include/linux/mmzone.h	2018-12-23 19:29:42.430602202 +0800
@@ -522,6 +522,8 @@ enum pgdat_flags {
 					 * many pages under writeback
 					 */
 	PGDAT_RECLAIM_LOCKED,		/* prevents concurrent reclaim */
+	PGDAT_DRAM,			/* Volatile DRAM memory node */
+	PGDAT_PMEM,			/* Persistent memory node */
 };
 
 static inline unsigned long zone_end_pfn(const struct zone *zone)
@@ -919,6 +921,30 @@ extern struct pglist_data contig_page_da
 
 #endif /* !CONFIG_NEED_MULTIPLE_NODES */
 
+static inline int is_node_pmem(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	return test_bit(PGDAT_PMEM, &pgdat->flags);
+}
+
+static inline int is_node_dram(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	return test_bit(PGDAT_DRAM, &pgdat->flags);
+}
+
+static inline void set_node_type(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	if (node_isset(nid, numa_nodes_pmem))
+		set_bit(PGDAT_PMEM, &pgdat->flags);
+	else
+		set_bit(PGDAT_DRAM, &pgdat->flags);
+}
+
 extern struct pglist_data *first_online_pgdat(void);
 extern struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
 extern struct zone *next_zone(struct zone *zone);


