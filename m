Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107FEC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8C627821
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PjhfDh4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8C627821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967051AbeF1WoE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:44:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49746 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964786AbeF1Wn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:43:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SMcu9I071628;
        Thu, 28 Jun 2018 22:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=T0yaG9ciUukEyvK2f0cZ03RZkhvc+EAbx0OcpNZfKU4=;
 b=PjhfDh4u5D6US2ZNSih75qGWQ2mJYswh4ce9Q6QR86w8Wz6LGG7Qt17Zv+KQ/jy/C7q7
 K8iLQ2dJHa2z5cEB4MG8IjN5k6dj01XQLdVyUlGz2wz0UWZ4KJIyW53dBYfWSkNm5GEd
 2ltG2R3DwBLxgkGVCTW+Gmt7Mn4eTYixUbjw6sgUNAoyi8tpl1RkffhILfDt4te3QZmp
 KnzrYGCZx4WWC1hoGNy2Se7YWua583vNJ1KcrjBrslyblYV8aRh5QArML1tVsRYQM128
 /BljigkBViswFAWO3d5F0UanMeFs6HD+/rb9bFai3utkLr7wHuYVXWt5qX/bhc16/0Jc Ow== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmu49rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5SMhNHA012773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:23 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5SMhNom023374;
        Thu, 28 Jun 2018 22:43:23 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 15:43:23 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 5/5] sched: SIS_CORE to disable idle core search
Date:   Thu, 28 Jun 2018 15:44:56 -0700
Message-Id: <20180628224456.13548-6-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
References: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=395
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280249
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
index 574cb14..33fbc47 100644
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

