Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ADBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA80E26390
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA80E26390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935275AbeFZAw1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:52:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934658AbeFZAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:31 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0o5nA141754
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:31 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju975c1y3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:30 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:29 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oOQ19699728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DF81B2073;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D330B206B;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6858516CA09C; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 09/13] rcutorture: Disable RT throttling for boost tests
Date:   Mon, 25 Jun 2018 17:52:23 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-00000445293E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B3F00
Message-Id: <20180626005227.30660-9-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently rcutorture is not able to torture RCU boosting properly. This
is because the rcutorture's boost threads which are doing the torturing
may be throttled due to RT throttling.

This patch makes rcutorture use the right torture technique (unthrottled
rcutorture boost tasks) for torturing RCU so that the test fails
correctly when no boost is available.

Currently this requires accessing sysctl_sched_rt_runtime directly, but
that should be Ok since rcutorture is test code. Such direct access is
also only possible if rcutorture is used as a built-in so make it
conditional on that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index aa0be7ec2a26..74e47d0a618c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -55,6 +55,7 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/sysctl.h>
 
 #include "rcu.h"
 
@@ -772,6 +773,32 @@ static void rcu_torture_boost_cb(struct rcu_head *head)
 	smp_store_release(&rbip->inflight, 0);
 }
 
+static int old_rt_runtime = -1;
+
+static void rcu_torture_disable_rt_throttle(void)
+{
+	/*
+	 * Disable RT throttling so that rcutorture's boost threads don't get
+	 * throttled. Only possible if rcutorture is built-in otherwise the
+	 * user should manually do this by setting the sched_rt_period_us and
+	 * sched_rt_runtime sysctls.
+	 */
+	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
+		return;
+
+	old_rt_runtime = sysctl_sched_rt_runtime;
+	sysctl_sched_rt_runtime = -1;
+}
+
+static void rcu_torture_enable_rt_throttle(void)
+{
+	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
+		return;
+
+	sysctl_sched_rt_runtime = old_rt_runtime;
+	old_rt_runtime = -1;
+}
+
 static int rcu_torture_boost(void *arg)
 {
 	unsigned long call_rcu_time;
@@ -1511,6 +1538,7 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
 	mutex_lock(&boost_mutex);
 	t = boost_tasks[cpu];
 	boost_tasks[cpu] = NULL;
+	rcu_torture_enable_rt_throttle();
 	mutex_unlock(&boost_mutex);
 
 	/* This must be outside of the mutex, otherwise deadlock! */
@@ -1527,6 +1555,7 @@ static int rcutorture_booster_init(unsigned int cpu)
 
 	/* Don't allow time recalculation while creating a new task. */
 	mutex_lock(&boost_mutex);
+	rcu_torture_disable_rt_throttle();
 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
 	boost_tasks[cpu] = kthread_create_on_node(rcu_torture_boost, NULL,
 						  cpu_to_node(cpu),
-- 
2.17.1

