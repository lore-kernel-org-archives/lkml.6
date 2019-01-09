Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDABC20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfAIV3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:29:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbfAIV2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:28:43 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LSZTc034540
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:28:42 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn7pt588-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:28:42 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:28:41 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:28:36 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LSZvI23134446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:28:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5D5DB2073;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ED21B206C;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 60C2216C63E5; Wed,  9 Jan 2019 13:28:35 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/12] rcu: Move rcu_cpu_kthread_status to rcu_data structure
Date:   Wed,  9 Jan 2019 13:28:25 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109212816.GA32282@linux.ibm.com>
References: <20190109212816.GA32282@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-00000380061C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144145; UDB=6.00595708; IPR=6.00924407;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:28:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-00004712238C
Message-Id: <20190109212834.1257-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that RCU has a perfectly good per-CPU rcu_data structure, most
per-CPU quantities should be stored there.

This commit therefore moves the rcu_cpu_kthread_status per-CPU variable
to the rcu_data structure.  This also makes this variable unconditionally
present, which should be acceptable given the memory reduction due to the
RCU flavor consolidation and also due to simplifications this will enable.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        | 3 ++-
 kernel/rcu/tree_plugin.h | 7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index ef517ba25192..047f5e9350d1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -237,6 +237,8 @@ struct rcu_data {
 	/* 6) RCU priority boosting. */
 	struct task_struct *rcu_cpu_kthread_task;
 					/* rcuc per-CPU kthread or NULL. */
+	unsigned int rcu_cpu_kthread_status;
+					/* Running status for rcuc. */
 
 	/* 7) Diagnostic data, including RCU CPU stall warnings. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
@@ -407,7 +409,6 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 int rcu_dynticks_snap(struct rcu_data *rdp);
 
 #ifdef CONFIG_RCU_BOOST
-DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
 DECLARE_PER_CPU(int, rcu_cpu_kthread_cpu);
 DECLARE_PER_CPU(unsigned int, rcu_cpu_kthread_loops);
 DECLARE_PER_CPU(char, rcu_cpu_has_work);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 359bf1f6f8e0..935dc594cf30 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -40,7 +40,6 @@
 /*
  * Control variables for per-CPU and per-rcu_node kthreads.
  */
-DEFINE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
 DEFINE_PER_CPU(unsigned int, rcu_cpu_kthread_loops);
 DEFINE_PER_CPU(char, rcu_cpu_has_work);
 
@@ -1310,7 +1309,7 @@ static void invoke_rcu_callbacks_kthread(void)
 	if (__this_cpu_read(rcu_data.rcu_cpu_kthread_task) != NULL &&
 	    current != __this_cpu_read(rcu_data.rcu_cpu_kthread_task)) {
 		rcu_wake_cond(__this_cpu_read(rcu_data.rcu_cpu_kthread_task),
-			      __this_cpu_read(rcu_cpu_kthread_status));
+			      __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
 	}
 	local_irq_restore(flags);
 }
@@ -1383,7 +1382,7 @@ static void rcu_cpu_kthread_setup(unsigned int cpu)
 
 static void rcu_cpu_kthread_park(unsigned int cpu)
 {
-	per_cpu(rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
+	per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
 }
 
 static int rcu_cpu_kthread_should_run(unsigned int cpu)
@@ -1398,7 +1397,7 @@ static int rcu_cpu_kthread_should_run(unsigned int cpu)
  */
 static void rcu_cpu_kthread(unsigned int cpu)
 {
-	unsigned int *statusp = this_cpu_ptr(&rcu_cpu_kthread_status);
+	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
 	char work, *workp = this_cpu_ptr(&rcu_cpu_has_work);
 	int spincnt;
 
-- 
2.17.1

