Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5EAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812C72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbfAPGvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:51:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731274AbfAPGvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:51:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0G6iMIb119239
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:51:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q1up8jdu2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 01:51:30 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 16 Jan 2019 06:51:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 06:51:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0G6pOlp1114580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 06:51:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCC3CA4040;
        Wed, 16 Jan 2019 06:51:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65FDEA4051;
        Wed, 16 Jan 2019 06:51:23 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 06:51:23 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 16 Jan 2019 08:51:22 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm/page_alloc: check return value of memblock_alloc_node_nopanic()
Date:   Wed, 16 Jan 2019 08:51:21 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19011606-0016-0000-0000-0000024616F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011606-0017-0000-0000-000032A031BE
Message-Id: <1547621481-8374-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=874 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two early memory allocations that use
memblock_alloc_node_nopanic() and do not check its return value.
While this happens very early during boot and chances that the allocation
will fail are diminishing, it is still worth to have proper checks for the
allocation errors.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..7801accbe02a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6376,10 +6376,14 @@ static void __ref setup_usemap(struct pglist_data *pgdat,
 {
 	unsigned long usemapsize = usemap_size(zone_start_pfn, zonesize);
 	zone->pageblock_flags = NULL;
-	if (usemapsize)
+	if (usemapsize) {
 		zone->pageblock_flags =
 			memblock_alloc_node_nopanic(usemapsize,
 							 pgdat->node_id);
+		if (!zone->pageblock_flags)
+			panic("Failed to allocate %ld bytes for zone %s pageblock flags\n",
+			      usemapsize, zone->name);
+	}
 }
 #else
 static inline void setup_usemap(struct pglist_data *pgdat, struct zone *zone,
@@ -6609,6 +6613,9 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 		end = ALIGN(end, MAX_ORDER_NR_PAGES);
 		size =  (end - start) * sizeof(struct page);
 		map = memblock_alloc_node_nopanic(size, pgdat->node_id);
+		if (!map)
+			panic("Failed to allocate %ld bytes for memory map\n",
+			      size);
 		pgdat->node_mem_map = map + offset;
 	}
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
-- 
2.7.4

