Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07851C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A7A26E58
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A7A26E58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932579AbeFZRLv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:11:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932135AbeFZRIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4MEV027338
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jup7c1v9e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:53 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:51 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8k7i17170910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA0CFB2065;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 929CCB2070;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F2BF516CA0B0; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 21/22] rcu: Record ->gp_state for both phases of grace-period initialization
Date:   Tue, 26 Jun 2018 10:10:47 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0060-0000-0000-00000282CDC5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539668; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0061-0000-0000-000045955A2E
Message-Id: <20180626171048.2181-21-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grace-period initialization first processes any recent CPU-hotplug
operations, and then initializes state for the new grace period.  These
two phases of initialization are currently not distinguished in debug
prints, but the distinction is valuable in a number of debug situations.
This commit therefore introduces two new values for ->gp_state,
RCU_GP_ONOFF and RCU_GP_INIT, in order to make this distinction.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c |  2 ++
 kernel/rcu/tree.h | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1e87ff1154a5..9e83743ca9d9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1891,6 +1891,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 * for subsequent online CPUs, and that quiescent-state forcing
 	 * will handle subsequent offline CPUs.
 	 */
+	rsp->gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rsp, rnp) {
 		spin_lock(&rsp->ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
@@ -1950,6 +1951,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 * The grace period cannot complete until the initialization
 	 * process finishes, because this kthread handles both.
 	 */
+	rsp->gp_state = RCU_GP_INIT;
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		rcu_gp_slow(rsp, gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f52bc059bfec..8077aff7ab40 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -380,16 +380,20 @@ struct rcu_state {
 #define RCU_GP_IDLE	 0	/* Initial state and no GP in progress. */
 #define RCU_GP_WAIT_GPS  1	/* Wait for grace-period start. */
 #define RCU_GP_DONE_GPS  2	/* Wait done for grace-period start. */
-#define RCU_GP_WAIT_FQS  3	/* Wait for force-quiescent-state time. */
-#define RCU_GP_DOING_FQS 4	/* Wait done for force-quiescent-state time. */
-#define RCU_GP_CLEANUP   5	/* Grace-period cleanup started. */
-#define RCU_GP_CLEANED   6	/* Grace-period cleanup complete. */
+#define RCU_GP_ONOFF     3	/* Grace-period initialization hotplug. */
+#define RCU_GP_INIT      4	/* Grace-period initialization. */
+#define RCU_GP_WAIT_FQS  5	/* Wait for force-quiescent-state time. */
+#define RCU_GP_DOING_FQS 6	/* Wait done for force-quiescent-state time. */
+#define RCU_GP_CLEANUP   7	/* Grace-period cleanup started. */
+#define RCU_GP_CLEANED   8	/* Grace-period cleanup complete. */
 
 #ifndef RCU_TREE_NONCORE
 static const char * const gp_state_names[] = {
 	"RCU_GP_IDLE",
 	"RCU_GP_WAIT_GPS",
 	"RCU_GP_DONE_GPS",
+	"RCU_GP_ONOFF",
+	"RCU_GP_INIT",
 	"RCU_GP_WAIT_FQS",
 	"RCU_GP_DOING_FQS",
 	"RCU_GP_CLEANUP",
-- 
2.17.1

