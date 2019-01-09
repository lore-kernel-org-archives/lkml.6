Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C707206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfAIVlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:41:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbfAIVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:41:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LdxHP142244
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:41:50 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwnf7ss5h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:41:50 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:41:49 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:41:45 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09Lfi9519988488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:41:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70262B2065;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D057B2068;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:41:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 13C1416C63E5; Wed,  9 Jan 2019 13:41:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/8] rcu: Rename rcu_process_callbacks() to rcu_core() for Tree RCU
Date:   Wed,  9 Jan 2019 13:41:37 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214115.GA2835@linux.ibm.com>
References: <20190109214115.GA2835@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-2213-0000-0000-00000339970C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144149; UDB=6.00595711; IPR=6.00924412;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:41:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-2214-0000-0000-00005CE7FD07
Message-Id: <20190109214142.4428-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the name rcu_process_callbacks() still makes sense for Tiny
RCU, where most of what it does is invoke callbacks, it no longer makes
much sense for Tree RCU, especially given that the actually callback
invocation is relegated to rcu_do_batch(), or, for no-CBs CPUs, to the
rcuo kthreads.  Especially in the latter case, rcu_process_callbacks()
has very little to do with actual callbacks.  A better description of
this function is that it performs RCU's core processing.

This commit therefore changes the name of Tree RCU's rcu_process_callbacks()
function to rcu_core(), which also has the virtue of being consistent with
the existing invoke_rcu_core() function.

While in the area, the header comment is reworked.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.html      |  2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg          |  4 ++--
 .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg          |  4 ++--
 kernel/rcu/tree.c                                      | 10 +++-------
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
index a3acfd49255f..8d21af02b1f0 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
@@ -491,7 +491,7 @@ in a per-CPU variable.
 
 <p>The next time an <tt>RCU_SOFTIRQ</tt> handler executes on
 this CPU (for example, after the next scheduler-clock
-interrupt), <tt>__rcu_process_callbacks()</tt> will invoke
+interrupt), <tt>rcu_core()</tt> will invoke
 <tt>rcu_check_quiescent_state()</tt>, which will notice the
 recorded quiescent state, and invoke
 <tt>rcu_report_qs_rdp()</tt>.
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index f0bbe6f8d729..2bcd742d6e49 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3924,7 +3924,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_process_callbacks()</text>
+         xml:space="preserve">rcu_core()</text>
       <text
          style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
          id="text202-7-5-3-27-0"
@@ -3933,7 +3933,7 @@
          font-style="normal"
          y="-4165.7954"
          x="3745.7725"
-         xml:space="preserve">rcu_check_quiescent_state())</text>
+         xml:space="preserve">rcu_check_quiescent_state()</text>
       <text
          style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
          id="text202-7-5-3-27-0-9"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
index 3596ffdd4685..779c9ac31a52 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
@@ -797,7 +797,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_process_callbacks()</text>
+         xml:space="preserve">rcu_core()</text>
       <text
          style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
          id="text202-7-5-3-27-0"
@@ -806,7 +806,7 @@
          font-style="normal"
          y="-4165.7954"
          x="3745.7725"
-         xml:space="preserve">rcu_check_quiescent_state())</text>
+         xml:space="preserve">rcu_check_quiescent_state()</text>
       <text
          style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
          id="text202-7-5-3-27-0-9"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a79dd51c9cce..36b04b41f2c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2711,12 +2711,8 @@ void rcu_fwd_progress_check(unsigned long j)
 }
 EXPORT_SYMBOL_GPL(rcu_fwd_progress_check);
 
-/*
- * This does the RCU core processing work for the specified rcu_data
- * structures.  This may be called only from the CPU to whom the rdp
- * belongs.
- */
-static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
+/* Perform RCU core processing work for the current CPU.  */
+static __latent_entropy void rcu_core(struct softirq_action *unused)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
@@ -3777,7 +3773,7 @@ void __init rcu_init(void)
 	rcu_init_one();
 	if (dump_tree)
 		rcu_dump_rcu_node_tree();
-	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
+	open_softirq(RCU_SOFTIRQ, rcu_core);
 
 	/*
 	 * We don't need protection against CPU-hotplug here because
-- 
2.17.1

