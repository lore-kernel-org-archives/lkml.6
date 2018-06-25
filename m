Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6650BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272AA2623A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272AA2623A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965017AbeFYWqD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:46:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754775AbeFYWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:46:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMicuV087252
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:46:01 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96p0j79-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:46:01 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:46:00 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:45:55 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMjsbj57999388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:45:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EDBBB2066;
        Mon, 25 Jun 2018 18:45:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F633B2067;
        Mon, 25 Jun 2018 18:45:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:45:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CAA5316CA096; Mon, 25 Jun 2018 15:47:59 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 3/4] srcu: Add address of first callback to rcutorture output
Date:   Mon, 25 Jun 2018 15:47:57 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625224734.GA10860@linux.vnet.ibm.com>
References: <20180625224734.GA10860@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-0040-0000-0000-000004450CA1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052301; UDB=6.00539448; IPR=6.00830226;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:45:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-0041-0000-0000-0000084B2256
Message-Id: <20180625224758.11300-3-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the address of the first callback to the per-CPU rcutorture
output in order to allow lost wakeups to be more efficiently tracked down.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/srcutree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 37bef2fe80e6..5a1a9a07b407 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1271,11 +1271,11 @@ void srcu_torture_stats_print(struct srcu_struct *sp, char *tt, char *tf)
 		unsigned long l0, l1;
 		unsigned long u0, u1;
 		long c0, c1;
-		struct srcu_data *counts;
+		struct srcu_data *sdp;
 
-		counts = per_cpu_ptr(sp->sda, cpu);
-		u0 = counts->srcu_unlock_count[!idx];
-		u1 = counts->srcu_unlock_count[idx];
+		sdp = per_cpu_ptr(sp->sda, cpu);
+		u0 = sdp->srcu_unlock_count[!idx];
+		u1 = sdp->srcu_unlock_count[idx];
 
 		/*
 		 * Make sure that a lock is always counted if the corresponding
@@ -1283,12 +1283,13 @@ void srcu_torture_stats_print(struct srcu_struct *sp, char *tt, char *tf)
 		 */
 		smp_rmb();
 
-		l0 = counts->srcu_lock_count[!idx];
-		l1 = counts->srcu_lock_count[idx];
+		l0 = sdp->srcu_lock_count[!idx];
+		l1 = sdp->srcu_lock_count[idx];
 
 		c0 = l0 - u0;
 		c1 = l1 - u1;
-		pr_cont(" %d(%ld,%ld)", cpu, c0, c1);
+		pr_cont(" %d(%ld,%ld %1p)",
+			cpu, c0, c1, rcu_segcblist_head(&sdp->srcu_cblist));
 		s0 += c0;
 		s1 += c1;
 	}
-- 
2.17.1

