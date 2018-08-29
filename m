Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388A72064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388A72064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeH3Cy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:54:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727490AbeH3CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs1jP003172
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61jbxhck-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:13 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs8rp46989356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE6A3B2064;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA07DB205F;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C403716C91DC; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 22/24] rcu: Remove !PREEMPT code from rcu_note_voluntary_context_switch()
Date:   Wed, 29 Aug 2018 15:54:03 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0060-0000-0000-000002A66512
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860735;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0061-0000-0000-00004655BC84
Message-Id: <20180829225405.7275-22-paulmck@linux.vnet.ibm.com>
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

Because RCU-tasks exists only in PREEMPT kernels and because RCU-sched
no longer exists in PREEMPT kernels, it is no longer necessary for the
rcu_note_voluntary_context_switch() macro to do anything for !PREEMPT
kernels.  This commit therefore removes !PREEMPT-related code from
this macro, namely, the rcu_all_qs().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d6d543b60a9f..e4f821165d0b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -150,18 +150,14 @@ static inline void rcu_init_nohz(void) { }
 		if (READ_ONCE((t)->rcu_tasks_holdout)) \
 			WRITE_ONCE((t)->rcu_tasks_holdout, false); \
 	} while (0)
-#define rcu_note_voluntary_context_switch(t) \
-	do { \
-		rcu_all_qs(); \
-		rcu_tasks_qs(t); \
-	} while (0)
+#define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU */
 #define rcu_tasks_qs(t)	do { } while (0)
-#define rcu_note_voluntary_context_switch(t)		rcu_all_qs()
+#define rcu_note_voluntary_context_switch(t) do { } while (0)
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
-- 
2.17.1

