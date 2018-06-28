Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C46C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5960D279F6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z4TFzOTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5960D279F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966954AbeF1WoC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:44:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49744 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934442AbeF1Wn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:43:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SMd0rF071636;
        Thu, 28 Jun 2018 22:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=sJjEH6uy3y81OltlXmycG2vOTJSoL+GiOyu7ev6FDrE=;
 b=Z4TFzOTbX0+pPKpQjJxoyYi3U0AbFIERdgBrHgZytR9Ims+c6JtG9xRjzfpdea9BJ3Pv
 QQvU8bPyMIF9emrDbBOdbi3wX7rARUpknO62G6a/4JV0X8nSysP74KvMSNSQ0+K/ELli
 EsgYWk6ma8RejfpNGDN3ceA4CvazCtJ9c+Z9rxmOYDznLfA9Y0DKaSaMXL3pS/sSozDZ
 YK1fXz1+48TEVtqDN3xVFXUvI+j456RFcQhVg7+bs4g33TpyCUYv+XvqQ2mf4PVq+gz1
 L4vOxcv2YLznSdq3runfvThNpPr6ZiGRvwqMt4Bw5/YETaGTk8VX7CzneAGemwEzi4yW Uw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jukmu49rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:22 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5SMhL0h008889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:22 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5SMhL9B001730;
        Thu, 28 Jun 2018 22:43:21 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 15:43:21 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 1/5] sched: limit cpu search in select_idle_cpu
Date:   Thu, 28 Jun 2018 15:44:52 -0700
Message-Id: <20180628224456.13548-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
References: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280249
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
index e497c05..7243146 100644
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
@@ -6390,10 +6390,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	if (sched_feat(SIS_PROP)) {
 		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		floor = cpumask_weight(topology_sibling_cpumask(target));
+		if (floor < 2)
+			floor = 2;
+		limit = 2*floor;
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

