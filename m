Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A280C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF1826242
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF1826242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755756AbeFYW4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:56:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755065AbeFYWz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:55:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMmrmt112034
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:58 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96r0rrx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:58 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:55:57 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:55:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMtqH315794644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:55:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB798B2064;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9410DB2067;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E51A316CA098; Mon, 25 Jun 2018 15:57:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 4/5] torture: Make online/offline messages appear only for verbose=2
Date:   Mon, 25 Jun 2018 15:57:54 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625225735.GA11793@linux.vnet.ibm.com>
References: <20180625225735.GA11793@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-0060-0000-0000-000002825FE8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052304; UDB=6.00539450; IPR=6.00830229;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:55:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-0061-0000-0000-0000459310D4
Message-Id: <20180625225755.12839-4-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bugs reproduce quickly only at high CPU-hotplug rates, so the
rcutorture TREE03 scenario now has only 200 milliseconds spacing between
CPU-hotplug operations.  At this rate, the torture-test pair of console
messages per operation becomes a bit voluminous.  This commit therefore
converts the torture-test set of "verbose" kernel-boot arguments from
bool to int, and prints the extra console messages only when verbose=2.
The default is still verbose=1.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/torture.h      |  2 +-
 kernel/locking/locktorture.c |  2 +-
 kernel/rcu/rcuperf.c         |  2 +-
 kernel/rcu/rcutorture.c      |  2 +-
 kernel/torture.c             | 12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 66272862070b..a55e80817dae 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -79,7 +79,7 @@ void stutter_wait(const char *title);
 int torture_stutter_init(int s);
 
 /* Initialization and cleanup. */
-bool torture_init_begin(char *ttype, bool v);
+bool torture_init_begin(char *ttype, int v);
 void torture_init_end(void);
 bool torture_cleanup_begin(void);
 void torture_cleanup_end(void);
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 8402b3349dca..4a2e13870a9b 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -57,7 +57,7 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
-torture_param(bool, verbose, true,
+torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
 
 static char *torture_type = "spin_lock";
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index e232846516b3..fb8094848906 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -88,7 +88,7 @@ torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, nwriters, -1, "Number of RCU updater threads");
 torture_param(bool, shutdown, !IS_ENABLED(MODULE),
 	      "Shutdown at end of performance tests.");
-torture_param(bool, verbose, true, "Enable verbose debugging printk()s");
+torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 
 static char *perf_type = "rcu";
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 42fcb7f05fac..a5540bd831c4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -101,7 +101,7 @@ torture_param(int, test_boost_interval, 7,
 	     "Interval between boost tests, seconds.");
 torture_param(bool, test_no_idle_hz, true,
 	     "Test support for tickless idle CPUs");
-torture_param(bool, verbose, true,
+torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
 
 static char *torture_type = "rcu";
diff --git a/kernel/torture.c b/kernel/torture.c
index 3de1efbecd6a..840fd33c1cda 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -53,7 +53,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com>");
 
 static char *torture_type;
-static bool verbose;
+static int verbose;
 
 /* Mediate rmmod and system shutdown.  Concurrent rmmod & shutdown illegal! */
 #define FULLSTOP_DONTSTOP 0	/* Normal operation. */
@@ -98,7 +98,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 	if (!cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
 		return false;
 
-	if (verbose)
+	if (verbose > 1)
 		pr_alert("%s" TORTURE_FLAG
 			 "torture_onoff task: offlining %d\n",
 			 torture_type, cpu);
@@ -111,7 +111,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 				 "torture_onoff task: offline %d failed: errno %d\n",
 				 torture_type, cpu, ret);
 	} else {
-		if (verbose)
+		if (verbose > 1)
 			pr_alert("%s" TORTURE_FLAG
 				 "torture_onoff task: offlined %d\n",
 				 torture_type, cpu);
@@ -147,7 +147,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 	if (cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
 		return false;
 
-	if (verbose)
+	if (verbose > 1)
 		pr_alert("%s" TORTURE_FLAG
 			 "torture_onoff task: onlining %d\n",
 			 torture_type, cpu);
@@ -160,7 +160,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 				 "torture_onoff task: online %d failed: errno %d\n",
 				 torture_type, cpu, ret);
 	} else {
-		if (verbose)
+		if (verbose > 1)
 			pr_alert("%s" TORTURE_FLAG
 				 "torture_onoff task: onlined %d\n",
 				 torture_type, cpu);
@@ -647,7 +647,7 @@ static void torture_stutter_cleanup(void)
  * The runnable parameter points to a flag that controls whether or not
  * the test is currently runnable.  If there is no such flag, pass in NULL.
  */
-bool torture_init_begin(char *ttype, bool v)
+bool torture_init_begin(char *ttype, int v)
 {
 	mutex_lock(&fullstop_mutex);
 	if (torture_type != NULL) {
-- 
2.17.1

