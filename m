Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EFB56C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A455D20660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bR+MXqpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A455D20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934411AbeFLRtS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:49:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54046 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934073AbeFLRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:48:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CHjv6g139705;
        Tue, 12 Jun 2018 17:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=K9ZSVOQ8SugAfSuitLQCsDiSfn6LgnA7XgIEQ83c51E=;
 b=bR+MXqpXpt50jEbTjPXWC2BqqciWY2Z7p+42QI+Xwd/hoyQ4DCfL9TJ4tQ/x8IaJhUb7
 /6rtnVUemiDH74xgEtDNXQ76GoDNnApXXS94VrtTnncaDY3Z1ITh45EBPJ80u4BhoQv5
 S67d/Gmf0AgsIDb5xJt7W/t9Y1q8rHf1azA8CqEq0WbkhioKFDN8seox5mcHlSmT+whO
 Epd9Mee7+DRC766ihpBoOQAdgjrpnW+y0S5cZffBdmEVpJKEnVe6cVBdDODbERM5SZC3
 aNzBSlEd/ABIfagUtjQDeRGFyODCZocpc76FxUmBBsvc6vOPVEzkshQDSIjCxsR5qg0C pQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jgecxjbfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CHm61Q007379
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:07 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CHm69a021145;
        Tue, 12 Jun 2018 17:48:06 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 10:48:06 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 2/5] sched: introduce per-cpu var next_cpu to track search limit
Date:   Tue, 12 Jun 2018 10:49:59 -0700
Message-Id: <20180612175002.31453-3-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
References: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a per-cpu variable to track the limit upto which idle cpu search
was done in select_idle_cpu(). This will help to start the search next time
from there. This is necessary for rotating the search window over entire
LLC domain.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/core.c  | 2 ++
 kernel/sched/sched.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8d59b25..b3e4ec1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -20,6 +20,7 @@
 #include <trace/events/sched.h>
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(HAVE_JUMP_LABEL)
 /*
@@ -5996,6 +5997,7 @@ void __init sched_init(void)
 	for_each_possible_cpu(i) {
 		struct rq *rq;
 
+		per_cpu(next_cpu, i) = -1;
 		rq = cpu_rq(i);
 		raw_spin_lock_init(&rq->lock);
 		rq->nr_running = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 67702b4..eb12b50 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -912,6 +912,7 @@ static inline void update_idle_core(struct rq *rq) { }
 #endif
 
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DECLARE_PER_CPU_SHARED_ALIGNED(int, next_cpu);
 
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
-- 
2.9.3

