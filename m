Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BE4C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFCC2244C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFCC2244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeHJTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:31:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727381AbeHJTb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:31:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7AGxMdx142230
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:00:47 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ksckswhbw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:00:45 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 10 Aug 2018 18:00:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Aug 2018 18:00:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7AH0cEs34275534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Aug 2018 17:00:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DB0E52051;
        Fri, 10 Aug 2018 20:00:44 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.84.228.228])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3000E5204F;
        Fri, 10 Aug 2018 20:00:40 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Andre Wild <wild@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] sched/topology: Set correct numa topology type
Date:   Fri, 10 Aug 2018 22:30:18 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <reply-to=<20180808081942.GA37418@linux.vnet.ibm.com>
References: <reply-to=<20180808081942.GA37418@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081017-0008-0000-0000-0000025FFDEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081017-0009-0000-0000-000021C81276
Message-Id: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-10_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808100182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
sched domain") scheduler introduces an new numa level. However this
leads to numa topology on 2 node systems no more marked as NUMA_DIRECT.
After this commit, it gets reported as NUMA_BACKPLANE. This is because
sched_domains_numa_level is now 2 on 2 node systems.

Fix this by allowing setting systems that have upto 2 numa levels as
NUMA_DIRECT.

While here remove a code that assumes level can be 0.

Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a6e6b855ba81..cec3ee3ed320 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1315,7 +1315,7 @@ static void init_numa_topology_type(void)
 
 	n = sched_max_numa_distance;
 
-	if (sched_domains_numa_levels <= 1) {
+	if (sched_domains_numa_levels <= 2) {
 		sched_numa_topology_type = NUMA_DIRECT;
 		return;
 	}
@@ -1400,9 +1400,6 @@ void sched_init_numa(void)
 			break;
 	}
 
-	if (!level)
-		return;
-
 	/*
 	 * 'level' contains the number of unique distances
 	 *
-- 
2.12.3

