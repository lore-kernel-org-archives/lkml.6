Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E752C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B22E2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B22E2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeKCEwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:52:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbeKCEwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:52:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2JdVK4169745
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 15:44:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ngvwh05s3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 15:44:03 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Nov 2018 19:44:02 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 19:43:56 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2JhtCf28901592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 19:43:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A5CEB2066;
        Fri,  2 Nov 2018 19:43:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66605B205F;
        Fri,  2 Nov 2018 19:43:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 19:43:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8C9E016C2ABB; Fri,  2 Nov 2018 12:43:56 -0700 (PDT)
Date:   Fri, 2 Nov 2018 12:43:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ran Rozenstein <ranro@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH tip/core/rcu 02/19] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Reply-To: paulmck@linux.ibm.com
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-2-paulmck@linux.vnet.ibm.com>
 <AM4PR0501MB27691ECD1B0ECB0531B16F20C5F30@AM4PR0501MB2769.eurprd05.prod.outlook.com>
 <20181029142735.GZ4170@linux.ibm.com>
 <20181030034452.GA224709@google.com>
 <20181030125800.GE4170@linux.ibm.com>
 <20181030222123.GB44036@joelaf.mtv.corp.google.com>
 <20181031182259.GH4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031182259.GH4170@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110219-0072-0000-0000-000003C209C7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009973; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111712; UDB=6.00576144; IPR=6.00891803;
 MB=3.00024008; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 19:44:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110219-0073-0000-0000-000049FA2C36
Message-Id: <20181102194356.GA8378@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:22:59AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 30, 2018 at 03:21:23PM -0700, Joel Fernandes wrote:
> > On Tue, Oct 30, 2018 at 05:58:00AM -0700, Paul E. McKenney wrote:
> > > On Mon, Oct 29, 2018 at 08:44:52PM -0700, Joel Fernandes wrote:
> > > > On Mon, Oct 29, 2018 at 07:27:35AM -0700, Paul E. McKenney wrote:

[ . . . ]

> > > > The INT_MAX naming could be very confusing for nesting levels, could we not
> > > > instead just define something like:
> > > > #define RCU_NESTING_MIN (INT_MIN - 1)
> > > > #define RCU_NESTING_MAX (INT_MAX)
> > > > 
> > > > and just use that? also one more comment below:
> > > 
> > > Hmmm...  There is currently no use for RCU_NESTING_MAX, but if the check
> > > at the end of __rcu_read_unlock() were to be extended to check for
> > > too-deep positive nesting, it would need to check for something like
> > > INT_MAX/2.  You could of course argue that the current check against
> > > INT_MIN/2 should instead be against -INT_MAX/2, but there really isn't
> > > much difference between the two.
> > > 
> > > Another approach would be to convert to unsigned in order to avoid the
> > > overflow problem completely.
> > > 
> > > For the moment, anyway, I am inclined to leave it as is.
> > 
> > Both the unsigned and INT_MIN/2 options sound good to me, but if you want
> > leave it as is, that would be fine as well. thanks,
> 
> One approach would be something like this:
> 
> #define RCU_READ_LOCK_BIAS (INT_MAX)
> #define RCU_READ_LOCK_NMAX (-INT_MAX)
> #define RCU_READ_LOCK_PMAX INT_MAX
> 
> Then _rcu_read_unlock() would set ->rcu_read_lock_nesting to
> -RCU_READ_LOCK_BIAS, and compare against RCU_READ_LOCK_NMAX.
> The comparison against RCU_READ_LOCK_PMAX would preferably take
> place just after the increment in __rcu_read_lock(), again only under
> CONFIG_PROVE_RCU.
> 
> rcu_preempt_deferred_qs() would then subtract then add RCU_READ_LOCK_BIAS.
> 
> Thoughts?

Hearing no objections, here is the updated patch.

								Thanx, Paul

------------------------------------------------------------------------

commit 970cab5d3d206029ed27274a98ea1c3d7e780e53
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Mon Oct 29 07:36:50 2018 -0700

    rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
    
    Subtracting INT_MIN can be interpreted as unconditional signed integer
    overflow, which according to the C standard is undefined behavior.
    Therefore, kernel build arguments notwithstanding, it would be good to
    future-proof the code.  This commit therefore substitutes INT_MAX for
    INT_MIN in order to avoid undefined behavior.
    
    While in the neighborhood, this commit also creates some meaningful names
    for INT_MAX and friends in order to improve readability, as suggested
    by Joel Fernandes.
    
    Reported-by: Ran Rozenstein <ranro@mellanox.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
    
    squash! rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
    
    While in the neighborhood, use macros to give meaningful names.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bd8186d0f4a7..e60f820ffb83 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -397,6 +397,11 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 	return rnp->gp_tasks != NULL;
 }
 
+/* Bias and limit values for ->rcu_read_lock_nesting. */
+#define RCU_NEST_BIAS INT_MAX
+#define RCU_NEST_NMAX (-INT_MAX / 2)
+#define RCU_NEST_PMAX (INT_MAX / 2)
+
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
@@ -405,6 +410,8 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 void __rcu_read_lock(void)
 {
 	current->rcu_read_lock_nesting++;
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+		WARN_ON_ONCE(current->rcu_read_lock_nesting > RCU_NEST_PMAX);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -424,20 +431,18 @@ void __rcu_read_unlock(void)
 		--t->rcu_read_lock_nesting;
 	} else {
 		barrier();  /* critical section before exit code. */
-		t->rcu_read_lock_nesting = INT_MIN;
+		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
 		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 		barrier();  /* ->rcu_read_unlock_special load before assign */
 		t->rcu_read_lock_nesting = 0;
 	}
-#ifdef CONFIG_PROVE_LOCKING
-	{
-		int rrln = READ_ONCE(t->rcu_read_lock_nesting);
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		int rrln = t->rcu_read_lock_nesting;
 
-		WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);
+		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
 	}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
 
@@ -617,11 +622,11 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
 	if (couldrecurse)
-		t->rcu_read_lock_nesting -= INT_MIN;
+		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 	if (couldrecurse)
-		t->rcu_read_lock_nesting += INT_MIN;
+		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
 }
 
 /*

