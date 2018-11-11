Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215E0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA0D21527
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA0D21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeKLFdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:33:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbeKLFdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:33:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJi8Y2036559
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:17 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdbnsp56-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:17 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:44:16 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:44:12 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJiB3627000888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:44:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 853CCB2064;
        Sun, 11 Nov 2018 19:44:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EE12B2065;
        Sun, 11 Nov 2018 19:44:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:44:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7ED8C16C5D5F; Sun, 11 Nov 2018 11:44:12 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 03/41] rcu: Eliminate synchronize_rcu_mult()
Date:   Sun, 11 Nov 2018 11:43:32 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-2213-0000-0000-00000315A7DF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116019; UDB=6.00578733; IPR=6.00896120;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:44:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-2214-0000-0000-00005C386BB1
Message-Id: <20181111194410.6368-3-paulmck@linux.ibm.com>
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

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Now that synchronize_rcu() waits for both RCU read-side critical
sections and preempt-disabled regions of code, the sole caller of
synchronize_rcu_mult() can be replaced by synchronize_rcu().
This patch makes this change and removes synchronize_rcu_mult().
Note that _wait_rcu_gp() still supports synchronize_rcu_mult(),
and thus might be simplified in the future to take only take
a single call_rcu() function rather than the current list of them.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate_wait.h | 17 -----------------
 kernel/rcu/update.c           |  6 ++----
 kernel/sched/core.c           |  2 +-
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 8a16c3eb3dd0..c0578ba23c1a 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -31,21 +31,4 @@ do {									\
 
 #define wait_rcu_gp(...) _wait_rcu_gp(false, __VA_ARGS__)
 
-/**
- * synchronize_rcu_mult - Wait concurrently for multiple grace periods
- * @...: List of call_rcu() functions for different grace periods to wait on
- *
- * This macro waits concurrently for multiple types of RCU grace periods.
- * For example, synchronize_rcu_mult(call_rcu, call_rcu_tasks) would wait
- * on concurrent RCU and RCU-tasks grace periods.  Waiting on a give SRCU
- * domain requires you to write a wrapper function for that SRCU domain's
- * call_srcu() function, supplying the corresponding srcu_struct.
- *
- * If Tiny RCU, tell _wait_rcu_gp() does not bother waiting for RCU,
- * given that anywhere synchronize_rcu_mult() can be called is automatically
- * a grace period.
- */
-#define synchronize_rcu_mult(...) \
-	_wait_rcu_gp(IS_ENABLED(CONFIG_TINY_RCU), __VA_ARGS__)
-
 #endif /* _LINUX_SCHED_RCUPDATE_WAIT_H */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index f203b94f6b5b..c729ca5e6ee2 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -335,8 +335,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 	/* Initialize and register callbacks for each crcu_array element. */
 	for (i = 0; i < n; i++) {
 		if (checktiny &&
-		    (crcu_array[i] == call_rcu ||
-		     crcu_array[i] == call_rcu_bh)) {
+		    (crcu_array[i] == call_rcu)) {
 			might_sleep();
 			continue;
 		}
@@ -352,8 +351,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 	/* Wait for all callbacks to be invoked. */
 	for (i = 0; i < n; i++) {
 		if (checktiny &&
-		    (crcu_array[i] == call_rcu ||
-		     crcu_array[i] == call_rcu_bh))
+		    (crcu_array[i] == call_rcu))
 			continue;
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f12225f26b70..ea12ebc57840 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5788,7 +5788,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 *
 	 * Do sync before park smpboot threads to take care the rcu boost case.
 	 */
-	synchronize_rcu_mult(call_rcu, call_rcu_sched);
+	synchronize_rcu();
 
 	if (!sched_smp_initialized)
 		return 0;
-- 
2.17.1

