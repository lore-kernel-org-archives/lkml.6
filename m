Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1604C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D61D20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D61D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeH3CjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:39:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727675AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMckd3118343
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r189xm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvcx33423468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9CEBB206C;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5EB1B207A;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B155116C91D2; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 45/52] rcu: Restructure rcu_check_gp_kthread_starvation()
Date:   Wed, 29 Aug 2018 15:38:47 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B957
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F161C
Message-Id: <20180829223854.4055-45-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes the rsp and gpa local variables, repurposes the j
local variable and adds a gpk (GP kthread) local to improve readability.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0eccfd02e0b3..488ac7a36835 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1224,24 +1224,21 @@ static const char *gp_state_getname(short gs)
  */
 static void rcu_check_gp_kthread_starvation(void)
 {
-	unsigned long gpa;
+	struct task_struct *gpk = rcu_state.gp_kthread;
 	unsigned long j;
-	struct rcu_state *rsp = &rcu_state;
 
-	j = jiffies;
-	gpa = READ_ONCE(rsp->gp_activity);
-	if (j - gpa > 2 * HZ) {
+	j = jiffies - READ_ONCE(rcu_state.gp_activity);
+	if (j > 2 * HZ) {
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
-		       rsp->name, j - gpa,
-		       (long)rcu_seq_current(&rsp->gp_seq),
-		       rsp->gp_flags,
-		       gp_state_getname(rsp->gp_state), rsp->gp_state,
-		       rsp->gp_kthread ? rsp->gp_kthread->state : ~0,
-		       rsp->gp_kthread ? task_cpu(rsp->gp_kthread) : -1);
-		if (rsp->gp_kthread) {
+		       rcu_state.name, j,
+		       (long)rcu_seq_current(&rcu_state.gp_seq),
+		       rcu_state.gp_flags,
+		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
+		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
+		if (gpk) {
 			pr_err("RCU grace-period kthread stack dump:\n");
-			sched_show_task(rsp->gp_kthread);
-			wake_up_process(rsp->gp_kthread);
+			sched_show_task(gpk);
+			wake_up_process(gpk);
 		}
 	}
 }
-- 
2.17.1

