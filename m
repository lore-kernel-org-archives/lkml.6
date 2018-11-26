Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9382C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B350E20660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B350E20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeKZWrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:47:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbeKZWrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:47:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAQBrneu058818
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:53:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p0f6jbcns-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:53:51 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 26 Nov 2018 11:53:45 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Nov 2018 11:53:41 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAQBrel23670362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 11:53:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C9C852050;
        Mon, 26 Nov 2018 11:53:40 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.115])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8EDD25204F;
        Mon, 26 Nov 2018 11:53:38 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 26 Nov 2018 13:53:37 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        linux-alpha@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] alpha: fix hang caused by the bootmem removal
Date:   Mon, 26 Nov 2018 13:53:36 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18112611-0016-0000-0000-0000022CC644
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112611-0017-0000-0000-00003285198D
Message-Id: <1543233216-25833-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion of alpha to memblock as the early memory manager caused boot
to hang as described at [1].

The issue is caused because for CONFIG_DISCTONTIGMEM=y case, memblock_add()
is called using memory start PFN that had been rounded down to the nearest
8Mb and it caused memblock to see more memory that is actually present in
the system.

Besides, memblock allocates memory from high addresses while bootmem was
using low memory, which broke the assumption that early allocations are
always accessible by the hardware.

This patch ensures that memblock_add() is using the correct PFN for the
memory start and forces memblock to use bottom-up allocations.

[1] https://lkml.org/lkml/2018/11/22/1032

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Tested-by: Meelis Roos <mroos@linux.ee>
---
 arch/alpha/kernel/setup.c | 1 +
 arch/alpha/mm/numa.c      | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index a37fd99..4b5b1b2 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -634,6 +634,7 @@ setup_arch(char **cmdline_p)
 
 	/* Find our memory.  */
 	setup_memory(kernel_end);
+	memblock_set_bottom_up(true);
 
 	/* First guess at cpu cache sizes.  Do this before init_arch.  */
 	determine_cpu_caches(cpu->type);
diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index 74846553..d0b7337 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -144,14 +144,14 @@ setup_memory_node(int nid, void *kernel_end)
 	if (!nid && (node_max_pfn < end_kernel_pfn || node_min_pfn > start_kernel_pfn))
 		panic("kernel loaded out of ram");
 
+	memblock_add(PFN_PHYS(node_min_pfn),
+		     (node_max_pfn - node_min_pfn) << PAGE_SHIFT);
+
 	/* Zone start phys-addr must be 2^(MAX_ORDER-1) aligned.
 	   Note that we round this down, not up - node memory
 	   has much larger alignment than 8Mb, so it's safe. */
 	node_min_pfn &= ~((1UL << (MAX_ORDER-1))-1);
 
-	memblock_add(PFN_PHYS(node_min_pfn),
-		     (node_max_pfn - node_min_pfn) << PAGE_SHIFT);
-
 	NODE_DATA(nid)->node_start_pfn = node_min_pfn;
 	NODE_DATA(nid)->node_present_pages = node_max_pfn - node_min_pfn;
 
-- 
2.7.4

