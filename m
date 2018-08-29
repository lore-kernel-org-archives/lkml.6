Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CB620684
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CB620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeH3Br2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:47:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727390AbeH3Bqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:46:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TLcpmU121201
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:59 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61rcvc9t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:47:59 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 17:47:58 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 17:47:53 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TLlrF946530588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 21:47:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F14BAB2065;
        Wed, 29 Aug 2018 17:46:48 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D262EB205F;
        Wed, 29 Aug 2018 17:46:48 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 17:46:48 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DED6916C91D7; Wed, 29 Aug 2018 14:47:51 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 16/17] rcutorture: Check GP completion at stutter end
Date:   Wed, 29 Aug 2018 14:47:49 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829214722.GA23411@linux.vnet.ibm.com>
References: <20180829214722.GA23411@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082921-0052-0000-0000-000003281C84
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080727; UDB=6.00557487; IPR=6.00860713;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 21:47:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082921-0053-0000-0000-00005DE5E2B9
Message-Id: <20180829214750.26972-16-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_torture_writer() function invokes stutter_wait() at the end of
each writer pass, which occasionally blocks for an extended time period
in order to ensure that RCU can handle intermittent loads.  But part of
handling a busy period is invoking all the callbacks before the end of
the idle period induced by stutter_wait().

This commit therefore adds a return value to stutter_wait() indicating
whether stutter_wait() actually waited.  In addition, this commit causes
rcu_torture_writer() to test this value and if set, checks that all the
elements of the rcu_tortures[] array have been freed up.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/torture.h | 2 +-
 kernel/rcu/rcutorture.c | 5 ++++-
 kernel/torture.c        | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 61dfd93b6ee4..48fad21109fc 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -77,7 +77,7 @@ void torture_shutdown_absorb(const char *title);
 int torture_shutdown_init(int ssecs, void (*cleanup)(void));
 
 /* Task stuttering, which forces load/no-load transitions. */
-void stutter_wait(const char *title);
+bool stutter_wait(const char *title);
 int torture_stutter_init(int s);
 
 /* Initialization and cleanup. */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7df8142a6a22..ae10ad531993 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1144,7 +1144,10 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		stutter_wait("rcu_torture_writer");
+		if (stutter_wait("rcu_torture_writer"))
+			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
+				if (list_empty(&rcu_tortures[i].rtort_free))
+					WARN_ON_ONCE(1);
 	} while (!torture_must_stop());
 	/* Reset expediting back to unexpedited. */
 	if (expediting > 0)
diff --git a/kernel/torture.c b/kernel/torture.c
index 1ac24a826589..17d91f5fba2a 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -573,7 +573,7 @@ static int stutter;
  * Block until the stutter interval ends.  This must be called periodically
  * by all running kthreads that need to be subject to stuttering.
  */
-void stutter_wait(const char *title)
+bool stutter_wait(const char *title)
 {
 	int spt;
 
@@ -590,6 +590,7 @@ void stutter_wait(const char *title)
 		}
 		torture_shutdown_absorb(title);
 	}
+	return !!spt;
 }
 EXPORT_SYMBOL_GPL(stutter_wait);
 
-- 
2.17.1

