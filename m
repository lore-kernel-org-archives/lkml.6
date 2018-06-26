Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E093C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B6F2638C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B6F2638C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935243AbeFZAwZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:52:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934678AbeFZAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:31 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0n1dE035441
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:31 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96pv63u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:31 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:30 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oOOt10420640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BFA8B206B;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F0DEB206C;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6E5CB16CA09D; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 10/13] rcutorture: Make boost test more robust
Date:   Mon, 25 Jun 2018 17:52:24 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-000004452940
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B3F03
Message-Id: <20180626005227.30660-10-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently, with RCU_BOOST disabled, I get no failures when forcing
rcutorture to test RCU boost priority inversion. The reason seems to be
that we don't check for failures if the callback never ran at all for
the duration of the boost-test loop.

Further, the 'rtb' and 'rtbf' counters seem to be used inconsistently.
'rtb' is incremented at the start of each test and 'rtbf' is incremented
per-cpu on each failure of call_rcu. So its possible 'rtbf' > 'rtb'.

To test the boost with rcutorture, I did following on a 4-CPU x86 machine:

modprobe rcutorture  test_boost=2
sleep 20
rmmod rcutorture

With patch:
rtbf: 8 rtb: 12

Without patch:
rtbf: 0 rtb: 2

In summary this patch:
 - Increments failed and total test counters once per boost-test.
 - Checks for failure cases correctly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 45 +++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 74e47d0a618c..36b9b8266213 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -799,6 +799,18 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
+static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
+{
+	if (end - start > test_boost_duration * HZ - HZ / 2) {
+		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
+		n_rcu_torture_boost_failure++;
+
+		return true; /* failed */
+	}
+
+	return false; /* passed */
+}
+
 static int rcu_torture_boost(void *arg)
 {
 	unsigned long call_rcu_time;
@@ -819,6 +831,21 @@ static int rcu_torture_boost(void *arg)
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
+		/* Track if the test failed already in this test interval? */
+		bool failed = false;
+
+		/* Increment n_rcu_torture_boosts once per boost-test */
+		while (!kthread_should_stop()) {
+			if (mutex_trylock(&boost_mutex)) {
+				n_rcu_torture_boosts++;
+				mutex_unlock(&boost_mutex);
+				break;
+			}
+			schedule_timeout_uninterruptible(1);
+		}
+		if (kthread_should_stop())
+			goto checkwait;
+
 		/* Wait for the next test interval. */
 		oldstarttime = boost_starttime;
 		while (ULONG_CMP_LT(jiffies, oldstarttime)) {
@@ -837,11 +864,10 @@ static int rcu_torture_boost(void *arg)
 				/* RCU core before ->inflight = 1. */
 				smp_store_release(&rbi.inflight, 1);
 				call_rcu(&rbi.rcu, rcu_torture_boost_cb);
-				if (jiffies - call_rcu_time >
-					 test_boost_duration * HZ - HZ / 2) {
-					VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
-					n_rcu_torture_boost_failure++;
-				}
+				/* Check if the boost test failed */
+				failed = failed ||
+					 rcu_torture_boost_failed(call_rcu_time,
+								 jiffies);
 				call_rcu_time = jiffies;
 			}
 			stutter_wait("rcu_torture_boost");
@@ -849,6 +875,14 @@ static int rcu_torture_boost(void *arg)
 				goto checkwait;
 		}
 
+		/*
+		 * If boost never happened, then inflight will always be 1, in
+		 * this case the boost check would never happen in the above
+		 * loop so do another one here.
+		 */
+		if (!failed && smp_load_acquire(&rbi.inflight))
+			rcu_torture_boost_failed(call_rcu_time, jiffies);
+
 		/*
 		 * Set the start time of the next test interval.
 		 * Yes, this is vulnerable to long delays, but such
@@ -861,7 +895,6 @@ static int rcu_torture_boost(void *arg)
 			if (mutex_trylock(&boost_mutex)) {
 				boost_starttime = jiffies +
 						  test_boost_interval * HZ;
-				n_rcu_torture_boosts++;
 				mutex_unlock(&boost_mutex);
 				break;
 			}
-- 
2.17.1

