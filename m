Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99207C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574492148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574492148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeKLFgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:36:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeKLFdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:33:47 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJi9nD052526
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:21 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdjvhct5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:21 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:44:20 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:44:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJiCJN27328532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:44:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9805DB206A;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 614C2B206B;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2DA8216C5DB2; Sun, 11 Nov 2018 11:44:13 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH tip/core/rcu 31/41] net/sched: Replace call_rcu_bh() and rcu_barrier_bh()
Date:   Sun, 11 Nov 2018 11:44:00 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0064-0000-0000-000003722EA1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116019; UDB=6.00577118; IPR=6.00896119;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:44:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0065-0000-0000-00003B4D4138
Message-Id: <20181111194410.6368-31-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that call_rcu()'s callback is not invoked until after bh-disable
regions of code have completed (in addition to explicitly marked
RCU read-side critical sections), call_rcu() can be used in place
of call_rcu_bh().  Similarly, rcu_barrier() can be used in place o
frcu_barrier_bh().  This commit therefore makes these changes.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>
---
 net/sched/sch_api.c     | 2 +-
 net/sched/sch_generic.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index ca3b0f46de53..016e628c6ac9 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -540,7 +540,7 @@ void qdisc_put_stab(struct qdisc_size_table *tab)
 
 	if (--tab->refcnt == 0) {
 		list_del(&tab->list);
-		call_rcu_bh(&tab->rcu, stab_kfree_rcu);
+		call_rcu(&tab->rcu, stab_kfree_rcu);
 	}
 }
 EXPORT_SYMBOL(qdisc_put_stab);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index de1663f7d3ad..66ba2ce2320f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1372,7 +1372,7 @@ void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
 	if (!tp_head) {
 		RCU_INIT_POINTER(*miniqp->p_miniq, NULL);
 		/* Wait for flying RCU callback before it is freed. */
-		rcu_barrier_bh();
+		rcu_barrier();
 		return;
 	}
 
@@ -1380,10 +1380,10 @@ void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
 		&miniqp->miniq1 : &miniqp->miniq2;
 
 	/* We need to make sure that readers won't see the miniq
-	 * we are about to modify. So wait until previous call_rcu_bh callback
+	 * we are about to modify. So wait until previous call_rcu callback
 	 * is done.
 	 */
-	rcu_barrier_bh();
+	rcu_barrier();
 	miniq->filter_list = tp_head;
 	rcu_assign_pointer(*miniqp->p_miniq, miniq);
 
@@ -1392,7 +1392,7 @@ void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
 		 * block potential new user of miniq_old until all readers
 		 * are not seeing it.
 		 */
-		call_rcu_bh(&miniq_old->rcu, mini_qdisc_rcu_func);
+		call_rcu(&miniq_old->rcu, mini_qdisc_rcu_func);
 }
 EXPORT_SYMBOL(mini_qdisc_pair_swap);
 
-- 
2.17.1

