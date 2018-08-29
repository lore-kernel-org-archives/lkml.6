Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7A9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9EF20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9EF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeH3Brs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:47:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727292AbeH3Bqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:46:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLcq83138097
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:58 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m629dtykr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:57 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:47:57 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:47:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLlp1a44105936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:47:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD0A5B2071;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DF29B205F;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:46:47 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AD5D816C91CB; Wed, 29 Aug 2018 14:47:51 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/17] rcutorture: Also use GP sequence to judge forward progress
Date:   Wed, 29 Aug 2018 14:47:40 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829214722.GA23411@linux.vnet.ibm.com>
References: <20180829214722.GA23411@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0040-0000-0000-0000046753F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080727; UDB=6.00557487; IPR=6.00860713;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:47:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0041-0000-0000-0000086E6DC7
Message-Id: <20180829214750.26972-7-paulmck@linux.vnet.ibm.com>
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

Currently, rcutorture relies solely on the progress of
rcu_torture_writer() to judge grace-period forward progress.  In theory,
this is the gold standard of forward progress, but in practice rcutorture
separately detects and reports rcu_torture_writer() stalls.  This commit
therefore adds the grace-period sequence number (when provided) to the
judgment of grace-period forward progress, which makes it easier to
distinguish between failure of actual grace periods to progress on the
one hand and downstream forward-progress failures on the other.

For example, given this change, if rcu_torture_writer() stalls,
but rcu_torture_fwd_prog() does not complain, then the grace-period
computation is working, which is a hint that the failure lies in callback
processing, wakeup of the rcu_torture_writer() kthread, or similar.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fd3ce6cc8eea..dee7b45b2186 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1673,7 +1673,8 @@ static int __init rcu_torture_stall_init(void)
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
-	unsigned long cvar;
+	unsigned long cver;
+	unsigned long gps;
 	int idx;
 	unsigned long stopat;
 	bool tested = false;
@@ -1681,7 +1682,8 @@ static int rcu_torture_fwd_prog(void *args)
 	VERBOSE_TOROUT_STRING("rcu_torture_fwd_progress task started");
 	do {
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
-		cvar = READ_ONCE(rcu_torture_current_version);
+		cver = READ_ONCE(rcu_torture_current_version);
+		gps = cur_ops->get_gp_seq();
 		stopat = jiffies + cur_ops->stall_dur() / fwd_progress_div;
 		while (time_before(jiffies, stopat) && !torture_must_stop()) {
 			idx = cur_ops->readlock();
@@ -1692,8 +1694,9 @@ static int rcu_torture_fwd_prog(void *args)
 		}
 		if (!time_before(jiffies, stopat) && !torture_must_stop()) {
 			tested = true;
-			WARN_ON_ONCE(cvar ==
-				     READ_ONCE(rcu_torture_current_version));
+			cver = cver == READ_ONCE(rcu_torture_current_version);
+			gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
+			WARN_ON_ONCE(cver && gps < 2);
 		}
 		/* Avoid slow periods, better to test when busy. */
 		stutter_wait("rcu_torture_fwd_prog");
-- 
2.17.1

