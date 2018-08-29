Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D1EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3300E20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3300E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeH3Cjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:39:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727471AbeH3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcjpm118313
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r189xf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcv7l46268472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17D5CB2066;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03FDFB2064;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2EC3316C91DC; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 21/52] rcu: Remove rsp parameter from rcu_gp_slow()
Date:   Wed, 29 Aug 2018 15:38:23 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0060-0000-0000-000002A6641C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0061-0000-0000-00004655B6AD
Message-Id: <20180829223854.4055-21-paulmck@linux.vnet.ibm.com>
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

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to RCU's
functions.  This commit therefore removes the rsp parameter from
rcu_gp_slow().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 752cd23860ed..751c28ddf5b1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1820,10 +1820,10 @@ static void note_gp_changes(struct rcu_data *rdp)
 		rcu_gp_kthread_wake();
 }
 
-static void rcu_gp_slow(struct rcu_state *rsp, int delay)
+static void rcu_gp_slow(int delay)
 {
 	if (delay > 0 &&
-	    !(rcu_seq_ctr(rsp->gp_seq) %
+	    !(rcu_seq_ctr(rcu_state.gp_seq) %
 	      (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
 		schedule_timeout_uninterruptible(delay);
 }
@@ -1916,7 +1916,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		raw_spin_unlock_irq_rcu_node(rnp);
 		spin_unlock(&rsp->ofl_lock);
 	}
-	rcu_gp_slow(rsp, gp_preinit_delay); /* Races with CPU hotplug. */
+	rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
 
 	/*
 	 * Set the quiescent-state-needed bits in all the rcu_node
@@ -1932,7 +1932,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 */
 	rsp->gp_state = RCU_GP_INIT;
 	rcu_for_each_node_breadth_first(rsp, rnp) {
-		rcu_gp_slow(rsp, gp_init_delay);
+		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(&rcu_data);
 		rcu_preempt_check_blocked_tasks(rsp, rnp);
@@ -2058,7 +2058,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		rcu_nocb_gp_cleanup(sq);
 		cond_resched_tasks_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
-		rcu_gp_slow(rsp, gp_cleanup_delay);
+		rcu_gp_slow(gp_cleanup_delay);
 	}
 	rnp = rcu_get_root();
 	raw_spin_lock_irq_rcu_node(rnp); /* GP before rsp->gp_seq update. */
-- 
2.17.1

