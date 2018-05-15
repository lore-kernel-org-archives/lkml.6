Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeEODqJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 23:46:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752060AbeEODqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 23:46:08 -0400
Date: Mon, 14 May 2018 20:47:33 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 7/8] rcu: trace CleanupMore condition only if needed
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-8-joel@joelfernandes.org>
 <20180514192028.GG26088@linux.vnet.ibm.com>
 <20180515010131.GF209519@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515010131.GF209519@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051503-2213-0000-0000-000002A57396
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009027; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032468; UDB=6.00527835; IPR=6.00811599;
 MB=3.00021117; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 03:46:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051503-2214-0000-0000-00005A1F51AC
Message-Id: <20180515034733.GZ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:01:31PM -0700, Joel Fernandes wrote:
> On Mon, May 14, 2018 at 12:20:28PM -0700, Paul E. McKenney wrote:
> > On Sun, May 13, 2018 at 08:15:40PM -0700, Joel Fernandes (Google) wrote:
> > > Currently the tree RCU clean up code records a CleanupMore trace event
> > > even if the GP was already in progress. This makes CleanupMore show up
> > > twice for no reason. Avoid it.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Good catch, and I applied this patch.  I did rework the commit log
> > a bit, so please look it over to make sure I didn't mess it up.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 52c4e689efd975f5383895b1bc1b91bc90fdd372
> > Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Date:   Sun May 13 20:15:40 2018 -0700
> > 
> >     rcu: Produce last "CleanupMore" trace only if late-breaking request
> >     
> >     Currently the tree RCU clean-up code records a "CleanupMore" trace
> >     event in response to late-arriving grace-period requests even if the
> >     grace period was already requested. This makes "CleanupMore" show up an
> >     extra time (in addition to once for each rcu_node structure that was
> >     previously marked with the request) for no good reason.  This commit
> >     therefore avoids emitting this trace message unless the only if the only
> >     request for this next grace period arrived during or after the cleanup
> >     scan of the rcu_node structures.
> 
> Yes, this is fine except "unless the only if the only" should be "unless the".

I did update this after sending, and I still have "the the".  Will fix on
next rebase.  As my daughter recently reminded me, the Law of Conservation
of Bugs.  ;-)

							Thanx, Paul

> thanks,
> 
> - Joel
> 
> >     
> >     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8063a0478870..de6447dd73de 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2072,7 +2072,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
> >  	rsp->gp_state = RCU_GP_IDLE;
> >  	/* Check for GP requests since above loop. */
> >  	rdp = this_cpu_ptr(rsp->rda);
> > -	if (ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
> > +	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
> >  		trace_rcu_this_gp(rnp, rdp, rnp->gp_seq_needed,
> >  				  TPS("CleanupMore"));
> >  		needgp = true;
> > 
> 
