Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B06CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E57208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iRhkekbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E57208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933987AbeGIRxz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:53:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40692 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933702AbeGIRxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:53:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69HnbX8103309;
        Mon, 9 Jul 2018 17:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=4SgNFnYGaVik9BBBJr44H16EIHmackJp8+ORuSv+Xy4=;
 b=iRhkekbT3xPjQajmphBMYDcLEK1AAZq7hN5wZT0vyXUm9B4+CKsqHJaH9fR2VNUaMSLA
 apANEEwhHbi9LTNb8v8cTorSwHtVZydNG0ZpNUVEcp8DVEwK0Qg3P7WsQM7BrZ1uDScY
 IVmSa2UMoqLVdp+oQ4WD6dCjRw3IddbysMNTUzBzg233nUM+GByj8qDtM+bR+t+Njw26
 JxT0iO+xrAOo3hU7V3ILthfIx9F/9yz+PHlUdW/pFwNfmFqHrqPvN+spF2ssDa6I8LvH
 z/UQCn80MOvRp4Y/XV/VI+QATPrWBSs6cIG4IczshpOUqI216RThZ2Kib9fxGy0BjBYN 4w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7dna0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 17:53:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w69HrPdf006309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 17:53:25 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69HrPtb030678;
        Mon, 9 Jul 2018 17:53:25 GMT
Received: from xakep.us.oracle.com (/10.154.140.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 10:53:25 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, pasha.tatashin@oracle.com
Subject: [PATCH v4 3/3] mm/sparse: refactor sparse vmemmap buffer allocations
Date:   Mon,  9 Jul 2018 13:53:12 -0400
Message-Id: <20180709175312.11155-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709175312.11155-1-pasha.tatashin@oracle.com>
References: <20180709175312.11155-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=947
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When struct pages are allocated for sparse-vmemmap VA layout, we first
try to allocate one large buffer, and than if that fails allocate struct
pages for each section as we go.

The code that allocates buffer is uses global variables and is spread
across several call sites.

Cleanup the code by introducing three functions to handle the global
buffer:
vmemmap_buffer_init()	initialize the buffer
vmemmap_buffer_fini()	free the remaining part of the buffer
vmemmap_buffer_alloc()	alloc from the buffer, and if buffer is empty
return NULL

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/sparse-vmemmap.c | 72 ++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 87ba7cf8c75b..4e7f51aebabf 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -46,8 +46,42 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
 					    BOOTMEM_ALLOC_ACCESSIBLE, node);
 }
 
-static void *vmemmap_buf;
-static void *vmemmap_buf_end;
+static void *vmemmap_buf __meminitdata;
+static void *vmemmap_buf_end __meminitdata;
+
+static void __init vmemmap_buffer_init(int nid, unsigned long map_count)
+{
+	unsigned long sec_size = sizeof(struct page) * PAGES_PER_SECTION;
+	unsigned long alloc_size = ALIGN(sec_size, PMD_SIZE) * map_count;
+
+	BUG_ON(vmemmap_buf);
+	vmemmap_buf = __earlyonly_bootmem_alloc(nid, alloc_size, 0,
+						__pa(MAX_DMA_ADDRESS));
+	vmemmap_buf_end = vmemmap_buf + alloc_size;
+}
+
+static void __init vmemmap_buffer_fini(void)
+{
+	unsigned long size = vmemmap_buf_end - vmemmap_buf;
+
+	if (vmemmap_buf && size > 0)
+		memblock_free_early(__pa(vmemmap_buf), size);
+	vmemmap_buf = NULL;
+}
+
+static void * __meminit vmemmap_buffer_alloc(unsigned long size)
+{
+	void *ptr = NULL;
+
+	if (vmemmap_buf) {
+		ptr = (void *)ALIGN((unsigned long)vmemmap_buf, size);
+		if (ptr + size > vmemmap_buf_end)
+			ptr = NULL;
+		else
+			vmemmap_buf = ptr + size;
+	}
+	return ptr;
+}
 
 void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 {
@@ -76,18 +110,10 @@ void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 /* need to make sure size is all the same during early stage */
 void * __meminit vmemmap_alloc_block_buf(unsigned long size, int node)
 {
-	void *ptr;
-
-	if (!vmemmap_buf)
-		return vmemmap_alloc_block(size, node);
-
-	/* take the from buf */
-	ptr = (void *)ALIGN((unsigned long)vmemmap_buf, size);
-	if (ptr + size > vmemmap_buf_end)
-		return vmemmap_alloc_block(size, node);
-
-	vmemmap_buf = ptr + size;
+	void *ptr = vmemmap_buffer_alloc(size);
 
+	if (!ptr)
+		ptr = vmemmap_alloc_block(size, node);
 	return ptr;
 }
 
@@ -282,19 +308,9 @@ struct page * __init sparse_populate_node(unsigned long pnum_begin,
 					  unsigned long map_count,
 					  int nid)
 {
-	unsigned long size = sizeof(struct page) * PAGES_PER_SECTION;
 	unsigned long pnum, map_index = 0;
-	void *vmemmap_buf_start;
-
-	size = ALIGN(size, PMD_SIZE) * map_count;
-	vmemmap_buf_start = __earlyonly_bootmem_alloc(nid, size,
-						      PMD_SIZE,
-						      __pa(MAX_DMA_ADDRESS));
-	if (vmemmap_buf_start) {
-		vmemmap_buf = vmemmap_buf_start;
-		vmemmap_buf_end = vmemmap_buf_start + size;
-	}
 
+	vmemmap_buffer_init(nid, map_count);
 	for (pnum = pnum_begin; map_index < map_count; pnum++) {
 		if (!present_section_nr(pnum))
 			continue;
@@ -303,14 +319,8 @@ struct page * __init sparse_populate_node(unsigned long pnum_begin,
 		map_index++;
 		BUG_ON(pnum >= pnum_end);
 	}
+	vmemmap_buffer_fini();
 
-	if (vmemmap_buf_start) {
-		/* need to free left buf */
-		memblock_free_early(__pa(vmemmap_buf),
-				    vmemmap_buf_end - vmemmap_buf);
-		vmemmap_buf = NULL;
-		vmemmap_buf_end = NULL;
-	}
 	return pfn_to_page(section_nr_to_pfn(pnum_begin));
 }
 
-- 
2.18.0

