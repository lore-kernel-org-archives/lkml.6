Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9553C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8192C214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8192C214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeKLFVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:21:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbeKLFVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:21:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJOCMJ004565
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:32:23 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npd3usx7c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:32:22 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:32:22 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:32:18 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJWHJW18612306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:32:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49F61B206C;
        Sun, 11 Nov 2018 19:32:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25730B2065;
        Sun, 11 Nov 2018 19:32:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:32:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 546D716C5D4F; Sun, 11 Nov 2018 11:32:18 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/4] rcu: Eliminate BUG_ON() for kernel/rcu/tree_plugin.h
Date:   Sun, 11 Nov 2018 11:32:16 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111193156.GA3666@linux.ibm.com>
References: <20181111193156.GA3666@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0060-0000-0000-000002D0FBB5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116015; UDB=6.00578730; IPR=6.00896116;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:32:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0061-0000-0000-0000472A0171
Message-Id: <20181111193217.4010-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tree_plugin.h file has a number of calls to BUG_ON(), which panics
the kernel, which is not a good strategy for devices (like embedded)
that don't have a way to capture console output.  This commit therefore
converts these BUG_ON() calls to WARN_ON_ONCE() and WARN_ONCE().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 05915e536336..105a19752ac2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1464,7 +1464,8 @@ static void __init rcu_spawn_boost_kthreads(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_cpu_has_work, cpu) = 0;
-	BUG_ON(smpboot_register_percpu_thread(&rcu_cpu_thread_spec));
+	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcuo kthread, OOM is now expected behavior\n", __func__))
+		return;
 	rcu_for_each_leaf_node(rnp)
 		(void)rcu_spawn_one_boost_kthread(rnp);
 }
@@ -2322,7 +2323,8 @@ static int rcu_nocb_kthread(void *arg)
 		tail = rdp->nocb_follower_tail;
 		rdp->nocb_follower_tail = &rdp->nocb_follower_head;
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-		BUG_ON(!list);
+		if (WARN_ON_ONCE(!list))
+			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeNonEmpty"));
 
 		/* Each pass through the following loop invokes a callback. */
@@ -2495,7 +2497,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	/* Spawn the kthread for this CPU. */
 	t = kthread_run(rcu_nocb_kthread, rdp_spawn,
 			"rcuo%c/%d", rcu_state.abbr, cpu);
-	BUG_ON(IS_ERR(t));
+	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo kthread, OOM is now expected behavior\n", __func__))
+		return;
 	WRITE_ONCE(rdp_spawn->nocb_kthread, t);
 }
 
-- 
2.17.1

