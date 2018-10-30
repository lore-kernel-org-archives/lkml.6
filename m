Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EE5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCA22080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCA22080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeJaCuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:50:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727771AbeJaCuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:50:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UHsFYi070835
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:55:46 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2neun2s9nt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:55:46 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 30 Oct 2018 13:55:44 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Oct 2018 13:55:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9UHtegM25231576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 17:55:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 408AFB2066;
        Tue, 30 Oct 2018 17:55:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E95BB2065;
        Tue, 30 Oct 2018 17:55:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Oct 2018 17:55:39 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C7B0216C2455; Tue, 30 Oct 2018 10:55:39 -0700 (PDT)
Date:   Tue, 30 Oct 2018 10:55:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH RFC kenrel/rcu] Eliminate BUG_ON() for sync.c
Reply-To: paulmck@linux.ibm.com
References: <20181022145241.GA7488@linux.ibm.com>
 <20181022152406.GA7257@redhat.com>
 <20181022155644.GG4170@linux.ibm.com>
 <20181022161439.GA8640@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022161439.GA8640@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18103017-0060-0000-0000-000002C99CED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009955; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01110237; UDB=6.00575258; IPR=6.00890329;
 MB=3.00023968; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-30 17:55:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103017-0061-0000-0000-00004706F9C7
Message-Id: <20181030175539.GL4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 06:14:40PM +0200, Oleg Nesterov wrote:
> On 10/22, Paul E. McKenney wrote:
> >
> > > > @@ -125,12 +125,12 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> > > >  		rsp->gp_state = GP_PENDING;
> > > >  	spin_unlock_irq(&rsp->rss_lock);
> > > >
> > > > -	BUG_ON(need_wait && need_sync);
> > > > -
> > > >  	if (need_sync) {
> > > >  		gp_ops[rsp->gp_type].sync();
> > > >  		rsp->gp_state = GP_PASSED;
> > > >  		wake_up_all(&rsp->gp_wait);
> > > > +		if (WARN_ON_ONCE(need_wait))
> > > > +			wait_event(rsp->gp_wait, rsp->gp_state == GP_PASSED);
> > >
> > > This wait_event(gp_state == GP_PASSED) is pointless, note that this branch
> > > does gp_state = GP_PASSED 2 lines above.
> >
> > OK, I have removed this one.
> >
> > > And if we add WARN_ON_ONCE(need_wait), then we should probably also add
> > > WARN_ON_ONCE(need_sync) into the next "if (need_wait)" branch just for
> > > symmetry.
> >
> > But in that case, the earlier "if" prevents "need_sync" from ever getting
> > there, unless I lost the thread here.
> 
> Yes, you are right, we would also need to remove "else",
> 
> > Should I remove the others?
> 
> Up to you, I am fine either way.
> 
> IOW, feel free to remove this BUG_ON's altogether, or turn them all into
> WARN_ON_ONCE's, whatever you like more.
> 
> > > ----------------------------------------------------------------------------
> > > Damn.
> > >
> > > This suddenly reminds me that I rewrote this code completely, and you even
> > > reviewed the new implementation and (iirc) acked it!
> > >
> > > However, I failed to force myself to rewrite the comments, and that is why
> > > I didn't send the "official" patch :/
> > >
> > > May be some time...
> >
> > Could you please point me at the last email thread?  Yes, I should be
> > able to find it, but I would probably get the wrong one.  :-/
> 
> probably this one,
> 
> 	[PATCH] rcu_sync: simplify the state machine, introduce __rcu_sync_enter()
> 	https://lkml.org/lkml/2016/7/16/150
> 
> but I am not sure, will recheck tomorrow.

Just following up...  Here is what I currently have.

							Thanx, Paul

------------------------------------------------------------------------

commit 1c1d315dfb7049d0233b89948a3fbcb61ea15d26
Author: Dennis Krein <Dennis.Krein@netapp.com>
Date:   Fri Oct 26 07:38:24 2018 -0700

    srcu: Lock srcu_data structure in srcu_gp_start()
    
    The srcu_gp_start() function is called with the srcu_struct structure's
    ->lock held, but not with the srcu_data structure's ->lock.  This is
    problematic because this function accesses and updates the srcu_data
    structure's ->srcu_cblist, which is protected by that lock.  Failing to
    hold this lock can result in corruption of the SRCU callback lists,
    which in turn can result in arbitrarily bad results.
    
    This commit therefore makes srcu_gp_start() acquire the srcu_data
    structure's ->lock across the calls to rcu_segcblist_advance() and
    rcu_segcblist_accelerate(), thus preventing this corruption.
    
    Reported-by: Bart Van Assche <bvanassche@acm.org>
    Reported-by: Christoph Hellwig <hch@infradead.org>
    Signed-off-by: Dennis Krein <Dennis.Krein@netapp.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 60f3236beaf7..697a2d7e8e8a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -451,10 +451,12 @@ static void srcu_gp_start(struct srcu_struct *sp)
 
 	lockdep_assert_held(&ACCESS_PRIVATE(sp, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
+	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&sp->srcu_gp_seq));
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&sp->srcu_gp_seq));
+	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
 	rcu_seq_start(&sp->srcu_gp_seq);
 	state = rcu_seq_state(READ_ONCE(sp->srcu_gp_seq));

