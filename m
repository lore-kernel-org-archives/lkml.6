Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E5FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E25625C40
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E25625C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeFZRNs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:13:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753130AbeFZRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4K1B064531
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqhsxhsx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:50 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8i8h6619616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52FE2B2072;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37FCCB2068;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A89F216CA0A2; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/22] rcu: Prevent useless FQS scan after all CPUs have checked in
Date:   Tue, 26 Jun 2018 10:10:33 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0040-0000-0000-000004457964
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539669; IPR=6.00830592;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0041-0000-0000-0000084B8FC0
Message-Id: <20180626171048.2181-7-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=715 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The force_qs_rnp() function checks for ->qsmask being all zero, that is,
all CPUs for the current rcu_node structure having already passed through
quiescent states.  But with RCU-preempt, this is not sufficient to report
quiescent states further up the tree, so there are further checks that
can initiate RCU priority boosting and also for races with CPU-hotplug
operations.  However, if neither of these further checks apply, the code
proceeds to carry out a useless scan of an all-zero ->qsmask.

This commit therefore adds code to release the current rcu_node
structure's lock and continue on to the next rcu_node structure, thereby
avoiding this useless scan.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 78dd96e8ce3e..324ca1b2b233 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2672,6 +2672,8 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 				/* rcu_report_unblock_qs_rnp() rlses ->lock */
 				continue;
 			}
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+			continue;
 		}
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
-- 
2.17.1

