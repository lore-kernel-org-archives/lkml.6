Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB87C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8BD20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8BD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeFTREU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:04:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932597AbeFTREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:04:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGxHeO103185
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:04:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsbnvetb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:04:14 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 18:04:13 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 18:04:09 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH481X26673216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:04:08 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13F95A405D;
        Wed, 20 Jun 2018 17:54:49 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F37EA4059;
        Wed, 20 Jun 2018 17:54:47 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.124.219.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 17:54:47 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 00/19]  Fixes for sched/numa_balancing
Date:   Wed, 20 Jun 2018 22:33:01 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062017-4275-0000-0000-0000028FF4A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-4276-0000-0000-000037973E8F
Message-Id: <1529514181-9842-21-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset based on v4.17, provides few simple cleanups and fixes in
the sched/numa_balancing code. Some of these fixes are specific to systems
having more than 2 nodes. Few patches add per-rq and per-node complexities
to solve what I feel are a fairness/correctness issues.

This version handles the comments given to some of the patches.
It also provides specjbb2005 numbers on a patch basis on a 4 node and
16 node system.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
(higher bops are better)
JVMS  v4.17  	v4.17+patch   %CHANGE
16    25705.2     26158.1     1.731
1     74433	  72725       -2.34

Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
(higher bops are better)
JVMS  v4.17  	v4.17+patch   %CHANGE
8     96589.6     113992      15.26
1     181830      174947      -3.93

Only patches, 2, 4, 13 and 16 have changes. The rest of the patches are
unchanged.
r
For overall numbers with v1 running perf-bench please look at
https://lwn.net/ml/linux-kernel/1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com

Srikar Dronamraju (19):
  sched/numa: Remove redundant field.
  sched/numa: Evaluate move once per node
  sched/numa: Simplify load_too_imbalanced
  sched/numa: Set preferred_node based on best_cpu
  sched/numa: Use task faults only if numa_group is not yet setup
  sched/debug: Reverse the order of printing faults
  sched/numa: Skip nodes that are at hoplimit
  sched/numa: Remove unused task_capacity from numa_stats
  sched/numa: Modify migrate_swap to accept additional params
  sched/numa: Stop multiple tasks from moving to the cpu at the same time
  sched/numa: Restrict migrating in parallel to the same node.
  sched/numa: Remove numa_has_capacity
  mm/migrate: Use xchg instead of spinlock
  sched/numa: Updation of scan period need not be in lock
  sched/numa: Use group_weights to identify if migration degrades locality
  sched/numa: Detect if node actively handling migration
  sched/numa: Pass destination cpu as a parameter to migrate_task_rq
  sched/numa: Reset scan rate whenever task moves across nodes
  sched/numa: Move task_placement closer to numa_migrate_preferred

 include/linux/mmzone.h  |   4 +-
 include/linux/sched.h   |   1 -
 kernel/sched/core.c     |  11 +-
 kernel/sched/deadline.c |   2 +-
 kernel/sched/debug.c    |   4 +-
 kernel/sched/fair.c     | 325 +++++++++++++++++++++++-------------------------
 kernel/sched/sched.h    |   6 +-
 mm/migrate.c            |  20 ++-
 mm/page_alloc.c         |   2 +-
 9 files changed, 187 insertions(+), 188 deletions(-)

-- 
1.8.3.1

