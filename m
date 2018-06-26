Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E903126368
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E903126368
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935286AbeFZAgm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:36:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934579AbeFZAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:33:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0ShT8130793
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96qbexq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:33:15 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:33:12 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0XBm010552044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:33:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1E56B2071;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3695B2067;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 13D1D16CA0A3; Mon, 25 Jun 2018 17:35:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 17/27] rcu: Speed up calling of RCU tasks callbacks
Date:   Mon, 25 Jun 2018 17:35:03 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626003448.GA26209@linux.vnet.ibm.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0072-0000-0000-000003747617
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539469; IPR=6.00830262;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:33:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0073-0000-0000-0000487C730B
Message-Id: <20180626003513.27812-17-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Joel Fernandes found that the synchronize_rcu_tasks() was taking a
significant amount of time. He demonstrated it with the following test:

 # cd /sys/kernel/tracing
 # while [ 1 ]; do x=1; done &
 # echo '__schedule_bug:traceon' > set_ftrace_filter
 # time echo '!__schedule_bug:traceon' > set_ftrace_filter;

real	0m1.064s
user	0m0.000s
sys	0m0.004s

Where it takes a little over a second to perform the synchronize,
because there's a loop that waits 1 second at a time for tasks to get
through their quiescent points when there's a task that must be waited
for.

After discussion we came up with a simple way to wait for holdouts but
increase the time for each iteration of the loop but no more than a
full second.

With the new patch we have:

 # time echo '!__schedule_bug:traceon' > set_ftrace_filter;

real	0m0.131s
user	0m0.000s
sys	0m0.004s

Which drops it down to 13% of what the original wait time was.

Link: http://lkml.kernel.org/r/20180523063815.198302-2-joel@joelfernandes.org
Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/update.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 5783bdf86e5a..4c7c49c106ee 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -668,6 +668,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	struct rcu_head *list;
 	struct rcu_head *next;
 	LIST_HEAD(rcu_tasks_holdouts);
+	int fract;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
 	housekeeping_affine(current, HK_FLAG_RCU);
@@ -749,13 +750,25 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 * holdouts.  When the list is empty, we are done.
 		 */
 		lastreport = jiffies;
-		while (!list_empty(&rcu_tasks_holdouts)) {
+
+		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
+		fract = 10;
+
+		for (;;) {
 			bool firstreport;
 			bool needreport;
 			int rtst;
 			struct task_struct *t1;
 
-			schedule_timeout_interruptible(HZ);
+			if (list_empty(&rcu_tasks_holdouts))
+				break;
+
+			/* Slowly back off waiting for holdouts */
+			schedule_timeout_interruptible(HZ/fract);
+
+			if (fract > 1)
+				fract--;
+
 			rtst = READ_ONCE(rcu_task_stall_timeout);
 			needreport = rtst > 0 &&
 				     time_after(jiffies, lastreport + rtst);
-- 
2.17.1

