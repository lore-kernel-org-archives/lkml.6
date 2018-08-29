Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E8E2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E8E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeH3Bqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:46:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727298AbeH3Bqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:46:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLcrYa094916
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:58 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7tf3k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:58 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:47:57 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:47:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLlpYD46530582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:47:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD8C7B2076;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B664B2068;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BE85E16C91D1; Wed, 29 Aug 2018 14:47:51 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 10/17] rcutorture: Add self-propagating callback to forward-progress testing
Date:   Wed, 29 Aug 2018 14:47:43 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829214722.GA23411@linux.vnet.ibm.com>
References: <20180829214722.GA23411@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0064-0000-0000-00000343FBDF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080727; UDB=6.00557487; IPR=6.00860713;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:47:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0065-0000-0000-00003A782F6E
Message-Id: <20180829214750.26972-10-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rcutorture is run on a quiet system with the rcutorture.stutter module
parameter set high, then there can legitimately be an extended period
during which no RCU forward progress takes place.  This can result
in false-positive no-forward-progress splats.  This commit therefore
makes rcu_torture_fwd_prog() create a self-propagating RCU callback
to ensure that grace periods are in progress for the duration of the
forward-progress test.

Note that the RCU flavor under test must define ->call(), ->sync(),
and ->cb_barrier() for this self-propagating callback to be created.
If one or more of those rcu_torture_ops fields are NULL, then the
rcu_torture_fwd_prog() function will silently proceed without creating
the self-propagating callback.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 89cc4d9c9a0c..316083687fd7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1670,20 +1670,49 @@ static int __init rcu_torture_stall_init(void)
 	return torture_create_kthread(rcu_torture_stall, NULL, stall_task);
 }
 
+/* State structure for forward-progress self-propagating RCU callback. */
+struct fwd_cb_state {
+	struct rcu_head rh;
+	int stop;
+};
+
+/*
+ * Forward-progress self-propagating RCU callback function.  Because
+ * callbacks run from softirq, this function is an implicit RCU read-side
+ * critical section.
+ */
+static void rcu_torture_fwd_prog_cb(struct rcu_head *rhp)
+{
+	struct fwd_cb_state *fcsp = container_of(rhp, struct fwd_cb_state, rh);
+
+	if (READ_ONCE(fcsp->stop)) {
+		WRITE_ONCE(fcsp->stop, 2);
+		return;
+	}
+	cur_ops->call(&fcsp->rh, rcu_torture_fwd_prog_cb);
+}
+
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
 	unsigned long cver;
+	struct fwd_cb_state fcs = { .stop = 0 };
 	unsigned long gps;
 	int idx;
 	int sd;
 	int sd4;
+	bool selfpropcb = false;
 	unsigned long stopat;
 	bool tested = false;
 	int tested_tries = 0;
 	static DEFINE_TORTURE_RANDOM(trs);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fwd_progress task started");
+	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
+		init_rcu_head_on_stack(&fcs.rh);
+		cur_ops->call(&fcs.rh, rcu_torture_fwd_prog_cb);
+		selfpropcb = true;
+	}
 	do {
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 		cver = READ_ONCE(rcu_torture_current_version);
@@ -1708,6 +1737,13 @@ static int rcu_torture_fwd_prog(void *args)
 		/* Avoid slow periods, better to test when busy. */
 		stutter_wait("rcu_torture_fwd_prog");
 	} while (!torture_must_stop());
+	if (selfpropcb) {
+		WRITE_ONCE(fcs.stop, 1);
+		cur_ops->sync(); /* Wait for running callback to complete. */
+		cur_ops->cb_barrier(); /* Wait for queued callbacks. */
+		WARN_ON(READ_ONCE(fcs.stop) != 2);
+		destroy_rcu_head_on_stack(&fcs.rh);
+	}
 	/* Short runs might not contain a valid forward-progress attempt. */
 	WARN_ON(!tested && tested_tries >= 5);
 	torture_kthread_stopping("rcu_torture_fwd_prog");
-- 
2.17.1

