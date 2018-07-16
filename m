Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA929ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8948020877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CNlttGtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8948020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeGPPol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:44:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41714 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeGPPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:44:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GFDgPS049187;
        Mon, 16 Jul 2018 15:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=t7CKv5J4nGKVPPe7IH/P0j7Q5PeU21zXF/6+1/MMXRw=;
 b=CNlttGtB45UkETW8rJofuIey48OxEe3ZMHHiT27b/Te53M25Z/AVYluwxrQMMTignkWG
 Vpb9MlI9NW5bSJIlgP/9D3dHlCMmpJQOuvyk+VZDYDxls2GExzw0FMnuFZASzzTKZfyp
 Zb6EwL+rB255igUq3A69GvP+IEsWP88xZ2M83Ndex0gvvDRUR4Oyh1yEycD38BlSMalU
 Xq5WkDPWqCKgG56JJERzUwKKab09YrdGeUIPDIKG5V9KE19UNNah8NBumys3DzJ1CTL7
 O24Cv/3cmBgJIWYU0MDc/w/AdnqqqdqCpmCH+ckvzuhlZv1DfL9P1liujK8gpU9p5Rxa yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2k7a3t4x1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 15:16:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6GFGdbG015651
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 15:16:39 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6GFGaQt008948;
        Mon, 16 Jul 2018 15:16:36 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 15:16:35 +0000
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        pasha.tatashin@oracle.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] mm: don't do zero_resv_unavail if memmap is not allocated
Date:   Mon, 16 Jul 2018 11:16:30 -0400
Message-Id: <20180716151630.770-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving zero_resv_unavail before memmap_init_zone(), caused a regression on
x86-32.

The cause is that we access struct pages before they are allocated when
CONFIG_FLAT_NODE_MEM_MAP is used.

free_area_init_nodes()
  zero_resv_unavail()
    mm_zero_struct_page(pfn_to_page(pfn)); <- struct page is not alloced
  free_area_init_node()
    if CONFIG_FLAT_NODE_MEM_MAP
      alloc_node_mem_map()
        memblock_virt_alloc_node_nopanic() <- struct page alloced here

On the other hand memblock_virt_alloc_node_nopanic() zeroes all the memory
that it returns, so we do not need to do zero_resv_unavail() here.

Fixes: e181ae0c5db9 ("mm: zero unavailable pages before memmap init")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 include/linux/mm.h | 2 +-
 mm/page_alloc.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a0fbb9ffe380..3982c83fdcbf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2132,7 +2132,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
 					struct mminit_pfnnid_cache *state);
 #endif
 
-#ifdef CONFIG_HAVE_MEMBLOCK
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
 void zero_resv_unavail(void);
 #else
 static inline void zero_resv_unavail(void) {}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5d800d61ddb7..a790ef4be74e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6383,7 +6383,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 	free_area_init_core(pgdat);
 }
 
-#ifdef CONFIG_HAVE_MEMBLOCK
+#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
 /*
  * Only struct pages that are backed by physical memory are zeroed and
  * initialized by going through __init_single_page(). But, there are some
@@ -6421,7 +6421,7 @@ void __paginginit zero_resv_unavail(void)
 	if (pgcnt)
 		pr_info("Reserved but unavailable: %lld pages", pgcnt);
 }
-#endif /* CONFIG_HAVE_MEMBLOCK */
+#endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
 
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 
-- 
2.18.0

