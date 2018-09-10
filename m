Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B50C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CACE20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CACE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeIJRar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:30:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727649AbeIJRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:30:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ACamef131560
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:36:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mdr991dup-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:36:50 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Mon, 10 Sep 2018 13:35:31 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Sep 2018 13:35:29 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ACZS5b66584732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Sep 2018 12:35:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 817414C046;
        Mon, 10 Sep 2018 15:35:20 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F0F44C040;
        Mon, 10 Sep 2018 15:35:20 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Sep 2018 15:35:20 +0100 (BST)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, Pavel.Tatashin@microsoft.com, osalvador@suse.de,
        gerald.schaefer@de.ibm.com, zaslonko@linux.ibm.com
Subject: [PATCH] memory_hotplug: fix the panic when memory end is not on the section boundary
Date:   Mon, 10 Sep 2018 14:35:27 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18091012-0012-0000-0000-000002A6A04C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091012-0013-0000-0000-000020DAD849
Message-Id: <20180910123527.71209-1-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=971 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If memory end is not aligned with the linux memory section boundary, such
a section is only partly initialized. This may lead to VM_BUG_ON due to
uninitialized struct pages access from is_mem_section_removable() or
test_pages_in_a_zone() function.

Here is one of the panic examples:
 CONFIG_DEBUG_VM_PGFLAGS=y
 kernel parameter mem=3075M

 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 ------------[ cut here ]------------
 Call Trace:
 ([<000000000039b8a4>] is_mem_section_removable+0xcc/0x1c0)
  [<00000000009558ba>] show_mem_removable+0xda/0xe0
  [<00000000009325fc>] dev_attr_show+0x3c/0x80
  [<000000000047e7ea>] sysfs_kf_seq_show+0xda/0x160
  [<00000000003fc4e0>] seq_read+0x208/0x4c8
  [<00000000003cb80e>] __vfs_read+0x46/0x180
  [<00000000003cb9ce>] vfs_read+0x86/0x148
  [<00000000003cc06a>] ksys_read+0x62/0xc0
  [<0000000000c001c0>] system_call+0xdc/0x2d8

This fix checks if the page lies within the zone boundaries before
accessing the struct page data. The check is added to both functions.
Actually similar check has already been present in
is_pageblock_removable_nolock() function but only after the struct page
is accessed.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: <stable@vger.kernel.org>
---
 mm/memory_hotplug.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9eea6e809a4e..8e20e8fcc3b0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1229,9 +1229,8 @@ static struct page *next_active_pageblock(struct page *page)
 	return page + pageblock_nr_pages;
 }
 
-static bool is_pageblock_removable_nolock(struct page *page)
+static bool is_pageblock_removable_nolock(struct page *page, struct zone **zone)
 {
-	struct zone *zone;
 	unsigned long pfn;
 
 	/*
@@ -1241,15 +1240,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
 	 * We have to take care about the node as well. If the node is offline
 	 * its NODE_DATA will be NULL - see page_zone.
 	 */
-	if (!node_online(page_to_nid(page)))
-		return false;
-
-	zone = page_zone(page);
 	pfn = page_to_pfn(page);
-	if (!zone_spans_pfn(zone, pfn))
+	if (*zone && !zone_spans_pfn(*zone, pfn))
 		return false;
+	if (!node_online(page_to_nid(page)))
+		return false;
+	*zone = page_zone(page);
 
-	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
+	return !has_unmovable_pages(*zone, page, 0, MIGRATE_MOVABLE, true);
 }
 
 /* Checks if this range of memory is likely to be hot-removable. */
@@ -1257,10 +1255,11 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
 	struct page *page = pfn_to_page(start_pfn);
 	struct page *end_page = page + nr_pages;
+	struct zone *zone = NULL;
 
 	/* Check the starting page of each pageblock within the range */
 	for (; page < end_page; page = next_active_pageblock(page)) {
-		if (!is_pageblock_removable_nolock(page))
+		if (!is_pageblock_removable_nolock(page, &zone))
 			return false;
 		cond_resched();
 	}
@@ -1296,6 +1295,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 				i++;
 			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
 				continue;
+			/* Check if we got outside of the zone */
+			if (zone && !zone_spans_pfn(zone, pfn))
+				return 0;
 			page = pfn_to_page(pfn + i);
 			if (zone && page_zone(page) != zone)
 				return 0;
-- 
2.16.4

