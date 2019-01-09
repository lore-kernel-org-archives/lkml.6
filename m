Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D4AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A22E206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfAIVTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:19:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbfAIVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:19:01 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LIh9b097352
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:19:00 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq5ev6fg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:19:00 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:58 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIrp021823526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01F2AB205F;
        Wed,  9 Jan 2019 21:18:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5F53B2066;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5A72E16C6402; Wed,  9 Jan 2019 13:18:52 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 06/12] rcu: Eliminate RCU_BH_FLAVOR and RCU_SCHED_FLAVOR
Date:   Wed,  9 Jan 2019 13:18:44 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
References: <20190109211830.GA30595@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0040-0000-0000-000004AF35A8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00593882; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0041-0000-0000-000008BA3A34
Message-Id: <20190109211850.31599-6-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=817 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the RCU flavors have been consolidated, RCU_BH_FLAVOR and
RCU_SCHED_FLAVOR are no longer used.  This commit therefore saves a
few lines by removing them.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu.h  | 2 --
 kernel/rcu/tree.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index a393e24a9195..75787186bd4f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -462,8 +462,6 @@ void rcu_request_urgent_qs_task(struct task_struct *t);
 
 enum rcutorture_type {
 	RCU_FLAVOR,
-	RCU_BH_FLAVOR,
-	RCU_SCHED_FLAVOR,
 	RCU_TASKS_FLAVOR,
 	SRCU_FLAVOR,
 	INVALID_RCU_FLAVOR
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e56a46444775..fc37bec32731 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -556,8 +556,6 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 {
 	switch (test_type) {
 	case RCU_FLAVOR:
-	case RCU_BH_FLAVOR:
-	case RCU_SCHED_FLAVOR:
 		*flags = READ_ONCE(rcu_state.gp_flags);
 		*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
 		break;
-- 
2.17.1

