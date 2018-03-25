Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeCYSmZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:42:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753832AbeCYSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:42:22 -0400
Date: Sun, 25 Mar 2018 11:43:07 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: rcu: Add might_sleep() check to synchronize_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
 <20180323172843.763579a9@gandalf.local.home>
 <alpine.DEB.2.21.1803232232410.1481@nanos.tec.linutronix.de>
 <20180323174023.60579f45@gandalf.local.home>
 <CAJWu+oqLnqGbuo9Y5DRJkskaMZ5=Krsxpbe1OhmEpd80CSG2mg@mail.gmail.com>
 <20180323212105.40766d1c@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323212105.40766d1c@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032518-2213-0000-0000-000002849E10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008742; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01008302; UDB=6.00513544; IPR=6.00787591;
 MB=3.00020235; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-25 18:42:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032518-2214-0000-0000-000059875EAD
Message-Id: <20180325184307.GE3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803250227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 09:21:05PM -0400, Steven Rostedt wrote:
> On Fri, 23 Mar 2018 15:57:04 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > > diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> > > index 194a7483bb93..857b494bee29 100644
> > > --- a/net/l2tp/l2tp_core.c
> > > +++ b/net/l2tp/l2tp_core.c
> > > @@ -1677,6 +1677,8 @@ void __l2tp_session_unhash(struct l2tp_session *session)
> > >  {
> > >         struct l2tp_tunnel *tunnel = session->tunnel;
> > >
> > > +       might_sleep();
> > > +
> > >         /* Remove the session from core hashes */
> > >         if (tunnel) {
> > >                 /* Remove from the per-tunnel hash */  
> > 
> > Thanks Thomas and Steven, also shouldn't this code be calling
> > synchronize_rcu_bh instead of synchronize_rcu, to complement the
> > rcu_read_lock_bh? In which situations would you call one versus the
> > other?
> 
> Probably, as the comment above rcu_read_lock_bh is:
> 
>  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
>  *
>  * This is equivalent of rcu_read_lock(), but to be used when updates
>  * are being done using call_rcu_bh() or synchronize_rcu_bh(). Since
>  * both call_rcu_bh() and synchronize_rcu_bh() consider completion of a
>  * softirq handler to be a quiescent state, a process in RCU read-side
>  * critical section must be protected by disabling softirqs.
> 
> It appears that the reason to use rcu_read_lock_bh() is if you are
> calling synchronize_rcu_bh(). Otherwise, one could just be using
> straight rcu_read_lock().

Agreed, these do have to match.  (I am still working on collapsing
RCU-preempt, RCU-bh, and RCU-sched into one thing per Linus's request,
but still at the pen-and-paper stage.  Not all that difficult, just a
lot of cases to cover.)

							Thanx, Paul
