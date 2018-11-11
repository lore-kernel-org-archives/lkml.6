Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A23E20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A23E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbeKLGL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:11:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731611AbeKLGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:05 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJ8N8046215
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:34 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdfdjqa0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:34 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:34 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:28 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKRSa22544604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FD34B206A;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 792AEB2067;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AF06D16C5D7F; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/17] rcutorture: Affinity forward-progress test to avoid housekeeping CPUs
Date:   Sun, 11 Nov 2018 12:20:15 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0072-0000-0000-000003C6F5DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00577118; IPR=6.00896132;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0073-0000-0000-00004A13578E
Message-Id: <20181111202027.13585-5-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit affinities the forward-progress tests to avoid hogging a
housekeeping CPU on the theory that the offloaded callbacks will be
running on those housekeeping CPUs.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: Fix NULL-pointer issue located by kbuild test robot. ]
Tested-by: Rong Chen <rong.a.chen@intel.com>
---
 kernel/rcu/rcu.h         |  2 ++
 kernel/rcu/rcutorture.c  |  1 +
 kernel/rcu/tree_plugin.h | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 2866166863f0..0f0f5ae8c3d4 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -539,8 +539,10 @@ extern struct workqueue_struct *rcu_par_gp_wq;
 
 #ifdef CONFIG_RCU_NOCB_CPU
 bool rcu_is_nocb_cpu(int cpu);
+void rcu_bind_current_to_nocb(void);
 #else
 static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
+static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bcc33bb8d9a6..36a3bc42782d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1803,6 +1803,7 @@ static int rcu_torture_fwd_prog(void *args)
 	int tested_tries = 0;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fwd_progress task started");
+	rcu_bind_current_to_nocb();
 	if (!IS_ENABLED(CONFIG_SMP) || !IS_ENABLED(CONFIG_RCU_BOOST))
 		set_user_nice(current, MAX_NICE);
 	do {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 05915e536336..1db2b0780c62 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2587,6 +2587,17 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
 	return true;
 }
 
+/*
+ * Bind the current task to the offloaded CPUs.  If there are no offloaded
+ * CPUs, leave the task unbound.  Splat if the bind attempt fails.
+ */
+void rcu_bind_current_to_nocb(void)
+{
+	if (cpumask_available(rcu_nocb_mask) && cpumask_weight(rcu_nocb_mask))
+		WARN_ON(sched_setaffinity(current->pid, rcu_nocb_mask));
+}
+EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
+
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
 static bool rcu_nocb_cpu_needs_barrier(int cpu)
-- 
2.17.1

