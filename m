Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F1FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A056820644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A056820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeH3BrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:47:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbeH3Bqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:46:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLcphP121227
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:48:01 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61rcvca9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:48:00 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:47:58 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:47:53 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLlqUd21430444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:47:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A76FB205F;
        Wed, 29 Aug 2018 17:46:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04FD5B2067;
        Wed, 29 Aug 2018 17:46:48 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E337916C91D8; Wed, 29 Aug 2018 14:47:51 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 17/17] rcutorture: Maintain self-propagating CB only during forward-progress test
Date:   Wed, 29 Aug 2018 14:47:50 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829214722.GA23411@linux.vnet.ibm.com>
References: <20180829214722.GA23411@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0060-0000-0000-000002A65FEE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080727; UDB=6.00557487; IPR=6.00860713;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:47:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0061-0000-0000-000046559E91
Message-Id: <20180829214750.26972-17-paulmck@linux.vnet.ibm.com>
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

The current forward-progress testing maintains a self-propagating
callback during the full test.  This could result in false negatives
for stutter-end checking, where it might appear that RCU was clearing
out old callbacks only because it was being continually motivated by
the self-propagating callback.  This commit therefore shuts down the
self-propagating callback at the end of each forward-progress test
interval.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ae10ad531993..a02a2f21386b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1706,7 +1706,7 @@ static int rcu_torture_fwd_prog(void *args)
 {
 	unsigned long cver;
 	unsigned long dur;
-	struct fwd_cb_state fcs = { .stop = 0 };
+	struct fwd_cb_state fcs;
 	unsigned long gps;
 	int idx;
 	int sd;
@@ -1722,11 +1722,14 @@ static int rcu_torture_fwd_prog(void *args)
 		set_user_nice(current, MAX_NICE);
 	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
 		init_rcu_head_on_stack(&fcs.rh);
-		cur_ops->call(&fcs.rh, rcu_torture_fwd_prog_cb);
 		selfpropcb = true;
 	}
 	do {
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
+		if  (selfpropcb) {
+			WRITE_ONCE(fcs.stop, 0);
+			cur_ops->call(&fcs.rh, rcu_torture_fwd_prog_cb);
+		}
 		cver = READ_ONCE(rcu_torture_current_version);
 		gps = cur_ops->get_gp_seq();
 		sd = cur_ops->stall_dur() + 1;
@@ -1748,13 +1751,15 @@ static int rcu_torture_fwd_prog(void *args)
 			WARN_ON(!cver && gps < 2);
 			pr_alert("%s: Duration %ld cver %ld gps %ld\n", __func__, dur, cver, gps);
 		}
+		if (selfpropcb) {
+			WRITE_ONCE(fcs.stop, 1);
+			cur_ops->sync(); /* Wait for running CB to complete. */
+			cur_ops->cb_barrier(); /* Wait for queued callbacks. */
+		}
 		/* Avoid slow periods, better to test when busy. */
 		stutter_wait("rcu_torture_fwd_prog");
 	} while (!torture_must_stop());
 	if (selfpropcb) {
-		WRITE_ONCE(fcs.stop, 1);
-		cur_ops->sync(); /* Wait for running callback to complete. */
-		cur_ops->cb_barrier(); /* Wait for queued callbacks. */
 		WARN_ON(READ_ONCE(fcs.stop) != 2);
 		destroy_rcu_head_on_stack(&fcs.rh);
 	}
-- 
2.17.1

