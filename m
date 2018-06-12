Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C985C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B6B2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oG2NDLs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B6B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934038AbeFLRsj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:48:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLRsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:48:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CHjxn5097411;
        Tue, 12 Jun 2018 17:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=XROqvxOiXGmYeEHuRYTbOFDzG40d6Pd3NxVJGeokawI=;
 b=oG2NDLs/cnh60/r+d6yjzJSvipLUSeDDO5560V2XLYn0pWwLqhduS5SpMzQMcHHHaq1Q
 Z3E/YwczBfEccOJV+SuoEZZso8Xt3Npjq48KPzJwSRhbdaatQMnvziImAvE2kV/V/jV5
 wKGZeN/8NNhCQZqhBngUn9I0YtZuU9XM6PGxjjEt5k48xypVUiNv35pSNdgwLgv0UkLD
 jKGg5EdE4hjJFuz2jXdp/1RkIPYbfC9ppHV43jGJmRI73oqIDa+GESQWalDFFi6FW/V0
 FihE7M9DFeFPZMcwjPGnqk4lEOe7WpdjlzCjSSpl2f8r7eMBcRKcpKNjXGMBzPEjGU8Q sA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jg7hx331j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CHm6VA023447
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:06 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5CHm5T7023890;
        Tue, 12 Jun 2018 17:48:06 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 10:48:05 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 1/5] sched: limit cpu search in select_idle_cpu
Date:   Tue, 12 Jun 2018 10:49:58 -0700
Message-Id: <20180612175002.31453-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
References: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put upper and lower limit on cpu search of select_idle_cpu. The lower limit
is amount of cpus in a core while upper limit is twice that. This ensures
for any architecture we will usually search beyond a core. The upper limit
also helps in keeping the search cost low and constant.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05..9a6d28d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6372,7 +6372,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, nr = INT_MAX;
+	int cpu, limit, floor, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6389,11 +6389,18 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;
 
 	if (sched_feat(SIS_PROP)) {
+		floor = cpumask_weight(topology_sibling_cpumask(target));
+		if (floor < 2)
+			floor = 2;
+		limit = 2*floor;
 		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > floor*avg_cost) {
 			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
+			if (nr > limit)
+				nr = limit;
+		} else {
+			nr = floor;
+		}
 	}
 
 	time = local_clock();
-- 
2.9.3

