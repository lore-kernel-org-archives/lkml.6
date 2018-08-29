Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A66C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629A620647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629A620647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeH3CxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727573AbeH3CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMsCIs028327
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m627rcvbd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:13 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs78s38076562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A844B2070;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 389F3B2066;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 682C816C91CA; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 06/24] rcu: Stop testing RCU-bh and RCU-sched
Date:   Wed, 29 Aug 2018 15:53:47 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331BA5C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F1C56
Message-Id: <20180829225405.7275-6-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the RCU-bh and RCU-sched update-side functions are simple
wrappers around their RCU counterparts, there isn't a whole lot of
point in testing them.  This commit therefore removes the self-test
capability and removes the corresponding kernel-boot parameters.
It also updates the various rcutorture .boot files to remove the
kernel boot parameters that call for testing RCU-bh and RCU-sched.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ---
 kernel/rcu/update.c                           | 38 +------------------
 .../rcutorture/configs/rcu/TINY02.boot        |  2 -
 .../rcutorture/configs/rcu/TREE01.boot        |  2 +-
 .../rcutorture/configs/rcu/TREE04.boot        |  2 +-
 .../rcutorture/configs/rcu/TREE05.boot        |  2 -
 .../rcutorture/configs/rcu/TREE06.boot        |  2 -
 .../rcutorture/configs/rcu/TREE08.boot        |  2 -
 8 files changed, 3 insertions(+), 53 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..aa96e669bcb8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3863,12 +3863,6 @@
 	rcupdate.rcu_self_test= [KNL]
 			Run the RCU early boot self tests
 
-	rcupdate.rcu_self_test_bh= [KNL]
-			Run the RCU bh early boot self tests
-
-	rcupdate.rcu_self_test_sched= [KNL]
-			Run the RCU sched early boot self tests
-
 	rdinit=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /init from the ramdisk,
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 9ea87d0aa386..ee366faecea6 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -203,11 +203,7 @@ void rcu_test_sync_prims(void)
 	if (!IS_ENABLED(CONFIG_PROVE_RCU))
 		return;
 	synchronize_rcu();
-	synchronize_rcu_bh();
-	synchronize_sched();
 	synchronize_rcu_expedited();
-	synchronize_rcu_bh_expedited();
-	synchronize_sched_expedited();
 }
 
 #if !defined(CONFIG_TINY_RCU) || defined(CONFIG_SRCU)
@@ -870,15 +866,10 @@ static void __init rcu_tasks_bootup_oddness(void)
 #ifdef CONFIG_PROVE_RCU
 
 /*
- * Early boot self test parameters, one for each flavor
+ * Early boot self test parameters.
  */
 static bool rcu_self_test;
-static bool rcu_self_test_bh;
-static bool rcu_self_test_sched;
-
 module_param(rcu_self_test, bool, 0444);
-module_param(rcu_self_test_bh, bool, 0444);
-module_param(rcu_self_test_sched, bool, 0444);
 
 static int rcu_self_test_counter;
 
@@ -895,30 +886,12 @@ static void early_boot_test_call_rcu(void)
 	call_rcu(&head, test_callback);
 }
 
-static void early_boot_test_call_rcu_bh(void)
-{
-	static struct rcu_head head;
-
-	call_rcu_bh(&head, test_callback);
-}
-
-static void early_boot_test_call_rcu_sched(void)
-{
-	static struct rcu_head head;
-
-	call_rcu_sched(&head, test_callback);
-}
-
 void rcu_early_boot_tests(void)
 {
 	pr_info("Running RCU self tests\n");
 
 	if (rcu_self_test)
 		early_boot_test_call_rcu();
-	if (rcu_self_test_bh)
-		early_boot_test_call_rcu_bh();
-	if (rcu_self_test_sched)
-		early_boot_test_call_rcu_sched();
 	rcu_test_sync_prims();
 }
 
@@ -931,15 +904,6 @@ static int rcu_verify_early_boot_tests(void)
 		early_boot_test_counter++;
 		rcu_barrier();
 	}
-	if (rcu_self_test_bh) {
-		early_boot_test_counter++;
-		rcu_barrier_bh();
-	}
-	if (rcu_self_test_sched) {
-		early_boot_test_counter++;
-		rcu_barrier_sched();
-	}
-
 	if (rcu_self_test_counter != early_boot_test_counter) {
 		WARN_ON(1);
 		ret = -1;
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINY02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TINY02.boot
index 6c1a292a65fb..b39f1553a478 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TINY02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINY02.boot
@@ -1,3 +1 @@
 rcupdate.rcu_self_test=1
-rcupdate.rcu_self_test_bh=1
-rcutorture.torture_type=rcu_bh
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index 9f3a4d28e508..ea47da95374b 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -1,4 +1,4 @@
-rcutorture.torture_type=rcu_bh maxcpus=8 nr_cpus=43
+maxcpus=8 nr_cpus=43
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
index e6071bb96c7d..5adc6756792a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
@@ -1 +1 @@
-rcutorture.torture_type=rcu_bh rcutree.rcu_fanout_leaf=4 nohz_full=1-7
+rcutree.rcu_fanout_leaf=4 nohz_full=1-7
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
index c7fd050dfcd9..779f1aed4606 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
@@ -1,5 +1,3 @@
-rcutorture.torture_type=sched
-rcupdate.rcu_self_test_sched=1
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE06.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE06.boot
index ad18b52a2cad..055f4aa79077 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE06.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE06.boot
@@ -1,6 +1,4 @@
 rcupdate.rcu_self_test=1
-rcupdate.rcu_self_test_bh=1
-rcupdate.rcu_self_test_sched=1
 rcutree.rcu_fanout_exact=1
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
index 1bd8efc4141e..22478fd3a865 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
@@ -1,5 +1,3 @@
-rcutorture.torture_type=sched
 rcupdate.rcu_self_test=1
-rcupdate.rcu_self_test_sched=1
 rcutree.rcu_fanout_exact=1
 rcu_nocbs=0-7
-- 
2.17.1

