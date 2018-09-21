Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA6AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67BC21557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67BC21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbeIUXjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:39:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390365AbeIUXjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:39:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LHnIT2176938
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:49:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mn3snm2aw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:49:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 21 Sep 2018 18:49:32 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 18:49:29 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LHnSdw62128224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 17:49:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93567AE055;
        Fri, 21 Sep 2018 20:48:33 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D07DAE051;
        Fri, 21 Sep 2018 20:48:32 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.199.39.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 20:48:31 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jirka Hladky <jhladky@redhat.com>
Subject: [PATCH v2 0/6] numabalancing patches
Date:   Fri, 21 Sep 2018 23:18:55 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18092117-4275-0000-0000-000002BDE7A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092117-4276-0000-0000-000037C7EE42
Message-Id: <1537552141-27815-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides left out patches from the previous series.
http://lore.kernel.org/lkml/1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com

Changes from previous posting:
Rebased the patchset to 4.19-rc4.
Handled comments from Ingo Molnar,Peter Peter Zijlstra and Mel Gorman.
Reorder to keep the most discussed patches at the end.

Some of the Ack/Reviewed-by carried from
http://lore.kernel.org/lkml/1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com

Please refer to previous postings
http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com
http://lore.kernel.org/lkml/1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com
http://lore.kernel.org/lkml/1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com

Specjbb2005 results (8 warehouses)
Higher bops are better

2 Socket - 2  Node Haswell - X86
JVMS  Prev    Current  %Change
4     200194  205910   2.85523
1     311331  318491   2.2998

2 Socket - 4 Node Power8 - PowerNV
JVMS  Prev    Current  %Change
1     197654  226796   14.7439

4 Socket - 4  Node Power7 - PowerVM
JVMS  Prev     Current  %Change
8     52227.1  60370    15.5913
1     102529   108100   5.43358

Mel Gorman (1):
  sched/numa: Limit the conditions where scan period is reset

Srikar Dronamraju (5):
  sched/numa: Stop multiple tasks from moving to the CPU at the same
    time
  sched/numa: Pass destination CPU as a parameter to migrate_task_rq
  sched/numa: Reset scan rate whenever task moves across nodes
  mm/migrate: Use trylock while resetting rate limit
  sched/numa: Avoid task migration for small NUMA improvement

 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  2 +-
 kernel/sched/fair.c     | 92 ++++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  3 +-
 mm/migrate.c            | 16 ++++++---
 5 files changed, 96 insertions(+), 19 deletions(-)

-- 
2.7.4

