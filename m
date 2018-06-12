Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A39DFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583E32086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5BjAmkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583E32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934369AbeFLRsq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:48:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59894 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbeFLRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:48:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CHjvBR072148;
        Tue, 12 Jun 2018 17:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=RkeuoDl92iFD1adBalzfY5dXtOqBi+bylp8KtP2Cg7s=;
 b=O5BjAmkUaUMIc+GNFfyz/08Y/wL0QexE16iNKGYcDGD5VhobH9CUWTkbIyVZ4r+miHmT
 kuaJLsz8N9TPnS2IjeLFdmsCjMsbk9E8Sth4K0xi9Aam5sgl81gK0yMeC6hTcF+Ino32
 lPUY0wjWKy/56rMMB6ASjkbqTNt6S1nWF+ZdE+qLPC6iwtJ6M5iPIEDNP5eIlLcSs/8P
 s8RTJIJJKnXzS4s67BH1XRlO2FltX6MxLzVZW20zzTF77mYRvIXYckTdPaeOywlscD7Z
 iNk6FVeuH1gQ8WubycmjlCxG/1x8aej8Vd8kqc0wwX6rJ5uciMwL1ykMrhSb+DZUKMEF 0A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jg6b1k4qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CHm8B5007518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:08 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CHm8GY021157;
        Tue, 12 Jun 2018 17:48:08 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 10:48:07 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 5/5] sched: SIS_CORE to disable idle core search
Date:   Tue, 12 Jun 2018 10:50:02 -0700
Message-Id: <20180612175002.31453-6-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
References: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=396
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SIS_CORE to disable idle core search. For some workloads
select_idle_core becomes a scalability bottleneck, removing it improves
throughput. Also there are workloads where disabling it can hurt latency,
so need to have an option.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 849c7c8..35a076e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6464,9 +6464,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+	if (sched_feat(SIS_CORE)) {
+		i = select_idle_core(p, sd, target);
+		if ((unsigned)i < nr_cpumask_bits)
+			return i;
+	}
 
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
-- 
2.9.3

