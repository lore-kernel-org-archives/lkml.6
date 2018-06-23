Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47F0C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3925724CB5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3925724CB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeFWRr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:47:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751583AbeFWRr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:47:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5NHhuev135378
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 13:47:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jsja7wa9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 13:47:57 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 23 Jun 2018 13:47:55 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 23 Jun 2018 13:47:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5NHlp1G11075850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 23 Jun 2018 17:47:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94F52B2066;
        Sat, 23 Jun 2018 13:47:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD6DB2064;
        Sat, 23 Jun 2018 13:47:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.148.28])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 23 Jun 2018 13:47:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A51C416C9CF6; Sat, 23 Jun 2018 10:49:54 -0700 (PDT)
Date:   Sat, 23 Jun 2018 10:49:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529647926-24427-1-git-send-email-byungchul.park@lge.com>
 <20180622062351.GC17010@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622062351.GC17010@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062317-2213-0000-0000-000002BF07EB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009247; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01051250; UDB=6.00538815; IPR=6.00829908;
 MB=3.00021827; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-23 17:47:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062317-2214-0000-0000-00005A956EDB
Message-Id: <20180623174954.GA3584@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806230211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:23:51PM +0900, Byungchul Park wrote:
> On Fri, Jun 22, 2018 at 03:12:06PM +0900, Byungchul Park wrote:
> > When passing through irq or NMI contexts, the current code uses
> > ->dynticks_nmi_nesting to detect if it's in the ourmost at the moment.
> > 
> > Here, the thing is that all the related functions, rcu_irq_enter(),
> > rcu_nmi_enter(), rcu_irq_exit() and rcu_nmi_exit() are carrying out
> > the check within each under the following call relationship so there
> > must be redundant conditional branches:
> > 
> >    rcu_irq_enter()
> >       /* A conditional branch with ->dynticks_nmi_nesting */
> >       rcu_nmi_enter()
> >          /* A conditional branch with ->dynticks_nmi_nesting */
>                                                ^
>                                   Precisely, ->dynticks
> >       /* A conditional branch with ->dynticks_nmi_nesting */
> > 
> >    rcu_irq_exit()
> >       /* A conditional branch with ->dynticks_nmi_nesting */
> >       rcu_nmi_exit()
> >          /* A conditional branch with ->dynticks_nmi_nesting */
> >       /* A conditional branch with ->dynticks_nmi_nesting */
> > 
> >    rcu_nmi_enter()
> >       /* A conditional branch with ->dynticks_nmi_nesting */
>                                                ^
>                                   Precisely, ->dynticks
> > 
> >    rcu_nmi_exit()
> >       /* A conditional branch with ->dynticks_nmi_nesting */
> > 
> > In order to make the code more readable and remove redundant
> > conditional branches, we need to refactor rcu_{nmi,irq}_{enter,exit}()
> > so they use a common function for each like:
> > 
> >    rcu_irq_enter() inlining rcu_nmi_enter_common(irq)
> >       /* A conditional branch with ->dynticks_nmi_nesting */
>                                                ^
>                                   Precisely, ->dynticks
> > 
> >    rcu_irq_exit() inlining rcu_nmi_exit_common(irq)
> >       /* A conditional branch with ->dynticks_nmi_nesting */
> > 
> >    rcu_nmi_enter() inlining rcu_nmi_enter_common(nmi)
> >       /* A conditional branch with ->dynticks_nmi_nesting */
>                                                ^
>                                   Precisely, ->dynticks
> > 
> >    rcu_nmi_exit() inlining rcu_nmi_exit_common(nmi)
> >       /* A conditional branch with ->dynticks_nmi_nesting */

I queued this for testing and further review, updating the commit log
as follows.  Please let me know if I messed up something.

							Thanx, Paul

------------------------------------------------------------------------

