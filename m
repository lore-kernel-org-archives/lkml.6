Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2420020870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwM6nd5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2420020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeGPSO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:14:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39946 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:14:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GHi0p2166871;
        Mon, 16 Jul 2018 17:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=7t7F+kI406v/SCiDy8NUkpqH+t2+sZ/cokropNI+ghM=;
 b=iwM6nd5GkWmpBXpDulNee5+/me8PQdVfthaRr/0zmJQ+OVDlQTxmhYwWr6pSOZJIJwhM
 9Q1hgEzJc3ta0hprOsNs9IZzXgeqQCkFpoVxw6muFgsbPVciFQvTSqyLqPMBOUr3K2aM
 +kXdCuzSaPmMvOYns8I6PNZDJP13/ZYChRjv2enYWXrnI3tCrPJ5crtNSP+9tL3SOV36
 8FlgSEGY6lF+IFWMnjCEK1YSCTg/fZz37Yqx6JDyapdgABdWIyCvZzLef2EjOMwIhMHi
 GfhbD3pfT0ahG6ZqPl3m2nUkcMT7dQrEDOprIjKsUF09kBeABbKtMSRv5esFE2nK+fGe cA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k7a3t5hh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:45:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHj1r5001979
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:45:01 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHj0vI025791;
        Mon, 16 Jul 2018 17:45:00 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 10:45:00 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, pasha.tatashin@oracle.com,
        abdhalee@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH v6 3/5] mm/sparse: move buffer init/fini to the common place
Date:   Mon, 16 Jul 2018 13:44:45 -0400
Message-Id: <20180716174447.14529-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716174447.14529-1-pasha.tatashin@oracle.com>
References: <20180716174447.14529-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that both variants of sparse memory use the same buffers to populate
memory map, we can move sparse_buffer_init()/sparse_buffer_fini() to the
common place.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 include/linux/mm.h  |  3 ---
 mm/sparse-vmemmap.c |  2 --
 mm/sparse.c         | 14 +++++++-------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a83d3e0e66d4..99d8c50adef6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2655,9 +2655,6 @@ void sparse_mem_maps_populate_node(struct page **map_map,
 				   unsigned long map_count,
 				   int nodeid);
 
-unsigned long __init section_map_size(void);
-void sparse_buffer_init(unsigned long size, int nid);
-void sparse_buffer_fini(void);
 void *sparse_buffer_alloc(unsigned long size);
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
 		struct vmem_altmap *altmap);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index b05c7663c640..cd15f3d252c3 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -270,7 +270,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 	unsigned long pnum;
 	int nr_consumed_maps = 0;
 
-	sparse_buffer_init(section_map_size() * map_count, nodeid);
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
 		if (!present_section_nr(pnum))
 			continue;
@@ -282,5 +281,4 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
 	}
-	sparse_buffer_fini();
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index db4867b62fff..20ca292d8f11 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -401,14 +401,14 @@ static void __init sparse_early_usemaps_alloc_node(void *data,
 }
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-unsigned long __init section_map_size(void)
+static unsigned long __init section_map_size(void)
 
 {
 	return ALIGN(sizeof(struct page) * PAGES_PER_SECTION, PMD_SIZE);
 }
 
 #else
-unsigned long __init section_map_size(void)
+static unsigned long __init section_map_size(void)
 {
 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
 }
@@ -433,10 +433,8 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 					  unsigned long map_count, int nodeid)
 {
 	unsigned long pnum;
-	unsigned long size = section_map_size();
 	int nr_consumed_maps = 0;
 
-	sparse_buffer_init(size * map_count, nodeid);
 	for (pnum = pnum_begin; pnum < pnum_end; pnum++) {
 		if (!present_section_nr(pnum))
 			continue;
@@ -447,14 +445,13 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
 	}
-	sparse_buffer_fini();
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
 static void *sparsemap_buf __meminitdata;
 static void *sparsemap_buf_end __meminitdata;
 
-void __init sparse_buffer_init(unsigned long size, int nid)
+static void __init sparse_buffer_init(unsigned long size, int nid)
 {
 	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
 	sparsemap_buf =
@@ -464,7 +461,7 @@ void __init sparse_buffer_init(unsigned long size, int nid)
 	sparsemap_buf_end = sparsemap_buf + size;
 }
 
-void __init sparse_buffer_fini(void)
+static void __init sparse_buffer_fini(void)
 {
 	unsigned long size = sparsemap_buf_end - sparsemap_buf;
 
@@ -494,8 +491,11 @@ static void __init sparse_early_mem_maps_alloc_node(void *data,
 				 unsigned long map_count, int nodeid)
 {
 	struct page **map_map = (struct page **)data;
+
+	sparse_buffer_init(section_map_size() * map_count, nodeid);
 	sparse_mem_maps_populate_node(map_map, pnum_begin, pnum_end,
 					 map_count, nodeid);
+	sparse_buffer_fini();
 }
 #else
 static struct page __init *sparse_early_mem_map_alloc(unsigned long pnum)
-- 
2.18.0

