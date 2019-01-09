Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF751C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C5320685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfAIV2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:28:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbfAIV2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:28:53 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LSoRs015895
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:28:52 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwrhys16a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:28:52 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:28:41 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:28:37 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LSaWQ22610072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:28:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 222BFB206B;
        Wed,  9 Jan 2019 21:28:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09D92B2075;
        Wed,  9 Jan 2019 21:28:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8A90716C6415; Wed,  9 Jan 2019 13:28:35 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/12] rcu: Add sysrq rcu_node-dump capability
Date:   Wed,  9 Jan 2019 13:28:32 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109212816.GA32282@linux.ibm.com>
References: <20190109212816.GA32282@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-00000380061E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144145; UDB=6.00595708; IPR=6.00924407;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:28:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-00004712238F
Message-Id: <20190109212834.1257-10-paulmck@linux.ibm.com>
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

Life is hard if RCU manages to get stuck without triggering RCU CPU
stall warnings or triggering the rcu_check_gp_start_stall() checks
for failing to start a grace period.  This commit therefore adds a
boot-time-selectable sysrq key (commandeering "y") that allows manually
dumping Tree RCU state.  The new rcutree.sysrq_rcu kernel boot parameter
must be set for this sysrq to be available.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 kernel/rcu/tree.c                             | 25 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..b0dbb2fa401f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3721,6 +3721,11 @@
 			This wake_up() will be accompanied by a
 			WARN_ONCE() splat and an ftrace_dump().
 
+	rcutree.sysrq_rcu= [KNL]
+			Commandeer a sysrq key to dump out Tree RCU's
+			rcu_node tree with an eye towards determining
+			why a new grace period has not yet started.
+
 	rcuperf.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 238150684fed..9ceb93f848cd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -62,6 +62,7 @@
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/tick.h>
+#include <linux/sysrq.h>
 
 #include "tree.h"
 #include "rcu.h"
@@ -115,6 +116,9 @@ int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
+/* Commandeer a sysrq key to dump RCU's tree. */
+static bool sysrq_rcu;
+module_param(sysrq_rcu, bool, 0444);
 
 /*
  * The rcu_scheduler_active variable is initialized to the value
@@ -577,6 +581,27 @@ void show_rcu_gp_kthreads(void)
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
+/* Dump grace-period-request information due to commandeered sysrq. */
+static void sysrq_show_rcu(int key)
+{
+	show_rcu_gp_kthreads();
+}
+
+static struct sysrq_key_op sysrq_rcudump_op = {
+	.handler = sysrq_show_rcu,
+	.help_msg = "show-rcu(y)",
+	.action_msg = "Show RCU tree",
+	.enable_mask = SYSRQ_ENABLE_DUMP,
+};
+
+static int __init rcu_sysrq_init(void)
+{
+	if (sysrq_rcu)
+		return register_sysrq_key('y', &sysrq_rcudump_op);
+	return 0;
+}
+early_initcall(rcu_sysrq_init);
+
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
-- 
2.17.1

