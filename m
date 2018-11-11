Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6652BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C0121707
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C0121707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbeKLGLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:11:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730715AbeKLGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJ7BO042071
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:36 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdv7t20m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:34 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKS9Q22479024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FA8CB2066;
        Sun, 11 Nov 2018 20:20:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0A27B2068;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CB46616C5DA3; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/17] rcu: Print per-CPU callback counts for forward-progress failures
Date:   Sun, 11 Nov 2018 12:20:20 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0052-0000-0000-00000354249D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00578740; IPR=6.00896132;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0053-0000-0000-00005EBB30EF
Message-Id: <20181111202027.13585-10-paulmck@linux.ibm.com>
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

This commit prints out the non-zero per-CPU callback counts when a
forware-progress error (OOM event) occurs.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: Fix a pair of uninitialized locals spotted by kbuild test robot. ]
---
 kernel/rcu/tree.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 67f2c7a055b6..cef7d9867508 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2672,6 +2672,10 @@ rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 void rcu_fwd_progress_check(unsigned long j)
 {
+	unsigned long cbs;
+	int cpu;
+	unsigned long max_cbs = 0;
+	int max_cpu = -1;
 	struct rcu_data *rdp;
 
 	if (rcu_gp_in_progress()) {
@@ -2682,6 +2686,20 @@ void rcu_fwd_progress_check(unsigned long j)
 		rcu_check_gp_start_stall(rdp->mynode, rdp, j);
 		preempt_enable();
 	}
+	for_each_possible_cpu(cpu) {
+		cbs = rcu_get_n_cbs_cpu(cpu);
+		if (!cbs)
+			continue;
+		if (max_cpu < 0)
+			pr_info("%s: callbacks", __func__);
+		pr_cont(" %d: %lu", cpu, cbs);
+		if (cbs <= max_cbs)
+			continue;
+		max_cbs = cbs;
+		max_cpu = cpu;
+	}
+	if (max_cpu >= 0)
+		pr_cont("\n");
 }
 EXPORT_SYMBOL_GPL(rcu_fwd_progress_check);
 
-- 
2.17.1

