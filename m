Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24C8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7F2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfAIVuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:50:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbfAIVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:50:19 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LnWHs025875
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:50:18 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq5ew6ps-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:50:17 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:50:16 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:50:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LoAJH21102766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:50:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84619B2066;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54FC3B2067;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:50:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2E25A16C63AD; Wed,  9 Jan 2019 13:50:10 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 03/10] rcutorture: Add grace period after CPU offline
Date:   Wed,  9 Jan 2019 13:50:01 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109214944.GA5610@linux.ibm.com>
References: <20190109214944.GA5610@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0040-0000-0000-000004AF3828
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144152; UDB=6.00593882; IPR=6.00924415;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:50:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0041-0000-0000-000008BA3CB6
Message-Id: <20190109215008.6401-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beyond a certain point in the CPU-hotplug offline process, timers get
stranded on the outgoing CPU, and won't fire until that CPU comes back
online, which might well be never.  This commit therefore adds a hook
in torture_onoff_init() that is invoked from torture_offline(), which
rcutorture uses to occasionally wait for a grace period.  This should
result in failures for RCU implementations that rely on stranded timers
eventually firing in the absence of the CPU coming back online.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/torture.h      |  3 ++-
 kernel/locking/locktorture.c |  2 +-
 kernel/rcu/rcutorture.c      | 11 ++++++++++-
 kernel/torture.c             |  6 +++++-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 48fad21109fc..f2d3bcbf4337 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -50,11 +50,12 @@
 	do { if (verbose) pr_alert("%s" TORTURE_FLAG "!!! %s\n", torture_type, s); } while (0)
 
 /* Definitions for online/offline exerciser. */
+typedef void torture_ofl_func(void);
 bool torture_offline(int cpu, long *n_onl_attempts, long *n_onl_successes,
 		     unsigned long *sum_offl, int *min_onl, int *max_onl);
 bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 		    unsigned long *sum_onl, int *min_onl, int *max_onl);
-int torture_onoff_init(long ooholdoff, long oointerval);
+int torture_onoff_init(long ooholdoff, long oointerval, torture_ofl_func *f);
 void torture_onoff_stats(void);
 bool torture_onoff_failures(void);
 
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 7d0b0ed74404..c8b348097bb5 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -970,7 +970,7 @@ static int __init lock_torture_init(void)
 	/* Prepare torture context. */
 	if (onoff_interval > 0) {
 		firsterr = torture_onoff_init(onoff_holdoff * HZ,
-					      onoff_interval * HZ);
+					      onoff_interval * HZ, NULL);
 		if (firsterr)
 			goto unwind;
 	}
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0955f3a20952..9eb9235c1ec9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2243,6 +2243,14 @@ static void rcu_test_debug_objects(void)
 #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 }
 
+static void rcutorture_sync(void)
+{
+	static unsigned long n;
+
+	if (cur_ops->sync && !(++n & 0xfff))
+		cur_ops->sync();
+}
+
 static int __init
 rcu_torture_init(void)
 {
@@ -2404,7 +2412,8 @@ rcu_torture_init(void)
 	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
 	if (firsterr)
 		goto unwind;
-	firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval);
+	firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval,
+				      rcutorture_sync);
 	if (firsterr)
 		goto unwind;
 	firsterr = rcu_torture_stall_init();
diff --git a/kernel/torture.c b/kernel/torture.c
index bbf6d473e50c..a03ff722352b 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -75,6 +75,7 @@ static DEFINE_MUTEX(fullstop_mutex);
 static struct task_struct *onoff_task;
 static long onoff_holdoff;
 static long onoff_interval;
+static torture_ofl_func *onoff_f;
 static long n_offline_attempts;
 static long n_offline_successes;
 static unsigned long sum_offline;
@@ -118,6 +119,8 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			pr_alert("%s" TORTURE_FLAG
 				 "torture_onoff task: offlined %d\n",
 				 torture_type, cpu);
+		if (onoff_f)
+			onoff_f();
 		(*n_offl_successes)++;
 		delta = jiffies - starttime;
 		*sum_offl += delta;
@@ -243,11 +246,12 @@ torture_onoff(void *arg)
 /*
  * Initiate online-offline handling.
  */
-int torture_onoff_init(long ooholdoff, long oointerval)
+int torture_onoff_init(long ooholdoff, long oointerval, torture_ofl_func *f)
 {
 #ifdef CONFIG_HOTPLUG_CPU
 	onoff_holdoff = ooholdoff;
 	onoff_interval = oointerval;
+	onoff_f = f;
 	if (onoff_interval <= 0)
 		return 0;
 	return torture_create_kthread(torture_onoff, NULL, onoff_task);
-- 
2.17.1

