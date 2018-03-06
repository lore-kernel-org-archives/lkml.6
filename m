Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeCFRYK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:24:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753979AbeCFRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:24:08 -0500
Date: Tue, 6 Mar 2018 09:24:35 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <max.byungchul.park@gmail.com>
Cc: Byungchul Park <byungchul.park@lge.com>, rostedt@goodmis.org,
        josh@joshtriplett.org, jiangshanlai@gmail.com, kernel-team@lge.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] rcu: Prevent expedite reporting within RCU read-side
 section
Reply-To: paulmck@linux.vnet.ibm.com
References: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
 <CANrsvRO-QUS0p_2KMgNJN5h64mN49J37uh7KSYm7Fo5csi_t1w@mail.gmail.com>
 <CANrsvROu6fOu8vOubS2Z4m9nHYQtxw4+WTwz1UqeaLJ66_bQ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrsvROu6fOu8vOubS2Z4m9nHYQtxw4+WTwz1UqeaLJ66_bQ1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030617-0024-0000-0000-00000332048A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008628; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999276; UDB=6.00508256; IPR=6.00778594;
 MB=3.00019879; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-06 17:24:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030617-0025-0000-0000-0000473D8BC5
Message-Id: <20180306172435.GV3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803060191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:43:19PM +0900, Byungchul Park wrote:
> On Mar 6, 2018 2:34 PM, "Byungchul Park" <byungchul.park@lge.com> wrote:
> >
> > Hello Paul and RCU folks,
> >
> > I am afraid I correctly understand and fix it. But I really wonder why
> > sync_rcu_exp_handler() reports the quiescent state even in the case that
> > current task is within a RCU read-side section. Do I miss something?
> 
> Hello,
> 
> I missed the fact that the original code is anyway safe because
> the case is gonna be handled properly in rcu_read_unlock().
> 
> This patch just makes unnecessary spin lock/unlock within *report*()
> avoided. Please ignore this if you don't think it's that worthy. I am
> also not sure if it is.
> 
> Sorry bothering you. And thanks.

Not a problem, especially given that you figured it out before I got
to your email.  And thank you for your review of RCU!

							Thanx, Paul

> > If I correctly understand it and you agree with it, I can add more logic
> > which make it more expedited by boosting current or making it urgent
> > when we fail to report the quiescent state on the IPI.
> >
> > ----->8-----
> > From 0b0191f506c19ce331a1fdb7c2c5a00fb23fbcf2 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul.park@lge.com>
> > Date: Tue, 6 Mar 2018 13:54:41 +0900
> > Subject: [RFC] rcu: Prevent expedite reporting within RCU read-side section
> >
> > We report the quiescent state for this cpu if it's out of RCU read-side
> > section at the moment IPI was just fired during the expedite process.
> >
> > However, current code reports the quiescent state even in the case:
> >
> >    1) the current task is still within a RCU read-side section
> >    2) the current task has been blocked within the RCU read-side section
> >
> > Since we don't get to the quiescent state yet in the case, we shouldn't
> > report it but check it another time.
> >
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > ---
> >  kernel/rcu/tree_exp.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 73e1d3d..cc69d14 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -731,13 +731,13 @@ static void sync_rcu_exp_handler(void *info)
> >         /*
> >          * We are either exiting an RCU read-side critical section (negative
> >          * values of t->rcu_read_lock_nesting) or are not in one at all
> > -        * (zero value of t->rcu_read_lock_nesting).  Or we are in an RCU
> > -        * read-side critical section that blocked before this expedited
> > -        * grace period started.  Either way, we can immediately report
> > -        * the quiescent state.
> > +        * (zero value of t->rcu_read_lock_nesting). We can immediately
> > +        * report the quiescent state.
> >          */
> > -       rdp = this_cpu_ptr(rsp->rda);
> > -       rcu_report_exp_rdp(rsp, rdp, true);
> > +       if (t->rcu_read_lock_nesting <= 0) {
> > +               rdp = this_cpu_ptr(rsp->rda);
> > +               rcu_report_exp_rdp(rsp, rdp, true);
> > +       }
> >  }
> >
> >  /**
> > --
> > 1.9.1
> >
> 
