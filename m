Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D38C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF942148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF942148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeKLFdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:33:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbeKLFdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:33:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJiAsi168571
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:18 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdfdhh9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:18 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:44:18 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:44:14 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJiD7p40632332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:44:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34387B2071;
        Sun, 11 Nov 2018 19:44:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1361CB2066;
        Sun, 11 Nov 2018 19:44:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:44:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D7C9216C5DAB; Sun, 11 Nov 2018 11:44:12 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-mm@kvack.org
Subject: [PATCH tip/core/rcu 19/41] main: Replace rcu_barrier_sched() with rcu_barrier()
Date:   Sun, 11 Nov 2018 11:43:48 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0052-0000-0000-00000354224B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116019; UDB=6.00578733; IPR=6.00896119;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:44:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0053-0000-0000-00005EBB219B
Message-Id: <20181111194410.6368-19-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all RCU flavors have been consolidated, rcu_barrier_sched()
is but a synonym for rcu_barrier().  This commit therefore replaces
the former with the latter.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <linux-mm@kvack.org>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index ee147103ba1b..a45486330243 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1046,12 +1046,12 @@ static void mark_readonly(void)
 {
 	if (rodata_enabled) {
 		/*
-		 * load_module() results in W+X mappings, which are cleaned up
-		 * with call_rcu_sched().  Let's make sure that queued work is
+		 * load_module() results in W+X mappings, which are cleaned
+		 * up with call_rcu().  Let's make sure that queued work is
 		 * flushed so that we don't hit false positives looking for
 		 * insecure pages which are W+X.
 		 */
-		rcu_barrier_sched();
+		rcu_barrier();
 		mark_rodata_ro();
 		rodata_test();
 	} else
-- 
2.17.1

