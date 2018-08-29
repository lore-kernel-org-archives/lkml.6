Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40CB2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40CB2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH3CT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:19:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbeH3CTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIiAN124265
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:57 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m60fgrecx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:55 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKnt825231504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E56AB206B;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79578B2065;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6B52D16C91DA; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 19/19] rcu: Remove rcu_data_p pointer to default rcu_data structure
Date:   Wed, 29 Aug 2018 15:20:47 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-000003281F39
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860723;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE5F2EA
Message-Id: <20180829222047.319-19-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_data_p pointer references the default set of per-CPU rcu_data
structures, that is, those that call_rcu() uses, as opposed to
call_rcu_bh() and sometimes call_rcu_sched().  But there is now only one
set of per-CPU rcu_data structures, so that one set is by definition
the default, which means that the rcu_data_p pointer no longer serves
any useful purpose.  This commit therefore removes it.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        |  1 -
 kernel/rcu/tree_plugin.h | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a3bcf08ad596..f0e7e3972fd9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -85,7 +85,6 @@ struct rcu_state rcu_state = {
 	.ofl_lock = __SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock),
 };
 
-static struct rcu_data __percpu *const rcu_data_p = &rcu_data;
 LIST_HEAD(rcu_struct_flavors);
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 329d5802d899..18175ca19f34 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -302,11 +302,11 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 static void rcu_qs(void)
 {
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_qs() invoked with preemption enabled!!!\n");
-	if (__this_cpu_read(rcu_data_p->cpu_no_qs.s)) {
+	if (__this_cpu_read(rcu_data.cpu_no_qs.s)) {
 		trace_rcu_grace_period(TPS("rcu_preempt"),
-				       __this_cpu_read(rcu_data_p->gp_seq),
+				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
-		__this_cpu_write(rcu_data_p->cpu_no_qs.b.norm, false);
+		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
 		barrier(); /* Coordinate with rcu_flavor_check_callbacks(). */
 		current->rcu_read_unlock_special.b.need_qs = false;
 	}
@@ -805,8 +805,8 @@ static void rcu_flavor_check_callbacks(int user)
 
 	/* If GP is oldish, ask for help from rcu_read_unlock_special(). */
 	if (t->rcu_read_lock_nesting > 0 &&
-	    __this_cpu_read(rcu_data_p->core_needs_qs) &&
-	    __this_cpu_read(rcu_data_p->cpu_no_qs.b.norm) &&
+	    __this_cpu_read(rcu_data.core_needs_qs) &&
+	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
 	    !t->rcu_read_unlock_special.b.need_qs &&
 	    time_after(jiffies, rsp->gp_start + HZ))
 		t->rcu_read_unlock_special.b.need_qs = true;
-- 
2.17.1

