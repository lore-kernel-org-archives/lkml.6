Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5DCC43143
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53220661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D53220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeH3DG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:06:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727667AbeH3DG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN42SB004625
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:45 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64a2916m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:45 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:43 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7aAW26673312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA13BB206E;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A677B2066;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2B4A216C91C6; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 03/10] rcu: Switch ->tick_nohz_enabled_snap to rcu_data structure
Date:   Wed, 29 Aug 2018 16:07:28 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-0060-0000-0000-000002A66613
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-0061-0000-0000-00004655C51B
Message-Id: <20180829230735.10256-3-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes ->tick_nohz_enabled_snap from the rcu_dynticks
structure and updates the code to access it from the rcu_data
structure.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d35cd9677b08..5d447ceba769 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -53,7 +53,6 @@ struct rcu_dynticks {
 				    /* Last jiffy CBs were accelerated. */
 	unsigned long last_advance_all;
 				    /* Last jiffy CBs were all advanced. */
-	int tick_nohz_enabled_snap; /* Previously seen value from sysfs. */
 #endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 };
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 978ce3539809..6511032371c1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1681,7 +1681,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 static void rcu_prepare_for_idle(void)
 {
 	bool needwake;
-	struct rcu_data *rdp;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	struct rcu_node *rnp;
 	int tne;
@@ -1692,10 +1692,10 @@ static void rcu_prepare_for_idle(void)
 
 	/* Handle nohz enablement switches conservatively. */
 	tne = READ_ONCE(tick_nohz_active);
-	if (tne != rdtp->tick_nohz_enabled_snap) {
+	if (tne != rdp->tick_nohz_enabled_snap) {
 		if (rcu_cpu_has_callbacks(NULL))
 			invoke_rcu_core(); /* force nohz to see update. */
-		rdtp->tick_nohz_enabled_snap = tne;
+		rdp->tick_nohz_enabled_snap = tne;
 		return;
 	}
 	if (!tne)
@@ -1721,7 +1721,6 @@ static void rcu_prepare_for_idle(void)
 	if (rdtp->last_accelerate == jiffies)
 		return;
 	rdtp->last_accelerate = jiffies;
-	rdp = this_cpu_ptr(&rcu_data);
 	if (rcu_segcblist_pend_cbs(&rdp->cblist)) {
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -1765,6 +1764,7 @@ static void rcu_idle_count_callbacks_posted(void)
 
 static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 {
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
 	struct rcu_dynticks *rdtp = &per_cpu(rcu_dynticks, cpu);
 	unsigned long nlpd = rdtp->nonlazy_posted - rdtp->nonlazy_posted_snap;
 
@@ -1772,7 +1772,7 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 		rdtp->last_accelerate & 0xffff, jiffies & 0xffff,
 		ulong2long(nlpd),
 		rdtp->all_lazy ? 'L' : '.',
-		rdtp->tick_nohz_enabled_snap ? '.' : 'D');
+		rdp->tick_nohz_enabled_snap ? '.' : 'D');
 }
 
 #else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-- 
2.17.1

