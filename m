Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE7CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7209F26E67
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7209F26E67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeFZRMb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:12:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932131AbeFZRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4Jbi064446
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqhsxhuv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:53 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:51 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8jrL1311212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC880B2068;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4BB2B2067;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DE77816CA0AC; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 17/22] rcutorture: Change units of onoff_interval to jiffies
Date:   Tue, 26 Jun 2018 10:10:43 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0064-0000-0000-00000320971E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539668; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0065-0000-0000-000039B968CA
Message-Id: <20180626171048.2181-17-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RCU bugs have been sensitive to the frequency of CPU-hotplug
operations, which have been gradually increased over time.  But this
frequency is now at the one-second lower limit that can be specified using
the rcutorture.onoff_interval kernel parameter.  This commit therefore
changes the units of rcutorture.onoff_interval from seconds to jiffies,
and also sets the value specified for this kernel parameter in the TREE03
rcutorture scenario to 200, which is 200 milliseconds for HZ=1000.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt               | 4 ++--
 kernel/rcu/rcutorture.c                                       | 4 ++--
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot    | 2 +-
 .../testing/selftests/rcutorture/configs/rcu/ver_functions.sh | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..77bd3e635313 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3632,8 +3632,8 @@
 			Set time (s) after boot for CPU-hotplug testing.
 
 	rcutorture.onoff_interval= [KNL]
-			Set time (s) between CPU-hotplug operations, or
-			zero to disable CPU-hotplug testing.
+			Set time (jiffies) between CPU-hotplug operations,
+			or zero to disable CPU-hotplug testing.
 
 	rcutorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (s).  Shuffling tasks
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0481c7286875..eb6d4915b4e6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -87,7 +87,7 @@ torture_param(int, object_debug, 0,
 	     "Enable debug-object double call_rcu() testing");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0,
-	     "Time between CPU hotplugs (s), 0=disable");
+	     "Time between CPU hotplugs (jiffies), 0=disable");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
@@ -1889,7 +1889,7 @@ rcu_torture_init(void)
 	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
 	if (firsterr)
 		goto unwind;
-	firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval * HZ);
+	firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval);
 	if (firsterr)
 		goto unwind;
 	firsterr = rcu_torture_stall_init();
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index b79ddb9eb9e8..5c3213cc3ad7 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -1,4 +1,4 @@
-rcutorture.onoff_interval=1 rcutorture.onoff_holdoff=30
+rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30
 rcutree.gp_preinit_delay=12
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
index 24ec91041957..7bab8246392b 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcu/ver_functions.sh
@@ -39,7 +39,7 @@ rcutorture_param_onoff () {
 	if ! bootparam_hotplug_cpu "$1" && configfrag_hotplug_cpu "$2"
 	then
 		echo CPU-hotplug kernel, adding rcutorture onoff. 1>&2
-		echo rcutorture.onoff_interval=3 rcutorture.onoff_holdoff=30
+		echo rcutorture.onoff_interval=1000 rcutorture.onoff_holdoff=30
 	fi
 }
 
-- 
2.17.1

