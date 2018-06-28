Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97859C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B5827821
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bw/3uLNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B5827821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967391AbeF1WoG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:44:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936138AbeF1Wn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:43:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SMcuZG035321;
        Thu, 28 Jun 2018 22:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=ReW1pI6oN+r6+AWvU3lVAoEyC5OJWHjiET6JJeScG5c=;
 b=bw/3uLNygcsIMAzdsW6Dpfdvw3muPyxU0kOeQ4ERmQlCu2C/BEBfapY3H9dcVuob+ptb
 WnpTTircSygsDjAt0mFdJfXQbHDOHU1WjLVI6wJySQ8dLJ5mP3ht4nMmvlZnVOY3WMR5
 ctdEH5kMZRVu0tBWWH3dHpvbEQ4/kIVDS4/XP7dJDMPzNyR7Al4mtLI7HYEH+EEVtq+3
 BTgEVxA9a9ep1Pw0sKPKpdYb5y75/44p/jwfd0aw4qVFbpf6jGYO34M/xtWInrseh5xs
 ulxfE2h9TxAPtHfge/ia9Pv+serSVNBGT+Vo70uwy42Rt9Q+j4QXGcLezeUAjY+RNjJS Mw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jum5844yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5SMhMRF000727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:22 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5SMhM7j023364;
        Thu, 28 Jun 2018 22:43:22 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 15:43:22 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 3/5] sched: rotate the cpu search window for better spread
Date:   Thu, 28 Jun 2018 15:44:54 -0700
Message-Id: <20180628224456.13548-4-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
References: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=656
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280249
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
index 7243146..574cb14 100644
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

