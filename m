Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0717ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6099A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tHMS/GdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6099A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeGPSOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:14:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58812 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:14:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GHi06b163561;
        Mon, 16 Jul 2018 17:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=HshFKhNMdbDY+R2VFmveccDHbY+ei3+gykokCKNUd+k=;
 b=tHMS/GdXbvuKdXJaxMIZB3+lLFQIO0Rg7Ba+C5l1kOvSYVCJ9W9CBFW63mdbpZXhG6li
 Z5ZWRQX0CNLGmBNABFeiDAaEPabF2gsUZRD7FiidB7slIuyLBxMfGWRr5Sv/CVYL9hvA
 diwZuDvhufOMdP271lNOWFc4GUf4HG5QCOxumJI+zP3XAK/b/5d1ZxO1EK6oaXhHyW81
 lEmWEWUSqYKU+z4sDFdkn0dkakQNmATpA55NtubaNP+4HCKTTke3xXKu2+2unqIBWUz5
 JzwpyZflWULCuCkLeDwb2HAWzOMncD9t+j5+XKCoNU3jMafepj/904hyQeCZ+CLLT7ov og== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k7a3jnh18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:45:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GHj2XT017269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 17:45:03 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GHj29f005977;
        Mon, 16 Jul 2018 17:45:02 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 10:45:02 -0700
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
Subject: [PATCH v6 4/5] mm/sparse: add new sparse_init_nid() and sparse_init()
Date:   Mon, 16 Jul 2018 13:44:46 -0400
Message-Id: <20180716174447.14529-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716174447.14529-1-pasha.tatashin@oracle.com>
References: <20180716174447.14529-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse_init() requires to temporary allocate two large buffers: usemap_map
and map_map.  Baoquan He has identified that these buffers are so large
that Linux is not bootable on small memory machines, such as a kdump boot.
The buffers are especially large when CONFIG_X86_5LEVEL is set, as they
are scaled to the maximum physical memory size.

Baoquan provided a fix, which reduces these sizes of these buffers, but it
is much better to get rid of them entirely.

Add a new way to initialize sparse memory: sparse_init_nid(), which only
operates within one memory node, and thus allocates memory either in large
contiguous block or allocates section by section.  This eliminates the
need for use of temporary buffers.

For simplified bisecting and review temporarly call sparse_init()
new_sparse_init(), the new interface is going to be enabled as well as old
code removed in the next patch.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 20ca292d8f11..248d5d7bbf55 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -200,6 +200,11 @@ static inline int next_present_section_nr(int section_nr)
 	      (section_nr <= __highest_present_section_nr));	\
 	     section_nr = next_present_section_nr(section_nr))
 
+static inline unsigned long first_present_section_nr(void)
+{
+	return next_present_section_nr(-1);
+}
+
 /*
  * Record how many memory sections are marked as present
  * during system bootup.
@@ -668,6 +673,86 @@ void __init sparse_init(void)
 	memblock_free_early(__pa(usemap_map), size);
 }
 
+/*
+ * Initialize sparse on a specific node. The node spans [pnum_begin, pnum_end)
+ * And number of present sections in this node is map_count.
+ */
+static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
+				   unsigned long pnum_end,
+				   unsigned long map_count)
+{
+	unsigned long pnum, usemap_longs, *usemap;
+	struct page *map;
+
+	usemap_longs = BITS_TO_LONGS(SECTION_BLOCKFLAGS_BITS);
+	usemap = sparse_early_usemaps_alloc_pgdat_section(NODE_DATA(nid),
+							  usemap_size() *
+							  map_count);
+	if (!usemap) {
+		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
+		goto failed;
+	}
+	sparse_buffer_init(map_count * section_map_size(), nid);
+	for_each_present_section_nr(pnum_begin, pnum) {
+		if (pnum >= pnum_end)
+			break;
+
+		map = sparse_mem_map_populate(pnum, nid, NULL);
+		if (!map) {
+			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
+			       __func__, nid);
+			pnum_begin = pnum;
+			goto failed;
+		}
+		check_usemap_section_nr(nid, usemap);
+		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usemap);
+		usemap += usemap_longs;
+	}
+	sparse_buffer_fini();
+	return;
+failed:
+	/* We failed to allocate, mark all the following pnums as not present */
+	for_each_present_section_nr(pnum_begin, pnum) {
+		struct mem_section *ms;
+
+		if (pnum >= pnum_end)
+			break;
+		ms = __nr_to_section(pnum);
+		ms->section_mem_map = 0;
+	}
+}
+
+/*
+ * Allocate the accumulated non-linear sections, allocate a mem_map
+ * for each and record the physical to section mapping.
+ */
+void __init new_sparse_init(void)
+{
+	unsigned long pnum_begin = first_present_section_nr();
+	int nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
+	unsigned long pnum_end, map_count = 1;
+
+	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
+	set_pageblock_order();
+
+	for_each_present_section_nr(pnum_begin + 1, pnum_end) {
+		int nid = sparse_early_nid(__nr_to_section(pnum_end));
+
+		if (nid == nid_begin) {
+			map_count++;
+			continue;
+		}
+		/* Init node with sections in range [pnum_begin, pnum_end) */
+		sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
+		nid_begin = nid;
+		pnum_begin = pnum_end;
+		map_count = 1;
+	}
+	/* cover the last node */
+	sparse_init_nid(nid_begin, pnum_begin, pnum_end, map_count);
+	vmemmap_populate_print_last();
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 
 /* Mark all memory sections within the pfn range as online */
-- 
2.18.0

