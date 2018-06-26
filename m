Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB75C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A30626E53
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A30626E53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932329AbeFZRJE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:09:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932111AbeFZRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4Kwg156869
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2juqm25y7n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:51 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:51 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8jEF1835456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD56B2065;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A1A0B206A;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ADD2F16CA0A3; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 08/22] rcu: Suppress false-positive offline-CPU lockdep-RCU splat
Date:   Tue, 26 Jun 2018 10:10:34 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0052-0000-0000-000003045DA3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539669; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0053-0000-0000-00005D25E428
Message-Id: <20180626171048.2181-8-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_lockdep_current_cpu_online() function currently checks only the
RCU-sched data structures to determine whether or not RCU believes that a
given CPU is offline.  Unfortunately, there are multiple flavors of RCU,
which means that there is a short window of time during which the various
flavors disagree as to whether or not a given CPU is offline.  This can
result in false-positive lockdep-RCU splats in which some other flavor
of RCU tries to do something based on its view that the CPU is online,
only to get hit with a lockdep-RCU splat because RCU-sched instead
believes that the CPU is offline.

This commit therefore changes rcu_lockdep_current_cpu_online() to scan
all RCU flavors and to consider a given CPU to be online if any of the
RCU flavors believe it to be online, thus preventing these false-positive
splats.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 324ca1b2b233..5171c0361fbd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1030,41 +1030,41 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
 
 /*
- * Is the current CPU online?  Disable preemption to avoid false positives
- * that could otherwise happen due to the current CPU number being sampled,
- * this task being preempted, its old CPU being taken offline, resuming
- * on some other CPU, then determining that its old CPU is now offline.
- * It is OK to use RCU on an offline processor during initial boot, hence
- * the check for rcu_scheduler_fully_active.  Note also that it is OK
- * for a CPU coming online to use RCU for one jiffy prior to marking itself
- * online in the cpu_online_mask.  Similarly, it is OK for a CPU going
- * offline to continue to use RCU for one jiffy after marking itself
- * offline in the cpu_online_mask.  This leniency is necessary given the
- * non-atomic nature of the online and offline processing, for example,
- * the fact that a CPU enters the scheduler after completing the teardown
- * of the CPU.
+ * Is the current CPU online as far as RCU is concerned?
  *
- * This is also why RCU internally marks CPUs online during in the
- * preparation phase and offline after the CPU has been taken down.
+ * Disable preemption to avoid false positives that could otherwise
+ * happen due to the current CPU number being sampled, this task being
+ * preempted, its old CPU being taken offline, resuming on some other CPU,
+ * then determining that its old CPU is now offline.  Because there are
+ * multiple flavors of RCU, and because this function can be called in the
+ * midst of updating the flavors while a given CPU coming online or going
+ * offline, it is necessary to check all flavors.  If any of the flavors
+ * believe that given CPU is online, it is considered to be online.
  *
- * Disable checking if in an NMI handler because we cannot safely report
- * errors from NMI handlers anyway.
+ * Disable checking if in an NMI handler because we cannot safely
+ * report errors from NMI handlers anyway.  In addition, it is OK to use
+ * RCU on an offline processor during initial boot, hence the check for
+ * rcu_scheduler_fully_active.
  */
 bool rcu_lockdep_current_cpu_online(void)
 {
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	bool ret;
+	struct rcu_state *rsp;
 
-	if (in_nmi())
+	if (in_nmi() || !rcu_scheduler_fully_active)
 		return true;
 	preempt_disable();
-	rdp = this_cpu_ptr(&rcu_sched_data);
-	rnp = rdp->mynode;
-	ret = (rdp->grpmask & rcu_rnp_online_cpus(rnp)) ||
-	      !rcu_scheduler_fully_active;
+	for_each_rcu_flavor(rsp) {
+		rdp = this_cpu_ptr(rsp->rda);
+		rnp = rdp->mynode;
+		if (rdp->grpmask & rcu_rnp_online_cpus(rnp)) {
+			preempt_enable();
+			return true;
+		}
+	}
 	preempt_enable();
-	return ret;
+	return false;
 }
 EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 
-- 
2.17.1

