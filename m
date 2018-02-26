Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeBZWC3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751823AbeBZWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:21 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 12/12] torture: Provide more sensible nreader/nwriter defaults for rcuperf
Date: Mon, 26 Feb 2018 14:02:41 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0008-0000-0000-000002DB9DD4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0009-0000-0000-00003864E994
Message-Id: <1519682561-510-12-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default values for nreader and nwriter are apparently not all that
user-friendly, resulting in people doing scalability tests that ran all
runs at large scale.  This commit therefore makes both the nreaders and
nwriters module default to the number of CPUs, and adds a comment to
rcuperf.c stating that the number of CPUs should be specified using the
nr_cpus kernel boot parameter.  This commit also eliminates the redundant
rcuperf scripting specification of default values for these parameters.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcuperf.c                               | 21 ++++++++++++++++++-
 .../rcutorture/configs/rcuperf/ver_functions.sh    | 24 +---------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index d1ebdf9868bb..777e7a6a0292 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -61,11 +61,30 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.vnet.ibm.com>");
 #define VERBOSE_PERFOUT_ERRSTRING(s) \
 	do { if (verbose) pr_alert("%s" PERF_FLAG "!!! %s\n", perf_type, s); } while (0)
 
+/*
+ * The intended use cases for the nreaders and nwriters module parameters
+ * are as follows:
+ *
+ * 1.	Specify only the nr_cpus kernel boot parameter.  This will
+ *	set both nreaders and nwriters to the value specified by
+ *	nr_cpus for a mixed reader/writer test.
+ *
+ * 2.	Specify the nr_cpus kernel boot parameter, but set
+ *	rcuperf.nreaders to zero.  This will set nwriters to the
+ *	value specified by nr_cpus for an update-only test.
+ *
+ * 3.	Specify the nr_cpus kernel boot parameter, but set
+ *	rcuperf.nwriters to zero.  This will set nreaders to the
+ *	value specified by nr_cpus for a read-only test.
+ *
+ * Various other use cases may of course be specified.
+ */
+
 torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
 torture_param(int, gp_async_max, 1000, "Max # outstanding waits per reader");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
-torture_param(int, nreaders, 0, "Number of RCU reader threads");
+torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, nwriters, -1, "Number of RCU updater threads");
 torture_param(bool, shutdown, !IS_ENABLED(MODULE),
 	      "Shutdown at end of performance tests.");
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
index b9603115d7c7..d36b8fd6f0fc 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
@@ -20,32 +20,10 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
 
-# rcuperf_param_nreaders bootparam-string
-#
-# Adds nreaders rcuperf module parameter if not already specified.
-rcuperf_param_nreaders () {
-	if ! echo "$1" | grep -q "rcuperf.nreaders"
-	then
-		echo rcuperf.nreaders=-1
-	fi
-}
-
-# rcuperf_param_nwriters bootparam-string
-#
-# Adds nwriters rcuperf module parameter if not already specified.
-rcuperf_param_nwriters () {
-	if ! echo "$1" | grep -q "rcuperf.nwriters"
-	then
-		echo rcuperf.nwriters=-1
-	fi
-}
-
 # per_version_boot_params bootparam-string config-file seconds
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 `rcuperf_param_nreaders "$1"` \
-		`rcuperf_param_nwriters "$1"` \
-		rcuperf.shutdown=1 \
+	echo $1 rcuperf.shutdown=1 \
 		rcuperf.verbose=1
 }
-- 
2.5.2
