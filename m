Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E4226E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E4226E4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeFZRJI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:09:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932120AbeFZRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH5Qvb120507
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jus52s7dd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:51 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8kBG6226542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA28AB2067;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81C14B206E;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E340316CA0AD; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 18/22] rcu: Remove CPU-hotplug failsafe from force-quiescent-state code path
Date:   Tue, 26 Jun 2018 10:10:44 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0072-0000-0000-00000374C873
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539668; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0073-0000-0000-0000487E75F5
Message-Id: <20180626171048.2181-18-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that quiescent states for newly offlined CPUs are reported either
when that CPU goes offline or at the end of grace-period initialization,
the CPU-hotplug failsafe in the force-quiescent-state code path is no
longer needed.

This commit therefore removes this failsafe.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/trace/events/rcu.h | 10 +++++-----
 kernel/rcu/tree.c          |  9 +--------
 kernel/rcu/tree.h          |  1 -
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 759e7e83733d..a8d07feff6a0 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -391,11 +391,11 @@ TRACE_EVENT(rcu_quiescent_state_report,
 
 /*
  * Tracepoint for quiescent states detected by force_quiescent_state().
- * These trace events include the type of RCU, the grace-period number that
- * was blocked by the CPU, the CPU itself, and the type of quiescent state,
- * which can be "dti" for dyntick-idle mode, "ofl" for CPU offline, "kick"
- * when kicking a CPU that has been in dyntick-idle mode for too long, or
- * "rqc" if the CPU got a quiescent state via its rcu_qs_ctr.
+ * These trace events include the type of RCU, the grace-period number
+ * that was blocked by the CPU, the CPU itself, and the type of quiescent
+ * state, which can be "dti" for dyntick-idle mode, "kick" when kicking
+ * a CPU that has been in dyntick-idle mode for too long, or "rqc" if the
+ * CPU got a quiescent state via its rcu_qs_ctr.
  */
 TRACE_EVENT(rcu_fqs,
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8704b31b696d..c698a595b932 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1188,14 +1188,6 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		smp_store_release(ruqp, true);
 	}
 
-	/* Check for the CPU being offline. */
-	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp))) {
-		trace_rcu_fqs(rdp->rsp->name, rdp->gp_seq, rdp->cpu, TPS("ofl"));
-		rdp->offline_fqs++;
-		rcu_gpnum_ovf(rnp, rdp);
-		return 1;
-	}
-
 	/*
 	 * A CPU running for an extended time within the kernel can
 	 * delay RCU grace periods.  When the CPU is in NO_HZ_FULL mode,
@@ -3716,6 +3708,7 @@ void rcu_cpu_starting(unsigned int cpu)
 		nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 		/* Allow lockless access for expedited grace periods. */
 		smp_store_release(&rsp->ncpus, rsp->ncpus + nbits); /* ^^^ */
+		rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
 			/* Report QS -after- changing ->qsmaskinitnext! */
 			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 6683da6e4ecc..795d469c6f67 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -217,7 +217,6 @@ struct rcu_data {
 
 	/* 4) reasons this CPU needed to be kicked by force_quiescent_state */
 	unsigned long dynticks_fqs;	/* Kicked due to dynticks idle. */
-	unsigned long offline_fqs;	/* Kicked due to being offline. */
 	unsigned long cond_resched_completed;
 					/* Grace period that needs help */
 					/*  from cond_resched(). */
-- 
2.17.1

