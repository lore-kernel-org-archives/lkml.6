Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2889FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31712089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31712089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeH1M4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:56:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727087AbeH1M4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:56:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7S94CZY110734
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:05:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m51j2db82-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:05:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Tue, 28 Aug 2018 10:05:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 10:05:40 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7S95eLw26214496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 09:05:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D41FC4C050;
        Tue, 28 Aug 2018 12:05:38 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D284C046;
        Tue, 28 Aug 2018 12:05:38 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Aug 2018 12:05:38 +0100 (BST)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pasha.tatashin@oracle.com, mhocko@kernel.org,
        zaslonko@linux.ibm.com
Subject: [PATCH] memory_hotplug: fix kernel_panic on offline page processing
Date:   Tue, 28 Aug 2018 11:05:39 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18082809-0016-0000-0000-000001FCB903
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082809-0017-0000-0000-0000325328A0
Message-Id: <20180828090539.41491-1-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Within show_valid_zones() the function test_pages_in_a_zone() should be
called for online memory blocks only. Otherwise it might lead to the
VM_BUG_ON due to uninitialized struct pages (when CONFIG_DEBUG_VM_PGFLAGS
kernel option is set):

 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 ------------[ cut here ]------------
 Call Trace:
 ([<000000000038f91e>] test_pages_in_a_zone+0xe6/0x168)
  [<0000000000923472>] show_valid_zones+0x5a/0x1a8
  [<0000000000900284>] dev_attr_show+0x3c/0x78
  [<000000000046f6f0>] sysfs_kf_seq_show+0xd0/0x150
  [<00000000003ef662>] seq_read+0x212/0x4b8
  [<00000000003bf202>] __vfs_read+0x3a/0x178
  [<00000000003bf3ca>] vfs_read+0x8a/0x148
  [<00000000003bfa3a>] ksys_read+0x62/0xb8
  [<0000000000bc2220>] system_call+0xdc/0x2d8

That VM_BUG_ON was triggered by the page poisoning introduced in
mm/sparse.c with the git commit d0dc12e86b31 ("mm/memory_hotplug: optimize
memory hotplug")
With the same commit the new 'nid' field has been added to the struct
memory_block in order to store and later on derive the node id for offline
pages (instead of accessing struct page which might be uninitialized). But
one reference to nid in show_valid_zones() function has been overlooked.
Fixed with current commit.
Also, nr_pages will not be used any more after test_pages_in_a_zone() call,
do not update it.

Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
Cc: <stable@vger.kernel.org> # v4.17+
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 drivers/base/memory.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f5e560188a18..622ab8edc035 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -416,26 +416,24 @@ static ssize_t show_valid_zones(struct device *dev,
 	struct zone *default_zone;
 	int nid;
 
-	/*
-	 * The block contains more than one zone can not be offlined.
-	 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
-	 */
-	if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages, &valid_start_pfn, &valid_end_pfn))
-		return sprintf(buf, "none\n");
-
-	start_pfn = valid_start_pfn;
-	nr_pages = valid_end_pfn - start_pfn;
-
 	/*
 	 * Check the existing zone. Make sure that we do that only on the
 	 * online nodes otherwise the page_zone is not reliable
 	 */
 	if (mem->state == MEM_ONLINE) {
+		/*
+		 * The block contains more than one zone can not be offlined.
+		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
+		 */
+		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
+					  &valid_start_pfn, &valid_end_pfn))
+			return sprintf(buf, "none\n");
+		start_pfn = valid_start_pfn;
 		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
 		goto out;
 	}
 
-	nid = pfn_to_nid(start_pfn);
+	nid = mem->nid;
 	default_zone = zone_for_pfn_range(MMOP_ONLINE_KEEP, nid, start_pfn, nr_pages);
 	strcat(buf, default_zone->name);
 
-- 
2.16.4

