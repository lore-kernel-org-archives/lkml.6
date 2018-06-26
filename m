Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3928C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AA425D56
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AA425D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeFZRJC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:09:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932128AbeFZRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4J2Y064467
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqhsxhst-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:51 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:50 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8jHR6619620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4030B206A;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD217B2065;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0371D16CA0B1; Tue, 26 Jun 2018 10:10:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 22/22] rcu: Add diagnostics for offline CPUs failing to report QS
Date:   Tue, 26 Jun 2018 10:10:48 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-2213-0000-0000-000002C0462D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539669; IPR=6.00830592;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-2214-0000-0000-00005A9DB91A
Message-Id: <20180626171048.2181-22-paulmck@linux.vnet.ibm.com>
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

CPUs are expected to report quiescent states when coming online and
when going offline, and grace-period initialization is supposed to
handle any race conditions where a CPU's ->qsmask bit is set just after
it goes offline.  This commit adds diagnostics for the case where an
offline CPU nevertheless has a grace period waiting on it.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 22 ++++++++++++++++++++++
 kernel/rcu/tree.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9e83743ca9d9..4b0aee4f9318 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1188,6 +1188,27 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		smp_store_release(ruqp, true);
 	}
 
+	/* If waiting too long on an offline CPU, complain. */
+	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
+	    time_after(jiffies, rdp->rsp->gp_start + HZ)) {
+		bool onl;
+		struct rcu_node *rnp1;
+
+		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
+		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
+			__func__, rnp->grplo, rnp->grphi, rnp->level,
+			(long)rnp->gp_seq, (long)rnp->completedqs);
+		for (rnp1 = rnp; rnp1; rnp1 = rnp1->parent)
+			pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx ->rcu_gp_init_mask %#lx\n",
+				__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext, rnp1->rcu_gp_init_mask);
+		onl = !!(rdp->grpmask & rcu_rnp_online_cpus(rnp));
+		pr_info("%s %d: %c online: %ld(%d) offline: %ld(%d)\n",
+			__func__, rdp->cpu, ".o"[onl],
+			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_flags,
+			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_flags);
+		return 1; /* Break things loose after complaining. */
+	}
+
 	/*
 	 * A CPU running for an extended time within the kernel can
 	 * delay RCU grace periods.  When the CPU is in NO_HZ_FULL mode,
@@ -1967,6 +1988,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 					    rnp->grphi, rnp->qsmask);
 		/* Quiescent states for tasks on any now-offline CPUs. */
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
+		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
 			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
 		else
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 8077aff7ab40..d51e6edc8e83 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -90,6 +90,7 @@ struct rcu_node {
 				/*  an rcu_data structure, otherwise, each */
 				/*  bit corresponds to a child rcu_node */
 				/*  structure. */
+	unsigned long rcu_gp_init_mask;	/* Mask of offline CPUs at GP init. */
 	unsigned long qsmaskinit;
 				/* Per-GP initial value for qsmask. */
 				/*  Initialized from ->qsmaskinitnext at the */
-- 
2.17.1

