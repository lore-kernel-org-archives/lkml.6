Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031752AbeBNWS3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:18:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031527AbeBNWS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:18:28 -0500
Date: Wed, 14 Feb 2018 14:18:41 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] srcu: Remove dead code in srcu_gp_end()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1518599124-29153-1-git-send-email-byungchul.park@lge.com>
 <20180214100054.45f525fe@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214100054.45f525fe@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021422-0048-0000-0000-000002373A49
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008535; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000253; SDB=6.00989785; UDB=6.00502616; IPR=6.00769139;
 BA=6.00005830; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019557; XFM=3.00000015;
 UTC=2018-02-14 22:18:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021422-0049-0000-0000-000044203809
Message-Id: <20180214221841.GT3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802140262
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:00:54AM -0500, Steven Rostedt wrote:
> On Wed, 14 Feb 2018 18:05:24 +0900
> Byungchul Park <byungchul.park@lge.com> wrote:
> 
> > Of course, compilers will optimize out a dead code. Anyway, remove
> > any dead code for better readibility.
> > 
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  kernel/rcu/srcutree.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 44bc0fa..829453b 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -531,7 +531,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
> >  	unsigned long flags;
> >  	unsigned long gpseq;
> >  	int idx;
> > -	int idxnext;
> 
> Interesting. According to git history, idxnext was never actually used.

Which raises the question of what I intended to do with it.  Reviewing
that function didn't activate any memories, though it did point out a
candidate simplification.

> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied, thank you both!

							Thanx, Paul

> -- Steve
> 
> >  	unsigned long mask;
> >  	struct srcu_data *sdp;
> >  	struct srcu_node *snp;
> > @@ -555,7 +554,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
> >  
> >  	/* Initiate callback invocation as needed. */
> >  	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
> > -	idxnext = (idx + 1) % ARRAY_SIZE(snp->srcu_have_cbs);
> >  	rcu_for_each_node_breadth_first(sp, snp) {
> >  		spin_lock_irq_rcu_node(snp);
> >  		cbs = false;
> 
