Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA6BEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB2720660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YL9w044v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB2720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934465AbeFLRtb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:49:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934060AbeFLRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:48:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CHjwPc072155;
        Tue, 12 Jun 2018 17:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=wXkNaYS3WkjGPZE38G0sDH96xXhgl8/RE3r4ST5R3gU=;
 b=YL9w044vMlaoOPQFT+o6GMSjGPEqSRnCXsEtSwoH+Ia6b73Rd027dzQ1W0oimNnNJ0W7
 LqjYHtsbrRotS/Q5P4tCaYlT58KvE4imqEBHzUFiywzqzLalRqzwLIa98tnJdA6AEzPf
 8lmDk7ZGW8z8EA3lwSCyrADDsBwDhHqplrgiPUmrTa5Fl5M6VN9dAujh4qT/82VlJBVq
 h/bgzVEdyKf+cb+wjC2bE/K6lK6ZHK4wFq4gTkk+d7hpFayq0h8YuxSW0BEw/Ea1iXmG
 RHWDCHBytrlHS9ObRevoMh5Xch2Q5Z1ubEM1cK/FlkwjbFDgZURJySdLbKThtxwvylHe sg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jg6b1k4qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CHm7PH027505
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:07 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CHm6Y8006223;
        Tue, 12 Jun 2018 17:48:07 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 10:48:06 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 3/5] sched: rotate the cpu search window for better spread
Date:   Tue, 12 Jun 2018 10:50:00 -0700
Message-Id: <20180612175002.31453-4-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
References: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=658
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rotate the cpu search window for better spread of threads. This will ensure
an idle cpu will quickly be found if one exists.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a6d28d..849c7c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6372,7 +6372,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, limit, floor, nr = INT_MAX;
+	int cpu, limit, floor, target_tmp, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6403,9 +6403,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		}
 	}
 
+	if (per_cpu(next_cpu, target) != -1)
+		target_tmp = per_cpu(next_cpu, target);
+	else
+		target_tmp = target;
+
 	time = local_clock();
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
+		per_cpu(next_cpu, target) = cpu;
 		if (!--nr)
 			return -1;
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-- 
2.9.3

