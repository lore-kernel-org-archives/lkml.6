Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661ABC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D5326361
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D5326361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965158AbeFZAeM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:34:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755580AbeFZAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:33:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0Sd5H047894
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:18 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96r3fbn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:17 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:33:17 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:33:12 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0XBoH10420972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:33:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2D85B2072;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C250BB205F;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 069CF16CA09E; Mon, 25 Jun 2018 17:35:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 15/27] rcu: Use RCU CPU stall timeout for rcu_check_gp_start_stall()
Date:   Mon, 25 Jun 2018 17:35:01 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626003448.GA26209@linux.vnet.ibm.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-00000320452A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539470; IPR=6.00830262;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:33:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B764D0
Message-Id: <20180626003513.27812-15-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_check_gp_start_stall() waits for one second after the first
request before complaining that a grace period has not yet started.  This
was desirable while testing the conversion from ->future_gp_needed[] to
->gp_seq_needed, but it is a bit on the hair-trigger side for production
use under heavy load.  This commit therefore makes this wait time be
exactly that of the RCU CPU stall warning, allowing easy adjustment of
both timeouts to suit the distribution or installation at hand.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a95d49730cfc..c5fec335bc31 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2753,6 +2753,7 @@ static void
 rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 			 struct rcu_data *rdp)
 {
+	const unsigned long gpssdelay = rcu_jiffies_till_stall_check() * HZ;
 	unsigned long flags;
 	unsigned long j;
 	struct rcu_node *rnp_root = rcu_get_root(rsp);
@@ -2762,8 +2763,8 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
-	if (time_before(j, READ_ONCE(rsp->gp_req_activity) + HZ) ||
-	    time_before(j, READ_ONCE(rsp->gp_activity) + HZ) ||
+	if (time_before(j, READ_ONCE(rsp->gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rsp->gp_activity) + gpssdelay) ||
 	    atomic_read(&warned))
 		return;
 
@@ -2771,8 +2772,8 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	j = jiffies;
 	if (rcu_gp_in_progress(rsp) ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, READ_ONCE(rsp->gp_req_activity) + HZ) ||
-	    time_before(j, READ_ONCE(rsp->gp_activity) + HZ) ||
+	    time_before(j, READ_ONCE(rsp->gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rsp->gp_activity) + gpssdelay) ||
 	    atomic_read(&warned)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
@@ -2783,18 +2784,18 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	j = jiffies;
 	if (rcu_gp_in_progress(rsp) ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, rsp->gp_req_activity + HZ) ||
-	    time_before(j, rsp->gp_activity + HZ) ||
+	    time_before(j, rsp->gp_req_activity + gpssdelay) ||
+	    time_before(j, rsp->gp_activity + gpssdelay) ||
 	    atomic_xchg(&warned, 1)) {
 		raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	pr_alert("%s: g%ld->%ld gar:%lu ga:%lu f%#x %s->state:%#lx\n",
+	pr_alert("%s: g%ld->%ld gar:%lu ga:%lu f%#x gs:%d %s->state:%#lx\n",
 		 __func__, (long)READ_ONCE(rsp->gp_seq),
 		 (long)READ_ONCE(rnp_root->gp_seq_needed),
 		 j - rsp->gp_req_activity, j - rsp->gp_activity,
-		 rsp->gp_flags, rsp->name,
+		 rsp->gp_flags, rsp->gp_state, rsp->name,
 		 rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL);
 	WARN_ON(1);
 	raw_spin_unlock_rcu_node(rnp_root);
-- 
2.17.1

