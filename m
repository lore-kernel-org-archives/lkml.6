Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2381BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE64C20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbeLQE0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:26:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbeLQE0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:26:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBH4IvQQ081829
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:26:29 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pe20a552r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:26:28 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 17 Dec 2018 04:26:27 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 04:26:22 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBH4QLEj19857568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 04:26:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1841DB2065;
        Mon, 17 Dec 2018 04:26:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4CD3B2067;
        Mon, 17 Dec 2018 04:26:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 17 Dec 2018 04:26:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4F3B916C3492; Sun, 16 Dec 2018 20:26:23 -0800 (PST)
Date:   Sun, 16 Dec 2018 20:26:23 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "He, Bo" <bo.he@intel.com>
Cc:     "Zhang, Jun" <jun.zhang@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        "Bai, Jie A" <jie.a.bai@intel.com>,
        "Sun, Yi J" <yi.j.sun@intel.com>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "Mei, Paul" <paul.mei@intel.com>
Subject: Re: rcu_preempt caused oom
Reply-To: paulmck@linux.ibm.com
References: <88DC34334CA3444C85D647DBFA962C2735AD5F9E@SHSMSX104.ccr.corp.intel.com>
 <20181213044020.GA19765@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A197EC@SHSMSX104.ccr.corp.intel.com>
 <20181213181136.GL4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A198C7@SHSMSX104.ccr.corp.intel.com>
 <20181214021527.GR4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A19939@SHSMSX104.ccr.corp.intel.com>
 <20181214051011.GS4170@linux.ibm.com>
 <20181214053841.GA16100@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A1A280@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A1A280@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121704-2213-0000-0000-0000032C0BAA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010239; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01132908; UDB=6.00588893; IPR=6.00913047;
 MB=3.00024714; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-17 04:26:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121704-2214-0000-0000-00005CA18A50
Message-Id: <20181217042623.GF4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:15:42AM +0000, He, Bo wrote:
> for double confirm the issue is not reproduce after 90 hours, we tried only add the enclosed patch on the easy reproduced build, the issue is not reproduced after 63 hours in the whole weekend on 16 boards.
> so current conclusion is the debug patch has extreme  effect on the rcu issue.

This is not a surprise.  (Please see the end of this email for a
replacement patch that won't suppress the bug.)

To see why this is not a surprise, let's take a closer look at your patch,
in light of the comment header for wait_event_idle_timeout_exclusive():

 * Returns:
 * 0 if the @condition evaluated to %false after the @timeout elapsed,
 * 1 if the @condition evaluated to %true after the @timeout elapsed,
 * or the remaining jiffies (at least 1) if the @condition evaluated
 * to %true before the @timeout elapsed.

The situation we are seeing is that the RCU_GP_FLAG_INIT is set, but
the rcu_preempt task does not wake up.  This would correspond to
the second case above, that is, a return value of 1.  Looking now
at your patch, with comments interspersed below:

------------------------------------------------------------------------

From e8b583aa685b3b4f304f72398a80461bba09389c Mon Sep 17 00:00:00 2001
From: "he, bo" <bo.he@intel.com>
Date: Sun, 9 Dec 2018 18:11:33 +0800
Subject: [PATCH] rcu: detect the preempt_rcu hang for triage jing's board

Change-Id: I2ffceec2ae4847867753609e45c99afc66956003
Tracked-On:
Signed-off-by: he, bo <bo.he@intel.com>
---
 kernel/rcu/tree.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 78c0cf2..d6de363 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2192,8 +2192,13 @@ static int __noreturn rcu_gp_kthread(void *arg)
 	int ret;
 	struct rcu_state *rsp = arg;
 	struct rcu_node *rnp = rcu_get_root(rsp);
+	pid_t rcu_preempt_pid;
 
 	rcu_bind_gp_kthread();
+	if(!strcmp(rsp->name, "rcu_preempt")) {
+		rcu_preempt_pid = rsp->gp_kthread->pid;
+	}
+
 	for (;;) {
 
 		/* Handle grace-period start. */
@@ -2202,8 +2207,19 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gp_seq),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
-			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
-						     RCU_GP_FLAG_INIT);
+			if (current->pid != rcu_preempt_pid) {
+				swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT);
+			} else {
+				ret = swait_event_idle_timeout_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT, 2*HZ);
+
+				if(!ret) {

We get here if ret==0.  Therefore, the above "if" statement needs to
instead be "if (ret == 1) {".

In addition, in order to get event traces dumped, we also need:

					rcu_ftrace_dump(DUMP_ALL);

+					show_rcu_gp_kthreads();
+					panic("hung_task: blocked in rcu_gp_kthread init");
+				}
+			}
+
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init(rsp))
-- 
2.7.4

------------------------------------------------------------------------

So, again, please change the "if(!ret) {" to "if (ret == 1) {", and
please add "rcu_ftrace_dump(DUMP_ALL);" right after this "if" statement,
as shown above.

With that change, I bet that you will again see failures.

> Compared with the swait_event_idle_timeout_exclusive will do 3 times to check the condition, while swait_event_idle_ exclusive will do 2 times check the condition.
> 
> so today I will do another experiment, only change as below:
> -			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
> -						     RCU_GP_FLAG_INIT);
> +			ret = swait_event_idle_timeout_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
> +					RCU_GP_FLAG_INIT, MAX_SCHEDULE_TIMEOUT);
> +
> 
> Can you get some clues from the experiment?

Again, please instead make the changes that I called out above, with
the replacement for your patch 0001 shown below.

							Thanx, Paul

PS.  I have been testing for quite some time, but am still unable
     to reproduce this.  So we must depend on you to reproduce it.

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b760c1369f7..86152af1a580 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2153,8 +2153,13 @@ static int __noreturn rcu_gp_kthread(void *arg)
 	int ret;
 	struct rcu_state *rsp = arg;
 	struct rcu_node *rnp = rcu_get_root(rsp);
+	pid_t rcu_preempt_pid;
 
 	rcu_bind_gp_kthread();
+	if(!strcmp(rsp->name, "rcu_preempt")) {
+		rcu_preempt_pid = rsp->gp_kthread->pid;
+	}
+
 	for (;;) {
 
 		/* Handle grace-period start. */
@@ -2163,8 +2168,20 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       READ_ONCE(rsp->gp_seq),
 					       TPS("reqwait"));
 			rsp->gp_state = RCU_GP_WAIT_GPS;
-			swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
-						     RCU_GP_FLAG_INIT);
+			if (current->pid != rcu_preempt_pid) {
+				swait_event_idle_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT);
+			} else {
+				ret = swait_event_idle_timeout_exclusive(rsp->gp_wq, READ_ONCE(rsp->gp_flags) &
+						RCU_GP_FLAG_INIT, 2*HZ);
+
+				if (ret == 1) {
+					rcu_ftrace_dump(DUMP_ALL);
+					show_rcu_gp_kthreads();
+					panic("hung_task: blocked in rcu_gp_kthread init");
+				}
+			}
+
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init(rsp))

