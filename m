Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B409C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03F026A2A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03F026A2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeFZVgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:36:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752175AbeFZVgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:36:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QLYNgX045426
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 17:36:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jutw9pc34-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 17:36:53 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 17:36:51 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 17:36:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QLajxU7274756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 21:36:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96EF5B2064;
        Tue, 26 Jun 2018 17:36:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FB77B2065;
        Tue, 26 Jun 2018 17:36:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 17:36:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B597716CA1A4; Tue, 26 Jun 2018 14:38:50 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:38:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 06/27] rcu: Mark task as .need_qs less
 aggressively
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-6-paulmck@linux.vnet.ibm.com>
 <20180626170812.GH2494@hirez.programming.kicks-ass.net>
 <20180626180303.GD3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626180303.GD3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062621-0072-0000-0000-00000374DFDB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009260; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052758; UDB=6.00539722; IPR=6.00830682;
 MB=3.00021869; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 21:36:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062621-0073-0000-0000-0000487EFECD
Message-Id: <20180626213850.GA18033@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:03:03AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 26, 2018 at 07:08:12PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 25, 2018 at 05:34:52PM -0700, Paul E. McKenney wrote:
> > > If any scheduling-clock interrupt interrupts an RCU-preempt read-side
> > > critical section, the interrupted task's ->rcu_read_unlock_special.b.need_qs
> > > field is set.  This causes the outermost rcu_read_unlock() to incur the
> > > extra overhead of calling into rcu_read_unlock_special().  This commit
> > > reduces that overhead by setting ->rcu_read_unlock_special.b.need_qs only
> > > if the grace period has been in effect for more than one second.
> > 
> > Even less agressive is never setting it at all.
> 
> True, but if the CPU has been in an RCU read-side critical section for
> a full second (which is the case with high probability when .b.need_qs
> is set after this change), we might want to respond to the end of that
> critical section sooner rather than later.
> 
> > Changelog fails to explain why not setting it every tick is correct, nor
> > why 1s is a 'safe' value to use.
> 
> The RCU CPU stall warning cannot be set to less than 3s, so 1s is
> reasonable.  It is a tradeoff -- setting it lower causes a greater
> fraction of RCU read-side critical sections to incur extra overhead at
> rcu_read_unlock() time, while setting it higher keeps a lazy approach
> to reporting the quiescent state to core RCU for longer critical sections.
> 
> The upcoming RCU-bh/RCU-preempt/RCU-sched consolidation will raise
> contention and overhead, so this is one of several things done to
> lower overhead and contention to compensate for that.

And does the following updated commit log help?

							Thanx, Paul

------------------------------------------------------------------------

commit aaf8af680740afc363583a6ed9549b08b613dd3d
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed May 16 14:41:41 2018 -0700

    rcu: Mark task as .need_qs less aggressively
    
    If any scheduling-clock interrupt interrupts an RCU-preempt read-side
    critical section, the interrupted task's ->rcu_read_unlock_special.b.need_qs
    field is set.  This causes the outermost rcu_read_unlock() to incur the
    extra overhead of calling into rcu_read_unlock_special().  This commit
    reduces that overhead by setting ->rcu_read_unlock_special.b.need_qs only
    if the grace period has been in effect for more than one second.
    
    Why one second?  Because this is comfortably smaller than the minimum
    RCU CPU stall-warning timeout of three seconds, but long enough that the
    .need_qs marking should happen quite rarely.  And if your RCU read-side
    critical section has run on-CPU for a full second, it is not unreasonable
    to invest some CPU time in ending the grace period quickly.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dbfe90191e19..0239cf8a4be6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -730,6 +730,7 @@ rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
  */
 static void rcu_preempt_check_callbacks(void)
 {
+	struct rcu_state *rsp = &rcu_preempt_state;
 	struct task_struct *t = current;
 
 	if (t->rcu_read_lock_nesting == 0) {
@@ -738,7 +739,9 @@ static void rcu_preempt_check_callbacks(void)
 	}
 	if (t->rcu_read_lock_nesting > 0 &&
 	    __this_cpu_read(rcu_data_p->core_needs_qs) &&
-	    __this_cpu_read(rcu_data_p->cpu_no_qs.b.norm))
+	    __this_cpu_read(rcu_data_p->cpu_no_qs.b.norm) &&
+	    !t->rcu_read_unlock_special.b.need_qs &&
+	    time_after(jiffies, rsp->gp_start + HZ))
 		t->rcu_read_unlock_special.b.need_qs = true;
 }
 

