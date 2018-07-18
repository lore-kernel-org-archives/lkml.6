Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629BEECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D35B2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D35B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbeGROPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731249AbeGROO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:14:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E16D1AE20;
        Wed, 18 Jul 2018 13:36:28 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 7/7] mm, slab: shorten kmalloc cache names for large sizes
Date:   Wed, 18 Jul 2018 15:36:20 +0200
Message-Id: <20180718133620.6205-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718133620.6205-1-vbabka@suse.cz>
References: <20180718133620.6205-1-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmalloc cache names can get quite long for large object sizes, when the sizes
are expressed in bytes. Use 'k' and 'M' prefixes to make the names as short
as possible e.g. in /proc/slabinfo. This works, as we mostly use power-of-two
sizes, with exceptions only below 1k.

Example: 'kmalloc-4194304' becomes 'kmalloc-4M'

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 614fb7ab8312..04d71ead7d12 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1049,15 +1049,15 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
 	{"kmalloc-16",             16},		{"kmalloc-32",             32},
 	{"kmalloc-64",             64},		{"kmalloc-128",           128},
 	{"kmalloc-256",           256},		{"kmalloc-512",           512},
-	{"kmalloc-1024",         1024},		{"kmalloc-2048",         2048},
-	{"kmalloc-4096",         4096},		{"kmalloc-8192",         8192},
-	{"kmalloc-16384",       16384},		{"kmalloc-32768",       32768},
-	{"kmalloc-65536",       65536},		{"kmalloc-131072",     131072},
-	{"kmalloc-262144",     262144},		{"kmalloc-524288",     524288},
-	{"kmalloc-1048576",   1048576},		{"kmalloc-2097152",   2097152},
-	{"kmalloc-4194304",   4194304},		{"kmalloc-8388608",   8388608},
-	{"kmalloc-16777216", 16777216},		{"kmalloc-33554432", 33554432},
-	{"kmalloc-67108864", 67108864}
+	{"kmalloc-1k",           1024},		{"kmalloc-2k",           2048},
+	{"kmalloc-4k",           4096},		{"kmalloc-8k",           8192},
+	{"kmalloc-16k",         16384},		{"kmalloc-32k",         32768},
+	{"kmalloc-64k",         65536},		{"kmalloc-128k",       131072},
+	{"kmalloc-256k",       262144},		{"kmalloc-512k",       524288},
+	{"kmalloc-1M",        1048576},		{"kmalloc-2M",        2097152},
+	{"kmalloc-4M",        4194304},		{"kmalloc-8M",        8388608},
+	{"kmalloc-16M",      16777216},		{"kmalloc-32M",      33554432},
+	{"kmalloc-64M",      67108864}
 };
 
 /*
@@ -1107,6 +1107,21 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
+static const char *
+kmalloc_cache_name(const char *prefix, unsigned int size)
+{
+
+	static const char units[3] = "\0kM";
+	int idx = 0;
+
+	while (size >= 1024 && (size % 1024 == 0)) {
+		size /= 1024;
+		idx++;
+	}
+
+	return kasprintf(GFP_NOWAIT, "%s-%u%c", prefix, size, units[idx]);
+}
+
 static void __init
 new_kmalloc_cache(int idx, int type, slab_flags_t flags)
 {
@@ -1114,7 +1129,7 @@ new_kmalloc_cache(int idx, int type, slab_flags_t flags)
 
 	if (type == KMALLOC_RECLAIM) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
-		name = kasprintf(GFP_NOWAIT, "kmalloc-rcl-%u",
+		name = kmalloc_cache_name("kmalloc-rcl",
 						kmalloc_info[idx].size);
 		BUG_ON(!name);
 	} else {
@@ -1163,8 +1178,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 
 		if (s) {
 			unsigned int size = kmalloc_size(i);
-			char *n = kasprintf(GFP_NOWAIT,
-				 "dma-kmalloc-%u", size);
+			const char *n = kmalloc_cache_name("dma-kmalloc", size);
 
 			BUG_ON(!n);
 			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
-- 
2.18.0

