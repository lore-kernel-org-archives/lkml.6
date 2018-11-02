Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E241C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BEA2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BEA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeKCF75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:59:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbeKCF75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:59:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2KiNZn137274
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 16:51:18 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ngwamhed3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 16:51:18 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 2 Nov 2018 20:51:17 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 20:51:14 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA2KpDe733554684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 20:51:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B00FB2065;
        Fri,  2 Nov 2018 20:51:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A059B205F;
        Fri,  2 Nov 2018 20:51:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.141])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 20:51:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 69D0516C1857; Fri,  2 Nov 2018 13:51:14 -0700 (PDT)
Date:   Fri, 2 Nov 2018 13:51:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Krein, Dennis" <Dennis.Krein@netapp.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: srcu hung task panic
Reply-To: paulmck@linux.ibm.com
References: <20181023141415.GJ4170@linux.ibm.com>
 <SN6PR06MB433307629C43832973E0F882E5F50@SN6PR06MB4333.namprd06.prod.outlook.com>
 <20181024105326.GL4170@linux.ibm.com>
 <SN6PR06MB4333940F6EE46EDDB20934EDE5F00@SN6PR06MB4333.namprd06.prod.outlook.com>
 <20181026144835.GW4170@linux.ibm.com>
 <20181102201448.GA15234@linux.ibm.com>
 <SN6PR06MB43338B272D71F977DBBF906FE5CF0@SN6PR06MB4333.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR06MB43338B272D71F977DBBF906FE5CF0@SN6PR06MB4333.namprd06.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18110220-0072-0000-0000-000003C210CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009973; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01111734; UDB=6.00576157; IPR=6.00891826;
 MB=3.00024008; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-02 20:51:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110220-0073-0000-0000-000049FA4CA2
Message-Id: <20181102205114.GD4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:33:25PM +0000, Krein, Dennis wrote:
> Yes it's fine with me to sign off on this.  I have done extensive
> additional testing with the patch in my repro setup and have run well
> over 100 hours with no problem.  The repro setup with rcutorture and the
> inotify app typically reproduced a crash in 4 hours and always withing 12.
> We also did a lot of testing (several rigs all over 72 hours)  in our
> actual test rigs where running our fail over test along with rcutorture
> running and that always produced a crash in about 2 hours.

Thank you very much, Dennis, both for the fix and the testing!!!

For the 100 hours at 4 hours MTBF, there is a 99.3% probability of having
reduced the error rate by a factor of at least 5.  Assuming "several"
is at least three, the 72-hour runs at 2 hours MTBF shows a 99.5%
chance of having reduced the error rate by at least a factor of 20.
(Assuming random memoryless error distribution, etc., etc.)  So this
one does look like a winner.  ;-)

Is there anyone other than yourself who should get Tested-by credit
for this patch?  For that matter, is there someone who should get
Reported-by credit?

							Thanx, Paul