commit 5e5ea52645b197fb7ae2f59f7927079b91e91aa0
Author: Byungchul Park <byungchul.park@lge.com>
Date:   Fri Jun 22 15:12:06 2018 +0900

    rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
    
    When entering or exiting irq or NMI handlers, the current code uses
    ->dynticks_nmi_nesting to detect if it is in the outermost handler,
    that is, the one interrupting or returning to an RCU-idle context (the
    idle loop or nohz_full usermode execution).  When entering the outermost
    handler via an interrupt (as opposed to NMI), it is necessary to invoke
    rcu_dynticks_task_exit() just before the CPU is marked non-idle from an
    RCU perspective and to invoke rcu_cleanup_after_idle() just after the
    CPU is marked non-idle.  Similarly, when exiting the outermost handler
    via an interrupt, it is necessary to invoke rcu_prepare_for_idle() just
    before marking the CPU idle and to invoke rcu_dynticks_task_enter()
    just after marking the CPU idle.
    
    The decision to execute these four functions is currently taken in
    rcu_irq_enter() and rcu_irq_exit() as follows:
    
       rcu_irq_enter()
          /* A conditional branch with ->dynticks_nmi_nesting */
          rcu_nmi_enter()
             /* A conditional branch with ->dynticks */
          /* A conditional branch with ->dynticks_nmi_nesting */
    
       rcu_irq_exit()
          /* A conditional branch with ->dynticks_nmi_nesting */
          rcu_nmi_exit()
             /* A conditional branch with ->dynticks_nmi_nesting */
          /* A conditional branch with ->dynticks_nmi_nesting */
    
       rcu_nmi_enter()
          /* A conditional branch with ->dynticks */
    
       rcu_nmi_exit()
          /* A conditional branch with ->dynticks_nmi_nesting */
    
    This works, but the conditional branches in rcu_irq_enter() and
    rcu_irq_exit() are redundant with those in rcu_nmi_enter() and
    rcu_nmi_exit(), respectively.  Redundant branches are not something
    we want in the to/from-idle fastpaths, so this commit refactors
    rcu_{nmi,irq}_{enter,exit}() so they use a common inlined function passed
    a constant argument as follows:
    
       rcu_irq_enter() inlining rcu_nmi_enter_common(irq=true)
          /* A conditional branch with ->dynticks */
    
       rcu_irq_exit() inlining rcu_nmi_exit_common(irq=true)
          /* A conditional branch with ->dynticks_nmi_nesting */
    
       rcu_nmi_enter() inlining rcu_nmi_enter_common(irq=false)
          /* A conditional branch with ->dynticks */
    
       rcu_nmi_exit() inlining rcu_nmi_exit_common(irq=false)
          /* A conditional branch with ->dynticks_nmi_nesting */
    
    The combination of the constant function argument and the inlining allows
    the compiler to discard the conditionals that previously controlled
    execution of rcu_dynticks_task_exit(), rcu_cleanup_after_idle(),
    rcu_prepare_for_idle(), and rcu_dynticks_task_enter().  This reduces both
    the to-idle and from-idle path lengths by two conditional branches each,
    and improves readability as well.
    
    Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Signed-off-by: Byungchul Park <byungchul.park@lge.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8788ddbc0d13..4ed74f10c852 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -773,17 +773,17 @@ void rcu_user_enter(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_exit - inform RCU of exit from NMI context
+ * rcu_nmi_exit_common - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
  * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
+ * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_exit(void)
+static __always_inline void rcu_nmi_exit_common(bool irq)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 
@@ -809,7 +809,22 @@ void rcu_nmi_exit(void)
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
 	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
 	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+
+	if (irq)
+		rcu_prepare_for_idle();
+
 	rcu_dynticks_eqs_enter();
+
+	if (irq)
+		rcu_dynticks_task_enter();
+}
+
+/**
+ * rcu_nmi_exit - inform RCU of exit from NMI context
+ */
+void rcu_nmi_exit(void)
+{
+	rcu_nmi_exit_common(false);
 }
 
 /**
@@ -833,14 +848,8 @@ void rcu_nmi_exit(void)
  */
 void rcu_irq_exit(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_prepare_for_idle();
-	rcu_nmi_exit();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_enter();
+	rcu_nmi_exit_common(true);
 }
 
 /*
@@ -923,7 +932,7 @@ void rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter - inform RCU of entry to NMI context
+ * rcu_nmi_enter_common - inform RCU of entry to NMI context
  *
  * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
  * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
@@ -931,10 +940,10 @@ void rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter(), be sure to test
+ * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_enter(void)
+static __always_inline void rcu_nmi_enter_common(bool irq)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	long incby = 2;
@@ -951,7 +960,15 @@ void rcu_nmi_enter(void)
 	 * period (observation due to Andy Lutomirski).
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
+
+		if (irq)
+			rcu_dynticks_task_exit();
+
 		rcu_dynticks_eqs_exit();
+
+		if (irq)
+			rcu_cleanup_after_idle();
+
 		incby = 1;
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
@@ -962,6 +979,14 @@ void rcu_nmi_enter(void)
 	barrier();
 }
 
+/**
+ * rcu_nmi_enter - inform RCU of entry to NMI context
+ */
+void rcu_nmi_enter(void)
+{
+	rcu_nmi_enter_common(false);
+}
+
 /**
  * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
  *
@@ -986,14 +1011,8 @@ void rcu_nmi_enter(void)
  */
 void rcu_irq_enter(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_exit();
-	rcu_nmi_enter();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_cleanup_after_idle();
+	rcu_nmi_enter_common(true);
 }
 
 /*

