Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215A72184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfBFMKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:10:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbfBFMKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:10:40 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16C5PR2132409
        for <linux-kernel@vger.kernel.org>; Wed, 6 Feb 2019 07:10:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfxsm245w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:10:39 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 6 Feb 2019 12:10:36 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 12:10:34 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16CAX7C8913254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 12:10:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E72A44204F;
        Wed,  6 Feb 2019 12:10:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80CD042070;
        Wed,  6 Feb 2019 12:10:31 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Feb 2019 12:10:31 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 06 Feb 2019 14:10:30 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/2] memblock: split checks whether a region should be skipped to a helper function
Date:   Wed,  6 Feb 2019 14:10:25 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549455025-17706-1-git-send-email-rppt@linux.ibm.com>
References: <1549455025-17706-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020612-0016-0000-0000-000002531D6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020612-0017-0000-0000-000032AD2650
Message-Id: <1549455025-17706-3-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __next_mem_range() and __next_mem_range_rev() duplucate the code that
checks whether a region should be skipped because of node or flags
incompatibility.

Split this code into a helper function.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 53 +++++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index af5fe8e..f87d3ae 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -958,6 +958,29 @@ void __init_memblock __next_reserved_mem_region(u64 *idx,
 	*idx = ULLONG_MAX;
 }
 
+static bool should_skip_region(struct memblock_region *m, int nid, int flags)
+{
+	int m_nid = memblock_get_region_node(m);
+
+	/* only memory regions are associated with nodes, check it */
+	if (nid != NUMA_NO_NODE && nid != m_nid)
+		return true;
+
+	/* skip hotpluggable memory regions if needed */
+	if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
+		return true;
+
+	/* if we want mirror memory skip non-mirror memory regions */
+	if ((flags & MEMBLOCK_MIRROR) && !memblock_is_mirror(m))
+		return true;
+
+	/* skip nomap memory unless we were asked for it explicitly */
+	if (!(flags & MEMBLOCK_NOMAP) && memblock_is_nomap(m))
+		return true;
+
+	return false;
+}
+
 /**
  * __next__mem_range - next function for for_each_free_mem_range() etc.
  * @idx: pointer to u64 loop variable
@@ -1005,20 +1028,7 @@ void __init_memblock __next_mem_range(u64 *idx, int nid,
 		phys_addr_t m_end = m->base + m->size;
 		int	    m_nid = memblock_get_region_node(m);
 
-		/* only memory regions are associated with nodes, check it */
-		if (nid != NUMA_NO_NODE && nid != m_nid)
-			continue;
-
-		/* skip hotpluggable memory regions if needed */
-		if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
-			continue;
-
-		/* if we want mirror memory skip non-mirror memory regions */
-		if ((flags & MEMBLOCK_MIRROR) && !memblock_is_mirror(m))
-			continue;
-
-		/* skip nomap memory unless we were asked for it explicitly */
-		if (!(flags & MEMBLOCK_NOMAP) && memblock_is_nomap(m))
+		if (should_skip_region(m, nid, flags))
 			continue;
 
 		if (!type_b) {
@@ -1122,20 +1132,7 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
 		phys_addr_t m_end = m->base + m->size;
 		int m_nid = memblock_get_region_node(m);
 
-		/* only memory regions are associated with nodes, check it */
-		if (nid != NUMA_NO_NODE && nid != m_nid)
-			continue;
-
-		/* skip hotpluggable memory regions if needed */
-		if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
-			continue;
-
-		/* if we want mirror memory skip non-mirror memory regions */
-		if ((flags & MEMBLOCK_MIRROR) && !memblock_is_mirror(m))
-			continue;
-
-		/* skip nomap memory unless we were asked for it explicitly */
-		if (!(flags & MEMBLOCK_NOMAP) && memblock_is_nomap(m))
+		if (should_skip_region(m, nid, flags))
 			continue;
 
 		if (!type_b) {
-- 
2.7.4