> ________________________________
> From: Paul E. McKenney <paulmck@linux.ibm.com>
> Sent: Friday, November 2, 2018 2:14:48 PM
> To: Krein, Dennis
> Cc: linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org; hch@infradead.org; bvanassche@acm.org
> Subject: Re: srcu hung task panic
> 
> NetApp Security WARNING: This is an external email. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> 
> On Fri, Oct 26, 2018 at 07:48:35AM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 26, 2018 at 04:00:53AM +0000, Krein, Dennis wrote:
> > > I have a patch attached that fixes the problem for us.  I also tried a
> > > version with an smb_mb() call added at end of rcu_segcblist_enqueue()
> > > - but that turned out not to be needed.  I think the key part of
> > > this is locking srcu_data in srcu_gp_start().  I also put in the
> > > preempt_disable/enable in __call_srcu() so that it couldn't get scheduled
> > > out and possibly moved to another CPU.  I had one hung task panic where
> > > the callback that would complete the wait was properly set up but for some
> > > reason the delayed work never happened.  Only thing I could determine to
> > > cause that was if __call_srcu() got switched out after dropping spin lock.
> >
> > Good show!!!
> >
> > You are quite right, the srcu_data structure's ->lock
> > must be held across the calls to rcu_segcblist_advance() and
> > rcu_segcblist_accelerate().  Color me blind, given that I repeatedly
> > looked at the "lockdep_assert_held(&ACCESS_PRIVATE(sp, lock));" and
> > repeatedly misread it as "lockdep_assert_held(&ACCESS_PRIVATE(sdp,
> > lock));".
> >
> > A few questions and comments:
> >
> > o     Are you OK with my adding your Signed-off-by as shown in the
> >       updated patch below?
> 
> Hmmm...  I either need your Signed-off-by or to have someone cleanroom
> recreate the patch before I can send it upstream.  I would much prefer
> to use your Signed-off-by so that you get due credit, but one way or
> another I do need to fix this bug.
> 
>                                                         Thanx, Paul
> 
> > o     I removed the #ifdefs because this is needed everywhere.
> >       However, I do agree that it can be quite helpful to use these
> >       while experimenting with different potential solutions.
> >
> > o     Preemption is already disabled across all of srcu_gp_start()
> >       because the sp->lock is an interrupt-disabling lock.  This means
> >       that disabling preemption would have no effect.  I therefore
> >       removed the preempt_disable() and preempt_enable().
> >
> > o     What sequence of events would lead to the work item never being
> >       executed?  Last I knew, workqueues were supposed to be robust
> >       against preemption.
> >
> > I have added Christoph and Bart on CC (along with their Reported-by tags)
> > because they were recently seeing an intermittent failure that might
> > have been caused gby tyhis same bug.  Could you please check to see if
> > the below patch fixes your problem, give or take the workqueue issue?
> >
> >                                                       Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit 1c1d315dfb7049d0233b89948a3fbcb61ea15d26
> > Author: Dennis Krein <Dennis.Krein@netapp.com>
> > Date:   Fri Oct 26 07:38:24 2018 -0700
> >
> >     srcu: Lock srcu_data structure in srcu_gp_start()
> >
> >     The srcu_gp_start() function is called with the srcu_struct structure's
> >     ->lock held, but not with the srcu_data structure's ->lock.  This is
> >     problematic because this function accesses and updates the srcu_data
> >     structure's ->srcu_cblist, which is protected by that lock.  Failing to
> >     hold this lock can result in corruption of the SRCU callback lists,
> >     which in turn can result in arbitrarily bad results.
> >
> >     This commit therefore makes srcu_gp_start() acquire the srcu_data
> >     structure's ->lock across the calls to rcu_segcblist_advance() and
> >     rcu_segcblist_accelerate(), thus preventing this corruption.
> >
> >     Reported-by: Bart Van Assche <bvanassche@acm.org>
> >     Reported-by: Christoph Hellwig <hch@infradead.org>
> >     Signed-off-by: Dennis Krein <Dennis.Krein@netapp.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 60f3236beaf7..697a2d7e8e8a 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -451,10 +451,12 @@ static void srcu_gp_start(struct srcu_struct *sp)
> >
> >       lockdep_assert_held(&ACCESS_PRIVATE(sp, lock));
> >       WARN_ON_ONCE(ULONG_CMP_GE(sp->srcu_gp_seq, sp->srcu_gp_seq_needed));
> > +     spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
> >       rcu_segcblist_advance(&sdp->srcu_cblist,
> >                             rcu_seq_current(&sp->srcu_gp_seq));
> >       (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> >                                      rcu_seq_snap(&sp->srcu_gp_seq));
> > +     spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
> >       smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
> >       rcu_seq_start(&sp->srcu_gp_seq);
> >       state = rcu_seq_state(READ_ONCE(sp->srcu_gp_seq));
> 

